import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';

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
  test('parses a Frankfurter v2 ECB quote', () {
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
      throwsA(isA<FrankfurterEcbException>()),
    );
  });

  test('latest asks Frankfurter v2 for the ECB provider', () async {
    late Uri requested;
    final client = FrankfurterEcbClient(
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
    expect(requested.queryParameters['providers'], 'ecb');
    expect(requested.host, 'api.frankfurter.dev');
  });

  test('surfaces an unsupported pair', () async {
    final client = FrankfurterEcbClient(
      client: _StubClient((request) async => _json(404, 'not found', request)),
    );

    expect(
      () => client.latest(from: 'BTC', to: 'EUR'),
      throwsA(isA<FrankfurterEcbException>()),
    );
  });

  test('series asks for the date range and sorts the quotes', () async {
    late Uri requested;
    final client = FrankfurterEcbClient(
      client: _StubClient((request) async {
        requested = request.url;
        return _json(
          200,
          '[{"date":"2026-10-21","base":"USD","quote":"EUR","rate":0.9},'
          '{"date":"2026-10-20","base":"USD","quote":"EUR","rate":0.8}]',
          request,
        );
      }),
    );

    final quotes = await client.series(
      from: 'USD',
      to: 'EUR',
      start: DateTime(2026, 10, 20),
      end: DateTime(2026, 10, 21),
    );

    expect(quotes.map((q) => q.rate), [0.8, 0.9]);
    expect(requested.path, '/v2/rates');
    expect(requested.queryParameters['from'], '2026-10-20');
    expect(requested.queryParameters['to'], '2026-10-21');
    expect(requested.queryParameters['providers'], 'ecb');
  });
}
