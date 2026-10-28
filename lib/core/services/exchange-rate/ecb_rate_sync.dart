import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';
import 'package:monekin/core/services/exchange-rate/today_rate_plan.dart';
import 'package:monekin/core/utils/uuid.dart';

class EcbSyncResult {
  const EcbSyncResult({
    required this.addedRates,
    required this.updatedCurrencies,
    required this.failedCurrencies,
  });

  final int addedRates;
  final int updatedCurrencies;

  /// Codes of the currencies that could not be updated.
  final List<String> failedCurrencies;
}

/// Fills the gap between the last saved rate of every currency and today with
/// the ECB rates. Dates that already have a rate are never overwritten.
Future<EcbSyncResult> syncEcbRates({
  required String preferredCurrency,
  FrankfurterEcbClient? client,
}) async {
  client ??= FrankfurterEcbClient();
  final lastRates = await ExchangeRateService.instance.getExchangeRates().first;
  final today = DateTime.now();

  var addedRates = 0;
  var updatedCurrencies = 0;
  final failed = <String>[];

  for (final last in lastRates) {
    final code = last.currencyCode;

    final availability = ecbFetchAvailability(
      currency: code,
      preferred: preferredCurrency,
    );
    if (availability != EcbFetchAvailability.available) {
      failed.add(code);
      continue;
    }

    try {
      final quotes = await client.series(
        from: code,
        to: preferredCurrency,
        start: last.date.add(const Duration(days: 1)),
        end: today,
      );

      // The last saved rate is the most recent one, so every date after it is
      // free.
      for (final quote in quotes.where((q) => q.date.isAfter(last.date))) {
        await ExchangeRateService.instance.insertOrUpdateExchangeRate(
          ExchangeRate(
            id: generateUUID(),
            currency: last.currency,
            date: quote.date,
            exchangeRate: quote.rate,
          ),
        );
        addedRates++;
      }

      if (quotes.isNotEmpty) updatedCurrencies++;
    } catch (_) {
      failed.add(code);
    }
  }

  return EcbSyncResult(
    addedRates: addedRates,
    updatedCurrencies: updatedCurrencies,
    failedCurrencies: failed,
  );
}
