import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/budget/budget.dart';

class BudgetServive {
  final AppDB db;

  BudgetServive._(this.db);
  static final BudgetServive instance = BudgetServive._(AppDB.instance);

  Future<bool> insertBudget(Budget budget) {
    return db.transaction(() async {
      await db
          .into(db.transactionFilterSets)
          .insert(budget.trFilters.toDBModel(id: budget.filterID));

      await db
          .into(db.budgets)
          .insert(
            BudgetInDB(
              id: budget.id,
              name: budget.name,
              limitAmount: budget.limitAmount,
              intervalPeriod: budget.intervalPeriod,
              startDate: budget.startDate,
              endDate: budget.endDate,
              filterID: budget.filterID,
            ),
          );

      return true;
    });
  }

  Future<bool> deleteBudget(String id) {
    return db.transaction(() async {
      // Delete the filter first:
      final budgetToDelete = await (db.select(
        db.budgets,
      )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

      if (budgetToDelete == null) {
        return false;
      }

      await (db.delete(
        db.transactionFilterSets,
      )..where((tbl) => tbl.id.equals(budgetToDelete.filterID))).go();

      await (db.delete(db.budgets)..where((tbl) => tbl.id.isValue(id))).go();

      return true;
    });
  }

  Future<bool> updateBudget(Budget budget) {
    return db.transaction(() async {
      await deleteBudget(budget.id);

      await insertBudget(budget);

      return true;
    });
  }

  Stream<List<Budget>> getBudgets({
    Expression<bool> Function(Budgets, TransactionFilterSets)? predicate,
    OrderBy Function(Budgets, TransactionFilterSets)? orderBy,
    int? limit,
    int? offset,
  }) {
    return db
        .getBudgetsWithFullData(
          predicate: predicate,
          orderBy: orderBy,
          limit: (b, trFilter) => Limit(limit ?? -1, offset),
        )
        .watch();
  }

  Stream<Budget?> getBudgetById(String id) {
    return getBudgets(
      predicate: (p0, trFilter) => p0.id.equals(id),
      limit: 1,
    ).map((res) => res.firstOrNull);
  }
}
