import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/debt/debt_direction.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

class DebtServive {
  final AppDB db;

  DebtServive._(this.db);
  static final DebtServive instance = DebtServive._(AppDB.instance);

  Future<int> insertDebt(DebtInDB debt) {
    return db.into(db.debts).insert(debt);
  }

  Future<int> deleteDebt(String debtId) {
    return (db.delete(db.debts)..where((tbl) => tbl.id.equals(debtId))).go();
  }

  Future<double> getDebtCurrentAmount(Debt debt) async {
    final transactions = await (db.select(
      db.transactions,
    )..where((tbl) => tbl.debtId.equals(debt.id))).get();

    double currentAmount = debt.initialAmount;

    for (final transaction in transactions) {
      if (debt.type == DebtDirection.lent) {
        if (transaction.type == TransactionType.expense) {
          currentAmount += transaction.value;
        } else if (transaction.type == TransactionType.income) {
          currentAmount -= transaction.value;
        }
      } else {
        if (transaction.type == TransactionType.income) {
          currentAmount += transaction.value;
        } else if (transaction.type == TransactionType.expense) {
          currentAmount -= transaction.value;
        }
      }
    }

    return currentAmount;
  }

  Stream<List<Debt>> getDebts({
    Expression<bool> Function(Debts, Currencies)? predicate,
    OrderBy Function(Debts, Currencies)? orderBy,
    int? limit,
    int? offset,
  }) {
    return db
        .getDebtsWithFullData(
          predicate: predicate,
          orderBy: orderBy,
          limit: (b, trFilter) => Limit(limit ?? -1, offset),
        )
        .watch();
  }

  Stream<Debt?> getDebtById(String id) {
    return getDebts(
      predicate: (p0, trFilter) => p0.id.equals(id),
      limit: 1,
    ).map((res) => res.firstOrNull);
  }
}
