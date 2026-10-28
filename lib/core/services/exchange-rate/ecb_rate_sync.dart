import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';
import 'package:monekin/core/services/exchange-rate/today_rate_plan.dart';
import 'package:monekin/core/utils/uuid.dart';

class EcbSyncResult {
  const EcbSyncResult({
    required this.addedRates,
    required this.failedCurrencies,
  });

  final int addedRates;

  /// Codes of the currencies that could not be updated.
  final List<String> failedCurrencies;
}

/// Saves today's ECB rate for every currency that already has a rate. Days
/// that already have a rate are never overwritten.
Future<EcbSyncResult> syncEcbRates({
  required String preferredCurrency,
  FrankfurterEcbClient? client,
}) async {
  client ??= FrankfurterEcbClient();
  final lastRates = await ExchangeRateService.instance.getExchangeRates().first;
  final today = DateUtils.dateOnly(DateTime.now());

  var addedRates = 0;
  final failed = <String>[];

  for (final last in lastRates) {
    final code = last.currencyCode;

    if (DateUtils.isSameDay(last.date, today)) continue;

    final availability = ecbFetchAvailability(
      currency: code,
      preferred: preferredCurrency,
    );
    if (availability != EcbFetchAvailability.available) {
      failed.add(code);
      continue;
    }

    try {
      final quote = await client.latest(from: code, to: preferredCurrency);

      await ExchangeRateService.instance.insertOrUpdateExchangeRate(
        ExchangeRate(
          id: generateUUID(),
          currency: last.currency,
          date: today,
          exchangeRate: quote.rate,
        ),
      );
      addedRates++;
    } catch (_) {
      failed.add(code);
    }
  }

  return EcbSyncResult(addedRates: addedRates, failedCurrencies: failed);
}
