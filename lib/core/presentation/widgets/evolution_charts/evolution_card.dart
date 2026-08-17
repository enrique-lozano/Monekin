import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/dates/date_range_chips.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Value, period trend, chart and date-range chips in the layout used by the
/// dashboard and the account / security / asset details pages.
///
/// On narrow widths the block is undecorated: padded header, full-bleed chart,
/// chips below. From [BreakpointID.md] it sits in a surface card; from
/// [BreakpointID.lg] the chips move up next to the header.
class EvolutionCard extends StatelessWidget {
  const EvolutionCard({
    super.key,
    required this.valueLabel,
    required this.finalValue,
    required this.chart,
    required this.currentPeriod,
    required this.onPresetSelected,
    this.currency,
    this.initialValue,
    this.changeValue,
    this.changePercentage,
    this.highlightedValue,
    this.oldestDate,
    this.footer,
    this.chartHeight,
    this.showDateSelector = true,
    this.loading = false,
    this.contentInset = 16,
  });

  final String valueLabel;
  final double finalValue;
  final CurrencyInDB? currency;

  /// Period-start value used to compute the trend vs the displayed amount.
  /// Ignored when [changeValue] or [changePercentage] is passed.
  final double? initialValue;

  /// Explicit trend delta. When set (with or without [changePercentage]),
  /// this is shown instead of `displayed - initialValue`.
  final double? changeValue;
  final double? changePercentage;

  final ValueListenable<double?>? highlightedValue;
  final Widget chart;
  final DatePeriod currentPeriod;
  final ValueChanged<DatePeriod> onPresetSelected;
  final DateTime? oldestDate;
  final Widget? footer;
  final double? chartHeight;
  final bool showDateSelector;
  final bool loading;

  /// Horizontal inset for the header and chips when the card is not decorated.
  final double contentInset;

  DateRangeChips _chips({bool shrink = false}) {
    return DateRangeChips(
      currentPeriod: currentPeriod,
      oldestDate: oldestDate,
      onPresetSelected: onPresetSelected,
      wrap: shrink,
      shrink: shrink,
      padding: EdgeInsets.zero,
    );
  }

  Widget _padded(Widget child, {required bool decorated}) {
    if (decorated || contentInset <= 0) return child;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: contentInset),
      child: child,
    );
  }

  /// Trend delta and percentage for a displayed [value]: the explicit
  /// [changeValue]/[changePercentage] when given, otherwise derived from
  /// [initialValue]. A null [change] means there is no trend to show.
  ({double? change, double percentage}) _trend(double value) {
    if (changeValue != null || changePercentage != null) {
      return (change: changeValue ?? 0, percentage: changePercentage ?? 0);
    }
    if (initialValue == null) return (change: null, percentage: 0);

    final change = value - initialValue!;
    return (
      change: change,
      percentage: initialValue == 0 ? 0.0 : change / initialValue!.abs(),
    );
  }

  Widget _valueHeader(
    BuildContext context, {
    required double maxWidth,
    required bool wideAmount,
    required bool inlineTrend,
  }) {
    final theme = Theme.of(context);
    final hint = AppColors.of(context).textHint;
    final hintStyle = theme.textTheme.headlineSmall!.copyWith(
      fontWeight: FontWeight.w700,
      color: hint,
    );

    Widget amountAndTrend(double value, CurrencyInDB? currency) {
      final amount = CurrencyDisplayer(
        amountToConvert: value,
        currency: currency,
        integerStyle: theme.textTheme.headlineLarge!.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: wideAmount ? 38 : 32,
          height: 1.05,
        ),
        decimalsStyle: hintStyle,
        currencyStyle: hintStyle,
      );

      final (:change, :percentage) = _trend(value);
      if (change == null) return amount;

      final trend = TrendingValue(
        percentage: percentage,
        value: change,
        valueCurrency: currency,
        dataTypes: const [
          TrendingValueDataType.value,
          TrendingValueDataType.percentage,
        ],
        fontWeight: FontWeight.bold,
        fontSize: 16,
        style: TrendingValueStyle.chip,
        compactValue: change.abs() >= 100000,
      );

      // Estimate the amount's rendered width (~0.6·fontSize per digit, plus a
      // bit for the currency symbol and separators) and stack the trend below
      // once the amount would take over 60% of the row, leaving too little for
      // it beside. Based on [finalValue] (not the hovered [value]) so scrubbing
      // the chart doesn't reflow the header.
      final digits = currency == null
          ? 0
          : UINumberFormatter.digitCount(finalValue, currency: currency);
      final fontSize = wideAmount ? 38.0 : 32.0;
      final estimatedAmountWidth = digits * fontSize * 0.6 + fontSize * 2;
      final crowded = estimatedAmountWidth > maxWidth * 0.6;

      return inlineTrend && !crowded
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 12,
              children: [
                Flexible(child: amount),
                trend,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [amount, trend],
            );
    }

    // [TrendingValue] needs an explicit currency to render money (unlike
    // [CurrencyDisplayer] it won't fall back to the preferred one), so resolve
    // it once for both.
    Widget forValue(double value) {
      if (currency != null) return amountAndTrend(value, currency);

      return StreamBuilder(
        stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
        builder: (context, snapshot) => amountAndTrend(value, snapshot.data),
      );
    }

    final highlighted = highlightedValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueLabel.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelMedium!.copyWith(
            color: hint,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Skeletonizer(
          enabled: loading,
          child: highlighted == null
              ? forValue(finalValue)
              : ValueListenableBuilder<double?>(
                  valueListenable: highlighted,
                  builder: (_, value, _) => forValue(value ?? finalValue),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final window = BreakPoint.of(context);
        final local = BreakPoint.fromWidth(constraints.maxWidth);
        final decorated = window.isLargerOrEqualTo(BreakpointID.md);
        final chipsInline =
            showDateSelector && local.isLargerOrEqualTo(BreakpointID.lg);
        final height = chartHeight ?? (decorated ? 150.0 : 110.0);

        final header = _valueHeader(
          context,
          maxWidth: constraints.maxWidth - (decorated ? 48 : contentInset * 2),
          wideAmount: decorated,
          inlineTrend: !chipsInline,
        );

        final body = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _padded(
              chipsInline
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: header),
                        const SizedBox(width: 16),
                        _chips(shrink: true),
                      ],
                    )
                  : header,
              decorated: decorated,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: height,
              child: RepaintBoundary(child: ClipRect(child: chart)),
            ),
            if (showDateSelector && !chipsInline) ...[
              const SizedBox(height: 14),
              _padded(_chips(), decorated: decorated),
            ],
            if (footer != null) ...[
              const Divider(height: 24),
              _padded(footer!, decorated: decorated),
            ],
          ],
        );

        if (!decorated) return body;

        return DecoratedBox(
          decoration: cardSurfaceDecoration(context, radius: 24),
          child: Padding(padding: const EdgeInsets.all(24), child: body),
        );
      },
    );
  }
}
