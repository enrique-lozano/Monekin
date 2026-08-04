import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';

/// A single tab/segment for [ExpandingSegmentedTabs].
class SegmentedTabItem<T> {
  const SegmentedTabItem({
    required this.value,
    required this.icon,
    required this.label,
    this.color,
    this.badgeCount,
  });

  /// The value this segment represents.
  final T value;

  final IconData icon;

  final String label;

  /// Optional accent color for this segment. When set, it is used as the
  /// selected background instead of [ExpandingSegmentedTabs.selectedColor],
  /// with an automatically-contrasting foreground.
  final Color? color;

  /// Optional count rendered as a small badge next to the label. Only shown
  /// while the segment displays its label (i.e. it is expanded/selected).
  final int? badgeCount;
}

/// A segmented tab bar that adapts to the available width instead of
/// truncating labels:
///
/// - If every segment's icon + label fits in the available space, all
///   segments stay fully expanded (like Flutter's `SegmentedButton`).
/// - Otherwise, only the selected segment shows its label (with an
///   expand/collapse animation); the rest shrink to just their icon.
class ExpandingSegmentedTabs<T> extends StatelessWidget {
  const ExpandingSegmentedTabs({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
    this.fullWidth = true,
    this.height = 40,
    this.collapsedWidth = 48,
    this.duration = const Duration(milliseconds: 250),
    this.borderColor,
    this.selectedColor,
    this.selectedForegroundColor,
    this.unselectedForegroundColor,
  }) : assert(
         items.length > 1,
         'ExpandingSegmentedTabs needs at least 2 items; with only one, '
         "there's nothing to switch between, so don't display it at all.",
       );

  final List<SegmentedTabItem<T>> items;
  final T selected;
  final ValueChanged<T> onSelected;

  /// Whether the bar should stretch to fill all the available width
  /// (segments sharing it equally, like Flutter's `SegmentedButton` wrapped
  /// in a `SizedBox(width: double.infinity)`). When false, and every segment
  /// fits, the bar hugs its content width instead.
  ///
  /// This only affects the "everything fits" case: when segments must
  /// collapse to fit the available space, the bar always spans it fully.
  final bool fullWidth;

  /// Height of the bar.
  final double height;

  /// Width of a collapsed (icon-only) segment.
  final double collapsedWidth;

  final Duration duration;

  final Color? borderColor;

  /// Background of the selected segment, used when that item doesn't define
  /// its own [SegmentedTabItem.color]. Defaults to
  /// `colorScheme.secondaryContainer`.
  final Color? selectedColor;

  /// Foreground (icon/label) of the selected segment, used when that item
  /// doesn't define its own [SegmentedTabItem.color]. Defaults to
  /// `colorScheme.onSecondaryContainer`.
  final Color? selectedForegroundColor;

  /// Foreground (icon) of unselected segments. Defaults to
  /// `colorScheme.onSurfaceVariant`.
  final Color? unselectedForegroundColor;

  static const double _iconSize = 20;
  static const double _labelGap = 6;
  static const TextStyle _labelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
  );
  static const TextStyle _badgeTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 11,
  );

  double get _horizontalPadding => (collapsedWidth - _iconSize) / 2;

  double _fullSegmentWidth(BuildContext context, SegmentedTabItem<T> item) {
    final painter = TextPainter(
      text: TextSpan(text: item.label, style: _labelStyle),
      textDirection: Directionality.of(context),
      maxLines: 1,
    )..layout();

    final badgeWidth = item.badgeCount == null
        ? 0.0
        : _labelGap + _badgeWidth(context, item.badgeCount!);

    return _horizontalPadding * 2 +
        _iconSize +
        _labelGap +
        painter.width +
        badgeWidth;
  }

  double _badgeWidth(BuildContext context, int count) {
    final painter = TextPainter(
      text: TextSpan(text: '$count', style: _badgeTextStyle),
      textDirection: Directionality.of(context),
      maxLines: 1,
    )..layout();

    // Horizontal padding of the badge pill on both sides.
    return painter.width + 12;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final shape = BorderRadius.circular(height / 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidths = [
          for (final item in items) _fullSegmentWidth(context, item),
        ];
        final totalFullWidth = fullWidths.fold<double>(0, (a, b) => a + b);
        final fitsExpanded = totalFullWidth <= constraints.maxWidth;

        final effectiveCollapsedWidth =
            collapsedWidth * items.length <= constraints.maxWidth
            ? collapsedWidth
            : constraints.maxWidth / items.length;

        final selectedCollapsedWidth =
            (constraints.maxWidth -
                    effectiveCollapsedWidth * (items.length - 1))
                .clamp(effectiveCollapsedWidth, constraints.maxWidth);

        return Container(
          height: height,
          clipBehavior: Clip.antiAlias,
          // The border is drawn as a foreground decoration so it always
          // paints on top of the (square-cornered) segments below, instead
          // of being hidden behind them at the rounded corners.
          decoration: BoxDecoration(borderRadius: shape),
          foregroundDecoration: BoxDecoration(
            border: Border.all(color: borderColor ?? colorScheme.outline),
            borderRadius: shape,
          ),
          child: Row(
            mainAxisSize: fullWidth || !fitsExpanded
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              for (var i = 0; i < items.length; i++)
                if (fitsExpanded && fullWidth)
                  Expanded(
                    child: _buildSegment(
                      context,
                      items[i],
                      isSelected: items[i].value == selected,
                      width: null,
                      showLabel: true,
                    ),
                  )
                else if (fitsExpanded)
                  _buildSegment(
                    context,
                    items[i],
                    isSelected: items[i].value == selected,
                    width: fullWidths[i],
                    showLabel: true,
                  )
                else
                  _buildSegment(
                    context,
                    items[i],
                    isSelected: items[i].value == selected,
                    width: items[i].value == selected
                        ? selectedCollapsedWidth
                        : effectiveCollapsedWidth,
                    showLabel: items[i].value == selected,
                  ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSegment(
    BuildContext context,
    SegmentedTabItem<T> item, {
    required bool isSelected,
    required double? width,
    required bool showLabel,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final bgColor = isSelected
        ? (item.color ?? selectedColor ?? colorScheme.secondaryContainer)
        : Colors.transparent;

    final fgColor = isSelected
        ? (item.color?.getContrastColor() ??
              selectedForegroundColor ??
              colorScheme.onSecondaryContainer)
        : (unselectedForegroundColor ?? colorScheme.onSurfaceVariant);

    return AnimatedContainer(
      duration: duration,
      curve: Curves.easeOutCubic,
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(color: bgColor),
      child: Tappable(
        onTap: () => onSelected(item.value),
        bgColor: bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: _iconSize, color: fgColor),
            if (showLabel)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: _labelGap),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _labelStyle.copyWith(color: fgColor),
                  ),
                ),
              ),
            if (showLabel && item.badgeCount != null)
              Padding(
                padding: const EdgeInsets.only(left: _labelGap),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: fgColor.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    '${item.badgeCount}',
                    style: _badgeTextStyle.copyWith(color: fgColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
