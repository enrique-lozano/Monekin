import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:monekin/core/database/utils/database_enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum DebtDirection implements DatabaseEnum<int> {
  /// The user lent money to someone else
  lent(0),

  /// The user borrowed money from someone else
  borrowed(1);

  const DebtDirection(this.id);

  final int id;

  @override
  int get databaseValue => id;

  String title(BuildContext context) {
    final t = Translations.of(context);

    switch (this) {
      case DebtDirection.lent:
        return "t.debts.direction.lent.title";
      case DebtDirection.borrowed:
        return "t.debts.direction.borrowed.title";
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case DebtDirection.lent:
        return AppColors.of(context).success; // Green
      case DebtDirection.borrowed:
        return AppColors.of(context).danger; // Red
    }
  }

  IconData icon() {
    switch (this) {
      case DebtDirection.lent:
        return Icons.arrow_upward_rounded;
      case DebtDirection.borrowed:
        return Icons.arrow_downward_rounded;
    }
  }
}
