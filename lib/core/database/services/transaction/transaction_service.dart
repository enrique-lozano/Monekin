import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:rxdart/rxdart.dart';

class TransactionQueryStatResult {
  int numberOfRes;
  double valueSum;

  TransactionQueryStatResult(
      {required this.numberOfRes, required this.valueSum});
}

class TransactionService {
  final AppDB db;

  TransactionService._(this.db);
  static final TransactionService instance =
      TransactionService._(AppDB.instance);

  Future<int> insertTransaction(TransactionInDB transaction) async {
    final toReturn = await db.into(db.transactions).insert(transaction);

    // To update the getAccountsData() function results
    // TODO: Check why we need this. The function already listen to changes in the transactions table
    db.markTablesUpdated([db.accounts]);
    return toReturn;
  }

  Future<int> insertOrUpdateTransaction(TransactionInDB transaction) async {
    final toReturn = await db
        .into(db.transactions)
        .insert(transaction, mode: InsertMode.insertOrReplace);

    // To update the getAccountsData() function results
    // TODO: Check why we need this. The function already listen to changes in the transactions table
    db.markTablesUpdated([db.accounts]);

    return toReturn;
  }

  Future<int> deleteTransaction(String transactionId) {
    return (db.delete(db.transactions)
          ..where((tbl) => tbl.id.equals(transactionId)))
        .go();
  }

  Stream<List<MoneyTransaction>> getTransactionsFromPredicate({
    Expression<bool> Function(Transactions, Accounts, Currencies, Accounts,
            Currencies, Categories, Categories)?
        predicate,
    OrderBy Function(
            Transactions transaction,
            Accounts account,
            Currencies accountCurrency,
            Accounts receivingAccount,
            Currencies receivingAccountCurrency,
            Categories c,
            Categories)?
        orderBy,
    int? limit,
    int? offset,
  }) {
    return db
        .getTransactionsWithFullData(
          predicate: predicate,
          orderBy: orderBy,
          limit: (t, a, accountCurrency, ra, receivingAccountCurrency, c, pc) =>
              Limit(limit ?? -1, offset),
        )
        .watch();
  }

  Stream<List<MoneyTransaction>> getTransactions({
    TransactionFilters? filters,
    OrderBy Function(
            Transactions transaction,
            Accounts account,
            Currencies accountCurrency,
            Accounts receivingAccount,
            Currencies receivingAccountCurrency,
            Categories c,
            Categories)?
        orderBy,
    int? limit,
    int? offset,
  }) {
    return getTransactionsFromPredicate(
        predicate: filters?.toTransactionExpression(),
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  Stream<TransactionQueryStatResult> countTransactions({
    TransactionFilters predicate = const TransactionFilters(),
    bool convertToPreferredCurrency = true,
    DateTime? exchDate,
  }) {
    if (predicate.transactionTypes == null ||
        predicate.transactionTypes!
            .map((e) => e.index)
            .contains(TransactionType.transfer.index)) {
      // If we should take into account transfers:
      return Rx.combineLatest([
        // INCOME AND EXPENSES
        db
            .countTransactions(
              predicate: predicate
                  .copyWith(
                    transactionTypes: predicate.transactionTypes
                            ?.whereNot((element) =>
                                element.index == TransactionType.transfer.index)
                            .toList() ??
                        [TransactionType.income, TransactionType.expense],
                  )
                  .toTransactionExpression(),
              date: (exchDate ?? DateTime.now()),
            )
            .watchSingle(),

        // TRANSFERS FROM ORIGIN ACCOUNTS
        db
            .countTransactions(
              predicate: predicate.copyWith(
                transactionTypes: [TransactionType.transfer],
                includeReceivingAccountsInAccountFilters: false,
              ).toTransactionExpression(),
              date: (exchDate ?? DateTime.now()),
            )
            .watchSingle(),

        // TRANSFERS FROM DESTINY ACCOUNTS
        db
            .countTransactions(
              predicate: predicate.copyWith(
                transactionTypes: [TransactionType.transfer],
                accountsIDs: null,
              ).toTransactionExpression(
                extraFilters: (transaction, account, accountCurrency,
                        receivingAccount, receivingAccountCurrency, c, p6) =>
                    [
                  if (predicate.accountsIDs != null)
                    transaction.receivingAccountID.isIn(predicate.accountsIDs!)
                ],
              ),
              date: (exchDate ?? DateTime.now()),
            )
            .watchSingle()
      ], (res) {
        return TransactionQueryStatResult(
            numberOfRes: res.map((e) => e.transactionsNumber).sum,
            valueSum: convertToPreferredCurrency
                ? res[0].sumInPrefCurrency -
                    res[1].sumInPrefCurrency +
                    res[2].sumInDestinyInPrefCurrency
                : res[0].sum - res[1].sum + res[2].sumInDestiny);
      });
    }

    // If we should not take into account transfers, we just return the normal sum
    return db
        .countTransactions(
          predicate: predicate.toTransactionExpression(),
          date: (exchDate ?? DateTime.now()),
        )
        .watchSingle()
        .map((event) => TransactionQueryStatResult(
            numberOfRes: event.transactionsNumber,
            valueSum: convertToPreferredCurrency
                ? event.sumInPrefCurrency
                : event.sum));
  }

  Stream<MoneyTransaction?> getTransactionById(String id) {
    return db
        .getTransactionsWithFullData(
          predicate: (transaction, account, accountCurrency, receivingAccount,
                  receivingAccountCurrency, c, p6) =>
              transaction.id.equals(id),
          limit: (t, a, accountCurrency, ra, receivingAccountCurrency, c, pc) =>
              Limit(1, 0),
        )
        .watchSingleOrNull();
  }

  Stream<bool> checkIfCreateTransactionIsPossible() {
    return AccountService.instance
        .getAccounts(
          predicate: (acc, curr) => AppDB.instance.buildExpr([
            acc.type.equalsValue(AccountType.saving).not(),
            acc.isArchived.isNotValue(true)
          ]),
          limit: 1,
        )
        .map((event) => event.isNotEmpty);
  }
}
