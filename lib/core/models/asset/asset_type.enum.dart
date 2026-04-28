import 'package:flutter/material.dart';
import 'package:monekin/core/database/utils/database_enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Stored in [assets.assetType] as [databaseValue] (snake_case strings).
enum AssetType implements DatabaseEnum<String> {
  stocks('stocks'),
  funds('funds'),
  crypto('crypto'),
  realEstate('real_estate'),
  vehicle('vehicle'),
  jewelryArt('jewelry_art'),
  other('other');

  const AssetType(this.databaseValue);

  @override
  final String databaseValue;

  bool get isFinancial =>
      this == stocks || this == funds || this == crypto;

  bool get isPhysical =>
      this == realEstate || this == vehicle || this == jewelryArt;

  String displayName(BuildContext context) {
    final t = Translations.of(context).assets.types;
    return switch (this) {
      AssetType.stocks => t.stocks,
      AssetType.funds => t.funds,
      AssetType.crypto => t.crypto,
      AssetType.realEstate => t.realEstate,
      AssetType.vehicle => t.vehicle,
      AssetType.jewelryArt => t.jewelryArt,
      AssetType.other => t.other,
    };
  }
}
