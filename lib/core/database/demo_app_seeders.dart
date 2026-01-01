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
    type: AccountType.normal,
    currencyId: _prefCurrencyCode,
    iniValue: 1000,
    date: DateTime(2023),
    iconId: 'wallet',
  ),
  AccountInDB(
    id: _bankAccountID,
    name: 'My Bank',
    displayOrder: 2,
    type: AccountType.normal,
    currencyId: _prefCurrencyCode,
    iniValue: 5000,
    date: DateTime(2023),
    iconId: 'bank',
  ),
];

final List<TagInDB> _tagsToCreate = [
  const TagInDB(id: 'tag1', name: 'Holidays', color: 'FF5733', displayOrder: 1),
  const TagInDB(id: 'tag2', name: 'Work', color: '33FF57', displayOrder: 2),
];

final List<BudgetInDB> _budgetsToCreate = [
  BudgetInDB(
    id: 'budget1',
    name: 'Monthly Food',
    limitAmount: 500,
    intervalPeriod: Periodicity.month,
  ),
];

final List<BudgetCategoryData> _budgetCategoriesToCreate = [
  const BudgetCategoryData(
    budgetID: 'budget1',
    categoryID: '2', // Food & Dining
  ),
];

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
          type: TransactionType.I,
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
            type: TransactionType.E,
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
            type: TransactionType.E,
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
    batch.insertAll(db.budgets, _budgetsToCreate);
    batch.insertAll(db.budgetCategory, _budgetCategoriesToCreate);
    batch.insertAll(db.transactions, transactions);
    batch.insertAll(db.transactionTags, transactionTags);
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
    await db
        .update(db.accounts)
        .write(
          _accountsToCreate.first.copyWith(
            iniValue: _accountsToCreate.first.iniValue - currentBalance,
          ),
        );
  }

  Logger.printDebug('Demo data seeding finished.');
}
