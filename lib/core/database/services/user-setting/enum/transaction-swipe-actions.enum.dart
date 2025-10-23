import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
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

  TransactionStatus toTransactionStatus() {
    switch (this) {
      case TransactionSwipeAction.voided:
        return TransactionStatus.voided;
      case TransactionSwipeAction.pending:
        return TransactionStatus.pending;
      case TransactionSwipeAction.reconciled:
        return TransactionStatus.reconciled;
      case TransactionSwipeAction.unreconciled:
        return TransactionStatus.unreconciled;
      default:
        throw Exception('Cannot convert $this to TransactionStatus');
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case TransactionSwipeAction.delete:
        return Theme.of(context).colorScheme.error;
      case TransactionSwipeAction.edit:
        return Theme.of(context).colorScheme.primary;
      default:
        return toTransactionStatus().color;
    }
  }

  Color contrastColor(BuildContext context) {
    switch (this) {
      case TransactionSwipeAction.delete:
        return Theme.of(context).colorScheme.onError;
      case TransactionSwipeAction.edit:
        return Theme.of(context).colorScheme.onPrimary;
      default:
        return Colors.white;
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionSwipeAction.delete:
        return Icons.delete_forever_rounded;
      case TransactionSwipeAction.edit:
        return Icons.edit_rounded;
      default:
        return toTransactionStatus().icon;
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
        return t.settings.swipe_actions.toggle_voided;
      case TransactionSwipeAction.pending:
        return t.settings.swipe_actions.toggle_pending;
      case TransactionSwipeAction.reconciled:
        return t.settings.swipe_actions.toggle_reconciled;
      case TransactionSwipeAction.unreconciled:
        return t.settings.swipe_actions.toggle_unreconciled;
      default:
        return t.settings.swipe_actions.none;
    }
  }
}
