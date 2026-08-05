import 'package:monekin/core/models/asset/security_type.enum.dart';
import 'package:monekin/core/services/market_data/market_data_provider.dart';
import 'package:monekin/core/services/market_data/yahoo_finance_provider.dart';

/// A single, 100%-weight taxonomy assignment guessed from online data.
typedef OnlineTaxonomyGuess = ({String taxonomyId, String categoryId});

/// Entry point for the online market-data lookup (search, autofill and logos).
///
/// Monekin stays offline-first: calls only happen as a result of a user action
/// and degrade to empty/null when offline. Swap [provider] to add more sources.
class MarketDataService {
  MarketDataService._(this.provider);

  static final MarketDataService instance = MarketDataService._(
    YahooFinanceProvider(),
  );

  final MarketDataProvider provider;

  Future<List<MarketSearchResult>> search(String query) async {
    return provider.search(query);
  }

  Future<MarketQuote?> getQuote(String symbol) async {
    return provider.getQuote(symbol);
  }

  final _tickersWithoutLogo = <String>{};

  String? logoUrlForTicker(String? ticker) {
    final t = _normalizeTicker(ticker);
    if (t == null || _tickersWithoutLogo.contains(t)) return null;
    return provider.logoUrl(t);
  }

  /// Remembers that [ticker] has no logo, so we stop re-requesting it (and
  /// flashing a placeholder) on every rebuild.
  void markLogoUnavailable(String? ticker) {
    final t = _normalizeTicker(ticker);
    if (t != null) _tickersWithoutLogo.add(t);
  }

  String? _normalizeTicker(String? ticker) {
    final t = ticker?.trim().toUpperCase();
    return (t == null || t.isEmpty) ? null : t;
  }

  static SecurityType securityTypeFor(String quoteType) {
    switch (quoteType.toUpperCase()) {
      case 'CRYPTOCURRENCY':
        return SecurityType.crypto;
      case 'ETF':
      case 'MUTUALFUND':
        return SecurityType.fund;
      case 'EQUITY':
      default:
        return SecurityType.stock;
    }
  }

  /// Best-effort classification (asset class, industry, region) inferred from a
  /// search result, targeting the seeded built-in taxonomy ids. Callers should
  /// still validate the ids exist (a user may have deleted a built-in category).
  static List<OnlineTaxonomyGuess> classificationFor(MarketSearchResult r) {
    final out = <OnlineTaxonomyGuess>[];

    final assetClass = _assetClassFor(r.quoteType);
    if (assetClass != null) {
      out.add((taxonomyId: 'asset_classes', categoryId: assetClass));
    }

    final industry = r.sector == null ? null : _industryFor(r.sector!);
    if (industry != null) {
      out.add((taxonomyId: 'industries', categoryId: industry));
    }

    final region = _regionFor(r.exchange);
    if (region != null) {
      out.add((taxonomyId: 'regions', categoryId: region));
    }

    return out;
  }

  static String? _assetClassFor(String quoteType) {
    switch (quoteType.toUpperCase()) {
      case 'EQUITY':
        return 'ac_equity';
      case 'CRYPTOCURRENCY':
        return 'ac_digital';
      // ETFs / funds are too ambiguous to tag confidently.
      default:
        return null;
    }
  }

  static String? _industryFor(String sector) {
    switch (sector.toLowerCase()) {
      case 'technology':
        return 'ind_it';
      case 'financial services':
      case 'financial':
        return 'ind_financials';
      case 'healthcare':
        return 'ind_health';
      case 'consumer cyclical':
        return 'ind_cons_disc';
      case 'consumer defensive':
        return 'ind_cons_staples';
      case 'energy':
        return 'ind_energy';
      case 'industrials':
        return 'ind_industrials';
      case 'basic materials':
        return 'ind_materials';
      case 'communication services':
        return 'ind_comm';
      case 'utilities':
        return 'ind_utilities';
      case 'real estate':
        return 'ind_real_estate';
      default:
        return null;
    }
  }

  /// Region from the exchange where the instrument is *listed* (not necessarily
  /// the issuer's country).
  static String? _regionFor(String? exchange) {
    if (exchange == null) return null;

    switch (exchange.toUpperCase()) {
      // United States / Canada
      case 'NMS':
      case 'NGM':
      case 'NCM':
      case 'NYQ':
      case 'ASE':
      case 'PCX':
      case 'BATS':
      case 'TOR':
      case 'VAN':
      case 'CNQ':
        return 'r_am_north';
      // Latin America
      case 'SAO':
      case 'BUE':
      case 'MEX':
        return 'r_am_latin';
      // Western Europe (DE, FR, NL, CH, BE, AT)
      case 'GER':
      case 'FRA':
      case 'STU':
      case 'MUN':
      case 'HAM':
      case 'DUS':
      case 'BER':
      case 'PAR':
      case 'AMS':
      case 'EBS':
      case 'BRU':
      case 'VIE':
        return 'r_eu_west';
      // Northern Europe (UK, Ireland, Nordics)
      case 'LSE':
      case 'IOB':
      case 'ISE':
      case 'STO':
      case 'CPH':
      case 'HEL':
      case 'OSL':
        return 'r_eu_north';
      // Southern Europe (ES, IT, PT, GR)
      case 'MCE':
      case 'MIL':
      case 'LIS':
      case 'ATH':
        return 'r_eu_south';
      // Eastern Asia (JP, CN, HK, TW, KR)
      case 'JPX':
      case 'TYO':
      case 'HKG':
      case 'SHH':
      case 'SHZ':
      case 'TAI':
      case 'TWO':
      case 'KSC':
      case 'KOE':
        return 'r_as_east';
      // Southern Asia (IN)
      case 'NSI':
      case 'BSE':
        return 'r_as_south';
      // South-eastern Asia
      case 'SES':
      case 'SET':
      case 'JKT':
      case 'KLS':
        return 'r_as_southeast';
      // Oceania
      case 'ASX':
      case 'NZE':
        return 'r_oceania';
      default:
        return null;
    }
  }
}
