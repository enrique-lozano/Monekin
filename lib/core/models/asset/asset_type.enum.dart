import 'package:flutter/material.dart';
import 'package:monekin/core/database/utils/database_enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Stored in [assets.assetType] as [databaseValue] (snake_case strings).
///
/// Assets are **physical / non-market** holdings only (real estate, vehicles,
/// precious metals, etc.). Market instruments (stocks, funds, crypto) are
/// modelled as `securities` + `holdings`, not as assets.
enum AssetType implements DatabaseEnum<String> {
  realEstate('real_estate'),
  vehicle('vehicle'),
  preciousMetal('precious_metal'),
  jewelryArt('jewelry_art'),
  other('other');

  const AssetType(this.databaseValue);

  @override
  final String databaseValue;

  String displayName(BuildContext context) {
    final t = Translations.of(context).assets.types;
    return switch (this) {
      AssetType.realEstate => t.real_estate,
      AssetType.vehicle => t.vehicle,
      AssetType.preciousMetal => t.precious_metal,
      AssetType.jewelryArt => t.jewelry_art,
      AssetType.other => t.other,
    };
  }

  String description(BuildContext context) {
    final t = Translations.of(context).assets.type_descriptions;
    return switch (this) {
      AssetType.realEstate => t.real_estate,
      AssetType.vehicle => t.vehicle,
      AssetType.preciousMetal => t.precious_metal,
      AssetType.jewelryArt => t.jewelry_art,
      AssetType.other => t.other,
    };
  }

  /// Example names to show as a hint in the asset name field.
  String nameHint(BuildContext context) {
    final t = Translations.of(context).assets.form.name_hints;
    return switch (this) {
      AssetType.realEstate => t.real_estate,
      AssetType.vehicle => t.vehicle,
      AssetType.preciousMetal => t.precious_metal,
      AssetType.jewelryArt => t.jewelry_art,
      AssetType.other => t.other,
    };
  }

  IconData icon() {
    return switch (this) {
      AssetType.realEstate => Icons.home,
      AssetType.vehicle => Icons.directions_car,
      AssetType.preciousMetal => Icons.paid,
      AssetType.jewelryArt => Icons.diamond,
      AssetType.other => Icons.category,
    };
  }

  Color color() {
    return switch (this) {
      AssetType.realEstate => const Color(0xFF3B82F6),
      AssetType.vehicle => const Color(0xFF14B8A6),
      AssetType.preciousMetal => const Color(0xFFF59E0B),
      AssetType.jewelryArt => const Color(0xFFA855F7),
      AssetType.other => const Color(0xFF64748B),
    };
  }
}
