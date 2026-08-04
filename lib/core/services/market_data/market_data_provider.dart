/// A single tradable instrument returned by an online market-data search.
class MarketSearchResult {
  const MarketSearchResult({
    required this.symbol,
    required this.name,
    required this.quoteType,
    this.exchange,
    this.exchangeName,
    this.sector,
    this.industry,
  });

  final String symbol;
  final String name;

  /// Raw instrument type as reported by the provider (`EQUITY`, `ETF`,
  /// `MUTUALFUND`, `CRYPTOCURRENCY`).
  final String quoteType;

  /// Provider exchange code (`NMS`, `GER`...), used for region classification.
  final String? exchange;
  final String? exchangeName;
  final String? sector;
  final String? industry;
}

/// A price + currency snapshot for an instrument.
class MarketQuote {
  const MarketQuote({required this.symbol, this.currencyCode, this.price});

  final String symbol;
  final String? currencyCode;
  final double? price;
}

/// Reserved for the (not-yet-built) price-history backfill feature.
class MarketHistoricalPrice {
  const MarketHistoricalPrice({required this.date, required this.price});

  final DateTime date;
  final double price;
}

/// Abstraction over an online market-data source (stock/fund/crypto).
///
/// Monekin is offline-first, so implementations only ever hit the network as a
/// direct result of a user action and must degrade gracefully (empty/null,
/// never throw) when offline.
abstract class MarketDataProvider {
  String get id;

  Future<List<MarketSearchResult>> search(String query, {int limit = 8});

  Future<MarketQuote?> getQuote(String symbol);

  /// A best-effort logo URL, or `null` when unavailable. The image may still
  /// fail to load, so callers must always have a fallback.
  String? logoUrl(String symbol);

  /// Reserved for a future iteration (backfilling a security's price history).
  bool get supportsPriceHistory => false;

  Future<List<MarketHistoricalPrice>> getPriceHistory(
    String symbol, {
    DateTime? from,
    DateTime? to,
  }) async {
    throw UnimplementedError('Price-history backfill is not implemented yet');
  }
}
