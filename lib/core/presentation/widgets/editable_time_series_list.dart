import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A vertical list of dated values (prices, valuations, exchange rates...) where
/// each row can be expanded to edit or delete that point. Items must be sorted
/// newest-first (the previous/older value is read from `items[index + 1]` to
/// compute the variation shown on each tile).
class EditableTimeSeriesList<T> extends StatefulWidget {
  const EditableTimeSeriesList({
    super.key,
    required this.items,
    required this.dateExtractor,
    required this.onEdit,
    required this.onDelete,
    this.scrollController,
    required this.valueExtractor,
    required this.currency,
    this.physics,
  });

  /// The items to display in the list.
  final List<T> items;

  /// Extracts the [DateTime] shown as the tile title.
  final DateTime Function(T) dateExtractor;

  /// Extracts the currencyValue to be displayed in each tile. If a null is returned,
  /// the value will be inherited from the previous one
  final double Function(T) valueExtractor;

  final CurrencyInDB currency;

  /// Called when the user taps the edit action for an item.
  final void Function(T item) onEdit;

  /// Called when the user taps the delete action for an item.
  final void Function(T item) onDelete;

  /// Optional scroll controller for the inner [ListView].
  final ScrollController? scrollController;

  /// Optional scroll physics for the inner [ListView]. Pass
  /// [NeverScrollableScrollPhysics] to let the list flow inside an outer scroll.
  final ScrollPhysics? physics;

  @override
  State<EditableTimeSeriesList<T>> createState() =>
      _EditableTimeSeriesListState<T>();
}

class _EditableTimeSeriesListState<T> extends State<EditableTimeSeriesList<T>> {
  Set<DateTime> _expandedTiles = {};

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: widget.physics,
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

        double itemValue = widget.valueExtractor(item);

        return ExpansionTile(
          title: Text(
            getMMMdDateFormatBasedOnYear(widget.dateExtractor(item)).text,
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
                    onPressed: () => widget.onDelete(item),
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

/// A [CardWithHeader] wrapping an [EditableTimeSeriesList], with a built-in
/// empty state and client-side pagination ("See more (N)"). Used across the
/// asset, security and exchange-rate detail pages so a long history renders a
/// handful of rows up front instead of thousands of tiles.
///
/// [items] must be sorted newest-first, like [EditableTimeSeriesList].
class EditableTimeSeriesCard<T> extends StatefulWidget {
  const EditableTimeSeriesCard({
    super.key,
    required this.title,
    this.titleBuilder,
    this.headerAction,
    required this.emptyDescription,
    this.emptyTitle,
    required this.items,
    required this.dateExtractor,
    required this.valueExtractor,
    required this.currency,
    required this.onEdit,
    required this.onDelete,
    this.initialCount = 10,
    this.pageSize = 10,
  });

  final String title;
  final Widget Function(String title)? titleBuilder;
  final Widget? headerAction;

  final String emptyDescription;
  final String? emptyTitle;

  final List<T> items;
  final DateTime Function(T) dateExtractor;
  final double Function(T) valueExtractor;
  final CurrencyInDB currency;

  final void Function(T item) onEdit;
  final void Function(T item) onDelete;

  /// How many rows to show before the first "See more" tap.
  final int initialCount;

  /// How many extra rows each "See more" tap reveals.
  final int pageSize;

  @override
  State<EditableTimeSeriesCard<T>> createState() =>
      _EditableTimeSeriesCardState<T>();
}

class _EditableTimeSeriesCardState<T> extends State<EditableTimeSeriesCard<T>> {
  late int _visible = widget.initialCount;

  @override
  void didUpdateWidget(covariant EditableTimeSeriesCard<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Keep the revealed count sane when the underlying list changes (e.g. after
    // adding/deleting a point) without collapsing back to the first page.
    final maxVisible = widget.items.length.clamp(widget.initialCount, 1 << 30);
    if (_visible > maxVisible) _visible = maxVisible;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    if (widget.items.isEmpty) {
      return CardWithHeader(
        title: widget.title,
        titleBuilder: widget.titleBuilder,
        headerAction: widget.headerAction,
        body: NoResults(
          title: widget.emptyTitle ?? t.general.empty_warn,
          description: widget.emptyDescription,
          showIllustration: false,
        ),
      );
    }

    final total = widget.items.length;
    final visible = _visible.clamp(0, total);
    final remaining = total - visible;

    return CardWithHeader(
      title: widget.title,
      titleBuilder: widget.titleBuilder,
      headerAction: widget.headerAction,
      bodyPadding: const EdgeInsets.symmetric(vertical: 4),
      body: EditableTimeSeriesList<T>(
        items: widget.items.sublist(0, visible),
        dateExtractor: widget.dateExtractor,
        valueExtractor: widget.valueExtractor,
        currency: widget.currency,
        onEdit: widget.onEdit,
        onDelete: widget.onDelete,
        physics: const NeverScrollableScrollPhysics(),
      ),
      footer: remaining > 0
          ? CardFooterWithSingleButton(
              text: t.ui_actions.see_more_count(n: remaining),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              onButtonClick: () => setState(
                () => _visible = (_visible + widget.pageSize).clamp(0, total),
              ),
            )
          : null,
    );
  }
}
