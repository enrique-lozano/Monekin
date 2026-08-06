import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';

void main() {
  late AppDB db;
  late SecurityService service;

  const securityId = 'sec-1';

  setUp(() {
    db = AppDB.forTesting(NativeDatabase.memory());
    service = SecurityService.forTesting(db);
  });

  tearDown(() async {
    await db.close();
  });

  SecurityInDB buildSecurity({double? price, DateTime? priceDate}) {
    return SecurityInDB(
      id: securityId,
      name: 'Apple',
      type: SecurityType.stock,
      currencyId: 'USD',
      ticker: 'AAPL',
      currentPrice: price,
      priceDate: priceDate,
    );
  }

  test('insertSecurity records an initial price point when priced', () async {
    await service.insertSecurity(
      buildSecurity(price: 100, priceDate: DateTime(2026, 1, 1)),
    );

    final history = await service.getPriceHistory(securityId).first;
    expect(history.length, 1);
    expect(history.first.price, 100);
  });

  test('insertSecurity without a price records no history', () async {
    await service.insertSecurity(buildSecurity());

    final history = await service.getPriceHistory(securityId).first;
    expect(history, isEmpty);
  });

  test('syncs the current price to the latest observation by date', () async {
    await service.insertSecurity(
      buildSecurity(price: 100, priceDate: DateTime(2026, 1, 1)),
    );
    // Add out of chronological order; the March point must win.
    await service.addPricePoint(securityId, 120, DateTime(2026, 3, 1));
    await service.addPricePoint(securityId, 110, DateTime(2026, 2, 1));
    await service.syncCurrentPriceFromHistory(securityId);

    final sec = await service.getSecurityById(securityId).first;
    expect(sec!.currentPrice, 120);
  });

  test('importPricePoints bulk-inserts and aligns the current price', () async {
    await service.insertSecurity(buildSecurity());

    final count = await service.importPricePoints(securityId, [
      (date: DateTime(2026, 1, 1), price: 10),
      (date: DateTime(2026, 2, 1), price: 20),
      (date: DateTime(2026, 3, 1), price: 30),
    ]);

    expect(count, 3);

    final history = await service.getPriceHistory(securityId).first;
    expect(history.length, 3);

    final sec = await service.getSecurityById(securityId).first;
    expect(sec!.currentPrice, 30);
  });

  test(
    'importPricePoints overwrites existing points on the same calendar date',
    () async {
      await service.insertSecurity(buildSecurity());
      await service.addPricePoint(securityId, 10, DateTime(2026, 1, 1));

      final count = await service.importPricePoints(securityId, [
        (date: DateTime(2026, 1, 1), price: 15),
        (date: DateTime(2026, 2, 1), price: 20),
      ]);

      expect(count, 2);

      final history = await service.getPriceHistory(securityId).first;
      expect(history.length, 2);
      expect(history.firstWhere((p) => p.date.month == 1).price, 15);
    },
  );

  test(
    'getDatesWithExistingPrice returns only dates already recorded',
    () async {
      await service.insertSecurity(buildSecurity());
      await service.addPricePoint(securityId, 10, DateTime(2026, 1, 1));

      final overlapping = await service.getDatesWithExistingPrice(securityId, [
        DateTime(2026, 1, 1),
        DateTime(2026, 2, 1),
      ]);

      expect(overlapping, {DateTime(2026, 1, 1)});
    },
  );

  test(
    'deletePricePoint realigns the current price to the previous point',
    () async {
      await service.insertSecurity(buildSecurity());
      await service.importPricePoints(securityId, [
        (date: DateTime(2026, 1, 1), price: 10),
        (date: DateTime(2026, 2, 1), price: 20),
      ]);

      final history = await service.getPriceHistory(securityId).first;
      final latest = history.last; // oldest-first, so last == newest (Feb, 20)
      await service.deletePricePoint(latest.id, securityId);

      final sec = await service.getSecurityById(securityId).first;
      expect(sec!.currentPrice, 10);
    },
  );

  test('updatePrice sets the current price and appends to history', () async {
    await service.insertSecurity(buildSecurity());

    await service.updatePrice(securityId, 250, date: DateTime(2026, 5, 1));

    final sec = await service.getSecurityById(securityId).first;
    expect(sec!.currentPrice, 250);

    final history = await service.getPriceHistory(securityId).first;
    expect(history.any((p) => p.price == 250), isTrue);
  });

  test('updatePrice replaces the observation of the same day', () async {
    await service.insertSecurity(buildSecurity());

    // Correcting a typo minutes later must not leave two points on that day,
    // which would make "the latest price of the day" ambiguous.
    await service.updatePrice(securityId, 250, date: DateTime(2026, 5, 1, 9));
    await service.updatePrice(securityId, 260, date: DateTime(2026, 5, 1, 18));
    await service.updatePrice(securityId, 270, date: DateTime(2026, 5, 2));

    final history = await service.getPriceHistory(securityId).first;
    expect(history.length, 2);
    expect(history.firstWhere((p) => p.date.day == 1).price, 260);

    final sec = await service.getSecurityById(securityId).first;
    expect(sec!.currentPrice, 270);
  });

  test(
    'getPriceAtDate returns the latest observation up to the date',
    () async {
      await service.insertSecurity(
        buildSecurity(price: 100, priceDate: DateTime(2026, 1, 1)),
      );
      await service.addPricePoint(securityId, 200, DateTime(2026, 2, 1));
      await service.addPricePoint(securityId, 300, DateTime(2026, 3, 1));

      expect(
        await service.getPriceAtDate(securityId, DateTime(2026, 1, 15)),
        100,
      );
      expect(
        await service.getPriceAtDate(securityId, DateTime(2026, 2, 15)),
        200,
      );
      expect(
        await service.getPriceAtDate(securityId, DateTime(2026, 3, 15)),
        300,
      );
    },
  );

  test(
    'getPriceAtDate falls back to the current price before any history',
    () async {
      await service.insertSecurity(
        buildSecurity(price: 100, priceDate: DateTime(2026, 1, 1)),
      );

      // No observation on/before this date, so the current price is used.
      expect(
        await service.getPriceAtDate(securityId, DateTime(2025, 12, 1)),
        100,
      );
    },
  );
}
