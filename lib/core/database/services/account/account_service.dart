import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/numbers.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
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

  String _joinAccountAndRate(DateTime? date, {String columnName = 'excRate'}) =>
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
      AS $columnName ON accounts.currencyId = excRate.currencyCode
    ''';

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
    return getAccountsMoney(
      accountIds: [account.id],
      date: date,
      trFilters: trFilters,
      convertToPreferredCurrency: convertToPreferredCurrency,
    ).map((result) => result.roundWithDecimals(account.currency.decimalPlaces));
  }

  /// Get the amount of money that some accounts have in a certain period of time,
  /// specified in the [date] param. If the [date] param is null, it will return
  /// the money of the account right now.
  ///
  /// If the [accountIds] param is not specified, the function will return the money of
  /// all the user accounts (closed or not).
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

    // Get the accounts initial balance (converted to the preferred currency if necessary)
    final initialBalanceQuery = db
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
              ${accountIds != null ? 'WHERE accounts.id IN (${List.filled(accountIds.length, '?').join(', ')})' : ''} 
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

    // Sum the acount initial balance and the balance of the transactions
    return Rx.combineLatest(
      [
        initialBalanceQuery,
        TransactionService.instance.getTransactionsValueBalance(
          filters: trFilters.copyWith(maxDate: date, accountsIDs: accountIds),
          convertToPreferredCurrency: convertToPreferredCurrency,
        ),
      ],
      (res) {
        return res[0] + res[1];
      },
    );
  }

  /// Returns a stream of a double, representing the variation in money for a list of accounts between two dates.
  ///
  /// If the user does not provide a value for endDate, the function sets it to the
  /// current date. If the user does not provide a value for startDate, the function
  /// sets it to the minimum date in the list of accounts.
  ///
  /// You can add filters for the transactions that will be taken into account to calculate
  /// this value, via the [trFilters] param. We will overwrite the accountsIds
  /// param of this filter, based on the param in this func.
  Stream<double> getAccountsMoneyVariation({
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

    final accountsBalanceDuringPeriod = TransactionService.instance
        .getTransactionsValueBalance(
          filters: overwrittenFilters.copyWith(
            minDate: startDate,
            maxDate: endDate,
          ),
          convertToPreferredCurrency: convertToPreferredCurrency,
        );

    return Rx.combineLatest(
      [accountsBalanceStartPeriod, accountsBalanceDuringPeriod],
      (res) {
        final startBalance = res[0];
        final finalBalance = res[1] + startBalance;

        return (finalBalance - startBalance) / startBalance;
      },
    );
  }
}
