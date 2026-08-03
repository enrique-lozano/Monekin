import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:provider/provider.dart';

/// Segmented control for income / expense / transfer.
class TransactionFormTypeSelector extends StatelessWidget {
  const TransactionFormTypeSelector({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 12),
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();

    final types = [
      TransactionType.income,
      TransactionType.expense,
      if (c.linkedDebt == null) TransactionType.transfer,
    ];

    return Padding(
      padding: padding,
      child: ExpandingSegmentedTabs<TransactionType>(
        items: [
          for (final type in types)
            SegmentedTabItem(
              value: type,
              icon: type.icon,
              label: type.displayName(context),
              color: type.color(context),
            ),
        ],
        selected: c.transactionType,
        onSelected: c.onTransactionTypeChanged,
      ),
    );
  }
}
