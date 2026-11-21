import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:monekin/core/services/exchange-rate/frankfurter_client.dart';

class _StubClient extends http.BaseClient {
  _StubClient(this.onSend);

  final Future<http.StreamedResponse> Function(http.BaseRequest request) onSend;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return onSend(request);
  }
}

http.StreamedResponse _json(int status, String body, http.BaseRequest request) {
  return http.StreamedResponse(
    Stream.value(utf8.encode(body)),
    status,
    request: request,
  );
}

void main() {
  test('parses a Frankfurter v2 quote', () {
    final quote = parseFrankfurterRate(
      '{"date":"2026-10-13","base":"USD","quote":"EUR","rate":0.89381}',
    );

    expect(quote.date, DateTime(2026, 10, 13));
    expect(quote.rate, 0.89381);
  });

  test('rejects a non-positive rate', () {
    expect(
      () => parseFrankfurterRate(
        '{"date":"2026-10-13","base":"USD","quote":"EUR","rate":0}',
      ),
      throwsA(isA<FrankfurterException>()),
    );
  });

  test('latest asks Frankfurter v2 without pinning a provider', () async {
    late Uri requested;
    final client = FrankfurterClient(
      client: _StubClient((request) async {
        requested = request.url;
        return _json(
          200,
          '{"date":"2026-10-13","base":"USD","quote":"EUR","rate":0.89381}',
          request,
        );
      }),
    );

    final quote = await client.latest(from: 'USD', to: 'EUR');

    expect(quote.rate, 0.89381);
    expect(requested.path, '/v2/rate/usd/eur');
    expect(requested.host, 'api.frankfurter.dev');
    expect(requested.hasQuery, isFalse);
  });

  test('latest sends the requested date', () async {
    late Uri requested;
    final client = FrankfurterClient(
      client: _StubClient((request) async {
        requested = request.url;
        return _json(
          200,
          '{"date":"2026-10-13","base":"USD","quote":"EUR","rate":0.89381}',
          request,
        );
      }),
    );

    await client.latest(from: 'USD', to: 'EUR', date: DateTime(2026, 10, 13));

    expect(requested.queryParameters, {'date': '2026-10-13'});
  });

  for (final status in [404, 422]) {
    test('flags a pair Frankfurter has no rate for (HTTP $status)', () async {
      final client = FrankfurterClient(
        client: _StubClient(
          (request) async => _json(status, 'not found', request),
        ),
      );

      expect(
        () => client.latest(from: 'BTC', to: 'EUR'),
        throwsA(
          isA<FrankfurterException>().having(
            (e) => e.notAvailable,
            'notAvailable',
            isTrue,
          ),
        ),
      );
    });
  }
}
