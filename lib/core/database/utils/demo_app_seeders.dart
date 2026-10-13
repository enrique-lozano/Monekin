import 'dart:math';

import 'package:drift/drift.dart' show TableInfo, Value;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset_type.enum.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/goal/goal_type.enum.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/core/utils/uuid.dart';

const _cashAccountID = 'acc1';
const _bankAccountID = 'acc2';
const _brokerAccountID = 'acc3';

/// Read on every use (not cached), so the demo data can be seeded again in
/// another currency after changing the preferred one.
String get _prefCurrencyCode =>
    appStateSettings[SettingKey.preferredCurrency] ?? 'USD';

/// Rough value of 1 USD in the preferred currency, so the demo amounts look
/// plausible in any currency (a salary of 2,800 is fine in dollars, not in
/// rupees). Currencies not listed keep the dollar amounts.
const _usdValueIn = {
  'USD': 1.0,
  'EUR': 1.0,
  'GBP': 0.8,
  'BRL': 5.0,
  'MXN': 18.0,
  'TRY': 35.0,
  'INR': 80.0,
  'TWD': 32.0,
};

double get _amountScale => _usdValueIn[_prefCurrencyCode] ?? 1;

/// [amount] (in dollars) in the preferred currency, rounded to a plausible
/// precision (cents only when the scale is 1, as in the original amounts).
double demoAmount(double amount) {
  final scaled = amount * _amountScale;
  if (_amountScale == 1) return scaled;
  final step = scaled.abs() >= 1000 ? 10 : 1;
  return (scaled / step).roundToDouble() * step;
}

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
  AccountInDB(
    id: _brokerAccountID,
    name: 'Broker',
    displayOrder: 3,
    type: AccountType.investment,
    isSaving: false,
    trackingMode: AccountTrackingMode.transactions,
    currencyId: _prefCurrencyCode,
    iniValue: 20000,
    date: DateTime(2023),
    iconId: 'auto_graph',
  ),
];

final List<TagInDB> _tagsToCreate = [
  const TagInDB(id: 'tag1', name: 'Holidays', color: 'FF5733', displayOrder: 1),
  const TagInDB(id: 'tag2', name: 'Work', color: '33FF57', displayOrder: 2),
];

/// Budgeted category and its number of subcategories (budgets only match the
/// exact category ids of their filter).
const _budgetedCategories = {'2': 2, '5': 5, '4': 4, '3': 3};

final List<TransactionFilterSetInDB> _budgetFilterSetsToCreate = [
  for (final MapEntry(:key, :value) in _budgetedCategories.entries)
    TransactionFilterSetInDB(
      id: 'budget_filter_$key',
      categoriesIds: [key, for (var i = 1; i <= value; i++) '${key}_$i'],
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

/// Hand-picked latest transactions, each with a different category/icon, so
/// the top of the transactions list looks varied.
List<(TransactionInDB, String?)> _recentTransactionsToCreate() {
  final now = DateTime.now();

  final recent = <(TransactionInDB, String?)>[];

  void add(
    int daysAgo,
    int hour,
    int minute,
    String title,
    double value,
    String categoryId, {
    String accountId = _bankAccountID,
    TransactionType type = TransactionType.expense,
    String? tagId,
  }) {
    var date = DateTime(now.year, now.month, now.day - daysAgo, hour, minute);
    if (date.isAfter(now))
      date = now.subtract(Duration(minutes: recent.length));

    recent.add((
      TransactionInDB(
        id: generateUUID(),
        date: date,
        accountID: accountId,
        value: type == TransactionType.income ? value : -value,
        type: type,
        categoryID: categoryId,
        title: title,
        isHidden: false,
        status: TransactionStatus.reconciled,
      ),
      tagId,
    ));
  }

  add(0, 21, 15, 'Cinema', 20.47, '4_4', tagId: 'tag1');
  add(0, 13, 40, 'Starbucks', 6.4, '2_1', accountId: _cashAccountID);
  add(0, 9, 5, 'Zara', 59.9, '3_3');
  add(1, 19, 30, 'Spotify', 10.99, '4_3');
  add(1, 14, 10, 'Shell', 48.3, '5_2');
  add(
    1,
    11,
    20,
    'Sold old bike',
    120,
    '12',
    type: TransactionType.income,
    accountId: _cashAccountID,
  );
  add(2, 18, 45, 'Pharmacy', 23.15, '1_2', accountId: _cashAccountID);
  add(2, 12, 30, 'Tesco', 87.6, '2_2');
  add(3, 17, 0, 'Software License', 49, '3_2', tagId: 'tag2');

  return recent;
}

/// Days (from today) covered by [_recentTransactionsToCreate].
const _recentDays = 4;

/// Currency of the demo exchange rates (never the preferred one).
String get demoForeignCurrencyCode =>
    _prefCurrencyCode == 'USD' ? 'EUR' : 'USD';

/// Monthly exchange rate history (last 6 months) of a currency other than the
/// preferred one, as `1 unit = rate preferred currency`.
List<ExchangeRateInDB> _exchangeRatesToCreate() {
  final foreignCode = demoForeignCurrencyCode;
  final baseRate = switch (_prefCurrencyCode) {
    'USD' => 1.09, // 1 EUR in USD
    'EUR' => 0.92, // 1 USD in EUR
    _ => _amountScale,
  };
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

/// Same day [months] months ago, without time.
DateTime _monthsAgo(int months) {
  final now = DateTime.now();
  return DateTime(now.year, now.month - months, now.day);
}

typedef _DemoSecurity = ({
  String id,
  String name,
  String ticker,
  SecurityType type,
  double startPrice,
  double endPrice,
});

const List<_DemoSecurity> _demoSecurities = [
  (
    id: 'sec_vwce',
    name: 'Vanguard FTSE All-World',
    ticker: 'VWCE',
    type: SecurityType.fund,
    startPrice: 95,
    endPrice: 128,
  ),
  (
    id: 'sec_aapl',
    name: 'Apple Inc.',
    ticker: 'AAPL',
    type: SecurityType.stock,
    startPrice: 170,
    endPrice: 232,
  ),
  (
    id: 'sec_btc',
    name: 'Bitcoin',
    ticker: 'BTC',
    type: SecurityType.crypto,
    startPrice: 38000,
    endPrice: 61000,
  ),
];

/// Months of monthly price history of each security.
const _priceHistoryMonths = 24;

/// Buys of the broker account, as (security id, months ago, quantity).
const _demoTrades = [
  ('sec_vwce', 18, 60.0),
  ('sec_aapl', 12, 20.0),
  ('sec_btc', 10, 0.08),
  ('sec_vwce', 6, 40.0),
];

/// Price of [security] [monthsAgo] months ago: steady growth with some ups and
/// downs, so the charts don't look flat.
double _priceAt(_DemoSecurity security, int monthsAgo) {
  final progress = 1 - monthsAgo / _priceHistoryMonths;
  final trend =
      security.startPrice *
      pow(security.endPrice / security.startPrice, progress);
  final wave = monthsAgo == 0 ? 0 : 0.05 * sin(monthsAgo * 1.7);
  return double.parse((trend * (1 + wave)).toStringAsFixed(2));
}

List<SecurityInDB> _securitiesToCreate() => [
  for (final security in _demoSecurities)
    SecurityInDB(
      id: security.id,
      name: security.name,
      type: security.type,
      currencyId: _prefCurrencyCode,
      ticker: security.ticker,
      currentPrice: security.endPrice,
      priceDate: _monthsAgo(0),
    ),
];

List<SecurityPriceInDB> _securityPricesToCreate() => [
  for (final security in _demoSecurities)
    for (var month = _priceHistoryMonths; month >= 0; month--)
      SecurityPriceInDB(
        id: generateUUID(),
        securityID: security.id,
        date: _monthsAgo(month),
        price: _priceAt(security, month),
      ),
];

List<AssetInDB> _assetsToCreate() => [
  AssetInDB(
    id: 'asset_apartment',
    name: 'Apartment',
    currencyId: _prefCurrencyCode,
    initialValue: 0,
    creationDate: _monthsAgo(30),
    assetType: AssetType.realEstate,
  ),
  AssetInDB(
    id: 'asset_car',
    name: 'Car',
    currencyId: _prefCurrencyCode,
    initialValue: 0,
    creationDate: _monthsAgo(24),
    assetType: AssetType.vehicle,
  ),
];

List<AssetValuationInDB> _assetValuationsToCreate() => [
  for (final (assetId, monthsAgo, value) in [
    ('asset_apartment', 30, 145000.0),
    ('asset_apartment', 18, 151000.0),
    ('asset_apartment', 6, 158500.0),
    ('asset_apartment', 0, 163000.0),
    ('asset_car', 24, 24000.0),
    ('asset_car', 12, 20500.0),
    ('asset_car', 0, 17800.0),
  ])
    AssetValuationInDB(
      id: generateUUID(),
      assetId: assetId,
      date: _monthsAgo(monthsAgo),
      value: value,
    ),
];

/// Savings goals, both counting incomes (mainly the monthly salary), so they
/// show some progress.
final List<TransactionFilterSetInDB> _goalFilterSetsToCreate = [
  const TransactionFilterSetInDB(
    id: 'goal_filter_emergency',
    categoriesIds: ['10'], // Salary
  ),
  const TransactionFilterSetInDB(id: 'goal_filter_trip'),
];

List<GoalInDB> _goalsToCreate() => [
  GoalInDB(
    id: 'goal_emergency',
    name: 'Emergency fund',
    amount: 12000,
    initialAmount: 0,
    startDate: _monthsAgo(4),
    type: GoalType.income,
    filterID: 'goal_filter_emergency',
  ),
  GoalInDB(
    id: 'goal_trip',
    name: 'Trip to Japan',
    amount: 9000,
    initialAmount: 0,
    startDate: _monthsAgo(2),
    endDate: _monthsAgo(-6),
    type: GoalType.income,
    filterID: 'goal_filter_trip',
  ),
];

/// Deletes everything [fillWithDemoData] creates, so it can run again (e.g. in
/// another currency). Categories, currencies and settings are kept.
Future<void> clearDemoData() async {
  final db = AppDB.instance;
  await db.transaction(() async {
    for (final TableInfo table in [
      db.transactionTags,
      db.transactions,
      db.holdings,
      db.securityPrices,
      db.securities,
      db.assetValuations,
      db.assets,
      db.budgets,
      db.goals,
      db.transactionFilterSets,
      db.exchangeRates,
      db.tags,
      db.accounts,
    ]) {
      await db.delete(table).go();
    }
  });
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

    if (i < _recentDays) continue;

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
            categoryId = '2_1';
            title = ["McDonald's", 'Starbucks', 'Burger King'].randomItem();
            amount = 5 + random.nextDouble() * 40;
            if (random.nextDouble() < 0.2) tagId = 'tag1'; // Holidays sometimes
            break;
          case 1: // Groceries
            categoryId = '2_2';
            title = ['Tesco', 'Costco'].randomItem();
            amount = 50 + random.nextDouble() * 100;
            break;
          case 2: // Transport
            title = ['Uber', 'Gas', 'Bus Ticket'].randomItem();
            categoryId = title == 'Gas' ? '5_2' : '5_1';
            amount = 5 + random.nextDouble() * 50;
            if (title == 'Uber' && random.nextBool()) tagId = 'tag2'; // Work
            break;
          case 3: // Leisure
            title = ['Netflix', 'Cinema', 'Spotify', 'Bowling'].randomItem();
            categoryId = switch (title) {
              'Spotify' => '4_3',
              'Bowling' => '4',
              _ => '4_4',
            };
            amount = 10 + random.nextDouble() * 30;
            if (title == 'Cinema' || title == 'Bowling') {
              tagId = 'tag1';
            } // Holidays
            break;
          case 4: // Work
            categoryId = '3_2'; // Electronics
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

  for (final (transaction, tagId) in _recentTransactionsToCreate()) {
    transactions.add(transaction);
    if (tagId != null) {
      transactionTags.add(
        TransactionTag(transactionID: transaction.id, tagID: tagId),
      );
    }
  }

  Logger.printDebug('Inserting ${transactions.length} transactions...');

  // Amounts are written in dollars above and scaled here to the preferred
  // currency (accounts, budgets, goals, transactions, assets and prices).
  final accounts = [
    for (final a in _accountsToCreate)
      a.copyWith(iniValue: demoAmount(a.iniValue)),
  ];
  final allTransactions = [
    for (final t in [...transactions, ..._recurrentTransactionsToCreate()])
      t.copyWith(value: demoAmount(t.value)),
  ];

  await db.batch((batch) {
    batch.insertAll(db.accounts, accounts);
    batch.insertAll(db.tags, _tagsToCreate);
    batch.insertAll(db.transactionFilterSets, _budgetFilterSetsToCreate);
    batch.insertAll(db.budgets, [
      for (final b in _budgetsToCreate)
        b.copyWith(limitAmount: demoAmount(b.limitAmount)),
    ]);
    batch.insertAll(db.transactions, allTransactions);
    batch.insertAll(db.transactionTags, transactionTags);
    batch.insertAll(db.exchangeRates, _exchangeRatesToCreate());
    batch.insertAll(db.securities, [
      for (final s in _securitiesToCreate())
        s.copyWith(currentPrice: Value(demoAmount(s.currentPrice!))),
    ]);
    batch.insertAll(db.securityPrices, [
      for (final p in _securityPricesToCreate())
        p.copyWith(price: demoAmount(p.price)),
    ]);
    batch.insertAll(db.assets, _assetsToCreate());
    batch.insertAll(db.assetValuations, [
      for (final v in _assetValuationsToCreate())
        v.copyWith(value: demoAmount(v.value)),
    ]);
    batch.insertAll(db.transactionFilterSets, _goalFilterSetsToCreate);
    batch.insertAll(db.goals, [
      for (final g in _goalsToCreate())
        g.copyWith(amount: demoAmount(g.amount)),
    ]);
  });

  // Through the service, so the holdings and the trades stay in sync.
  for (final (securityId, monthsAgo, quantity) in _demoTrades) {
    final security = _demoSecurities.firstWhere((s) => s.id == securityId);
    await HoldingService.instance.buy(
      accountId: _brokerAccountID,
      securityId: securityId,
      quantity: quantity,
      pricePerUnit: demoAmount(_priceAt(security, monthsAgo)),
      date: _monthsAgo(monthsAgo),
    );
  }

  Logger.printDebug('Seed completed successfully!');

  Logger.printDebug('Executing minor adjustments...');
  // Adjust account balances:

  final cash = accounts.first;
  double currentBalance = cash.iniValue;
  for (final t in allTransactions.where((t) => t.accountID == _cashAccountID)) {
    currentBalance += t.value;
  }

  if (currentBalance < 0) {
    Logger.printDebug(
      'Adjusting account balance (current: $currentBalance)...',
    );
    await (db.update(db.accounts)..where((a) => a.id.equals(_cashAccountID)))
        .write(cash.copyWith(iniValue: cash.iniValue - currentBalance));
  }

  Logger.printDebug('Demo data seeding finished.');
}
