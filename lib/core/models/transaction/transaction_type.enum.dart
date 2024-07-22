import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/translations.g.dart';

/// All the possible types of a transaction
enum TransactionType {
  /// An income transaction
  I,

  /// An expense transaction
  E,

  /// A transfer transaction
  T;

  /// Wheter the type is `income` or `expense`.
  bool get isIncomeOrExpense {
    if (this == T) {
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
    if (this == I) {
      return t.transaction.types.income(n: plural ? 10 : 1);
    } else if (this == E) {
      return t.transaction.types.expense(n: plural ? 10 : 1);
    } else if (this == T) {
      return t.transaction.types.transfer(n: plural ? 10 : 1);
    }

    return '';
  }

  IconData get icon {
    if (this == I) {
      return Icons.south_east_rounded;
    } else if (this == E) {
      return Icons.north_east_rounded;
    }

    return Icons.swap_vert_rounded;
  }

  /// Get the sign of this transactionType
  IconData get mathIcon {
    if (this == I) {
      return Icons.add;
    } else if (this == E) {
      return Icons.remove;
    }

    return icon;
  }

  Color color(BuildContext context) {
    if (this == I) {
      return AppColors.of(context).success;
    } else if (this == E) {
      return AppColors.of(context).danger;
    }

    return AppColors.of(context).brand;
  }
}
