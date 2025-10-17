import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum TransactionSwipeAction {
  delete,
  edit,
  voided,
  pending,
  reconciled,
  unreconciled;

  static TransactionSwipeAction? fromString(String? actionString) {
    switch (actionString) {
      case 'delete':
        return TransactionSwipeAction.delete;
      case 'edit':
        return TransactionSwipeAction.edit;
      case 'voided':
        return TransactionSwipeAction.voided;
      case 'pending':
        return TransactionSwipeAction.pending;
      case 'reconciled':
        return TransactionSwipeAction.reconciled;
      case 'unreconciled':
        return TransactionSwipeAction.unreconciled;
      default:
        return null;
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case TransactionSwipeAction.delete:
        return AppColors.of(context).danger;
      case TransactionSwipeAction.edit:
        return Theme.of(context).colorScheme.primary;
      case TransactionSwipeAction.voided:
        return TransactionStatus.voided.color;
      case TransactionSwipeAction.pending:
        return TransactionStatus.pending.color;
      case TransactionSwipeAction.reconciled:
        return TransactionStatus.reconciled.color;
      case TransactionSwipeAction.unreconciled:
        return TransactionStatus.unreconciled.color;
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionSwipeAction.delete:
        return Icons.delete_forever_rounded;
      case TransactionSwipeAction.edit:
        return Icons.edit_rounded;
      case TransactionSwipeAction.voided:
        return TransactionStatus.voided.icon;
      case TransactionSwipeAction.pending:
        return TransactionStatus.pending.icon;
      case TransactionSwipeAction.reconciled:
        return TransactionStatus.reconciled.icon;
      case TransactionSwipeAction.unreconciled:
        return TransactionStatus.unreconciled.icon;
    }
  }
}

extension TransactionSwipeActionExtension on TransactionSwipeAction? {
  String displayName(BuildContext context) {
    final t = Translations.of(context);

    switch (this) {
      case TransactionSwipeAction.delete:
        return t.ui_actions.delete;
      case TransactionSwipeAction.edit:
        return t.ui_actions.edit;
      case TransactionSwipeAction.voided:
        return 'Set as Voided';
      case TransactionSwipeAction.pending:
        return 'Set as Pending';
      case TransactionSwipeAction.reconciled:
        return 'Set as Reconciled';
      case TransactionSwipeAction.unreconciled:
        return 'Set as Unreconciled';
      default:
        return 'No Action';
    }
  }
}
