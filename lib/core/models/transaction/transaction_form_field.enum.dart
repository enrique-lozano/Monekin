import 'package:flutter/material.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum TransactionFormField {
  category('category'),
  account('account'),
  date('date'),
  note('note'),
  tags('tags'),
  status('status');

  final String id;
  const TransactionFormField(this.id);

  String displayName(BuildContext context) {
    final t = Translations.of(context);
    switch (this) {
      case TransactionFormField.category:
        return t.general.category;
      case TransactionFormField.account:
        return t.general.account;
      case TransactionFormField.date:
        return t.general.time.date;
      case TransactionFormField.note:
        return t.transaction.form.description;
      case TransactionFormField.tags:
        return t.tags.display(n: 99);
      case TransactionFormField.status:
        return t.transaction.status.display(n: 1);
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionFormField.category:
        return Icons.category_outlined;
      case TransactionFormField.account:
        return Icons.account_balance_wallet_outlined;
      case TransactionFormField.date:
        return Icons.calendar_today_outlined;
      case TransactionFormField.note:
        return Icons.notes_rounded;
      case TransactionFormField.tags:
        return Icons.label_outline_rounded;
      case TransactionFormField.status:
        return Icons.check_circle_outline_rounded;
    }
  }
}
