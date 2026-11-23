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

  Future<void> insertAccount(String id, {String currency = 'EUR'}) {
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
            currencyId: currency,
          ),
        );
  }

  Future<void> insertTransfer(
    String id, {
    required String from,
    required String to,
    required double value,
    required DateTime date,
    double? valueInDestiny,
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
            valueInDestiny: valueInDestiny,
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

  Goal goal(
    GoalType type, {
    List<String>? accounts,
    List<String>? categories,
  }) => Goal(
    id: 'goal',
    name: 'Goal',
    amount: 1000,
    initialAmount: 0,
    startDate: DateTime(2026),
    endDate: DateTime(2027),
    type: type,
    trFilters: TransactionFilterSetInDB(
      id: 'filter',
      accountsIDs: accounts,
      categoriesIds: categories,
    ),
  );

  Future<double> balance(Goal goal, {bool converted = false}) => service
      .getTransactionsValueBalance(
        filters: goal.trFilters,
        convertToPreferredCurrency: converted,
      )
      .first;

  /// A USD account worth 0.90 EUR per dollar, EUR being the preferred currency.
  Future<void> insertUsdAccount() async {
    await db
        .into(db.currencies)
        .insert(
          const CurrencyInDB(
            code: 'USD',
            symbol: r'$',
            name: 'US Dollar',
            decimalPlaces: 2,
            isDefault: false,
            type: 0,
          ),
        );
    await db
        .into(db.exchangeRates)
        .insert(
          ExchangeRateInDB(
            id: 'usd',
            date: DateTime(2026),
            currencyCode: 'USD',
            exchangeRate: 0.9,
          ),
        );
    await insertAccount('usd', currency: 'USD');
  }

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

  test('a category filter leaves transfers out of the goal', () async {
    await insertMovement('expense', TransactionType.expense, -100);
    await insertTransfer(
      'out',
      from: 'checking',
      to: 'savings',
      value: 500,
      date: DateTime(2026, 6),
    );

    expect(
      await balance(goal(GoalType.expense, categories: ['category'])),
      -100,
    );
  });

  test(
    'a transfer into another currency counts its destination amount',
    () async {
      await insertUsdAccount();
      await insertTransfer(
        'in',
        from: 'checking',
        to: 'usd',
        value: 100,
        valueInDestiny: 110,
        date: DateTime(2026, 6),
      );

      expect(
        await balance(
          goal(GoalType.income, accounts: ['usd']),
          converted: true,
        ),
        closeTo(99, 1e-9),
      );
    },
  );

  test('a cross-currency transfer within a goal only counts the conversion '
      'difference', () async {
    await insertUsdAccount();
    await insertTransfer(
      'internal',
      from: 'checking',
      to: 'usd',
      value: 100,
      valueInDestiny: 110,
      date: DateTime(2026, 6),
    );

    expect(
      await balance(
        goal(GoalType.income, accounts: ['checking', 'usd']),
        converted: true,
      ),
      closeTo(-1, 1e-9),
    );
  });

  test('a transfer without destination amount is converted with the '
      'destination rate', () async {
    await insertUsdAccount();
    await insertTransfer(
      'in',
      from: 'checking',
      to: 'usd',
      value: 100,
      date: DateTime(2026, 6),
    );

    final transfer = (await service.getTransactions().first).single;

    expect(
      transfer.currentValueInDestinyInPreferredCurrency,
      closeTo(90, 1e-9),
    );
    expect(
      await balance(goal(GoalType.income, accounts: ['usd']), converted: true),
      closeTo(90, 1e-9),
    );
  });
}
