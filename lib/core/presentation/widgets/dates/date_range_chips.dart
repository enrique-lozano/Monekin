import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A quick date-range preset that maps a short label to a [DatePeriod].
///
/// Every preset is a rolling window ([PeriodType.lastDays]) or the whole
/// history, never a calendar cycle, so the same label always means the same
/// span no matter what day of the month/year it is picked on.
class DateRangePreset {
  const DateRangePreset({
    required this.label,
    required this.period,
    this.hideOnNarrow = false,
  });

  final String label;
  final DatePeriod period;

  /// Whether this preset should be dropped when the available width is
  /// smaller than [BreakpointID.sm], to give the remaining chips more room.
  final bool hideOnNarrow;

  /// Whether the given [datePeriod] corresponds to this preset.
  bool matches(DatePeriod datePeriod) {
    if (datePeriod.periodType != period.periodType) return false;

    return switch (period.periodType) {
      PeriodType.cycle => datePeriod.periodicity == period.periodicity,
      PeriodType.lastDays => datePeriod.lastDays == period.lastDays,
      PeriodType.allTime => true,
      PeriodType.dateRange => false,
    };
  }

  /// Whether this preset's window fits in the history available, given the
  /// [oldestDate] with data. Presets reaching further back are pointless,
  /// since they would render exactly like the all-time one.
  bool isAvailableFor(DateTime oldestDate) {
    final startDate = DatePeriodState(datePeriod: period).startDate;

    if (startDate == null) return true;

    return !oldestDate.isAfter(startDate);
  }
}

/// The period every screen showing [DateRangeChips] starts on, so that a chip
/// is always selected on a fresh start instead of falling back to "custom".
const defaultDatePeriod = DatePeriod.lastDays(30);

List<DateRangePreset> _presets(BuildContext context) {
  final t = Translations.of(context);

  return [
    DateRangePreset(
      label: t.home.date_ranges.week,
      period: const DatePeriod.lastDays(7),
    ),
    DateRangePreset(
      label: t.home.date_ranges.month,
      period: const DatePeriod.lastDays(30),
    ),
    DateRangePreset(
      label: t.home.date_ranges.quarter,
      period: const DatePeriod.lastDays(90),
      hideOnNarrow: true,
    ),
    DateRangePreset(
      label: t.home.date_ranges.half_year,
      period: const DatePeriod.lastDays(180),
    ),
    DateRangePreset(
      label: t.home.date_ranges.year,
      period: const DatePeriod.lastDays(365),
    ),
    DateRangePreset(
      label: t.home.date_ranges.max,
      period: const DatePeriod.allTime(),
    ),
  ];
}

/// A short label for [state], preferring the label of the quick chip it
/// corresponds to so that headers echo the chip the user just tapped, and
/// falling back to the full range text for custom periods.
String datePeriodShortLabel(BuildContext context, DatePeriodState state) {
  for (final preset in _presets(context)) {
    if (preset.matches(state.datePeriod)) return preset.label;
  }

  return state.getText(context, showLongMonth: false);
}

/// A horizontal, scrollable row of quick date-range chips plus a dashed
/// "custom" chip that opens the full date-period modal.
class DateRangeChips extends StatelessWidget {
  const DateRangeChips({
    super.key,
    required this.currentPeriod,
    required this.onPresetSelected,
    required this.onCustomTap,
    this.oldestDate,
    this.foregroundColor,
    this.wrap = false,
    this.shrink = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final DatePeriod currentPeriod;
  final void Function(DatePeriod period) onPresetSelected;
  final VoidCallback onCustomTap;

  /// Oldest date with data. When set, presets reaching further back than it
  /// are shown disabled, since they would all render the same chart.
  final DateTime? oldestDate;

  /// Base color for labels/borders. Defaults to the theme's onSurface.
  final Color? foregroundColor;

  /// When true, chips flow in a [Wrap] instead of a horizontally scrollable
  /// list. Useful on wide layouts with enough available width.
  final bool wrap;

  /// When true, the chips are laid out in a content-sized [Row]
  /// (`mainAxisSize.min`) with no scrolling. Useful to place them flush at the
  /// end of a wide container. The caller must guarantee there is enough room.
  final bool shrink;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final baseColor =
        foregroundColor ?? Theme.of(context).colorScheme.onSurface;
    final accent = Theme.of(context).colorScheme.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // Below `sm` there isn't enough room for every preset: drop the
        // least essential one (3M) first so the rest keep some breathing
        // room instead of overflowing.
        final isNarrow =
            availableWidth < BreakPoint.getById(BreakpointID.sm).width;

        // Below `xs` even that isn't enough: collapse the custom chip down
        // to just its icon to free up extra space.
        final isVeryNarrow =
            availableWidth < BreakPoint.getById(BreakpointID.xs).width;

        final presets = _presets(
          context,
        ).where((p) => !(isNarrow && p.hideOnNarrow)).toList();

        final anyPresetSelected = presets.any((p) => p.matches(currentPeriod));
        final isCustomSelected = !anyPresetSelected;

        final chips = <Widget>[
          for (final preset in presets)
            _Chip(
              label: preset.label,
              selected: preset.matches(currentPeriod),
              enabled: oldestDate == null || preset.isAvailableFor(oldestDate!),
              baseColor: baseColor,
              accent: accent,
              onTap: () {
                HapticFeedback.selectionClick();
                onPresetSelected(preset.period);
              },
            ),
          _Chip(
            label: t.home.date_ranges.custom,
            selected: isCustomSelected,
            baseColor: baseColor,
            accent: accent,
            icon: Icons.calendar_month_rounded,
            compact: isVeryNarrow,
            onTap: () {
              HapticFeedback.selectionClick();
              onCustomTap();
            },
          ),
        ];

        if (shrink) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: chips,
          );
        }

        if (wrap) {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            runAlignment: WrapAlignment.start,
            children: chips,
          );
        }

        return _FadingChipsRow(
          padding: padding,
          availableWidth: availableWidth,
          spacing: isNarrow
              ? 0
              : AppUtils.isMobileLayout(context)
              ? 4
              : 8,
          children: chips,
        );
      },
    );
  }
}

/// A horizontally scrollable, centered row of [children] that softly fades
/// out at whichever edge still has more content to reveal, instead of
/// abruptly clipping the last chip when it overflows the viewport.
class _FadingChipsRow extends StatefulWidget {
  const _FadingChipsRow({
    required this.children,
    required this.spacing,
    required this.padding,
    required this.availableWidth,
  });

  final List<Widget> children;
  final double spacing;
  final EdgeInsets padding;
  final double availableWidth;

  @override
  State<_FadingChipsRow> createState() => _FadingChipsRowState();
}

class _FadingChipsRowState extends State<_FadingChipsRow> {
  static const _fadeWidth = 24.0;

  final _scrollController = ScrollController();

  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateFadeState);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateFadeState());
  }

  @override
  void didUpdateWidget(covariant _FadingChipsRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.children.length != widget.children.length ||
        oldWidget.availableWidth != widget.availableWidth) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateFadeState());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateFadeState);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateFadeState() {
    if (!mounted || !_scrollController.hasClients) return;

    final position = _scrollController.position;
    final canScrollLeft = position.pixels > position.minScrollExtent + 1;
    final canScrollRight = position.pixels < position.maxScrollExtent - 1;

    if (canScrollLeft != _canScrollLeft || canScrollRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canScrollLeft;
        _canScrollRight = canScrollRight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollView = SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: widget.padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: widget.availableWidth - widget.padding.horizontal,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: widget.spacing,
          children: widget.children,
        ),
      ),
    );

    if (!_canScrollLeft && !_canScrollRight) return scrollView;

    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) {
        final leftFraction = _canScrollLeft
            ? (_fadeWidth / bounds.width).clamp(0.0, 0.5)
            : 0.0;
        final rightFraction = _canScrollRight
            ? (_fadeWidth / bounds.width).clamp(0.0, 0.5)
            : 0.0;

        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Colors.transparent,
            Colors.white,
            Colors.white,
            Colors.transparent,
          ],
          stops: [0, leftFraction, 1 - rightFraction, 1],
        ).createShader(bounds);
      },
      child: scrollView,
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.baseColor,
    required this.accent,
    required this.onTap,
    this.enabled = true,
    this.icon,
    this.compact = false,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final Color baseColor;
  final Color accent;
  final IconData? icon;

  /// When true and [icon] is set, only the icon is shown (no label), for
  /// tight layouts. Wrapped in a [Tooltip] so the label is still reachable.
  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = selected
        ? accent.withOpacity(0.14)
        : Colors.transparent;

    final Color fgColor = selected
        ? accent
        : baseColor.withOpacity(enabled ? 0.5 : 0.22);

    final showLabel = !compact || icon == null;

    final chip = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: showLabel
              ? EdgeInsets.symmetric(
                  horizontal: icon != null ? 10 : 12,
                  vertical: 5,
                )
              : const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: fgColor),
                if (showLabel) const SizedBox(width: 4),
              ],
              if (showLabel)
                Text(
                  label,
                  style: TextStyle(
                    color: fgColor,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return showLabel ? chip : Tooltip(message: label, child: chip);
  }
}
