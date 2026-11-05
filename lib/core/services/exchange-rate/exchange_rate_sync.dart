import 'package:material_ui/material_ui.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_client.dart';
import 'package:monekin/core/utils/uuid.dart';

class RateSyncResult {
  const RateSyncResult({
    required this.addedRates,
    required this.unavailableCurrencies,
    required this.connectionFailed,
  });

  final int addedRates;

  /// Codes of the currencies for which Frankfurter has no rate.
  final List<String> unavailableCurrencies;

  /// Whether any request failed for network reasons (offline, timeout...).
  final bool connectionFailed;
}

enum _Outcome { added, skipped, unavailable, connectionFailed }

/// Saves today's Frankfurter rate for every currency that already has a rate.
/// Days that already have a rate are never overwritten.
Future<RateSyncResult> syncExchangeRates({
  required String preferredCurrency,
  FrankfurterClient? client,
  ExchangeRateService? exchangeRates,
  DateTime? now,
}) async {
  final ownsClient = client == null;
  final frankfurter = client ?? FrankfurterClient();
  final service = exchangeRates ?? ExchangeRateService.instance;

  try {
    final lastRates = await service.getExchangeRates().first;
    final today = DateUtils.dateOnly(now ?? DateTime.now());

    Future<_Outcome> sync(ExchangeRate last) async {
      if (DateUtils.isSameDay(last.date, today)) return _Outcome.skipped;

      try {
        final quote = await frankfurter.latest(
          from: last.currencyCode,
          to: preferredCurrency,
        );

        final inserted = await service.insertExchangeRateIfMissing(
          ExchangeRate(
            id: generateUUID(),
            currency: last.currency,
            date: today,
            exchangeRate: quote.rate,
          ),
          expectedBaseCurrency: preferredCurrency,
        );

        return inserted ? _Outcome.added : _Outcome.skipped;
      } on FrankfurterException catch (e) {
        return e.notAvailable
            ? _Outcome.unavailable
            : _Outcome.connectionFailed;
      } catch (_) {
        return _Outcome.connectionFailed;
      }
    }

    final outcomes = await Future.wait(lastRates.map(sync));

    return RateSyncResult(
      addedRates: outcomes.where((o) => o == _Outcome.added).length,
      unavailableCurrencies: [
        for (var i = 0; i < lastRates.length; i++)
          if (outcomes[i] == _Outcome.unavailable) lastRates[i].currencyCode,
      ],
      connectionFailed: outcomes.contains(_Outcome.connectionFailed),
    );
  } finally {
    if (ownsClient) frankfurter.close();
  }
}
