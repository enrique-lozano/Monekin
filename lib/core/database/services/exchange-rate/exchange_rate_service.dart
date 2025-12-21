import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:rxdart/rxdart.dart';

import '../../app_db.dart';

class ExchangeRateService {
  final AppDB db;

  ExchangeRateService._(this.db);
  static final ExchangeRateService instance = ExchangeRateService._(
    AppDB.instance,
  );

  Future<int> insertOrUpdateExchangeRate(ExchangeRateInDB toInsert) async {
    final elToCompare = (await (getLastExchangeRateOf(
      currencyCode: toInsert.currencyCode,
    )).first);

    if (elToCompare != null &&
        DateUtils.isSameDay(elToCompare.date, toInsert.date)) {
      toInsert = toInsert.copyWith(id: elToCompare.id);
    }

    return db
        .into(db.exchangeRates)
        .insert(toInsert, mode: InsertMode.insertOrReplace);
  }

  Future<int> deleteExchangeRates({String? currencyCode}) {
    return (db.delete(db.exchangeRates)..where(
          (e) => currencyCode != null
              ? e.currencyCode.equals(currencyCode)
              : e.currencyCode.isNotNull(),
        ))
        .go();
  }

  Future<int> deleteExchangeRateById(String id) {
    return (db.delete(db.exchangeRates)..where((e) => e.id.equals(id))).go();
  }

  /// Get the last exchange rates for all the currencies that the user have in the list of exchange rates
  Stream<List<ExchangeRate>> getExchangeRates({double? limit}) {
    limit ??= -1;

    return db.getLastExchangeRates(limit: limit).watch();
  }

  /// Get all the exchange rates that a currency have in the app
  Stream<List<ExchangeRate>> getExchangeRatesOf(
    String currencyCode, {
    double? limit,
  }) {
    limit ??= -1;

    return db
        .getExchangeRates(
          predicate: (e, currency) => e.currencyCode.equals(currencyCode),
          limit: limit,
        )
        .watch();
  }

  /// Get the last exchange rate before a specified date, for a given currency. If the date is not provided, the current date is used
  Stream<ExchangeRate?> getLastExchangeRateOf({
    required String currencyCode,
    DateTime? date,
  }) {
    date ??= DateTime.now();

    return db
        .getExchangeRates(
          predicate: (e, currency) =>
              e.currencyCode.equals(currencyCode) &
              e.date.isSmallerOrEqualValue(date!),
          limit: 1,
        )
        .watchSingleOrNull();
  }

  Stream<double> calculateExchangeRateToPreferredCurrency({
    required String fromCurrency,
    num amount = 1,
    DateTime? date,
  }) {
    date ??= DateTime.now();

    return getLastExchangeRateOf(currencyCode: fromCurrency, date: date)
        .map((event) => event?.exchangeRate ?? 1)
        .map((excRate) => excRate * amount);
  }

  Stream<double> calculateExchangeRate({
    required String fromCurrency,
    required String toCurrency,
    num amount = 1,
    DateTime? date,
  }) {
    date ??= DateTime.now();

    final fromExchangeRate = getLastExchangeRateOf(
      currencyCode: fromCurrency,
      date: date,
    ).map((event) => event?.exchangeRate ?? 1);
    final toExchangeRate = getLastExchangeRateOf(
      currencyCode: toCurrency,
      date: date,
    ).map((event) => event?.exchangeRate ?? 1);

    return Rx.combineLatest2(
      fromExchangeRate,
      toExchangeRate,
      (a, b) => (a / b) * amount,
    );
  }
}
