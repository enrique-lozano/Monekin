import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/services/exchange-rate/ecb_rate_sync.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';

void main() {
  late AppDB db;
  late ExchangeRateService service;
  final today = DateTime(2026, 10, 29);

  Future<void> save(String id, String currency, DateTime date, double rate) {
    return db
        .into(db.exchangeRates)
        .insert(
          ExchangeRateInDB(
            id: id,
            date: date,
            currencyCode: currency,
            exchangeRate: rate,
          ),
        );
  }

  Future<EcbSyncResult> sync(
    Future<http.Response> Function(http.Request) handle,
  ) {
    return syncEcbRates(
      preferredCurrency: 'EUR',
      client: FrankfurterEcbClient(client: MockClient(handle)),
      exchangeRates: service,
      now: today,
    );
  }

  http.Response quote() =>
      http.Response('{"date":"2026-10-29","rate":1.2}', 200);

  setUp(() async {
    db = AppDB.forTesting(NativeDatabase.memory());
    service = ExchangeRateService.forTesting(db);

    for (final code in ['EUR', 'USD', 'GBP']) {
      await db
          .into(db.currencies)
          .insert(
            CurrencyInDB(
              code: code,
              name: code,
              symbol: code,
              decimalPlaces: 2,
              isDefault: true,
              type: 0,
            ),
          );
    }

    final yesterday = today.subtract(const Duration(days: 1));
    await save('usd', 'USD', yesterday, 1.1);
    await save('gbp', 'GBP', yesterday, 0.8);
  });

  tearDown(() => db.close());

  test('adds today\'s rate for every currency', () async {
    final result = await sync((_) async => quote());

    expect(result.addedRates, 2);
    expect(result.unpublishedCurrencies, isEmpty);
    expect(result.connectionFailed, isFalse);
    expect(await service.getExchangeRateItem('USD', today).first, isNotNull);
  });

  test('never overwrites a rate saved for today', () async {
    await save('manual', 'USD', today, 9.9);

    final result = await sync((_) async => quote());

    expect(result.addedRates, 1);
    final usd = await service.getExchangeRateItem('USD', today).first;
    expect(usd!.exchangeRate, 9.9);
  });

  test('reports currencies the ECB has no rate for apart', () async {
    final result = await sync(
      (request) async => request.url.path.contains('/usd/')
          ? http.Response('not found', 404)
          : quote(),
    );

    expect(result.addedRates, 1);
    expect(result.unpublishedCurrencies, ['USD']);
    expect(result.connectionFailed, isFalse);
  });

  test(
    'reports a connection failure without hiding it as unpublished',
    () async {
      final result = await sync(
        (_) async => throw const SocketException('off'),
      );

      expect(result.addedRates, 0);
      expect(result.unpublishedCurrencies, isEmpty);
      expect(result.connectionFailed, isTrue);
    },
  );
}
