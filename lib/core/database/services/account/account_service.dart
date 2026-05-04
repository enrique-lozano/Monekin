import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
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

  Stream<List<String>> _watchAccountIdsForBalance({
    Iterable<String>? accountIds,
  }) {
    if (accountIds == null) {
      return db
          .select(db.accounts)
          .watch()
          .map((rows) => rows.map((r) => r.id).toList());
    }
    final query = db.select(db.accounts)
      ..where((a) => a.id.isIn(accountIds.toList()));
    return query.watch().map((rows) => rows.map((r) => r.id).toList());
  }

  Stream<List<String>> _watchInvestmentAccountIds({
    Iterable<String>? accountIds,
  }) {
    if (accountIds == null) {
      return db
          .select(db.accounts)
          .watch()
          .map(
            (rows) => rows
                .where((r) => r.type == AccountType.investment.name)
                .map((r) => r.id)
                .toList(),
          );
    }
    final query = db.select(db.accounts)
      ..where(
        (a) =>
            a.type.equals(AccountType.investment.name) &
            a.id.isIn(accountIds.toList()),
      );
    return query.watch().map((rows) => rows.map((r) => r.id).toList());
  }

  Stream<double> _linkedPortfolioMarketAggregate({
    required DateTime date,
    Iterable<String>? accountIds,
    required bool convertToPreferredCurrency,
  }) {
    return _watchInvestmentAccountIds(accountIds: accountIds).switchMap((ids) {
      if (ids.isEmpty) return Stream.value(0.0);
      final streams = ids.map(
        (id) => InvestmentService.instance.streamLinkedAssetsTotalForAccount(
          id,
          date: date,
          convertToPreferredCurrency: convertToPreferredCurrency,
        ),
      );
      return Rx.combineLatestList(
        streams.toList(),
      ).map((values) => values.fold<double>(0, (a, b) => a + b));
    });
  }

  /// Get the amount of money that an account has in a certain period of time,
  /// specified in the [date] param. If the [date] param is null, it will return
  /// the money of the account right now.
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

    final linked = InvestmentService.instance.streamLinkedAssetsTotalForAccount(
      account.id,
      date: date,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );

    return Rx.combineLatest3(
      iniStream,
      ledgerTx,
      linked,
      (double ini, double ledger, double l) =>
          (ini + ledger + l).roundWithDecimals(account.currency.decimalPlaces),
    );
  }

  /// Get the amount of money that some accounts have in a certain period of time,
  /// specified in the [date] param. If the [date] param is null, it will return
  /// the money of the account right now.
  ///
  /// If the [accountIds] param is not specified, the function will return the money of
  /// all the user accounts (closed or not).
  ///
  /// Each account contributes **cash ledger** (income, expense, transfers, and
  /// investment-type rows) plus **linked asset** market value (assets whose
  /// `linkedAccountID` points at that account).
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

    final allAccountsTransactionsBalance =
        _watchAccountIdsForBalance(accountIds: accountIds).switchMap((ids) {
          if (ids.isEmpty) return Stream.value(0.0);
          return TransactionService.instance.getTransactionsValueBalance(
            filters: statusFiltered.copyWith(maxDate: date, accountsIDs: ids),
            convertToPreferredCurrency: convertToPreferredCurrency,
            exchDate: date,
          );
        });

    final linkedPortfolioMarket = _linkedPortfolioMarketAggregate(
      date: date,
      accountIds: accountIds,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );

    return Rx.combineLatest3(
      allAccountsInitialAmount,
      allAccountsTransactionsBalance,
      linkedPortfolioMarket,
      (double ini, double tr, double linked) => ini + tr + linked,
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
