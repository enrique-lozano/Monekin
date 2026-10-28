import 'dart:convert';

import 'package:http/http.dart' as http;

/// Visible credit required by Frankfurter for European Central Bank rates.
const frankfurterEcbCredit = 'European Central Bank via Frankfurter';

class FrankfurterRate {
  const FrankfurterRate({required this.date, required this.rate});

  final DateTime date;
  final double rate;
}

class FrankfurterEcbException implements Exception {
  FrankfurterEcbException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FrankfurterEcbClient {
  FrankfurterEcbClient({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  static const _timeout = Duration(seconds: 8);

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
      throw FrankfurterEcbException(
        'Frankfurter returned HTTP ${response.statusCode} for $label',
      );
    }

    return response.body;
  }

  /// ECB rate: how many [to] units one [from] unit buys. Without a [date] it
  /// is the latest one; otherwise the one of the closest ECB business day
  /// on or before it.
  ///
  /// Uses Frankfurter v2 pinned to the ECB provider. Unpinned v2 blends
  /// other sources, and v1 is frozen.
  Future<FrankfurterRate> latest({
    required String from,
    required String to,
    DateTime? date,
  }) async {
    final base = from.trim().toLowerCase();
    final quote = to.trim().toLowerCase();
    final uri = Uri.parse('https://api.frankfurter.dev/v2/rate/$base/$quote')
        .replace(
          queryParameters: {
            'providers': 'ecb',
            if (date != null) 'date': _formatIsoDate(date),
          },
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
    throw FrankfurterEcbException('Unexpected Frankfurter response');
  }

  final dateRaw = decoded['date'];
  final rateRaw = decoded['rate'];
  if (dateRaw is! String || rateRaw is! num || rateRaw <= 0) {
    throw FrankfurterEcbException('Unexpected Frankfurter response');
  }

  final date = _parseIsoDate(dateRaw);
  if (date == null) {
    throw FrankfurterEcbException('Unexpected Frankfurter date');
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
