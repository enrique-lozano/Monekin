import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/translations.g.dart';

/// All the possible types of a transaction
enum TransactionType {
  income,
  expense,
  transfer;

  /// Wheter the type is `income` or `expense`.
  bool get isIncomeOrExpense {
    if (this == transfer) {
      return false;
    }

    return true;
  }

  /// Wheter the type is of type `transfer`.
  ///
  /// This is an alias, so instead of doing `myType == TransactionType.transfer`, we can do
  /// `myType.isTransfer`, which is equivalent
  bool get isTransfer {
    return !isIncomeOrExpense;
  }

  String displayName(BuildContext context, {bool plural = false}) {
    if (this == income) {
      return t.transaction.types.income(n: plural ? 10 : 1);
    } else if (this == expense) {
      return t.transaction.types.expense(n: plural ? 10 : 1);
    } else if (this == transfer) {
      return t.transaction.types.transfer(n: plural ? 10 : 1);
    }

    return '';
  }

  IconData get icon {
    if (this == income) {
      return Icons.south_east_rounded;
    } else if (this == expense) {
      return Icons.north_east_rounded;
    }

    return Icons.swap_vert_rounded;
  }

  /// Get the sign of this transactionType
  IconData get mathIcon {
    if (this == income) {
      return Icons.add;
    } else if (this == expense) {
      return Icons.remove;
    }

    return icon;
  }

  Color color(BuildContext context) {
    if (this == income) {
      return AppColors.of(context).success;
    } else if (this == expense) {
      return AppColors.of(context).danger;
    }

    return AppColors.of(context).brand;
  }
}
