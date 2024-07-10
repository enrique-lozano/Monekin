import 'package:flutter_svg/flutter_svg.dart';
import 'package:monekin/core/database/app_db.dart';

class Currency extends CurrencyInDB {
  String get currencyIconPath =>
      'assets/icons/currency_flags/${code.toLowerCase()}.svg';

  SvgPicture displayFlagIcon({double? size}) {
    return SvgPicture.asset(
      currencyIconPath,
      height: size,
      width: size,
    );
  }

  Currency({required super.name, required super.code, required super.symbol});

  Currency.fromDB({required CurrencyInDB currencyInDB})
      : this(
          code: currencyInDB.code,
          name: currencyInDB.name,
          symbol: currencyInDB.symbol,
        );
}
