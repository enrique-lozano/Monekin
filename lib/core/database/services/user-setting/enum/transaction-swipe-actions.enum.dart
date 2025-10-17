import 'package:flutter/material.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum TransactionSwipeAction {
  delete,
  edit,
  voided,
  pending,
  reconciled,
  unreconciled,
  none;

  static TransactionSwipeAction fromString(String? actionString) {
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
      case 'none':
      default:
        return TransactionSwipeAction.none;
    }
  }

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
      case TransactionSwipeAction.none:
        return 'None';
    }
  }
}
