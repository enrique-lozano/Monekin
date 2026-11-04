import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/backup/csv_import_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/services/csv_import/csv_transaction_parser.dart';

void main() {
  late AppDB db;
  late CsvImportService service;
  late CsvImportDefaults defaults;

  setUp(() async {
    db = AppDB.forTesting(NativeDatabase.memory());
    service = CsvImportService.forTesting(
      db,
      categories: CategoryService.forTesting(db),
      tags: TagService.forTesting(db),
      preferredCurrencyCode: () async => 'USD',
    );

    const food = CategoryInDB(
      id: 'food',
      name: 'Food',
      iconId: 'wallet',
      color: '#4385be',
      type: CategoryType.E,
      displayOrder: 0,
    );
    await db.into(db.categories).insert(food);
    await db
        .into(db.tags)
        .insert(
          const TagInDB(
            id: 'tag-1',
            name: 'Trip',
            color: '4385be',
            displayOrder: 0,
          ),
        );

    defaults = CsvImportDefaults(category: Category.fromDB(food, null));
  });

  tearDown(() async {
    await db.close();
  });

  ParsedCsvTransaction expense(int i, {String? account, String? category}) =>
      ParsedCsvTransaction(
        type: TransactionType.expense,
        date: DateTime(2025, 1, 1).add(Duration(minutes: i)),
        amount: 10,
        accountName: account ?? 'Bank',
        categoryName: category,
        tags: i.isEven ? const ['trip'] : const [],
      );

  test(
    'creates each missing account once and links categories and tags',
    () async {
      final count = await service.importTransactions([
        expense(0, category: 'food'),
        expense(1, account: 'bank'),
        expense(2, account: 'Cash', category: 'Unknown'),
      ], defaults);

      expect(count, 3);

      final accounts = await db.select(db.accounts).get();
      expect(accounts.map((e) => e.name).toSet(), {'Bank', 'Cash'});
      expect(accounts.every((e) => e.currencyId == 'USD'), isTrue);

      // The account is as old as its first transaction
      expect(
        accounts.firstWhere((e) => e.name == 'Bank').date,
        DateTime(2025, 1, 1),
      );

      final transactions = await db.select(db.transactions).get();
      expect(transactions.every((e) => e.categoryID == 'food'), isTrue);
      expect(transactions.every((e) => e.value == -10), isTrue);

      // Tags are linked to the transactions that have them
      expect(await db.select(db.transactionTags).get(), hasLength(2));
    },
  );

  test('imports a transfer as a single transaction without category', () async {
    await service.importTransactions([
      ParsedCsvTransaction(
        type: TransactionType.transfer,
        date: DateTime(2025, 1, 1),
        amount: 25,
        accountName: 'Bank',
        receivingAccountName: 'Cash',
        valueInDestiny: 24,
      ),
    ], defaults);

    final transfer = (await db.select(db.transactions).get()).single;
    final accounts = {
      for (final a in await db.select(db.accounts).get()) a.name: a.id,
    };

    expect(transfer.categoryID, isNull);
    expect(transfer.accountID, accounts['Bank']);
    expect(transfer.receivingAccountID, accounts['Cash']);
    expect(transfer.value, 25);
    expect(transfer.valueInDestiny, 24);
  });

  test(
    'imports nothing for a transfer that the default account empties',
    () async {
      final account = Account.fromDB(
        AccountInDB(
          id: 'default',
          name: 'Default',
          iniValue: 0,
          displayOrder: 0,
          date: DateTime(2020),
          type: AccountType.money,
          isSaving: false,
          trackingMode: AccountTrackingMode.transactions,
          iconId: 'wallet',
          currencyId: 'USD',
        ),
        const CurrencyInDB(
          code: 'USD',
          symbol: r'$',
          name: 'US Dollar',
          decimalPlaces: 2,
          isDefault: true,
          type: 0,
        ),
      );

      final count = await service.importTransactions([
        ParsedCsvTransaction(
          type: TransactionType.transfer,
          date: DateTime(2025, 1, 1),
          amount: 25,
          accountName: 'Bank',
          receivingAccountName: 'Cash',
        ),
      ], CsvImportDefaults(category: defaults.category, account: account));

      expect(count, 0);
    },
  );

  test('imports a very large file in a reasonable time', () async {
    const total = 20000;
    final stopwatch = Stopwatch()..start();

    final count = await service.importTransactions([
      for (var i = 0; i < total; i++)
        expense(i, account: 'Account ${i % 5}', category: 'Food'),
    ], defaults);

    stopwatch.stop();

    expect(count, total);
    expect(await db.select(db.transactions).get(), hasLength(total));
    expect(await db.select(db.accounts).get(), hasLength(5));
    expect(stopwatch.elapsed, lessThan(const Duration(seconds: 20)));
  });
}
