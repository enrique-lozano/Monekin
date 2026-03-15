import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A generic time-series line chart that displays data points over time
/// with an optional gradient fill, hover interaction, and an
/// "insufficient data" overlay when there are too few points.
///
/// This widget is used by both the exchange-rate evolution chart and the
/// investment-valuation evolution chart.
class TimeSeriesEvolutionChart<T> extends StatelessWidget {
  const TimeSeriesEvolutionChart({
    super.key,
    required this.data,
    required this.dateExtractor,
    required this.valueExtractor,
    this.onHover,
  });

  /// The raw data items to plot.
  final List<T> data;

  /// Extracts the [DateTime] (x-axis) from a data item.
  final DateTime Function(T) dateExtractor;

  /// Extracts the numeric value (y-axis) from a data item.
  final double Function(T) valueExtractor;

  /// Called when the user hovers/touches a data point, or `null` when the
  /// touch ends. The callback receives the original data item.
  final void Function(T?)? onHover;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final lineColor = Theme.of(context).colorScheme.primary;

    final sortedData = List<T>.from(data)
      ..sort((a, b) => dateExtractor(a).compareTo(dateExtractor(b)));

    final isNotEnoughData = sortedData.length <= 2;

    List<double> values = [];
    double? effectiveMaxY;
    double? effectiveMinY;

    if (!isNotEnoughData) {
      values = sortedData.map(valueExtractor).toList();

      final maxY = values.reduce(max);
      final minY = values.reduce(min);

      final yRange = maxY - minY;
      final yPadding = yRange == 0 ? maxY * 0.1 : yRange * 0.1;

      effectiveMaxY = maxY + yPadding;
      effectiveMinY = max(0.0, minY - yPadding);
    }

    final chart = LineChart(
      LineChartData(
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        lineTouchData: isNotEnoughData
            ? const LineTouchData(enabled: false)
            : LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  tooltipPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final date = DateTime.fromMillisecondsSinceEpoch(
                        spot.x.toInt(),
                      );

                      final text =
                          '${DateFormat.yMMMd().format(date)}\n${spot.y.toStringAsFixed(2)}';

                      return LineTooltipItem(
                        text,
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? touchResponse) {
                      if (onHover == null) return;

                      if (event is FlPanEndEvent ||
                          event is FlLongPressEnd ||
                          event is FlTapUpEvent) {
                        onHover!(null);
                        return;
                      }

                      if (touchResponse != null &&
                          touchResponse.lineBarSpots != null &&
                          touchResponse.lineBarSpots!.isNotEmpty) {
                        final spot = touchResponse.lineBarSpots!.first;
                        final item = sortedData.firstWhere(
                          (element) =>
                              dateExtractor(element).millisecondsSinceEpoch ==
                              spot.x.toInt(),
                        );
                        onHover!(item);
                        return;
                      }

                      onHover!(null);
                    },
              ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: noAxisTitles,
          topTitles: noAxisTitles,
          bottomTitles: noAxisTitles,
          rightTitles: isNotEnoughData
              ? noAxisTitles
              : AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 46,
                    getTitlesWidget: (value, meta) {
                      if (value == meta.max || value == meta.min) {
                        return Container();
                      }

                      return SideTitleWidget(
                        meta: meta,
                        child: Text(
                          meta.formattedValue,
                          style: smallAxisTitleStyle(context),
                        ),
                      );
                    },
                  ),
                ),
        ),
        borderData: FlBorderData(show: false),
        minY: effectiveMinY,
        maxY: effectiveMaxY,
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
                          dateExtractor(e).millisecondsSinceEpoch.toDouble(),
                          valueExtractor(e),
                        ),
                      )
                      .toList(),
            isCurved: true,
            curveSmoothness: 0.2,
            color: isNotEnoughData
                ? Theme.of(context).colorScheme.outlineVariant
                : lineColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              applyCutOffY: !isNotEnoughData,
              cutOffY: effectiveMinY ?? 0,
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

    if (isNotEnoughData) {
      return Stack(
        alignment: Alignment.center,
        children: [
          chartContainer,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              t.general.insufficient_data,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      );
    }

    return chartContainer;
  }
}
