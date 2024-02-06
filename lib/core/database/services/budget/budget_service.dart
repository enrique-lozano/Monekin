import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/budget/budget.dart';

class BudgetServive {
  final AppDB db;

  BudgetServive._(this.db);
  static final BudgetServive instance = BudgetServive._(AppDB.instance);

  Future<bool> insertBudget(Budget budget) {
    return db.transaction(() async {
      await db.into(db.budgets).insert(BudgetInDB(
          id: budget.id,
          name: budget.name,
          limitAmount: budget.limitAmount,
          intervalPeriod: budget.intervalPeriod,
          startDate: budget.startDate,
          endDate: budget.endDate));

      if (budget.categories != null) {
        for (final category in budget.categories!) {
          await db.into(db.budgetCategory).insert(
              BudgetCategoryData(budgetID: budget.id, categoryID: category));
        }
      }

      if (budget.accounts != null) {
        for (final account in budget.accounts!) {
          await db.into(db.budgetAccount).insert(
              BudgetAccountData(budgetID: budget.id, accountID: account));
        }
      }

      return true;
    });
  }

  Future<bool> deleteBudget(String id) {
    return db.transaction(() async {
      await (db.delete(db.budgetAccount)
            ..where((tbl) => tbl.budgetID.isValue(id)))
          .go();

      await (db.delete(db.budgetCategory)
            ..where((tbl) => tbl.budgetID.isValue(id)))
          .go();

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
    Expression<bool> Function(Budgets)? predicate,
    OrderBy Function(Budgets)? orderBy,
    int? limit,
    int? offset,
  }) {
    return db
        .getBudgetsWithFullData(
          predicate: predicate,
          orderBy: orderBy,
          limit: (b) => Limit(limit ?? -1, offset),
        )
        .watch();
  }

  Stream<Budget?> getBudgetById(String id) {
    return getBudgets(predicate: (p0) => p0.id.equals(id), limit: 1)
        .map((res) => res.firstOrNull);
  }
}
