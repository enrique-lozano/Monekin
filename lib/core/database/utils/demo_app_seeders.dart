import 'dart:math';

import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/core/utils/uuid.dart';

const _cashAccountID = 'acc1';
const _bankAccountID = 'acc2';

final _prefCurrencyCode =
    appStateSettings[SettingKey.preferredCurrency] ?? 'USD';

final List<AccountInDB> _accountsToCreate = [
  AccountInDB(
    id: _cashAccountID,
    name: 'Cash',
    displayOrder: 1,
    type: AccountType.money,
    isSaving: false,
    trackingMode: AccountTrackingMode.transactions,
    currencyId: _prefCurrencyCode,
    iniValue: 1000,
    date: DateTime(2023),
    iconId: 'wallet',
  ),
  AccountInDB(
    id: _bankAccountID,
    name: 'My Bank',
    displayOrder: 2,
    type: AccountType.money,
    isSaving: false,
    trackingMode: AccountTrackingMode.transactions,
    currencyId: _prefCurrencyCode,
    iniValue: 5000,
    date: DateTime(2023),
    iconId: 'account_balance',
  ),
];

final List<TagInDB> _tagsToCreate = [
  const TagInDB(id: 'tag1', name: 'Holidays', color: 'FF5733', displayOrder: 1),
  const TagInDB(id: 'tag2', name: 'Work', color: '33FF57', displayOrder: 2),
];

final List<TransactionFilterSetInDB> _budgetFilterSetsToCreate = [
  for (final categoryId in ['2', '5', '4', '3'])
    TransactionFilterSetInDB(
      id: 'budget_filter_$categoryId',
      categoriesIds: [categoryId],
    ),
];

final List<BudgetInDB> _budgetsToCreate = [
  for (final (name, limit, categoryId) in [
    ('Monthly Food', 500.0, '2'),
    ('Transport', 150.0, '5'),
    ('Leisure', 120.0, '4'),
    ('Shopping', 200.0, '3'),
  ])
    BudgetInDB(
      id: 'budget_$categoryId',
      name: name,
      limitAmount: limit,
      intervalPeriod: Periodicity.month,
      filterID: 'budget_filter_$categoryId',
    ),
];

/// Upcoming payments of the subscriptions / recurrent transactions page.
List<TransactionInDB> _recurrentTransactionsToCreate() {
  final today = DateTime.now();

  TransactionInDB recurrent({
    required String title,
    required double value,
    required String categoryId,
    required int nextPaymentInDays,
    Periodicity period = Periodicity.month,
    String accountId = _bankAccountID,
  }) {
    return TransactionInDB(
      id: generateUUID(),
      date: DateTime(
        today.year,
        today.month,
        today.day,
      ).add(Duration(days: nextPaymentInDays, hours: 9)),
      accountID: accountId,
      value: -value,
      type: TransactionType.expense,
      categoryID: categoryId,
      title: title,
      isHidden: false,
      intervalPeriod: period,
      intervalEach: 1,
    );
  }

  return [
    recurrent(
      title: 'Rent',
      value: 850,
      categoryId: '6_1', // Rental
      nextPaymentInDays: 3,
    ),
    recurrent(
      title: 'Netflix',
      value: 12.99,
      categoryId: '4_4', // TV-shows and movies
      nextPaymentInDays: 5,
    ),
    recurrent(
      title: 'Spotify',
      value: 10.99,
      categoryId: '4_3', // Music
      nextPaymentInDays: 9,
    ),
    recurrent(
      title: 'Internet',
      value: 39.9,
      categoryId: '6_4',
      nextPaymentInDays: 12,
    ),
    recurrent(
      title: 'Phone',
      value: 15.9,
      categoryId: '6_5',
      nextPaymentInDays: 14,
    ),
    recurrent(
      title: 'Gym',
      value: 29.9,
      categoryId: '1_3', // Fitness
      nextPaymentInDays: 17,
      accountId: _cashAccountID,
    ),
    recurrent(
      title: 'Electricity',
      value: 62.5,
      categoryId: '6_3',
      nextPaymentInDays: 21,
    ),
    recurrent(
      title: 'Car insurance',
      value: 240,
      categoryId: '5_4',
      nextPaymentInDays: 40,
      period: Periodicity.year,
    ),
  ];
}

/// Currency of the demo exchange rates (never the preferred one).
String get demoForeignCurrencyCode =>
    _prefCurrencyCode == 'USD' ? 'EUR' : 'USD';

/// Monthly exchange rate history (last 6 months) of a currency other than the
/// preferred one, as `1 unit = rate preferred currency`.
List<ExchangeRateInDB> _exchangeRatesToCreate() {
  final foreignCode = demoForeignCurrencyCode;
  final baseRate = _prefCurrencyCode == 'USD' ? 1.09 : 0.92;
  final today = DateTime.now();
  final random = Random();

  return [
    for (var i = 5; i >= 0; i--)
      ExchangeRateInDB(
        id: generateUUID(),
        date: DateTime(today.year, today.month - i, 1),
        currencyCode: foreignCode,
        exchangeRate: double.parse(
          (baseRate * (1 + (random.nextDouble() - 0.5) * 0.08)).toStringAsFixed(
            4,
          ),
        ),
      ),
  ];
}

Future<void> fillWithDemoData() async {
  Logger.printDebug('Starting demo data seeding...');
  final db = AppDB.instance;
  // Ensure categories are loaded if needed, though we use hardcoded IDs
  await CategoryService.instance.getCategories().first;

  final transactions = <TransactionInDB>[];
  final transactionTags = <TransactionTag>[];
  final random = Random();

  Logger.printDebug('Generating transactions...');

  // Generate transactions for the last 2 years (730 days)
  for (int i = 0; i < 730; i++) {
    final date = DateTime.now().subtract(Duration(days: i));

    if (i % 50 == 0) {
      Logger.printDebug('Generating transactions for day $i...');
    }

    // Salary: Once a month, around the 28th
    if (date.day == 28) {
      transactions.add(
        TransactionInDB(
          id: generateUUID(),
          date: date,
          accountID: _bankAccountID,
          value: 2500 + random.nextDouble() * 500,
          type: TransactionType.income,
          categoryID: '10', // Salary
          isHidden: false,
          status: TransactionStatus.reconciled,
        ),
      );
    }

    if (i < 30) {
      // First month: Realistic transactions
      int numTransactions = random.nextInt(5); // 0 to 4 per day

      for (int j = 0; j < numTransactions; j++) {
        final transactionId = generateUUID();
        final isCash = random.nextDouble() < 0.3;
        final accountId = isCash ? _cashAccountID : _bankAccountID;

        // 0: Food (Eat out), 1: Groceries, 2: Transport, 3: Leisure, 4: Work related
        int type = random.nextInt(5);

        String title = '';
        String categoryId = '2'; // Default Food
        double amount = 0;
        String? tagId;

        switch (type) {
          case 0: // Eat out
            categoryId = '2';
            title = ["McDonald's", 'Starbucks', 'Burger King'].randomItem();
            amount = 5 + random.nextDouble() * 40;
            if (random.nextDouble() < 0.2) tagId = 'tag1'; // Holidays sometimes
            break;
          case 1: // Groceries
            categoryId = '2';
            title = ['Tesco', 'Costco'].randomItem();
            amount = 50 + random.nextDouble() * 100;
            break;
          case 2: // Transport
            categoryId = '5';
            title = ['Uber', 'Gas', 'Bus Ticket'].randomItem();
            amount = 5 + random.nextDouble() * 50;
            if (title == 'Uber' && random.nextBool()) tagId = 'tag2'; // Work
            break;
          case 3: // Leisure
            categoryId = '4';
            title = ['Netflix', 'Cinema', 'Spotify', 'Bowling'].randomItem();
            amount = 10 + random.nextDouble() * 30;
            if (title == 'Cinema' || title == 'Bowling') {
              tagId = 'tag1';
            } // Holidays
            break;
          case 4: // Work
            categoryId = '3'; // Purchases/Electronics/Stationery
            title = [
              'Nokia',
              'Nintendo Store',
              'Software License',
            ].randomItem();
            amount = 20 + random.nextDouble() * 100;

            if (title == 'Software License' && random.nextBool()) {
              tagId = 'tag2'; // Work
            }

            break;
        }

        transactions.add(
          TransactionInDB(
            id: transactionId,
            date: date.add(Duration(hours: 8 + random.nextInt(12))),
            accountID: accountId,
            value: -double.parse(
              amount.toStringAsFixed(2),
            ), // Negative for expense
            type: TransactionType.expense,
            categoryID: categoryId,
            title: title,
            isHidden: false,
            status: TransactionStatus.reconciled,
          ),
        );

        if (tagId != null) {
          transactionTags.add(
            TransactionTag(transactionID: transactionId, tagID: tagId),
          );
        }
      }
    } else {
      // Older transactions: Less frequent, generic
      // Less frequent in the past
      if (random.nextDouble() < 0.3) {
        // 30% chance of transaction
        final isCash = random.nextBool();
        final accountId = isCash ? _cashAccountID : _bankAccountID;

        // Categories: 2 (Food), 3 (Purchases), 4 (Leisure), 5 (Transport)
        final categoryId = ['2', '3', '4', '5'][random.nextInt(4)];

        double amount = 0;
        String? title;

        if (categoryId == '2') {
          // Food
          if (random.nextDouble() < 0.3) {
            amount = 50 + random.nextDouble() * 100; // Groceries
          } else {
            amount = 5 + random.nextDouble() * 20; // Eating out
            if (random.nextDouble() < 0.1) title = "McDonald's";
          }
        } else if (categoryId == '3') {
          // Purchases
          amount = 20 + random.nextDouble() * 200;
        } else if (categoryId == '4') {
          // Leisure
          amount = 10 + random.nextDouble() * 50;
          if (random.nextDouble() < 0.1) title = 'Netflix';
        } else if (categoryId == '5') {
          // Transport
          amount = 2 + random.nextDouble() * 30;
          if (random.nextDouble() < 0.1) title = 'Uber';
        }

        final transactionId = generateUUID();
        transactions.add(
          TransactionInDB(
            id: transactionId,
            date: date.add(Duration(hours: 8 + random.nextInt(12))),
            accountID: accountId,
            value: -double.parse(amount.toStringAsFixed(2)), // Negative
            type: TransactionType.expense,
            categoryID: categoryId,
            title: title,
            isHidden: false,
            status: TransactionStatus.reconciled,
          ),
        );

        // Add tags randomly (less frequent)
        if (random.nextDouble() < 0.1) {
          transactionTags.add(
            TransactionTag(
              transactionID: transactionId,
              tagID: random.nextBool() ? 'tag1' : 'tag2',
            ),
          );
        }
      }
    }
  }

  Logger.printDebug('Inserting ${transactions.length} transactions...');

  await db.batch((batch) {
    batch.insertAll(db.accounts, _accountsToCreate);
    batch.insertAll(db.tags, _tagsToCreate);
    batch.insertAll(db.transactionFilterSets, _budgetFilterSetsToCreate);
    batch.insertAll(db.budgets, _budgetsToCreate);
    batch.insertAll(db.transactions, [
      ...transactions,
      ..._recurrentTransactionsToCreate(),
    ]);
    batch.insertAll(db.transactionTags, transactionTags);
    batch.insertAll(db.exchangeRates, _exchangeRatesToCreate());
  });

  Logger.printDebug('Seed completed successfully!');

  Logger.printDebug('Executing minor adjustments...');
  // Adjust account balances:

  double currentBalance = _accountsToCreate.first.iniValue;
  for (final t in transactions.where((t) => t.accountID == _cashAccountID)) {
    currentBalance += t.value;
  }

  if (currentBalance < 0) {
    Logger.printDebug(
      'Adjusting account balance (current: $currentBalance)...',
    );
    await (db.update(
      db.accounts,
    )..where((a) => a.id.equals(_cashAccountID))).write(
      _accountsToCreate.first.copyWith(
        iniValue: _accountsToCreate.first.iniValue - currentBalance,
      ),
    );
  }

  Logger.printDebug('Demo data seeding finished.');
}
