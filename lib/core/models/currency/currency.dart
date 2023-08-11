import 'package:monekin/core/database/app_db.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Currency extends CurrencyInDB {
  final String name;

  String get currencyIconPath =>
      'assets/icons/currency_flags/${code.toLowerCase()}.svg';

  SvgPicture displayFlagIcon({double? size}) {
    return SvgPicture.asset(
      currencyIconPath,
      height: size,
      width: size,
    );
  }

  Currency({required this.name, required super.code, required super.symbol});
}
