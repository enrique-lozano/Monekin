import 'package:flutter/material.dart' show Icons, IconData;

enum CurrencyType {
  fiat(0),
  crypto(1),
  custom(2);

  final int dbValue;
  const CurrencyType(this.dbValue);

  static CurrencyType fromDb(int value) =>
      CurrencyType.values.firstWhere((e) => e.dbValue == value);

  IconData get icon {
    switch (this) {
      case CurrencyType.fiat:
        return Icons.attach_money;
      case CurrencyType.crypto:
        return Icons.currency_bitcoin;
      case CurrencyType.custom:
        return Icons.category;
    }
  }
}
