import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class EditableTimeSeriesList<T> extends StatefulWidget {
  const EditableTimeSeriesList({
    super.key,
    required this.items,
    required this.dateExtractor,
    required this.onEdit,
    required this.onDelete,
    this.scrollController,
    required this.valueExtractor,
    this.transactions,
    required this.currency,
  });

  /// The items to display in the list.
  final List<T> items;

  /// Extracts the [DateTime] shown as the tile title.
  final DateTime Function(T) dateExtractor;

  /// Extracts the currencyValue to be displayed in each tile. If a null is returned,
  /// the value will be inherited from the previous one
  final double Function(T) valueExtractor;

  final List<MoneyTransaction>? transactions;

  final CurrencyInDB currency;

  /// Called when the user taps the edit action for an item.
  final void Function(T item) onEdit;

  /// Called when the user taps the delete action for an item.
  final void Function(T item) onDelete;

  /// Optional scroll controller for the inner [ListView].
  final ScrollController? scrollController;

  @override
  State<EditableTimeSeriesList<T>> createState() =>
      _EditableTimeSeriesListState<T>();
}

class _EditableTimeSeriesListState<T> extends State<EditableTimeSeriesList<T>> {
  Set<DateTime> _expandedTiles = {};

  Widget buildListOfTransactions(List<MoneyTransaction> transactions) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: transactions.map((transaction) {
        return TransactionListTile(
          transaction: transaction,
          heroTag: 'EDITABLE_TIMESERIES__${transaction.id}',
          showDateTime: false,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ListView.separated(
      shrinkWrap: true,
      controller: widget.scrollController,
      itemCount: widget.items.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final prevItem = index >= widget.items.length - 1
            ? null
            : widget.items[index + 1];

        final isExpanded = _expandedTiles.contains(
          widget.dateExtractor(item).justDay(),
        );

        final transactionsInDate =
            widget.transactions
                ?.where(
                  (t) =>
                      DateUtils.isSameDay(widget.dateExtractor(item), t.date),
                )
                .toList() ??
            [];

        double? itemValue = widget.valueExtractor(item);

        return ExpansionTile(
          title: Row(
            spacing: 8,
            children: [
              Text(
                getMMMdDateFormatBasedOnYear(widget.dateExtractor(item)).text,
              ),
              if (transactionsInDate.isNotEmpty)
                Icon(
                  Icons.notes,
                  color: AppColors.of(context).textHint,
                  size: 16,
                ),
            ],
          ),
          leading: AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.expand_more),
          ),
          minTileHeight: 54,
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CurrencyDisplayer(
                amountToConvert: itemValue,
                currency: widget.currency,
                integerStyle: Theme.of(context).textTheme.titleMedium!,
              ),

              if (prevItem != null)
                Builder(
                  builder: (context) {
                    final oldValue = widget.valueExtractor(prevItem);

                    final variationPercentage =
                        (itemValue - oldValue) / oldValue;

                    if (variationPercentage == 0) {
                      return SizedBox.shrink();
                    }

                    return TrendingValue(
                      padding: const EdgeInsets.all(0),
                      percentage: variationPercentage,
                      fontSize: 12,
                    );
                  },
                ),
            ],
          ),
          onExpansionChanged: (expanded) {
            final tileId = widget.dateExtractor(item).justDay();

            setState(() {
              _expandedTiles = expanded ? {tileId} : {};
            });
          },
          childrenPadding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          children: [
            if (transactionsInDate.isNotEmpty) ...[
              CardWithHeader(
                title: t.transaction.display(n: 10),
                body: buildListOfTransactions(transactionsInDate),
              ),
              const SizedBox(height: 12),
            ],

            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    label: Text(t.ui_actions.edit),
                    icon: const Icon(Icons.edit),
                    onPressed: () => widget.onEdit(item),
                  ),
                ),
                Expanded(
                  child: FilledButton.tonalIcon(
                    label: Text(t.ui_actions.delete),
                    icon: const Icon(Icons.delete),
                    style: FilledButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.errorContainer,
                    ),
                    onPressed: transactionsInDate.isNotEmpty
                        ? null
                        : () => widget.onDelete(item),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        final item = widget.items[index];

        final nextItemDate = index < widget.items.length - 1
            ? widget.dateExtractor(widget.items[index + 1])
            : null;

        if (nextItemDate != null &&
            DateUtils.isSameDay(widget.dateExtractor(item), nextItemDate)) {
          return const SizedBox.shrink();
        }

        return const Divider();
      },
    );
  }
}
