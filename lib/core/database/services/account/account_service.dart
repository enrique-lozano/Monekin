import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
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
    return (db.delete(db.accounts)..where((tbl) => tbl.id.equals(accountId)))
        .go();
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
          orderBy: orderBy,
          limit: (a, currency) => Limit(limit ?? -1, offset),
        )
        .watch();
  }

  Stream<Account?> getAccountById(String id) {
    return getAccounts(predicate: (a, c) => a.id.equals(id), limit: 1)
        .map((res) => res.firstOrNull);
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
  ///   print('Money: \$\${money.toStringAsFixed(2)}');
  /// });
  /// ```
  Stream<double> getAccountMoney({
    required Account account,
    DateTime? date,
    Iterable<String>? categoriesIds,
    bool convertToPreferredCurrency = false,
  }) {
    return getAccountsMoney(
      accountIds: [account.id],
      date: date,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );
  }

  /// Get the amount of money that some accounts have in a certain period of time,
  /// specified in the [date] param. If the [date] param is null, it will return
  /// the money of the account right now.
  ///
  /// If [categoriesIds] is defined, it will only take into account the transactions
  /// of this categories to get the final money.
  Stream<double> getAccountsMoney({
    Iterable<String>? accountIds,
    DateTime? date,
    Iterable<String>? categoriesIds,
    bool convertToPreferredCurrency = true,
  }) {
    date ??= DateTime.now();

    // Get the accounts initial balance (converted to the preferred currency if necessary)
    final initialBalanceQuery = db
        .customSelect(
          """
      SELECT COALESCE(SUM(accounts.iniValue ${convertToPreferredCurrency ? ' * COALESCE(excRate.exchangeRate, 1)' : ''} ), 0) AS balance
      FROM accounts
          ${convertToPreferredCurrency ? _joinAccountAndRate(date) : ''}
          ${accountIds != null ? 'WHERE accounts.id IN (${List.filled(accountIds.length, '?').join(', ')})' : ''} 
      """,
          readsFrom: {
            db.accounts,
            if (convertToPreferredCurrency) db.exchangeRates
          },
          variables: [
            if (convertToPreferredCurrency) Variable.withDateTime(date),
            if (accountIds != null)
              for (var id in accountIds) Variable.withString(id)
          ],
        )
        .watchSingleOrNull()
        .map((res) {
          if (res?.data != null) {
            return (res!.data['balance'] as num).toDouble();
          }

          return 0.0;
        });

    // Sum the acount initial balance and the balance of the transactions
    return Rx.combineLatest([
      initialBalanceQuery,
      getAccountsData(
        accountIds: accountIds,
        categoriesIds: categoriesIds,
        accountDataFilter: AccountDataFilter.balance,
        convertToPreferredCurrency: convertToPreferredCurrency,
        endDate: date,
      )
    ], (res) => res[0] + res[1]);
  }

  Stream<double> getAccountsData2({
    TransactionFilters filters = const TransactionFilters(),
    bool convertToPreferredCurrency = true,
  }) {
    if (filters.status != null) {
      filters = filters.copyWith(
          status: filters.status!
            ..whereNot((element) => [
                  TransactionStatus.pending.index,
                  TransactionStatus.voided.index
                ].contains(element.index)));
    } else if (filters.notStatus != null) {
      filters = filters.copyWith(
          notStatus: filters.notStatus!
            ..addAll([TransactionStatus.pending, TransactionStatus.voided]));
    } else {
      filters = filters.copyWith(
          notStatus: [TransactionStatus.pending, TransactionStatus.voided]);
    }

    return TransactionService.instance
        .countTransactions(
            predicate: filters,
            exchDate: filters.maxDate ?? DateTime.now(),
            convertToPreferredCurrency: convertToPreferredCurrency)
        .map((event) => event.valueSum);
  }

  Stream<double> getAccountsData({
    required AccountDataFilter accountDataFilter,
    Iterable<String>? accountIds,
    Iterable<String>? categoriesIds,
    DateTime? endDate,
    DateTime? startDate,
    bool convertToPreferredCurrency = true,
  }) {
    return getAccountsData2(
      filters: TransactionFilters(
          accountsIDs: accountIds,
          categories: categoriesIds,
          maxDate: endDate,
          minDate: startDate,
          transactionTypes: accountDataFilter == AccountDataFilter.expense
              ? [TransactionType.expense]
              : accountDataFilter == AccountDataFilter.income
                  ? [TransactionType.income]
                  : null),
      convertToPreferredCurrency: convertToPreferredCurrency,
    );

    String transactionWhereStatement = """
        isHidden = 0
        AND status IS NOT 'voided'      
        AND status IS NOT 'pending'      
        ${categoriesIds != null ? ' AND transactions.categoryID IN (${List.filled(categoriesIds.length, '?').join(', ')}) ' : ''} 
        ${endDate != null ? ' AND transactions.date <= ?' : ''} 
        ${startDate != null ? ' AND transactions.date >= ?' : ''} 
        ${accountDataFilter == AccountDataFilter.expense ? ' AND value < 0 AND receivingAccountID IS NULL' : ''} 
        ${accountDataFilter == AccountDataFilter.income ? ' AND value > 0 AND receivingAccountID IS NULL' : ''}
      """;

    List<Variable<Object>> transactionWhereArgs = [
      if (categoriesIds != null)
        for (var id in categoriesIds) Variable.withString(id),
      if (endDate != null) Variable.withDateTime(endDate),
      if (startDate != null) Variable.withDateTime(startDate),
    ];

    return db
        .customSelect("""
        SELECT SUM(balance) 
          FROM (
            SELECT accountID,
                  accounts.name,
                  accounts.currencyId,
                  (SUM(CASE WHEN receivingAccountID IS NOT NULL THEN (COALESCE( -valueInDestiny, -value) ) ELSE value END) 
                    ${convertToPreferredCurrency ? '* COALESCE(excRate.exchangeRate, 1)' : ''} ) 
                  AS balance
             FROM transactions
                  LEFT JOIN
                  ( SELECT * FROM accounts )
                  AS accounts ON transactions.accountID = accounts.id
                  ${convertToPreferredCurrency ? _joinAccountAndRate(endDate) : ''}
                  WHERE ${accountIds != null ? 'accountID IN (${List.filled(accountIds.length, '?').join(', ')}) AND ' : ''} 
                  $transactionWhereStatement
            GROUP BY accountID
            UNION
            SELECT receivingAccountID,
                  accounts.name,
                  accounts.currencyId,
                  (SUM(CASE WHEN receivingAccountID IS NOT NULL THEN (COALESCE(valueInDestiny, value) ) ELSE value END) 
                    ${convertToPreferredCurrency ? '* COALESCE(excRate.exchangeRate, 1)' : ''} ) 
                  AS balance
             FROM transactions
                  LEFT JOIN
                  ( SELECT * FROM accounts )
                  AS accounts ON transactions.receivingAccountID = accounts.id
                  ${convertToPreferredCurrency ? _joinAccountAndRate(endDate) : ''}
            WHERE receivingAccountID IS NOT NULL
            ${accountIds != null ? 'AND receivingAccountID IN (${List.filled(accountIds.length, '?').join(', ')})' : ''}
            AND $transactionWhereStatement
            GROUP BY receivingAccountID
       )
       AS balance
    """, readsFrom: {
          db.accounts,
          db.transactions,
          if (convertToPreferredCurrency) db.exchangeRates
        }, variables: [
          if (endDate != null && convertToPreferredCurrency)
            Variable.withDateTime(endDate),
          if (accountIds != null)
            for (var id in accountIds) Variable.withString(id),
          ...transactionWhereArgs,
          if (endDate != null && convertToPreferredCurrency)
            Variable.withDateTime(endDate),
          if (accountIds != null)
            for (var id in accountIds) Variable.withString(id),
          ...transactionWhereArgs,
        ])
        .watchSingleOrNull()
        .map((res) {
          if (res?.data != null) {
            return (res!.data['SUM(balance)'] as num? ?? 0).toDouble();
          }

          return 0.0;
        });
  }

  /// Returns a stream of a double representing the variation in money for a list of accounts between two dates.
  ///
  /// If the user does not provide a value for endDate, the function sets it to the current date. If the user does not provide a value for startDate, the function sets it to the minimum date in the list of accounts.
  Stream<double> getAccountsMoneyVariation({
    required List<Account> accounts,
    DateTime? startDate,
    DateTime? endDate,
    bool convertToPreferredCurrency = true,
  }) {
    endDate ??= DateTime.now();
    startDate ??= accounts.map((e) => e.date).min;

    final Iterable<String> accountIds = accounts.map((e) => e.id);

    final accountsBalanceStartPeriod = getAccountsMoney(
        accountIds: accountIds,
        date: startDate,
        convertToPreferredCurrency: convertToPreferredCurrency);

    final accountsBalanceEndPeriod = getAccountsMoney(
        accountIds: accountIds,
        date: endDate,
        convertToPreferredCurrency: convertToPreferredCurrency);

    return Rx.combineLatest(
        [accountsBalanceStartPeriod, accountsBalanceEndPeriod],
        (res) => (res[1] - res[0]) / res[0]);
  }
}
