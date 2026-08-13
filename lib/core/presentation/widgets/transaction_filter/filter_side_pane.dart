import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_form.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A persistent, non-modal filter panel meant to live beside the page content
/// on wide layouts (a split pane). Unlike a drawer/bottom sheet, the content
/// and the filters stay interactive at the same time: [onChanged] fires live as
/// the user edits the filters.
///
/// When collapsed it shrinks to a narrow strip with a chevron toggle, filter
/// icon, active-filter count badge, and a vertical label.
class FilterSidePane extends StatelessWidget {
  const FilterSidePane({
    super.key,
    required this.filters,
    required this.onChanged,
    required this.expanded,
    required this.onToggle,
    this.showDateFilter = true,
    this.showTransactionRefinements = true,
    this.width = 340,
  });

  final TransactionFilterSet filters;
  final ValueChanged<TransactionFilterSet> onChanged;

  final bool expanded;
  final VoidCallback onToggle;

  final bool showDateFilter;
  final bool showTransactionRefinements;
  final double width;

  static const double collapsedWidth = 48;
  static const Duration _animDuration = Duration(milliseconds: 220);

  /// A soft separator color, matching the subtle lines used elsewhere in the
  /// app (the default divider color reads too heavy here).
  Color _lineColor(BuildContext context) =>
      Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return AnimatedContainer(
      duration: _animDuration,
      curve: Curves.easeInOut,
      width: expanded ? width : collapsedWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border(left: BorderSide(color: _lineColor(context))),
      ),
      // Keep the inner content laid out at its full [width] regardless of the
      // animating container width, clipping the overflow. This avoids reflow
      // (and overflow errors) while the pane grows/shrinks.
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.centerLeft,
          minWidth: width,
          maxWidth: width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              IgnorePointer(
                ignoring: expanded,
                child: AnimatedOpacity(
                  duration: _animDuration,
                  opacity: expanded ? 0 : 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: collapsedWidth,
                      child: _buildCollapsed(context, t),
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: !expanded,
                child: AnimatedOpacity(
                  duration: _animDuration,
                  opacity: expanded ? 1 : 0,
                  child: _buildExpanded(context, t),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsed(BuildContext context, Translations t) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final filterCount = filters.activeFilterCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: collapsedWidth,
          child: IconButton(
            tooltip: t.general.filters,
            onPressed: onToggle,
            icon: const Icon(Icons.chevron_left_rounded),
            iconSize: 20,
          ),
        ),
        Divider(height: 1, color: _lineColor(context)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              const SizedBox(height: 6),
              Icon(
                Icons.filter_alt_outlined,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),

              if (filterCount > 0)
                Badge.count(count: filterCount, maxCount: 99),

              RotatedBox(
                quarterTurns: 1,
                child: Text(
                  t.general.filters.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpanded(BuildContext context, Translations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 6, 8),
          child: Row(
            children: [
              const Icon(Icons.filter_alt_outlined, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  t.general.filters,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                tooltip: t.ui_actions.close,
                iconSize: 20,
                onPressed: onToggle,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: _lineColor(context)),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: TransactionFilterForm(
              filter: filters,
              onChanged: onChanged,
              showDateFilter: showDateFilter,
              showTransactionRefinements: showTransactionRefinements,
            ),
          ),
        ),
        Divider(height: 1, color: _lineColor(context)),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextButton.icon(
              onPressed: filters.hasFilter
                  ? () => onChanged(const TransactionFilterSet())
                  : null,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(t.transaction.filters.reset),
            ),
          ),
        ),
      ],
    );
  }
}
