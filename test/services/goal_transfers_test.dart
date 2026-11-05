import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/models/goal/goal_type.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

/// Savings goals follow the balance of their accounts: transfers crossing those
/// accounts count, while transfers between them cancel out. Expense goals count
/// expenses and those same transfers, but not income.
void main() {
  late AppDB db;
  late TransactionService service;

  Future<void> insertAccount(String id) {
    return db
        .into(db.accounts)
        .insert(
          AccountInDB(
            id: id,
            name: id,
            iniValue: 0,
            date: DateTime(2020),
            type: AccountType.money,
            isSaving: false,
            trackingMode: AccountTrackingMode.transactions,
            iconId: 'wallet',
            displayOrder: 0,
            currencyId: 'EUR',
          ),
        );
  }

  Future<void> insertTransfer(
    String id, {
    required String from,
    required String to,
    required double value,
    required DateTime date,
  }) {
    return db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: id,
            date: date,
            accountID: from,
            receivingAccountID: to,
            value: value,
            type: TransactionType.transfer,
            isHidden: false,
          ),
        );
  }

  Future<void> insertMovement(String id, TransactionType type, double value) {
    return db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: id,
            date: DateTime(2026, 6),
            accountID: 'checking',
            categoryID: 'category',
            value: value,
            type: type,
            isHidden: false,
          ),
        );
  }

  Goal goal(GoalType type, {List<String>? accounts}) => Goal(
    id: 'goal',
    name: 'Goal',
    amount: 1000,
    initialAmount: 0,
    startDate: DateTime(2026),
    endDate: DateTime(2027),
    type: type,
    trFilters: TransactionFilterSetInDB(id: 'filter', accountsIDs: accounts),
  );

  Future<double> balance(Goal goal) => service
      .getTransactionsValueBalance(
        filters: goal.trFilters,
        convertToPreferredCurrency: false,
      )
      .first;

  setUp(() async {
    db = AppDB.forTesting(NativeDatabase.memory());
    service = TransactionService.forTesting(db);

    await db
        .into(db.currencies)
        .insert(
          const CurrencyInDB(
            code: 'EUR',
            symbol: '€',
            name: 'Euro',
            decimalPlaces: 2,
            isDefault: true,
            type: 0,
          ),
        );

    await db
        .into(db.categories)
        .insert(
          const CategoryInDB(
            id: 'category',
            name: 'Category',
            iconId: 'wallet',
            color: '#4385be',
            type: CategoryType.B,
            displayOrder: 0,
          ),
        );

    await insertAccount('checking');
    await insertAccount('savings');
  });

  tearDown(() async {
    await db.close();
  });

  test('incoming transfers add to a savings goal', () async {
    await insertTransfer(
      'in',
      from: 'checking',
      to: 'savings',
      value: 500,
      date: DateTime(2026, 6),
    );

    expect(await balance(goal(GoalType.income, accounts: ['savings'])), 500);
  });

  test('outgoing transfers subtract from a savings goal', () async {
    await insertTransfer(
      'in',
      from: 'checking',
      to: 'savings',
      value: 500,
      date: DateTime(2026, 6),
    );
    await insertTransfer(
      'out',
      from: 'savings',
      to: 'checking',
      value: 200,
      date: DateTime(2026, 7),
    );

    expect(await balance(goal(GoalType.income, accounts: ['savings'])), 300);
  });

  test('transfers outside the goal dates are ignored', () async {
    await insertTransfer(
      'before',
      from: 'checking',
      to: 'savings',
      value: 500,
      date: DateTime(2025, 6),
    );

    expect(await balance(goal(GoalType.income, accounts: ['savings'])), 0);
  });

  test('transfers between the accounts of a goal change nothing', () async {
    await insertTransfer(
      'internal',
      from: 'checking',
      to: 'savings',
      value: 50,
      date: DateTime(2026, 6),
    );

    expect(
      await balance(goal(GoalType.income, accounts: ['checking', 'savings'])),
      0,
    );
  });

  test('savings goals follow the balance of their accounts', () async {
    await insertMovement('income', TransactionType.income, 300);
    await insertMovement('expense', TransactionType.expense, -100);
    await insertTransfer(
      'in',
      from: 'savings',
      to: 'checking',
      value: 50,
      date: DateTime(2026, 6),
    );

    expect(await balance(goal(GoalType.income, accounts: ['checking'])), 250);
  });

  test('expense goals count expenses and transfers but not income', () async {
    await insertMovement('income', TransactionType.income, 300);
    await insertMovement('expense', TransactionType.expense, -100);
    await insertTransfer(
      'out',
      from: 'checking',
      to: 'savings',
      value: 500,
      date: DateTime(2026, 6),
    );
    await insertTransfer(
      'in',
      from: 'savings',
      to: 'checking',
      value: 200,
      date: DateTime(2026, 7),
    );

    expect(await balance(goal(GoalType.expense, accounts: ['checking'])), -400);
  });
}
