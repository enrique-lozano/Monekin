import 'dart:convert';

import 'package:http/http.dart' as http;

/// Visible credit for the rates obtained through Frankfurter.
const frankfurterCredit = 'Exchange rates via Frankfurter';

class FrankfurterRate {
  const FrankfurterRate({required this.date, required this.rate});

  final DateTime date;
  final double rate;
}

class FrankfurterException implements Exception {
  FrankfurterException(this.message, {this.notAvailable = false});

  final String message;

  /// Frankfurter has no rate for the request: a currency or date none of its
  /// providers cover (HTTP 404), or a currency code it doesn't know at all
  /// (HTTP 422).
  final bool notAvailable;

  @override
  String toString() => message;
}

class FrankfurterClient {
  FrankfurterClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _timeout = Duration(seconds: 5);

  void close() => _client.close();

  Future<String> _get(Uri uri, String label) async {
    final response = await _client
        .get(
          uri,
          headers: const {
            'Accept': 'application/json',
            'User-Agent': 'Monekin (https://github.com/enrique-lozano/Monekin)',
          },
        )
        .timeout(_timeout);

    if (response.statusCode != 200) {
      throw FrankfurterException(
        'Frankfurter returned HTTP ${response.statusCode} for $label',
        notAvailable: response.statusCode == 404 || response.statusCode == 422,
      );
    }

    return response.body;
  }

  /// Rate: how many [to] units one [from] unit buys. Without a [date] it is
  /// the latest one; otherwise the one of the closest business day on or
  /// before it.
  ///
  /// Uses Frankfurter v2, which blends all its providers. v1 is frozen.
  Future<FrankfurterRate> latest({
    required String from,
    required String to,
    DateTime? date,
  }) async {
    final base = from.trim().toLowerCase();
    final quote = to.trim().toLowerCase();
    final uri = Uri.parse('https://api.frankfurter.dev/v2/rate/$base/$quote')
        .replace(
          queryParameters: date == null ? null : {'date': _formatIsoDate(date)},
        );

    return parseFrankfurterRate(await _get(uri, '$base/$quote'));
  }
}

String _formatIsoDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

FrankfurterRate parseFrankfurterRate(String body) {
  final decoded = jsonDecode(body);
  if (decoded is! Map<String, dynamic>) {
    throw FrankfurterException('Unexpected Frankfurter response');
  }

  final dateRaw = decoded['date'];
  final rateRaw = decoded['rate'];
  if (dateRaw is! String || rateRaw is! num || rateRaw <= 0) {
    throw FrankfurterException('Unexpected Frankfurter response');
  }

  final date = _parseIsoDate(dateRaw);
  if (date == null) {
    throw FrankfurterException('Unexpected Frankfurter date');
  }

  return FrankfurterRate(date: date, rate: rateRaw.toDouble());
}

DateTime? _parseIsoDate(String value) {
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(value);
  if (match == null) return null;

  final year = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final day = int.parse(match.group(3)!);
  final date = DateTime(year, month, day);
  if (date.year != year || date.month != month || date.day != day) {
    return null;
  }
  return date;
}
