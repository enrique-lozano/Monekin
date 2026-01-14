import 'package:flutter/widgets.dart';
import 'package:monekin/core/database/utils/database_enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum GoalType implements DatabaseEnum<int> {
  expense(0),
  income(1);

  const GoalType(this.id);

  final int id;

  @override
  int get databaseValue => id;

  String title(BuildContext context) {
    final t = Translations.of(context);

    switch (this) {
      case GoalType.income:
        return t.goals.type.income.title;
      case GoalType.expense:
        return t.goals.type.expense.title;
    }
  }

  String description(BuildContext context) {
    final t = Translations.of(context);

    switch (this) {
      case GoalType.income:
        return t.goals.type.income.descr;
      case GoalType.expense:
        return t.goals.type.expense.descr;
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case GoalType.income:
        return AppColors.of(context).success; // Green
      case GoalType.expense:
        return AppColors.of(context).danger; // Red
    }
  }
}
