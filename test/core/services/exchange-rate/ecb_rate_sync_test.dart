import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/services/exchange-rate/ecb_rate_sync.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';

void main() {
  late AppDB db;
  late ExchangeRateService service;
  late Map<SettingKey, String?> oldSettings;
  final today = DateTime(2026, 10, 29);

  Future<void> save(
    String id,
    DateTime date,
    double value, {
    String currency = 'EUR',
  }) async {
    await db
        .into(db.exchangeRates)
        .insert(
          ExchangeRateInDB(
            id: id,
            date: date,
            currencyCode: currency,
            exchangeRate: value,
          ),
        );
  }

  FrankfurterEcbClient client(
    Future<http.Response> Function(http.Request) handle,
  ) {
    return FrankfurterEcbClient(client: MockClient(handle));
  }

  http.Response quote() =>
      http.Response('{"date":"2026-10-29","rate":1.2}', 200);

  setUp(() async {
    oldSettings = Map.of(appStateSettings);
    db = AppDB.forTesting(NativeDatabase.memory());
    service = ExchangeRateService.forTesting(db);
    for (final code in ['EUR', 'USD', 'GBP', 'JPY']) {
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
    await service.changePreferredCurrency('USD');
    await save('yesterday', today.subtract(const Duration(days: 1)), 1.1);
  });

  tearDown(() async {
    await db.close();
    appStateSettings
      ..clear()
      ..addAll(oldSettings);
  });

  test('preserves today manual rate even with a newer future row', () async {
    await save('manual', today, 1.7);
    await save('future', today.add(const Duration(days: 1)), 1.9);
    var requests = 0;
    final result = await syncEcbRates(
      preferredCurrency: 'USD',
      exchangeRates: service,
      now: today,
      client: client((_) async {
        requests++;
        return quote();
      }),
    );
    expect(requests, 0);
    expect(result.addedRates, 0);
    expect(
      (await service.getExchangeRateItem('EUR', today).first)!.exchangeRate,
      1.7,
    );
  });

  test('does not overwrite a manual rate saved during HTTP lookup', () async {
    final started = Completer<void>();
    final response = Completer<http.Response>();
    final sync = syncEcbRates(
      preferredCurrency: 'USD',
      exchangeRates: service,
      now: today,
      client: client((_) {
        started.complete();
        return response.future;
      }),
    );
    await started.future;
    await save('manual', today, 1.8);
    response.complete(quote());
    expect((await sync).addedRates, 0);
    final saved = await service.getExchangeRateItem('EUR', today).first;
    expect(saved!.id, 'manual');
    expect(saved.exchangeRate, 1.8);
  });

  test(
    'changing the base while HTTP is pending cancels stale writes',
    () async {
      final started = Completer<void>();
      final response = Completer<http.Response>();
      final sync = syncEcbRates(
        preferredCurrency: 'USD',
        exchangeRates: service,
        now: today,
        client: client((_) {
          started.complete();
          return response.future;
        }),
      );
      await started.future;
      await service.changePreferredCurrency('GBP');
      response.complete(quote());
      final result = await sync;
      expect(result.cancelled, isTrue);
      expect(result.showSuccess, isFalse);
      expect(await db.select(db.exchangeRates).get(), isEmpty);
      expect(
        (await db.select(db.userSettings).getSingle()).settingValue,
        'GBP',
      );
    },
  );

  test('concurrent syncs count only the one row actually inserted', () async {
    final bothStarted = Completer<void>();
    final response = Completer<http.Response>();
    var requests = 0;
    final api = client((_) {
      if (++requests == 2) bothStarted.complete();
      return response.future;
    });
    final first = syncEcbRates(
      preferredCurrency: 'USD',
      exchangeRates: service,
      now: today,
      client: api,
    );
    final second = syncEcbRates(
      preferredCurrency: 'USD',
      exchangeRates: service,
      now: today,
      client: api,
    );
    await bothStarted.future;
    response.complete(quote());
    final results = await Future.wait([first, second]);
    expect(
      results.fold<int>(0, (total, result) => total + result.addedRates),
      1,
    );
    expect(
      (await service.getExchangeRateItem('EUR', today).first)!.exchangeRate,
      1.2,
    );
  });

  test('all failed requests do not report a successful update', () async {
    final result = await syncEcbRates(
      preferredCurrency: 'USD',
      exchangeRates: service,
      now: today,
      client: client((_) async => throw http.ClientException('offline')),
    );
    expect(result.addedRates, 0);
    expect(result.failedCurrencies, ['EUR']);
    expect(result.showSuccess, isFalse);
  });

  test(
    'partial failure keeps successful inserts and failed currency codes',
    () async {
      await save(
        'jpy-yesterday',
        today.subtract(const Duration(days: 1)),
        0.01,
        currency: 'JPY',
      );
      final result = await syncEcbRates(
        preferredCurrency: 'USD',
        exchangeRates: service,
        now: today,
        client: client((request) async {
          if (request.url.path.contains('/jpy/')) {
            throw http.ClientException('offline');
          }
          return quote();
        }),
      );
      expect(result.addedRates, 1);
      expect(result.failedCurrencies, ['JPY']);
      expect(result.showSuccess, isTrue);
    },
  );
}
