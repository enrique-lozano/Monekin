import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';

/// `getTransactionsValueBalanceOnDates` must return what running
/// `getTransactionsValueBalance` once per date returns.
void main() {
  late AppDB db;
  late TransactionService service;

  setUp(() async {
    db = AppDB.forTesting(NativeDatabase.memory());
    service = TransactionService.forTesting(db);

    for (final (code, isDefault) in [('EUR', true), ('USD', false)]) {
      await db
          .into(db.currencies)
          .insert(
            CurrencyInDB(
              code: code,
              symbol: code,
              name: code,
              decimalPlaces: 2,
              isDefault: isDefault,
              type: 0,
            ),
          );
    }

    await db
        .into(db.exchangeRates)
        .insert(
          ExchangeRateInDB(
            id: 'rate-usd',
            currencyCode: 'USD',
            date: DateTime(2020),
            exchangeRate: 0.5,
          ),
        );

    for (final (id, currency) in [('eur', 'EUR'), ('usd', 'USD')]) {
      await db
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

    await db
        .into(db.categories)
        .insert(
          const CategoryInDB(
            id: 'cat',
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

  Future<void> insert(
    String id,
    DateTime date,
    double value, {
    String account = 'eur',
    TransactionType type = TransactionType.expense,
    String? receivingAccount,
    double? valueInDestiny,
    TransactionStatus? status,
  }) {
    return db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: id,
            date: date,
            accountID: account,
            categoryID: type == TransactionType.transfer ? null : 'cat',
            receivingAccountID: receivingAccount,
            value: value,
            valueInDestiny: valueInDestiny,
            type: type,
            isHidden: false,
            status: status,
          ),
        );
  }

  test('matches one balance query per date', () async {
    final start = DateTime(2024, 3, 1);
    await insert('a', start.add(const Duration(days: 1)), -10);
    await insert(
      'b',
      start.add(const Duration(days: 3)),
      50,
      type: TransactionType.income,
    );
    await insert(
      'c',
      start.add(const Duration(days: 3, hours: 5)),
      -20,
      account: 'usd',
    );
    await insert(
      't',
      start.add(const Duration(days: 4)),
      -30,
      type: TransactionType.transfer,
      receivingAccount: 'usd',
      valueInDestiny: 60,
    );
    await insert(
      'pending',
      start.add(const Duration(days: 2)),
      -999,
      status: TransactionStatus.pending,
    );
    await insert(
      'voided',
      start.add(const Duration(days: 2)),
      -999,
      status: TransactionStatus.voided,
    );

    // Unsorted on purpose, with a repeated date
    final dates = [
      for (final d in [6, 0, 2, 4, 4, 5, 3]) start.add(Duration(days: d)),
    ];

    for (final filters in [
      const TransactionFilterSet(),
      const TransactionFilterSet(accountsIDs: ['eur']),
      const TransactionFilterSet(accountsIDs: ['usd']),
      const TransactionFilterSet(transactionTypes: [TransactionType.expense]),
    ]) {
      final expected = [
        for (final date in dates)
          await service
              .getTransactionsValueBalance(
                filters: filters.copyWith(maxDate: date),
              )
              .first,
      ];

      final actual = await service
          .getTransactionsValueBalanceOnDates(dates: dates, filters: filters)
          .first;

      expect(actual, hasLength(dates.length));
      for (var i = 0; i < dates.length; i++) {
        expect(actual[i], closeTo(expected[i], 1e-9), reason: '$filters #$i');
      }
    }
  });

  test('returns an empty list when there are no dates', () async {
    expect(
      await service.getTransactionsValueBalanceOnDates(dates: []).first,
      isEmpty,
    );
  });
}
