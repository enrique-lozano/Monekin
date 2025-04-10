import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TransactionStatusFilterChip extends StatelessWidget {
  const TransactionStatusFilterChip({
    super.key,
    required this.status,
    required this.isSelected,
    this.onSelected,
  });

  final TransactionStatus? status;
  final bool isSelected;

  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ChoiceChip(
      label: Text(status?.displayName(context) ?? t.transaction.status.none),
      selected: isSelected,
      showCheckmark: false,
      avatar: Icon(
        status.icon,
        color: status.color,
      ),
      onSelected: onSelected,
    );
  }
}
