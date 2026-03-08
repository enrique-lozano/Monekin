import 'package:flutter/material.dart' show Colors, Icons;
import 'package:flutter/widgets.dart';
import 'package:monekin/core/database/utils/database_enum.dart';
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
        return t.debts.direction.lent;
      case DebtDirection.borrowed:
        return t.debts.direction.borrowed;
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case DebtDirection.lent:
        return Colors.lightBlue;
      case DebtDirection.borrowed:
        return Colors.purpleAccent;
    }
  }

  IconData icon() {
    switch (this) {
      case DebtDirection.lent:
        return Icons.north_east_rounded;
      case DebtDirection.borrowed:
        return Icons.south_west_rounded;
    }
  }
}
