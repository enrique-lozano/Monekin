import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A generic, responsive list of time-series items with inline edit/delete
/// on wide screens and a popup menu on narrow screens.
///
/// Used by both the exchange-rate details page and the investment
/// valuation history page.
class EditableTimeSeriesList<T> extends StatelessWidget {
  const EditableTimeSeriesList({
    super.key,
    required this.items,
    required this.dateExtractor,
    required this.subtitleBuilder,
    required this.onEdit,
    required this.onDelete,
    this.scrollController,
  });

  /// The items to display in the list.
  final List<T> items;

  /// Extracts the [DateTime] shown as the tile title.
  final DateTime Function(T) dateExtractor;

  /// Builds the subtitle widget for a given item.
  final Widget Function(BuildContext context, T item) subtitleBuilder;

  /// Called when the user taps the edit action for an item.
  final void Function(T item) onEdit;

  /// Called when the user taps the delete action for an item.
  final void Function(T item) onDelete;

  /// Optional scroll controller for the inner [ListView].
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isLargeScreen = BreakPoint.of(context).isLargerThan(BreakpointID.md);

    return ListView.separated(
      shrinkWrap: true,
      controller: scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          title: Text(DateFormat.yMMMMd().format(dateExtractor(item))),
          subtitle: subtitleBuilder(context, item),
          contentPadding: EdgeInsetsDirectional.only(
            start: 16,
            end: isLargeScreen ? 0 : 8,
          ),
          trailing: isLargeScreen
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.edit_rounded),
                      onPressed: () => onEdit(item),
                      tooltip: t.ui_actions.edit,
                    ),
                    IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.delete),
                      onPressed: () => onDelete(item),
                      tooltip: t.ui_actions.delete,
                    ),
                  ],
                )
              : MonekinPopupMenuButton(
                  actionItems: [
                    ListTileActionItem(
                      label: t.ui_actions.edit,
                      icon: Icons.edit_rounded,
                      onClick: () => onEdit(item),
                    ),
                    ListTileActionItem(
                      label: t.ui_actions.delete,
                      icon: Icons.delete,
                      role: ListTileActionRole.delete,
                      onClick: () => onDelete(item),
                    ),
                  ],
                ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
