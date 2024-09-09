import 'package:parsa/core/database/app_db.dart';

class ExchangeRate extends ExchangeRateInDB {
  CurrencyInDB currency;

  ExchangeRate({
    required super.id,
    required super.date,
    required this.currency,
    required super.exchangeRate,
  }) : super(currencyCode: currency.code);
}
