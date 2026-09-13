import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

/// The transactions list shows the payments the user still has to settle in
/// their own section, above the rest of the ledger. What lands there is decided
/// by `getTransactionsBySettlement`: a transaction is unsettled when it is
/// dated in the future, when it is a recurrency rule (its date is always the
/// next payment to make, so an overdue one is still unsettled) or when it is
/// explicitly marked as pending.
void main() {
  late AppDB db;
  late TransactionService service;

  final now = DateTime.now();

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
        .into(db.accounts)
        .insert(
          AccountInDB(
            id: 'acc-1',
            name: 'Account',
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

    await db
        .into(db.categories)
        .insert(
          const CategoryInDB(
            id: 'cat-1',
            name: 'Category',
            iconId: 'wallet',
            color: '#4385be',
            type: CategoryType.E,
            displayOrder: 0,
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> insertTransaction(
    String id, {
    required DateTime date,
    TransactionStatus? status,
    Periodicity? intervalPeriod,
  }) {
    return db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: id,
            date: date,
            accountID: 'acc-1',
            categoryID: 'cat-1',
            value: -10,
            type: TransactionType.expense,
            isHidden: false,
            status: status,
            intervalPeriod: intervalPeriod,
            intervalEach: intervalPeriod != null ? 1 : null,
          ),
        );
  }

  Future<List<String>> idsToSettle() async =>
      (await service.getTransactionsBySettlement(settled: false).first)
          .map((tr) => tr.id)
          .toList();

  Future<List<String>> settledIds() async =>
      (await service.getTransactionsBySettlement(settled: true).first)
          .map((tr) => tr.id)
          .toList();

  test('an overdue recurrency is still pending to settle', () async {
    await insertTransaction(
      'overdue-recurrency',
      date: now.subtract(const Duration(days: 90)),
      intervalPeriod: Periodicity.month,
    );
    await insertTransaction(
      'old-expense',
      date: now.subtract(const Duration(days: 2)),
    );

    expect(await idsToSettle(), ['overdue-recurrency']);
    expect(await settledIds(), ['old-expense']);
  });

  test('past transactions marked as pending are not settled', () async {
    await insertTransaction(
      'pending',
      date: now.subtract(const Duration(days: 30)),
      status: TransactionStatus.pending,
    );

    expect(await idsToSettle(), ['pending']);
    expect(await settledIds(), isEmpty);
  });

  test(
    'a transaction without status is settled once its date passes',
    () async {
      await insertTransaction(
        'past',
        date: now.subtract(const Duration(hours: 1)),
      );
      await insertTransaction('future', date: now.add(const Duration(days: 5)));

      expect(await idsToSettle(), ['future']);
      expect(await settledIds(), ['past']);
    },
  );

  test('the payments to settle come oldest-first', () async {
    await insertTransaction(
      'in-a-month',
      date: now.add(const Duration(days: 30)),
    );
    await insertTransaction(
      'overdue',
      date: now.subtract(const Duration(days: 10)),
      status: TransactionStatus.pending,
    );
    await insertTransaction('tomorrow', date: now.add(const Duration(days: 1)));

    expect(await idsToSettle(), ['overdue', 'tomorrow', 'in-a-month']);
  });

  test('both sides together cover every transaction exactly once', () async {
    await insertTransaction('a', date: now.subtract(const Duration(days: 1)));
    await insertTransaction('b', date: now.add(const Duration(days: 1)));
    await insertTransaction(
      'c',
      date: now.subtract(const Duration(days: 1)),
      status: TransactionStatus.voided,
    );
    await insertTransaction(
      'd',
      date: now.add(const Duration(days: 1)),
      intervalPeriod: Periodicity.year,
    );

    expect([...await idsToSettle(), ...await settledIds()]..sort(), [
      'a',
      'b',
      'c',
      'd',
    ]);
  });
}
