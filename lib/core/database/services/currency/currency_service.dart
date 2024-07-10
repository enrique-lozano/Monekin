import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/i18n/translations.g.dart';

class CurrencyService {
  final AppDB db;

  CurrencyService._(this.db);
  static final CurrencyService instance = CurrencyService._(AppDB.instance);

  Future<int> insertCurrency(CurrencyInDB currency) {
    return db.into(db.currencies).insert(currency);
  }

  Future<int> deleteCurrency(String currencyId) {
    return (db.delete(db.categories)..where((tbl) => tbl.id.equals(currencyId)))
        .go();
  }

  Stream<List<Currency>?> getCurrencies() {
    return db
        .select(db.currencies)
        .map((e) => Currency.fromDB(currencyInDB: e))
        .watch();
  }

  Stream<Currency?> getCurrencyByCode(String code) {
    return (db.select(db.currencies)..where((a) => a.code.equals(code)))
        .map((e) => Currency.fromDB(currencyInDB: e))
        .watchSingleOrNull();
  }

  Stream<List<Currency>?> searchCurrencies(String? toSearch) {
    if (toSearch == null || toSearch.trim() == '') return getCurrencies();

    toSearch = '%${toSearch.trim()}%';

    return (db.select(db.currencies)
          ..where((a) => a.code.like(toSearch!) | a.name.like(toSearch)))
        .map((e) => Currency.fromDB(currencyInDB: e))
        .watch();
  }

  Stream<Currency> getUserPreferredCurrency() {
    final settingService = UserSettingService.instance;

    return settingService
        .getSetting(SettingKey.preferredCurrency)
        .asyncMap((currencyCode) async {
      if (currencyCode == null) {
        currencyCode = 'USD';

        await settingService.setSetting(
            SettingKey.preferredCurrency, currencyCode);
      }

      return (await getCurrencyByCode(currencyCode).first)!;
    });
  }

  /// Get the `assets/sql/initial_currencies.json` file and seed the user currencies with its info, based
  /// on the current language of the device.
  ///
  /// This function is called only when the user database is created.
  Future<void> initializeCurrencies() async {
    String defaultCurrencies =
        await rootBundle.loadString('assets/sql/initial_currencies.json');

    dynamic json = jsonDecode(defaultCurrencies);

    // The category initialization is done before the app language is set, so we need to trigger this:
    String systemLang = AppLocaleUtils.findDeviceLocale().languageCode;

    if (!AppLocaleUtils.supportedLocalesRaw.any((lang) => lang == systemLang)) {
      systemLang = 'en';
    }

    for (final currency in json) {
      final currencyToPush = CurrencyInDB(
        name: currency['names'][systemLang] ?? currency['names']['en'],
        symbol: currency['symbol'],
        code: currency['code'],
      );

      await db.customStatement("""
            INSERT INTO currencies(code, symbol, name) 
            VALUES (
              '${currencyToPush.code}', 
              '${currencyToPush.symbol.replaceAll("'", "''")}', 
              '${currencyToPush.name.replaceAll("'", "''")}'
            )
          """);
    }
  }
}
