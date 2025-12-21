import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';

class ExchangeRateEvolutionChart extends StatelessWidget {
  const ExchangeRateEvolutionChart({
    super.key,
    required this.exchangeRates,
    this.onHover,
  });

  final List<ExchangeRate> exchangeRates;
  final void Function(ExchangeRate?)? onHover;

  @override
  Widget build(BuildContext context) {
    final lineColor = Theme.of(context).colorScheme.primary;

    // Sort by date
    final sortedRates = List<ExchangeRate>.from(exchangeRates)
      ..sort((a, b) => a.date.compareTo(b.date));

    final isNotEnoughData = sortedRates.length <= 2;

    List<double> balances = [];
    double? effectiveMaxY;
    double? effectiveMinY;

    if (!isNotEnoughData) {
      balances = sortedRates.map((e) => e.exchangeRate).toList();

      final maxY = balances.reduce(max);
      final minY = balances.reduce(min);

      // Add some padding to Y axis
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

                      return LineTooltipItem(
                        DateFormat.yMMMd().format(date),
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
                        final rate = sortedRates.firstWhere(
                          (element) =>
                              element.date.millisecondsSinceEpoch ==
                              spot.x.toInt(),
                        );
                        onHover!(rate);
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
                : sortedRates
                      .map(
                        (e) => FlSpot(
                          e.date.millisecondsSinceEpoch.toDouble(),
                          e.exchangeRate,
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
                        ).colorScheme.outlineVariant.withOpacity(0.5),
                        Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withOpacity(0.01),
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
              "Not enough data to display chart",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      );
    }

    return chartContainer;
  }
}
