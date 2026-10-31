import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';
import 'package:monekin/core/services/exchange-rate/today_rate_plan.dart';
import 'package:monekin/core/utils/uuid.dart';

class EcbSyncResult {
  const EcbSyncResult({
    required this.addedRates,
    required this.unpublishedCurrencies,
    required this.connectionFailed,
  });

  final int addedRates;

  /// Codes of the currencies for which the ECB has no rate.
  final List<String> unpublishedCurrencies;

  /// Whether any request failed for network reasons (offline, timeout...).
  final bool connectionFailed;
}

enum _Outcome { added, skipped, unpublished, connectionFailed }

/// Saves today's ECB rate for every currency that already has a rate. Days
/// that already have a rate are never overwritten.
Future<EcbSyncResult> syncEcbRates({
  required String preferredCurrency,
  FrankfurterEcbClient? client,
  ExchangeRateService? exchangeRates,
  DateTime? now,
}) async {
  final ownsClient = client == null;
  final ecb = client ?? FrankfurterEcbClient();
  final service = exchangeRates ?? ExchangeRateService.instance;

  try {
    final lastRates = await service.getExchangeRates().first;
    final today = DateUtils.dateOnly(now ?? DateTime.now());

    Future<_Outcome> sync(ExchangeRate last) async {
      if (DateUtils.isSameDay(last.date, today)) return _Outcome.skipped;

      final availability = ecbFetchAvailability(
        currency: last.currencyCode,
        preferred: preferredCurrency,
      );
      if (availability != EcbFetchAvailability.available) {
        return _Outcome.unpublished;
      }

      try {
        final quote = await ecb.latest(
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
      } on FrankfurterEcbException catch (e) {
        return e.notPublished
            ? _Outcome.unpublished
            : _Outcome.connectionFailed;
      } catch (_) {
        return _Outcome.connectionFailed;
      }
    }

    final outcomes = await Future.wait(lastRates.map(sync));

    return EcbSyncResult(
      addedRates: outcomes.where((o) => o == _Outcome.added).length,
      unpublishedCurrencies: [
        for (var i = 0; i < lastRates.length; i++)
          if (outcomes[i] == _Outcome.unpublished) lastRates[i].currencyCode,
      ],
      connectionFailed: outcomes.contains(_Outcome.connectionFailed),
    );
  } finally {
    if (ownsClient) ecb.close();
  }
}
