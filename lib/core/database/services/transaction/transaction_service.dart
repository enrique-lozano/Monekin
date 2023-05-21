import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:finlytics/core/database/database_impl.dart';
import 'package:finlytics/core/models/transaction/transaction.dart';

class TransactionService {
  final DatabaseImpl db;

  TransactionService._(this.db);
  static final TransactionService instance =
      TransactionService._(DatabaseImpl.instance);

  Future<int> insertTransaction(TransactionInDB account) {
    return db.into(db.transactions).insert(account);
  }

  Future<int> deleteTransaction(String accountId) {
    return (db.delete(db.transactions)
          ..where((tbl) => tbl.id.equals(accountId)))
        .go();
  }

  Stream<List<MoneyTransaction>> getTransactions({
    Expression<bool> Function(
            Transactions, Accounts, Accounts, Categories, Categories)?
        predicate,
    OrderBy Function(Transactions, Accounts, Accounts, Categories, Categories)?
        orderBy,
    int? limit,
    int? offset,
  }) {
    return db
        .getTransactionsWithFullData(
            predicate: predicate,
            orderBy: orderBy,
            limit: (t, a, ra, c, pc) => Limit(limit ?? -1, offset))
        .watch();
  }

  Stream<MoneyTransaction?> getTransactionById(String id) {
    return getTransactions(
            predicate: (a, _, __, ___, ____) => a.id.equals(id), limit: 1)
        .map((res) => res.firstOrNull);
  }
}
