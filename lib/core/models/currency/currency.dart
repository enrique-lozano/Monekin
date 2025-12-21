import 'package:flutter_svg/flutter_svg.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/currency/currency_type.enum.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Currency extends CurrencyInDB {
  CurrencyType get currencyType => CurrencyType.values[type];

  String get currencyIconPath =>
      'assets/icons/currency_flags/${code.toLowerCase()}.svg';

  SvgPicture displayFlagIcon({double? size}) {
    return SvgPicture.asset(
      currencyIconPath,
      height: size,
      width: size,
      placeholderBuilder: (context) => Bone.square(size: size),
    );
  }

  Currency({
    required super.name,
    required super.code,
    required super.symbol,
    super.decimalPlaces = 2,
    super.isDefault = true,
    super.type = 0,
  });

  Currency.fromDB({required CurrencyInDB currencyInDB})
    : this(
        code: currencyInDB.code,
        name: currencyInDB.name,
        symbol: currencyInDB.symbol,
        decimalPlaces: currencyInDB.decimalPlaces,
        isDefault: currencyInDB.isDefault,
        type: currencyInDB.type,
      );
}
