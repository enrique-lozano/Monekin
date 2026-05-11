import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/monetary_evolution_chart_shared.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';

/// A generic time-series line chart that displays data points over time
/// with an optional gradient fill, hover interaction, and an
/// "insufficient data" overlay when there are too few points.
///
/// This widget is used by both the exchange-rate evolution chart and the
/// investment-valuation evolution chart.
class TimeSeriesEvolutionChart<T> extends StatefulWidget {
  const TimeSeriesEvolutionChart({
    super.key,
    required this.data,
    required this.dateExtractor,
    required this.valueExtractor,
    this.currency,
    this.tooltipTitleBuilder,
    this.minY,
    this.maxY,
    this.extraLinesData,
    this.onHover,
  });

  /// The raw data items to plot.
  final List<T> data;

  /// Extracts the [DateTime] (x-axis) from a data item.
  final DateTime Function(T) dateExtractor;

  /// Extracts the numeric value (y-axis) from a data item.
  final double Function(T) valueExtractor;

  /// Optional currency used to format tooltip values.
  /// When null, tooltips show a plain numeric value.
  final CurrencyInDB? currency;

  /// Optional tooltip title builder. When provided, it overrides the default
  /// date-based title.
  final String Function(T item)? tooltipTitleBuilder;

  /// Optional Y-axis overrides. When null, the widget auto-computes them.
  final double? minY;
  final double? maxY;

  /// Optional extra lines (e.g. budget limits).
  final ExtraLinesData? extraLinesData;

  /// Called when the user hovers/touches a data point, or `null` when the
  /// touch ends. The callback receives the original data item.
  final void Function(T?)? onHover;

  @override
  State<TimeSeriesEvolutionChart<T>> createState() =>
      _TimeSeriesEvolutionChartState<T>();
}

class _TimeSeriesEvolutionChartState<T>
    extends State<TimeSeriesEvolutionChart<T>> {
  final EvolutionDateHoverHaptics _dateHaptics = EvolutionDateHoverHaptics();

  void _resetHover() {
    _dateHaptics.reset();
    widget.onHover?.call(null);
  }

  void _handleHoverSpot(FlSpot spot, Map<int, T> byX) {
    _dateHaptics.onHoveredXMs(spot.x.toInt());
    widget.onHover?.call(byX[spot.x.toInt()]);
  }

  @override
  Widget build(BuildContext context) {
    final lineColor = Theme.of(context).colorScheme.primary;

    final sortedData = List<T>.from(widget.data)
      ..sort(
        (a, b) => widget.dateExtractor(a).compareTo(widget.dateExtractor(b)),
      );

    final byX = <int, T>{
      for (final item in sortedData)
        widget.dateExtractor(item).millisecondsSinceEpoch: item,
    };

    final isNotEnoughData = sortedData.length <= 2;

    final chart = LineChart(
      LineChartData(
        minY: widget.minY,
        maxY: widget.maxY,
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        extraLinesData: widget.extraLinesData,
        lineTouchData: isNotEnoughData
            ? const LineTouchData(enabled: false)
            : LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  getTooltipColor: (spot) =>
                      Theme.of(context).colorScheme.surface,
                  tooltipPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final item = byX[spot.x.toInt()];
                      final date = DateTime.fromMillisecondsSinceEpoch(
                        spot.x.toInt(),
                      );

                      final title =
                          item != null && widget.tooltipTitleBuilder != null
                          ? widget.tooltipTitleBuilder!(item)
                          : DateFormat.yMMMd().format(date);

                      final valueSpans = widget.currency != null
                          ? UINumberFormatter.currency(
                              currency: widget.currency,
                              amountToConvert: spot.y,
                              integerStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ).getTextSpanList(context)
                          : <TextSpan>[
                              TextSpan(
                                text: spot.y.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ];

                      return LineTooltipItem(
                        '$title \n',
                        const TextStyle(fontSize: 12),
                        textAlign: TextAlign.start,
                        children: valueSpans,
                      );
                    }).toList();
                  },
                ),
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? touchResponse) {
                      if (evolutionChartTouchEnded(event)) {
                        _resetHover();
                        return;
                      }

                      if (touchResponse != null &&
                          touchResponse.lineBarSpots != null &&
                          touchResponse.lineBarSpots!.isNotEmpty) {
                        final spot = touchResponse.lineBarSpots!.first;
                        _handleHoverSpot(spot, byX);
                        return;
                      }

                      _resetHover();
                    },
              ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: isNotEnoughData
              ? noAxisTitles
              : AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      if (value == meta.max || value == meta.min) {
                        return Container();
                      }

                      return SideTitleWidget(
                        meta: meta,
                        child: Text(
                          meta.formattedValue,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                          style: smallAxisTitleStyle(context),
                        ),
                      );
                    },
                  ),
                ),
          topTitles: noAxisTitles,
          bottomTitles: noAxisTitles,
          rightTitles: noAxisTitles,
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: isNotEnoughData
                ? const [
                    FlSpot(0, 3),
                    FlSpot(1, 1),
                    FlSpot(2, 4),
                    FlSpot(3, 2),
                    FlSpot(4, 5),
                  ]
                : sortedData
                      .map(
                        (e) => FlSpot(
                          widget
                              .dateExtractor(e)
                              .millisecondsSinceEpoch
                              .toDouble(),
                          widget.valueExtractor(e),
                        ),
                      )
                      .toList(),
            isCurved: true,
            curveSmoothness: 0.05,
            color: isNotEnoughData
                ? Theme.of(context).colorScheme.outlineVariant
                : lineColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              applyCutOffY: !isNotEnoughData,
              cutOffY: widget.minY ?? 0,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isNotEnoughData
                    ? [
                        Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withAlpha(128),
                        Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withAlpha(3),
                      ]
                    : [lineColor.withAlpha(100), lineColor.withAlpha(1)],
              ),
            ),
          ),
        ],
      ),
    );

    final chartContainer = SizedBox(
      height:
          (BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.lg)
              ? 160
              : 120) *
          clampDouble(MediaQuery.of(context).size.height / 800, 0.25, 1),
      child: chart,
    );

    final interactiveChartContainer = widget.onHover == null
        ? chartContainer
        : MouseRegion(onExit: (_) => _resetHover(), child: chartContainer);

    if (isNotEnoughData) {
      return EvolutionChartInsufficientDataOverlay(
        child: interactiveChartContainer,
      );
    }

    return interactiveChartContainer;
  }
}
