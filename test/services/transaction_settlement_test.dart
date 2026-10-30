import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/transactions/details/utils/transaction_details.utils.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';

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
    TransactionType type = TransactionType.expense,
    double value = -10,
    String? receivingAccountId,
    double? valueInDestiny,
  }) {
    return db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: id,
            date: date,
            accountID: 'acc-1',
            categoryID: type.isIncomeOrExpense ? 'cat-1' : null,
            assetID: type == TransactionType.investment ? 'asset-1' : null,
            receivingAccountID: receivingAccountId,
            valueInDestiny: valueInDestiny,
            value: value,
            type: type,
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

  test(
    'financial totals exclude rules without hiding them from queries',
    () async {
      await insertTransaction(
        'overdue-rule',
        date: now.subtract(const Duration(days: 90)),
        intervalPeriod: Periodicity.month,
      );
      await insertTransaction(
        'future-rule',
        date: now.add(const Duration(days: 5)),
        intervalPeriod: Periodicity.month,
      );
      await insertTransaction(
        'posted',
        date: now.subtract(const Duration(days: 1)),
      );
      await insertTransaction(
        'pending',
        date: now.subtract(const Duration(days: 1)),
        status: TransactionStatus.pending,
      );
      await insertTransaction(
        'voided',
        date: now.subtract(const Duration(days: 1)),
        status: TransactionStatus.voided,
      );

      expect(await service.getTransactionsValueBalance().first, -10);
      expect(await service.countTransactions().first, 5);
      expect(await service.countTransactions(onlyPosted: true).first, 1);
      expect(
        (await service
                .getTransactions(
                  filters: const TransactionFilterSet(isRecurrent: true),
                )
                .first)
            .length,
        2,
      );
    },
  );

  test('posted totals intersect a recurring-only scope', () async {
    await insertTransaction(
      'rule',
      date: now.subtract(const Duration(days: 1)),
      intervalPeriod: Periodicity.month,
      value: -10,
    );
    await insertTransaction(
      'one-off',
      date: now.subtract(const Duration(days: 1)),
      value: -100,
    );

    expect(
      await service
          .getTransactionsValueBalance(
            filters: const TransactionFilterSet(isRecurrent: true),
          )
          .first,
      0,
    );
    expect(
      await service
          .getTransactionsValueBalance(
            filters: const TransactionFilterSet(
              isRecurrent: true,
              transactionTypes: [TransactionType.expense],
            ),
          )
          .first,
      0,
    );
    expect(
      await service
          .countTransactions(
            filters: const TransactionFilterSet(isRecurrent: true),
            onlyPosted: true,
          )
          .first,
      0,
    );
    expect(
      await service
          .getTransactions(
            filters: const TransactionFilterSet(isRecurrent: true),
            onlyPosted: true,
          )
          .first,
      isEmpty,
    );
    expect(
      await service
          .countTransactions(
            filters: const TransactionFilterSet(isRecurrent: true),
          )
          .first,
      1,
    );
    for (final isRecurrent in [null, false]) {
      expect(
        await service
            .getTransactionsValueBalance(
              filters: TransactionFilterSet(isRecurrent: isRecurrent),
            )
            .first,
        -100,
      );
    }
  });

  test('posted investment volume intersects a recurring-only scope', () async {
    await insertTransaction(
      'investment-rule',
      date: now.subtract(const Duration(days: 1)),
      intervalPeriod: Periodicity.month,
      type: TransactionType.investment,
      value: -10,
    );
    await insertTransaction(
      'investment-buy',
      date: now.subtract(const Duration(days: 1)),
      type: TransactionType.investment,
      value: -100,
    );

    expect(
      await service
          .getInvestmentBuyVolume(
            filters: const TransactionFilterSet(isRecurrent: true),
          )
          .first,
      0,
    );
    expect(
      await service
          .getInvestmentBuyVolume(
            filters: const TransactionFilterSet(isRecurrent: false),
          )
          .first,
      100,
    );
  });

  test('financial totals preserve date and status restrictions', () async {
    await insertTransaction(
      'past',
      date: now.subtract(const Duration(days: 1)),
    );
    await insertTransaction('future', date: now.add(const Duration(days: 1)));
    await insertTransaction(
      'reconciled',
      date: now.subtract(const Duration(days: 1)),
      status: TransactionStatus.reconciled,
    );

    expect(
      await service
          .getTransactionsValueBalance(
            filters: TransactionFilterSet(maxDate: now),
          )
          .first,
      -20,
    );
    expect(
      await service
          .getTransactionsValueBalance(
            filters: TransactionFilterSet(
              maxDate: now,
              status: [TransactionStatus.reconciled],
            ),
          )
          .first,
      -10,
    );
  });

  test(
    'advancing a rule does not count it and acceptance counts once',
    () async {
      await insertTransaction(
        'rule',
        date: now.subtract(const Duration(days: 90)),
        intervalPeriod: Periodicity.month,
      );
      final rule = (await service.getTransactionById('rule').first)!;
      expect(await service.getTransactionsValueBalance().first, 0);

      await db
          .update(db.transactions)
          .replace(rule.copyWith(date: now.subtract(const Duration(days: 60))));
      expect(await service.getTransactionsValueBalance().first, 0);

      await service.insertTransaction(
        buildAcceptedTransaction(rule, datetime: now),
      );
      expect(await service.getTransactionsValueBalance().first, -10);

      await db
          .update(db.transactions)
          .replace(rule.copyWith(date: now.add(const Duration(days: 30))));
      expect(await service.getTransactionsValueBalance().first, -10);
    },
  );

  test('recurring transfers affect neither account until posted', () async {
    final account = await db.select(db.accounts).getSingle();
    await db
        .into(db.accounts)
        .insert(account.copyWith(id: 'acc-2', name: 'Destination'));
    await insertTransaction(
      'transfer-rule',
      date: now.subtract(const Duration(days: 90)),
      intervalPeriod: Periodicity.month,
      type: TransactionType.transfer,
      value: 100,
      receivingAccountId: 'acc-2',
      valueInDestiny: 90,
    );

    Future<double> balanceFor(String accountId) => service
        .getTransactionsValueBalance(
          filters: TransactionFilterSet(accountsIDs: [accountId]),
          convertToPreferredCurrency: false,
        )
        .first;

    expect(await balanceFor('acc-1'), 0);
    expect(await balanceFor('acc-2'), 0);

    final rule = (await service.getTransactionById('transfer-rule').first)!;
    await service.insertTransaction(
      buildAcceptedTransaction(rule, datetime: now),
    );

    expect(await balanceFor('acc-1'), -100);
    expect(await balanceFor('acc-2'), 90);
  });

  test('investment buy volume counts only posted buys', () async {
    for (final status in [null, ...TransactionStatus.values]) {
      await insertTransaction(
        'buy-${status?.name}',
        date: now.subtract(const Duration(days: 1)),
        status: status,
        type: TransactionType.investment,
        value: -100,
      );
    }
    await insertTransaction(
      'buy-rule',
      date: now.subtract(const Duration(days: 90)),
      intervalPeriod: Periodicity.month,
      type: TransactionType.investment,
      value: -500,
    );
    await insertTransaction(
      'sell',
      date: now.subtract(const Duration(days: 1)),
      type: TransactionType.investment,
      value: 200,
    );

    expect(
      await service
          .getInvestmentBuyVolume(filters: const TransactionFilterSet())
          .first,
      300,
    );
  });

  test('recent history includes voided entries but not unpaid items', () async {
    await insertTransaction(
      'posted',
      date: now.subtract(const Duration(days: 1)),
    );
    await insertTransaction(
      'voided',
      date: now.subtract(const Duration(days: 1)),
      status: TransactionStatus.voided,
    );
    await insertTransaction(
      'pending',
      date: now.subtract(const Duration(days: 1)),
      status: TransactionStatus.pending,
    );
    await insertTransaction('future', date: now.add(const Duration(days: 1)));
    await insertTransaction(
      'rule',
      date: now.subtract(const Duration(days: 90)),
      intervalPeriod: Periodicity.month,
    );

    final filters = TransactionFilterSet(
      accountsIDs: ['acc-1'],
      status: TransactionStatus.notIn({TransactionStatus.pending}),
      isRecurrent: false,
      maxDate: now,
    );

    expect(
      (await service.getTransactions(filters: filters).first).map(
        (transaction) => transaction.id,
      ),
      unorderedEquals(['posted', 'voided']),
    );
    expect(await service.countTransactions(filters: filters).first, 2);
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
