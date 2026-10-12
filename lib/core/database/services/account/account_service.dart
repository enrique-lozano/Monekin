import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/numbers.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:rxdart/rxdart.dart';

enum AccountDataFilter { income, expense, balance }

class AccountService {
  final AppDB db;

  AccountService._(this.db);
  static final AccountService instance = AccountService._(AppDB.instance);

  Future<int> insertAccount(AccountInDB account) {
    return db.into(db.accounts).insert(account);
  }

  Future<bool> updateAccount(AccountInDB account) {
    return db.update(db.accounts).replace(account);
  }

  Future<int> deleteAccount(String accountId) {
    return (db.delete(
      db.accounts,
    )..where((tbl) => tbl.id.equals(accountId))).go();
  }

  Stream<List<Account>> getAccounts({
    Expression<bool> Function(Accounts acc, Currencies curr)? predicate,
    OrderBy Function(Accounts acc, Currencies curr)? orderBy,
    int? limit,
    int? offset,
  }) {
    return db
        .getAccountsWithFullData(
          predicate: predicate,
          orderBy:
              orderBy ??
              (acc, curr) => OrderBy([OrderingTerm.asc(acc.displayOrder)]),
          limit: (a, currency) => Limit(limit ?? -1, offset),
        )
        .watch();
  }

  Stream<Account?> getAccountById(String id) {
    return getAccounts(
      predicate: (a, c) => a.id.equals(id),
      limit: 1,
    ).map((res) => res.firstOrNull);
  }

  // --- Crud end --- //

  // ---------------------------------------------------------------------------
  // Accounts metrics & balances
  // ---------------------------------------------------------------------------

  String _joinAccountAndRate(
    DateTime? date, {
    String columnName = 'excRate',
    String accountTableName = 'accounts',
  }) =>
      '''
    LEFT JOIN
      (
          SELECT currencyCode,
                  exchangeRate
            FROM exchangeRates er
            WHERE date = (
                            SELECT MAX(date) 
                              FROM exchangeRates
                              WHERE currencyCode = er.currencyCode 
                              ${date != null ? 'AND  date <= ?' : ''}
                        )
            ORDER BY currencyCode
      )
      AS $columnName ON $accountTableName.currencyId = $columnName.currencyCode
    ''';

  /// The **cash** side of an account at [date] (defaults to now): its opening
  /// balance plus its ledger, with portfolio snapshots taking over from the
  /// ledger where they exist (see [_getSnapshotCashAdjustment]).
  ///
  /// This is [getAccountMoney] without the market value of the account's
  /// holdings. Use it to know how much spendable money an account holds, and to
  /// prefill the cash of a new portfolio snapshot.
  ///
  /// By default the returned amount is in the account currency.
  Stream<double> getAccountCash({
    required Account account,
    DateTime? date,
    TransactionFilterSet trFilters = const TransactionFilterSet(),
    bool convertToPreferredCurrency = false,
  }) {
    date ??= DateTime.now();

    final statusFiltered = trFilters.copyWith(
      status: TransactionStatus.getStatusThatCountsForStats(trFilters.status),
    );
    final baseFilter = statusFiltered.copyWith(
      accountsIDs: [account.id],
      maxDate: date,
    );

    final iniStream = account.date.isAfter(date)
        ? Stream.value(0.0)
        : Stream.value(account.iniValue).switchMap((ini) {
            if (!convertToPreferredCurrency) return Stream.value(ini);
            return ExchangeRateService.instance
                .calculateExchangeRateToPreferredCurrency(
                  amount: ini,
                  fromCurrency: account.currency.code,
                  date: date,
                );
          });

    final ledgerTx = TransactionService.instance.getTransactionsValueBalance(
      filters: baseFilter,
      convertToPreferredCurrency: convertToPreferredCurrency,
      exchDate: date,
    );

    final snapshotAnchor = _getSnapshotCashAdjustment(
      accountIds: [account.id],
      date: date,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );

    return Rx.combineLatest3(
      iniStream,
      ledgerTx,
      snapshotAnchor,
      (double ini, double ledger, double anchor) => ini + ledger + anchor,
    );
  }

  /// Get the amount of money that an account has in a certain period of time,
  /// specified in the [date] param. If the [date] param is null, it will return
  /// the money of the account right now.
  ///
  /// The balance is the account's cash ([getAccountCash]) plus the market value
  /// of the securities it holds.
  ///
  /// You can add filters for the transactions that will be taken into account to calculate
  /// this balance, via the [trFilters] param.
  ///
  /// By default, the returned amount will be in the account currency.
  ///
  /// Example:
  ///
  /// ```dart
  /// final account = Account(/*....*/)
  ///
  /// final moneyStream = getAccountMoney(
  ///   account: account,
  ///   date: DateTime.now(),
  ///   convertToPreferredCurrency: true,
  /// );
  ///
  /// moneyStream.listen((money) {
  ///   Logger.printDebug('Money: \$\${money.toStringAsFixed(2)}');
  /// });
  /// ```
  Stream<double> getAccountMoney({
    required Account account,
    DateTime? date,
    TransactionFilterSet trFilters = const TransactionFilterSet(),
    bool convertToPreferredCurrency = false,
  }) {
    date ??= DateTime.now();

    final cash = getAccountCash(
      account: account,
      date: date,
      trFilters: trFilters,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );

    final holdings = HoldingService.instance.getHoldingsMarketValue(
      accountIds: [account.id],
      convertToPreferred: convertToPreferredCurrency,
      convertToCurrency: convertToPreferredCurrency
          ? null
          : account.currency.code,
      date: date,
    );

    return Rx.combineLatest2(
      cash,
      holdings,
      (double c, double h) =>
          (c + h).roundWithDecimals(account.currency.decimalPlaces),
    );
  }

  /// Correction that lets portfolio snapshots own the **cash** of the accounts
  /// tracked in [AccountTrackingMode.holdings].
  ///
  /// A snapshot states the account's whole state on its date: what it held and
  /// how much cash it had. From that date on, that declared cash is the cash
  /// balance. Transactions dated after the snapshot still accumulate on top of
  /// it, which is what keeps interest, taxes and transfers working.
  ///
  /// Applied as an extra additive term in the cash formula:
  ///
  /// ```text
  /// cash(a, t) = Ini(a) + L(a, t) + Adj(a, t)
  /// Adj(a, t)  = snapshotCash(a, d) - (Ini(a) + L(a, d))
  /// ```
  ///
  /// where `d` is the date of the latest snapshot on or before `t`. The two
  /// ledgers cancel out, leaving `snapshotCash + the flows posted after d`.
  /// Accounts with no snapshot on or before `t` contribute 0, so every other
  /// account keeps its plain ledger balance.
  ///
  /// The correction is always computed against the unfiltered ledger (skipping
  /// voided and pending rows, as balances do everywhere): it anchors the
  /// account itself, so it is not something a transaction filter can exclude.
  Stream<double> _getSnapshotCashAdjustment({
    Iterable<String>? accountIds,
    required DateTime date,
    bool convertToPreferredCurrency = false,
  }) {
    if (accountIds != null && accountIds.isEmpty) return Stream.value(0.0);

    return db
        .customSelect(
          snapshotCashAdjustmentQuery(
            accountIdsCount: accountIds?.length,
            rateFactor: convertToPreferredCurrency
                ? ' * COALESCE(excRate.exchangeRate, 1)'
                : '',
            rateJoin: convertToPreferredCurrency
                ? _joinAccountAndRate(date)
                : '',
          ),
          readsFrom: {
            db.accounts,
            db.accountSnapshots,
            db.transactions,
            if (convertToPreferredCurrency) db.exchangeRates,
          },
          variables: [
            Variable.withDateTime(date),
            if (convertToPreferredCurrency) Variable.withDateTime(date),
            if (accountIds != null)
              for (final id in accountIds) Variable.withString(id),
          ],
        )
        .watchSingleOrNull()
        .map(
          (res) =>
              (res?.data['adjustment'] as num?)?.roundWithDecimals(8) ?? 0.0,
        );
  }

  /// The `SELECT` behind [_getSnapshotCashAdjustment].
  ///
  /// The ledger effect of a transaction on an account mirrors how
  /// [TransactionService.getTransactionsValueBalance] aggregates rows: the
  /// signed value for income / expense / investment, minus the value on the
  /// origin of a transfer, and plus `valueInDestiny` on its destination.
  /// Voided and pending rows never count.
  ///
  /// Parameters, in order: the cut-off date, the same date again when
  /// [rateJoin] is set, then one per account id.
  ///
  /// Exposed so tests (and the `v14.sql` backfill they check) can run the same
  /// query as the app.
  @visibleForTesting
  static String snapshotCashAdjustmentQuery({
    int? accountIdsCount,
    String rateFactor = '',
    String rateJoin = '',
  }) =>
      """
    SELECT COALESCE(SUM(
      (
        acs.cash
        - (CASE WHEN accounts.date > acs.date THEN 0 ELSE accounts.iniValue END)
        - COALESCE(
            (
              SELECT SUM(
                CASE
                  WHEN t.type != 'T' THEN t.value
                  WHEN t.accountID = accounts.id THEN -t.value
                  ELSE COALESCE(t.valueInDestiny, t.value)
                END
              )
              FROM transactions t
              WHERE (t.status IS NULL OR t.status NOT IN ('V', 'P'))
                AND t.date <= acs.date
                AND (
                  t.accountID = accounts.id
                  OR (t.type = 'T' AND t.receivingAccountID = accounts.id)
                )
            ),
            0
          )
      )$rateFactor
    ), 0)
    AS adjustment
    FROM accounts
    JOIN accountSnapshots acs
      ON acs.accountID = accounts.id
     AND acs.date = (
           SELECT MAX(acs2.date) FROM accountSnapshots acs2
            WHERE acs2.accountID = accounts.id AND acs2.date <= ?
         )
    $rateJoin
    WHERE accounts.trackingMode = 'holdings'
      ${accountIdsCount != null ? 'AND accounts.id IN (${List.filled(accountIdsCount, '?').join(', ')})' : ''}
    """;

  /// Get the amount of money that some accounts have in a certain period of time,
  /// specified in the [date] param. If the [date] param is null, it will return
  /// the money of the account right now.
  ///
  /// If the [accountIds] param is not specified, the function will return the money of
  /// all the user accounts (closed or not).
  ///
  /// Each account contributes its opening balance, its **cash ledger** (income,
  /// expense, transfers, and investment-type rows), the market value of its
  /// **holdings** and, for accounts tracked in [AccountTrackingMode.holdings],
  /// the cash declared in its latest portfolio snapshot
  /// ([_getSnapshotCashAdjustment]).
  ///
  /// You can add filters for the transactions that will be taken into account to calculate
  /// this balance, via the [trFilters] param. We will overwrite the accountsIds and the maxDate
  /// param of this filter, based on the other params in this func.
  Stream<double> getAccountsMoney({
    Iterable<String>? accountIds,
    DateTime? date,
    TransactionFilterSet trFilters = const TransactionFilterSet(),
    bool convertToPreferredCurrency = true,
  }) {
    if (accountIds != null && accountIds.isEmpty) {
      return Stream.value(0.0);
    }

    date ??= DateTime.now();

    final hasAccountFilter = accountIds != null;

    // Sum of opening balances for all accounts in scope (including investment).
    final allAccountsInitialAmount = db
        .customSelect(
          """
          SELECT COALESCE(
            SUM(
              CASE WHEN accounts.date > ? THEN 0
              ELSE accounts.iniValue 
                ${convertToPreferredCurrency ? ' * COALESCE(excRate.exchangeRate, 1)' : ''} 
              END
            )
          , 0) 
          AS balance
          FROM accounts
              ${convertToPreferredCurrency ? _joinAccountAndRate(date) : ''}
          WHERE 1 = 1
              ${hasAccountFilter ? 'AND accounts.id IN (${List.filled(accountIds.length, '?').join(', ')})' : ''} 
          """,
          readsFrom: {
            db.accounts,
            if (convertToPreferredCurrency) db.exchangeRates,
          },
          variables: [
            Variable.withDateTime(date),
            if (convertToPreferredCurrency) Variable.withDateTime(date),
            if (accountIds != null)
              for (final id in accountIds) Variable.withString(id),
          ],
        )
        .watchSingleOrNull()
        .map((res) {
          if (res?.data != null) {
            return (res!.data['balance'] as num).roundWithDecimals(8);
          }

          return 0.0;
        });

    final statusFiltered = trFilters.copyWith(
      status: TransactionStatus.getStatusThatCountsForStats(trFilters.status),
    );

    final allAccountsTransactionsBalance = TransactionService.instance
        .getTransactionsValueBalance(
          filters: statusFiltered.copyWith(
            maxDate: date,
            accountsIDs: accountIds,
          ),
          convertToPreferredCurrency: convertToPreferredCurrency,
          exchDate: date,
        );

    final holdingsMarket = HoldingService.instance.getHoldingsMarketValue(
      accountIds: accountIds,
      convertToPreferred: convertToPreferredCurrency,
      date: date,
    );

    final snapshotAnchors = _getSnapshotCashAdjustment(
      accountIds: accountIds,
      date: date,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );

    return Rx.combineLatest4(
      allAccountsInitialAmount,
      allAccountsTransactionsBalance,
      holdingsMarket,
      snapshotAnchors,
      (double ini, double tr, double holdings, double anchors) =>
          ini + tr + holdings + anchors,
    );
  }

  /// Relative change in combined account balance between two dates: fraction
  /// `(end - start) / start` in the same sense as [getAccountsMoney] (e.g. `0.05`
  /// means +5% when formatted as a percent).
  ///
  /// If the starting balance is zero (or numerically near zero), returns `0.0`
  /// when the ending balance is also near zero, otherwise `double.nan`.
  ///
  /// If [endDate] is null it defaults to now. If [startDate] is null it defaults
  /// to the earliest opening date among [accounts].
  ///
  /// [trFilters] is applied except [TransactionFilterSet.accountsIDs], which is
  /// overwritten from [accounts].
  Stream<double> getAccountsBalanceRelativeChange({
    required List<Account> accounts,
    DateTime? startDate,
    DateTime? endDate,
    TransactionFilterSet trFilters = const TransactionFilterSet(),
    bool convertToPreferredCurrency = true,
  }) {
    if (accounts.isEmpty) return Stream.value(0);

    endDate ??= DateTime.now();
    startDate ??= accounts.map((e) => e.date).min;

    final Iterable<String> accountIds = accounts.map((e) => e.id);

    final overwrittenFilters = trFilters.copyWith(
      accountsIDs: accountIds.toList(),
    );

    final accountsBalanceStartPeriod = getAccountsMoney(
      accountIds: accountIds,
      date: startDate,
      trFilters: overwrittenFilters,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );

    final accountsBalanceEndPeriod = getAccountsMoney(
      accountIds: accountIds,
      date: endDate,
      trFilters: overwrittenFilters,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );

    return Rx.combineLatest(
      [accountsBalanceStartPeriod, accountsBalanceEndPeriod],
      (res) {
        final startBalance = res[0];
        final finalBalance = res[1];

        const eps = 1e-10;
        if (startBalance.abs() < eps) {
          return finalBalance.abs() < eps ? 0.0 : double.nan;
        }

        return (finalBalance - startBalance) / startBalance;
      },
    );
  }

  /// Use [getAccountsBalanceRelativeChange] — same implementation; this name was misleading.
  @Deprecated('Use getAccountsBalanceRelativeChange')
  Stream<double> getAccountsMoneyVariation({
    required List<Account> accounts,
    DateTime? startDate,
    DateTime? endDate,
    TransactionFilterSet trFilters = const TransactionFilterSet(),
    bool convertToPreferredCurrency = true,
  }) {
    return getAccountsBalanceRelativeChange(
      accounts: accounts,
      startDate: startDate,
      endDate: endDate,
      trFilters: trFilters,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );
  }
}
