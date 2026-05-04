import 'package:flutter/material.dart';
import 'package:monekin/core/database/utils/database_enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// All the possible types of a transaction
enum TransactionType implements DatabaseEnum<String> {
  /// An income transaction
  income('I'),

  /// An expense transaction
  expense('E'),

  /// A transfer transaction
  transfer('T'),

  /// Cash flow for asset buy/sell (excluded from income/expense stats).
  investment('N');

  const TransactionType(this.id);

  final String id;

  @override
  String get databaseValue => id;

  /// Whether the type is `income` or `expense`.
  bool get isIncomeOrExpense {
    return this == income || this == expense;
  }

  /// Whether the type is `transfer`.
  bool get isTransfer {
    return this == transfer;
  }

  bool get isInvestment => this == investment;

  String displayName(BuildContext context, {bool plural = false}) {
    if (this == income) {
      return t.transaction.types.income(n: plural ? 10 : 1);
    } else if (this == expense) {
      return t.transaction.types.expense(n: plural ? 10 : 1);
    } else if (this == transfer) {
      return t.transaction.types.transfer(n: plural ? 10 : 1);
    } else if (this == investment) {
      return t.transaction.types.investment(n: plural ? 10 : 1);
    }

    return '';
  }

  IconData get icon {
    if (this == income) {
      return Icons.south_east_rounded;
    } else if (this == expense) {
      return Icons.north_east_rounded;
    } else if (this == investment) {
      return Icons.pie_chart_outline_rounded;
    }

    return Icons.swap_vert_rounded;
  }

  /// Get the sign of this transactionType
  IconData get mathIcon {
    if (this == income) {
      return Icons.add;
    } else if (this == expense) {
      return Icons.remove;
    } else if (this == investment) {
      return Icons.pie_chart_outline_rounded;
    }

    return icon;
  }

  Color color(BuildContext context) {
    if (this == income) {
      return AppColors.of(context).success;
    } else if (this == expense) {
      return AppColors.of(context).danger;
    } else if (this == investment) {
      return AppColors.of(context).brand;
    }

    return AppColors.of(context).brand;
  }
}
