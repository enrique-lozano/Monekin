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

    if (sortedRates.isEmpty) {
      return const SizedBox.shrink();
    }

    final balances = sortedRates.map((e) => e.exchangeRate).toList();
    final labels = sortedRates
        .map((e) => DateFormat.yMMMd().format(e.date))
        .toList();

    final maxY = balances.reduce(max);
    final minY = balances.reduce(min);

    // Add some padding to Y axis
    final yRange = maxY - minY;
    final yPadding = yRange == 0 ? maxY * 0.1 : yRange * 0.1;

    final effectiveMaxY = maxY + yPadding;
    final effectiveMinY = max(0.0, minY - yPadding);

    return SizedBox(
      height:
          (BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.lg)
              ? 160
              : 120) *
          clampDouble(MediaQuery.of(context).size.height / 800, 0.25, 1),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true, drawVerticalLine: false),

          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((_) => null).toList();
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
                    final index = touchResponse.lineBarSpots!.first.x.toInt();
                    if (index >= 0 && index < sortedRates.length) {
                      onHover!(sortedRates[index]);
                      return;
                    }
                  }

                  onHover!(null);
                },
          ),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: noAxisTitles,
            topTitles: noAxisTitles,
            bottomTitles: noAxisTitles,
            rightTitles: AxisTitles(
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
              spots: List.generate(
                balances.length,
                (index) => FlSpot(index.toDouble(), balances[index]),
              ),
              isCurved: true,
              curveSmoothness: 0.2,
              color: lineColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                applyCutOffY: true,
                cutOffY: effectiveMinY,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [lineColor.withAlpha(100), lineColor.withAlpha(1)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
