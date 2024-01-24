import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/i18n/translations.g.dart';

class CurrencyService {
  final _currencyTableName = 'currencies';
  final _currencyNamesTableName = 'currencyNames';

  String get _baseQuery =>
      'SELECT currency.code, currency.symbol, names.${LocaleSettings.currentLocale.languageCode} as name FROM $_currencyTableName as currency'
      ' JOIN $_currencyNamesTableName as names ON currency.code = names.currencyCode';

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
    return (db.customSelect(_baseQuery,
            readsFrom: {db.currencies, db.currencyNames}))
        .map((e) => Currency(
            name: e.data['name'],
            code: e.data['code'],
            symbol: e.data['symbol']))
        .watch();
  }

  Stream<Currency?> getCurrencyByCode(String code) {
    return (db.customSelect('$_baseQuery WHERE currency.code = ? LIMIT 1',
            variables: [Variable.withString(code)],
            readsFrom: {db.currencies, db.currencyNames}))
        .map((e) => Currency(
            name: e.data['name'],
            code: e.data['code'],
            symbol: e.data['symbol']))
        .watchSingleOrNull();
  }

  Stream<List<Currency>?> searchCurrencies(String? toSearch) {
    if (toSearch == null || toSearch.trim() == '') return getCurrencies();

    toSearch = '%${toSearch.trim()}%';

    return (db.customSelect(
            '$_baseQuery WHERE currency.code LIKE ? OR names.${LocaleSettings.currentLocale.languageCode} LIKE ?',
            variables: [
          Variable.withString(toSearch),
          Variable.withString(toSearch)
        ],
            readsFrom: {
          db.currencies,
          db.currencyNames
        }))
        .map((e) => Currency(
            name: e.data['name'],
            code: e.data['code'],
            symbol: e.data['symbol']))
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
}
