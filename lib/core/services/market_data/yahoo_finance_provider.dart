import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:monekin/core/services/market_data/market_data_provider.dart';
import 'package:monekin/core/utils/logger.dart';

/// [MarketDataProvider] backed by Yahoo Finance's public JSON endpoints. No API
/// key is required.
class YahooFinanceProvider implements MarketDataProvider {
  YahooFinanceProvider({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  static const _base = 'https://query1.finance.yahoo.com';

  // Yahoo rejects requests without a browser-like User-Agent.
  static const _headers = {
    'User-Agent': 'Mozilla/5.0 (compatible; Monekin/1.0; +https://monekin.app)',
    'Accept': 'application/json',
  };

  static const _timeout = Duration(seconds: 8);

  static const _supportedTypes = {
    'EQUITY',
    'ETF',
    'MUTUALFUND',
    'CRYPTOCURRENCY',
  };

  @override
  String get id => 'yahoo_finance';

  @override
  Future<List<MarketSearchResult>> search(String query, {int limit = 8}) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const [];

    final uri = Uri.parse('$_base/v1/finance/search').replace(
      queryParameters: {
        'q': trimmed,
        'quotesCount': '$limit',
        'newsCount': '0',
        'listsCount': '0',
        'enableFuzzyQuery': 'false',
      },
    );

    try {
      final res = await _client.get(uri, headers: _headers).timeout(_timeout);
      if (res.statusCode != 200) return const [];

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final quotes = (data['quotes'] as List?) ?? const [];

      final results = <MarketSearchResult>[];
      for (final raw in quotes) {
        if (raw is! Map<String, dynamic>) continue;

        final symbol = raw['symbol'] as String?;
        final quoteType = raw['quoteType'] as String?;
        if (symbol == null || quoteType == null) continue;
        if (!_supportedTypes.contains(quoteType)) continue;

        final name = (raw['longname'] ?? raw['shortname'] ?? symbol).toString();

        results.add(
          MarketSearchResult(
            symbol: symbol,
            name: name,
            quoteType: quoteType,
            exchange: raw['exchange'] as String?,
            exchangeName: raw['exchDisp'] as String?,
            sector: raw['sector'] as String?,
            industry: raw['industry'] as String?,
          ),
        );
      }

      return results;
    } catch (e) {
      Logger.printDebug('Yahoo search failed: $e');
      return const [];
    }
  }

  @override
  Future<MarketQuote?> getQuote(String symbol) async {
    final uri = Uri.parse(
      '$_base/v8/finance/chart/${Uri.encodeComponent(symbol)}',
    ).replace(queryParameters: {'range': '1d', 'interval': '1d'});

    try {
      final res = await _client.get(uri, headers: _headers).timeout(_timeout);
      if (res.statusCode != 200) return null;

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final results = (data['chart'] as Map<String, dynamic>?)?['result'];
      if (results is! List || results.isEmpty) return null;

      final meta = (results.first as Map<String, dynamic>)['meta'];
      if (meta is! Map<String, dynamic>) return null;

      return MarketQuote(
        symbol: symbol,
        currencyCode: meta['currency'] as String?,
        price: (meta['regularMarketPrice'] as num?)?.toDouble(),
      );
    } catch (e) {
      Logger.printDebug('Yahoo quote failed: $e');
      return null;
    }
  }

  @override
  String? logoUrl(String symbol) {
    final ticker = symbol.trim().toUpperCase();
    if (ticker.isEmpty) return null;

    // Yahoo doesn't expose logos, so we use FMP's key-less logo-by-ticker image.
    return 'https://financialmodelingprep.com/image-stock/'
        '${Uri.encodeComponent(ticker)}.png';
  }

  @override
  bool get supportsPriceHistory => false;

  @override
  Future<List<MarketHistoricalPrice>> getPriceHistory(
    String symbol, {
    DateTime? from,
    DateTime? to,
  }) async {
    throw UnimplementedError('Price-history backfill is not implemented yet');
  }
}
