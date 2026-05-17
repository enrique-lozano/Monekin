import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/transaction_form_controller.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
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

    if (c.isAssetTradeInvestment) return const SizedBox.shrink();

    final selectedColor = c.transactionType.color(context);
    final types = [
      TransactionType.income,
      TransactionType.expense,
      TransactionType.transfer,
    ];

    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: SegmentedButton<TransactionType>(
          segments: types
              .map(
                (e) => ButtonSegment<TransactionType>(
                  value: e,
                  label: Text(
                    e.displayName(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          selected: {c.transactionType},
          onSelectionChanged: (next) {
            final v = next.firstOrNull;
            if (v != null) c.onTransactionTypeChanged(v);
          },
          showSelectedIcon: false,
          style: ButtonStyle(
            animationDuration: const Duration(milliseconds: 250),
            side: WidgetStateProperty.resolveWith(
              (s) => const BorderSide(style: BorderStyle.none, width: 0),
            ),
            foregroundColor: WidgetStateProperty.resolveWith(
              (s) => s.contains(WidgetState.selected)
                  ? selectedColor.getContrastColor()
                  : AppColors.of(context).textBody,
            ),
            backgroundColor: WidgetStateProperty.resolveWith(
              (s) => s.contains(WidgetState.selected)
                  ? selectedColor
                  : Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
          ),
        ),
      ),
    );
  }
}
