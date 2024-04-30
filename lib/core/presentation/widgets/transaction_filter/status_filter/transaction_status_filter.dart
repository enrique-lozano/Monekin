import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/status_filter/transaction_status_filter_chip.dart';
import 'package:monekin/i18n/translations.g.dart';

class TransactionStatusFilter extends StatelessWidget {
  const TransactionStatusFilter({
    super.key,
    this.onSelected,
    required this.selectedStatuses,
    required this.allowMultipleSelection,
  });

  final void Function(TransactionStatus? statusSelected, bool value)?
      onSelected;

  final List<TransactionStatus?> selectedStatuses;
  final bool allowMultipleSelection;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${t.transaction.status.display(n: allowMultipleSelection ? 10 : 1)}:'),
        const SizedBox(height: 4),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final statusItem in [null, ...TransactionStatus.values]) ...[
                TransactionStatusFilterChip(
                  isSelected: selectedStatuses.contains(statusItem),
                  status: statusItem,
                  onSelected: onSelected != null
                      ? (value) => onSelected!(statusItem, value)
                      : null,
                ),
                const SizedBox(width: 6),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
