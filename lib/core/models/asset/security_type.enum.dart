import 'package:flutter/material.dart';
import 'package:monekin/core/database/utils/database_enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Type of a financial [security] (a tradable instrument held inside an
/// investment account). Stored in [securities.type] as [databaseValue].
enum SecurityType implements DatabaseEnum<String> {
  stock('stock'),
  fund('fund'),
  crypto('crypto');

  const SecurityType(this.databaseValue);

  @override
  final String databaseValue;

  String displayName(BuildContext context) {
    final t = Translations.of(context).assets.security_types;
    return switch (this) {
      SecurityType.stock => t.stock,
      SecurityType.fund => t.fund,
      SecurityType.crypto => t.crypto,
    };
  }

  IconData icon() {
    return switch (this) {
      SecurityType.stock => Icons.show_chart,
      SecurityType.fund => Icons.pie_chart,
      SecurityType.crypto => Icons.currency_bitcoin,
    };
  }

  Color color() {
    return switch (this) {
      SecurityType.stock => const Color(0xFF3B82F6),
      SecurityType.fund => const Color(0xFFA855F7),
      SecurityType.crypto => const Color(0xFFF59E0B),
    };
  }
}
