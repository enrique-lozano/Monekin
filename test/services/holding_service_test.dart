import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

void main() {
  late AppDB db;
  late HoldingService service;

  const accountId = 'acc-1';
  const securityId = 'sec-1';

  setUp(() {
    db = AppDB.forTesting(NativeDatabase.memory());
    service = HoldingService.forTesting(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> insertTrade({
    required double quantity,
    required double price,
    required DateTime date,
    String account = accountId,
    String security = securityId,
  }) {
    return db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: 'tx-${account}_${security}_${date.microsecondsSinceEpoch}_$quantity',
            date: date,
            accountID: account,
            value: -(quantity * price),
            type: TransactionType.investment,
            securityID: security,
            quantity: quantity,
            pricePerUnit: price,
            isHidden: false,
          ),
        );
  }

  Future<void> insertAccount(String id, AccountTrackingMode mode) {
    return db
        .into(db.accounts)
        .insert(
          AccountInDB(
            id: id,
            name: 'Account $id',
            iniValue: 0,
            date: DateTime(2026),
            type: AccountType.investment,
            isSaving: false,
            trackingMode: mode,
            iconId: 'wallet',
            displayOrder: 0,
            currencyId: 'USD',
          ),
        );
  }

  Future<void> insertSecurity(
    String id, {
    double currentPrice = 0,
    String currency = 'USD',
  }) {
    return db
        .into(db.securities)
        .insert(
          SecurityInDB(
            id: id,
            name: 'Security $id',
            type: SecurityType.stock,
            currencyId: currency,
            currentPrice: currentPrice,
          ),
        );
  }

  Future<void> insertHolding(
    String account,
    String security, {
    double quantity = 0,
    double avgCost = 0,
  }) {
    return db
        .into(db.holdings)
        .insert(
          HoldingInDB(
            id: 'hold-${account}_$security',
            accountID: account,
            securityID: security,
            quantity: quantity,
            avgCostPrice: avgCost,
          ),
        );
  }

  Future<void> insertPricePoint(String security, double price, DateTime date) {
    return db
        .into(db.securityPriceHistory)
        .insert(
          SecurityPriceHistoryInDB(
            id: 'sph-${security}_${date.microsecondsSinceEpoch}',
            securityID: security,
            date: date,
            price: price,
          ),
        );
  }

  test('computes weighted-average cost across several buys', () async {
    await insertTrade(quantity: 10, price: 100, date: DateTime(2026, 1, 1));
    await insertTrade(quantity: 10, price: 200, date: DateTime(2026, 2, 1));

    await service.recomputeHolding(
      accountId: accountId,
      securityId: securityId,
    );

    final holding = await service.getHolding(accountId, securityId).first;
    expect(holding, isNotNull);
    expect(holding!.quantity, 20);
    expect(holding.avgCostPrice, 150);
  });

  test('keeps the average cost after a partial sell', () async {
    await insertTrade(quantity: 10, price: 100, date: DateTime(2026, 1, 1));
    await insertTrade(quantity: 10, price: 200, date: DateTime(2026, 2, 1));
    await insertTrade(quantity: -5, price: 300, date: DateTime(2026, 3, 1));

    await service.recomputeHolding(
      accountId: accountId,
      securityId: securityId,
    );

    final holding = await service.getHolding(accountId, securityId).first;
    expect(holding, isNotNull);
    expect(holding!.quantity, 15);
    // Selling does not change the weighted-average cost basis.
    expect(holding.avgCostPrice, 150);
  });

  test('deletes the holding when the position is fully sold', () async {
    await insertTrade(quantity: 10, price: 100, date: DateTime(2026, 1, 1));
    await insertTrade(quantity: -10, price: 120, date: DateTime(2026, 2, 1));

    await service.recomputeHolding(
      accountId: accountId,
      securityId: securityId,
    );

    final holding = await service.getHolding(accountId, securityId).first;
    expect(holding, isNull);
  });

  test('replays trades in date order regardless of insertion order', () async {
    // Inserted newest-first, but the buy at 200 happens *after* the buy at 100.
    await insertTrade(quantity: 10, price: 200, date: DateTime(2026, 2, 1));
    await insertTrade(quantity: 10, price: 100, date: DateTime(2026, 1, 1));

    await service.recomputeHolding(
      accountId: accountId,
      securityId: securityId,
    );

    final holding = await service.getHolding(accountId, securityId).first;
    expect(holding!.avgCostPrice, 150);
  });

  test('ignores trades from other accounts or securities', () async {
    await insertTrade(quantity: 10, price: 100, date: DateTime(2026, 1, 1));
    await insertTrade(
      quantity: 5,
      price: 50,
      date: DateTime(2026, 1, 2),
      account: 'acc-2',
    );
    await insertTrade(
      quantity: 7,
      price: 70,
      date: DateTime(2026, 1, 3),
      security: 'sec-2',
    );

    await service.recomputeHolding(
      accountId: accountId,
      securityId: securityId,
    );

    final holding = await service.getHolding(accountId, securityId).first;
    expect(holding!.quantity, 10);
    expect(holding.avgCostPrice, 100);
  });

  group('time-aware market value', () {
    test(
      'transactions mode uses quantity and price as of the given date',
      () async {
        await insertAccount(accountId, AccountTrackingMode.transactions);
        await insertSecurity(securityId, currentPrice: 300);
        await insertHolding(accountId, securityId, quantity: 20, avgCost: 150);

        await insertTrade(quantity: 10, price: 100, date: DateTime(2026, 1, 1));
        await insertTrade(quantity: 10, price: 200, date: DateTime(2026, 2, 1));

        await insertPricePoint(securityId, 100, DateTime(2026, 1, 1));
        await insertPricePoint(securityId, 200, DateTime(2026, 2, 1));
        await insertPricePoint(securityId, 300, DateTime(2026, 3, 1));

        final janValue = await service
            .getHoldingsMarketValue(
              accountIds: [accountId],
              date: DateTime(2026, 1, 15),
            )
            .first;
        // Only the January buy has happened, at the January price.
        expect(janValue, closeTo(10 * 100, 0.001));

        final febValue = await service
            .getHoldingsMarketValue(
              accountIds: [accountId],
              date: DateTime(2026, 2, 15),
            )
            .first;
        expect(febValue, closeTo(20 * 200, 0.001));

        final marValue = await service
            .getHoldingsMarketValue(
              accountIds: [accountId],
              date: DateTime(2026, 3, 15),
            )
            .first;
        expect(marValue, closeTo(20 * 300, 0.001));
      },
    );

    test('holdings mode uses the latest snapshot as of the date', () async {
      await insertAccount('acc-h', AccountTrackingMode.holdings);
      await insertSecurity('sec-h', currentPrice: 50);

      await service.saveAccountSnapshot(
        accountId: 'acc-h',
        date: DateTime(2026, 1, 1),
        positions: [(securityId: 'sec-h', quantity: 2, avgCostPrice: 40)],
      );
      await service.saveAccountSnapshot(
        accountId: 'acc-h',
        date: DateTime(2026, 2, 1),
        positions: [(securityId: 'sec-h', quantity: 5, avgCostPrice: 42)],
      );

      await insertPricePoint('sec-h', 40, DateTime(2026, 1, 1));
      await insertPricePoint('sec-h', 50, DateTime(2026, 2, 1));

      final janValue = await service
          .getHoldingsMarketValue(
            accountIds: ['acc-h'],
            date: DateTime(2026, 1, 15),
          )
          .first;
      expect(janValue, closeTo(2 * 40, 0.001));

      final febValue = await service
          .getHoldingsMarketValue(
            accountIds: ['acc-h'],
            date: DateTime(2026, 2, 15),
          )
          .first;
      expect(febValue, closeTo(5 * 50, 0.001));
    });

    test(
      'transactions mode reflects a sold-out position at a past date',
      () async {
        await insertAccount(accountId, AccountTrackingMode.transactions);
        await insertSecurity(securityId, currentPrice: 0);

        await insertTrade(quantity: 10, price: 100, date: DateTime(2026, 1, 1));
        await insertTrade(
          quantity: -10,
          price: 120,
          date: DateTime(2026, 2, 1),
        );

        // The position is fully sold, so there is no current holding row.
        await service.recomputeHolding(
          accountId: accountId,
          securityId: securityId,
        );
        expect(await service.getHolding(accountId, securityId).first, isNull);

        await insertPricePoint(securityId, 100, DateTime(2026, 1, 1));
        await insertPricePoint(securityId, 120, DateTime(2026, 2, 1));

        // Even without a current holding, the value at a date when it was
        // still held is derived from the trade history (universe fix).
        final janValue = await service
            .getHoldingsMarketValue(
              accountIds: [accountId],
              date: DateTime(2026, 1, 15),
            )
            .first;
        expect(janValue, closeTo(10 * 100, 0.001));

        // After the sale it is worth nothing.
        final marValue = await service
            .getHoldingsMarketValue(
              accountIds: [accountId],
              date: DateTime(2026, 3, 1),
            )
            .first;
        expect(marValue, closeTo(0, 0.001));
      },
    );
  });

  group('per-holding valuation at date', () {
    test('transactions mode reports market and cost basis at date', () async {
      await insertAccount(accountId, AccountTrackingMode.transactions);
      await insertSecurity(securityId, currentPrice: 300);
      await insertHolding(accountId, securityId, quantity: 20, avgCost: 150);

      await insertTrade(quantity: 10, price: 100, date: DateTime(2026, 1, 1));
      await insertTrade(quantity: 10, price: 200, date: DateTime(2026, 2, 1));

      await insertPricePoint(securityId, 100, DateTime(2026, 1, 1));
      await insertPricePoint(securityId, 200, DateTime(2026, 2, 1));
      await insertPricePoint(securityId, 300, DateTime(2026, 3, 1));

      final valuations = await service
          .getHoldingValuationsAtDate(DateTime(2026, 3, 15))
          .first;

      expect(valuations.length, 1);
      final v = valuations.single;
      expect(v.securityId, securityId);
      expect(v.securityType, SecurityType.stock);
      expect(v.currencyId, 'USD');
      expect(v.market, closeTo(20 * 300, 0.001));
      // Weighted-average cost = (10*100 + 10*200) / 20 = 150.
      expect(v.cost, closeTo(20 * 150, 0.001));

      // Earlier in time only the January buy counts.
      final janValuations = await service
          .getHoldingValuationsAtDate(DateTime(2026, 1, 15))
          .first;
      expect(janValuations.single.market, closeTo(10 * 100, 0.001));
      expect(janValuations.single.cost, closeTo(10 * 100, 0.001));
    });

    test('holdings mode reports market and cost from the snapshot', () async {
      await insertAccount('acc-h3', AccountTrackingMode.holdings);
      await insertSecurity('sec-h3', currentPrice: 50);

      await service.saveAccountSnapshot(
        accountId: 'acc-h3',
        date: DateTime(2026, 1, 1),
        positions: [(securityId: 'sec-h3', quantity: 2, avgCostPrice: 40)],
      );
      await service.saveAccountSnapshot(
        accountId: 'acc-h3',
        date: DateTime(2026, 2, 1),
        positions: [(securityId: 'sec-h3', quantity: 5, avgCostPrice: 42)],
      );

      await insertPricePoint('sec-h3', 40, DateTime(2026, 1, 1));
      await insertPricePoint('sec-h3', 50, DateTime(2026, 2, 1));

      final valuations = await service
          .getHoldingValuationsAtDate(DateTime(2026, 2, 15))
          .first;

      final v = valuations.firstWhere((e) => e.securityId == 'sec-h3');
      expect(v.market, closeTo(5 * 50, 0.001));
      expect(v.cost, closeTo(5 * 42, 0.001));
    });
  });

  group('portfolio snapshots', () {
    test('mirror the latest snapshot into the holdings', () async {
      await insertAccount('acc-h2', AccountTrackingMode.holdings);
      await insertSecurity('sec-h2', currentPrice: 10);

      await service.saveAccountSnapshot(
        accountId: 'acc-h2',
        date: DateTime(2026, 1, 1),
        positions: [(securityId: 'sec-h2', quantity: 2, avgCostPrice: 40)],
      );
      await service.saveAccountSnapshot(
        accountId: 'acc-h2',
        date: DateTime(2026, 2, 1),
        positions: [(securityId: 'sec-h2', quantity: 5, avgCostPrice: 42)],
      );

      var holding = await service.getHolding('acc-h2', 'sec-h2').first;
      expect(holding, isNotNull);
      expect(holding!.quantity, 5);
      expect(holding.avgCostPrice, 42);

      // Deleting the latest snapshot realigns with the previous one.
      final febId = (await service.getAccountSnapshots('acc-h2').first)
          .firstWhere((s) => s.date == DateTime(2026, 2, 1))
          .id;
      await service.deleteAccountSnapshot(febId, 'acc-h2');
      holding = await service.getHolding('acc-h2', 'sec-h2').first;
      expect(holding, isNotNull);
      expect(holding!.quantity, 2);
      expect(holding.avgCostPrice, 40);

      // Deleting the last snapshot removes the holding entirely.
      final janId =
          (await service.getAccountSnapshots('acc-h2').first).single.id;
      await service.deleteAccountSnapshot(janId, 'acc-h2');
      holding = await service.getHolding('acc-h2', 'sec-h2').first;
      expect(holding, isNull);
    });

    test(
      'a security dropped from the latest snapshot is no longer held',
      () async {
        await insertAccount('acc-m', AccountTrackingMode.holdings);
        await insertSecurity('sec-a', currentPrice: 10);
        await insertSecurity('sec-b', currentPrice: 20);

        // Jan: two positions.
        await service.saveAccountSnapshot(
          accountId: 'acc-m',
          date: DateTime(2026, 1, 1),
          positions: [
            (securityId: 'sec-a', quantity: 3, avgCostPrice: 10),
            (securityId: 'sec-b', quantity: 4, avgCostPrice: 20),
          ],
        );
        // Feb: only sec-a remains (sec-b was dropped -> sold).
        await service.saveAccountSnapshot(
          accountId: 'acc-m',
          date: DateTime(2026, 2, 1),
          positions: [(securityId: 'sec-a', quantity: 3, avgCostPrice: 10)],
        );

        // Current holdings mirror the latest snapshot: only sec-a is held.
        expect(await service.getHolding('acc-m', 'sec-a').first, isNotNull);
        expect(await service.getHolding('acc-m', 'sec-b').first, isNull);

        await insertPricePoint('sec-a', 10, DateTime(2026, 1, 1));
        await insertPricePoint('sec-b', 20, DateTime(2026, 1, 1));

        // In January both were held.
        final janVals = await service
            .getHoldingValuationsAtDate(DateTime(2026, 1, 15))
            .first;
        expect(
          janVals.where((v) => v.accountId == 'acc-m' && v.market > 0).length,
          2,
        );

        // In February only sec-a is held (sec-b absent -> quantity 0).
        final febVals = await service
            .getHoldingValuationsAtDate(DateTime(2026, 2, 15))
            .first;
        expect(
          febVals.where((v) => v.accountId == 'acc-m' && v.market > 0).length,
          1,
        );
      },
    );

    test('an empty snapshot clears the holdings', () async {
      await insertAccount('acc-e', AccountTrackingMode.holdings);
      await insertSecurity('sec-e', currentPrice: 10);

      await service.saveAccountSnapshot(
        accountId: 'acc-e',
        date: DateTime(2026, 1, 1),
        positions: [(securityId: 'sec-e', quantity: 2, avgCostPrice: 10)],
      );
      expect(await service.getHolding('acc-e', 'sec-e').first, isNotNull);

      // A later empty snapshot means "nothing held from this date on".
      await service.saveAccountSnapshot(
        accountId: 'acc-e',
        date: DateTime(2026, 2, 1),
        positions: const [],
      );
      expect(await service.getHolding('acc-e', 'sec-e').first, isNull);
    });
  });
}
