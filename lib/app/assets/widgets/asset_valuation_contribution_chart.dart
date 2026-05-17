import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/monetary_evolution_chart_shared.dart';

class AssetValuationContributionPoint {
  const AssetValuationContributionPoint({
    required this.date,
    required this.valuation,
    required this.netContribution,
  });

  final DateTime date;
  final double valuation;
  final double netContribution;
}

class AssetValuationContributionChart extends StatefulWidget {
  const AssetValuationContributionChart({
    super.key,
    required this.points,
    required this.currency,
    required this.valuationLabel,
    required this.netContributionLabel,
    this.onHover,
    this.timeRange,
  });

  final List<AssetValuationContributionPoint> points;
  final CurrencyInDB currency;
  final String valuationLabel;
  final String netContributionLabel;
  final void Function(AssetValuationContributionPoint?)? onHover;
  final DateTimeRange? timeRange;

  @override
  State<AssetValuationContributionChart> createState() =>
      _AssetValuationContributionChartState();
}

class _AssetValuationContributionChartState
    extends State<AssetValuationContributionChart> {
  final EvolutionDateHoverHaptics _dateHaptics = EvolutionDateHoverHaptics();

  void _resetHover() {
    _dateHaptics.reset();
    widget.onHover?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final valuationColor = colorScheme.primary;
    final netContributionColor = colorScheme.tertiary;

    final sortedPoints = List<AssetValuationContributionPoint>.from(
      widget.points,
    )..sort((a, b) => a.date.compareTo(b.date));

    final chartSeries = _buildChartSeries(sortedPoints);
    final pointsByX = chartSeries.pointsByX;
    final valuationSpots = chartSeries.valuationSpots;
    final contributionSpots = chartSeries.contributionSpots;

    final isNotEnoughData = sortedPoints.length <= 2;

    final chart = LineChart(
      LineChartData(
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        lineTouchData: isNotEnoughData
            ? const LineTouchData(enabled: false)
            : LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  getTooltipColor: (spot) => colorScheme.surface,
                  tooltipPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 10,
                  ),
                  getTooltipItems: (touchedSpots) {
                    return buildMultiLineCurrencyLineTooltipItems(
                      context,
                      touchedSpots: touchedSpots,
                      currency: widget.currency,
                      lineLabel: (barIndex) => _lineLabel(context, barIndex),
                    );
                  },
                ),
                touchCallback: (event, touchResponse) {
                  if (evolutionChartTouchEnded(event)) {
                    _resetHover();
                    return;
                  }

                  final touchedSpots = touchResponse?.lineBarSpots;
                  final hoveredSpot =
                      touchedSpots == null || touchedSpots.isEmpty
                      ? null
                      : touchedSpots.first;
                  if (hoveredSpot == null) {
                    _resetHover();
                    return;
                  }

                  _dateHaptics.onHoveredXMs(hoveredSpot.x.toInt());

                  widget.onHover?.call(pointsByX[hoveredSpot.x.toInt()]);
                },
              ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: noAxisTitles,
          topTitles: noAxisTitles,
          bottomTitles: noAxisTitles,
          rightTitles: noAxisTitles,
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: isNotEnoughData
                ? const [FlSpot(0, 2), FlSpot(1, 2.5), FlSpot(2, 2.6)]
                : contributionSpots,
            isCurved: true,
            curveSmoothness: 0.05,
            color: isNotEnoughData
                ? colorScheme.outlineVariant
                : netContributionColor,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: isNotEnoughData
                  ? colorScheme.outlineVariant.withAlpha(10)
                  : netContributionColor,
            ),
          ),
          LineChartBarData(
            spots: isNotEnoughData
                ? const [FlSpot(0, 3), FlSpot(1, 2.7), FlSpot(2, 4)]
                : valuationSpots,
            isCurved: true,
            curveSmoothness: 0.05,
            color: isNotEnoughData ? colorScheme.outline : valuationColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isNotEnoughData
                    ? [
                        colorScheme.outlineVariant.withAlpha(80),
                        colorScheme.outlineVariant.withAlpha(5),
                      ]
                    : [
                        valuationColor.withAlpha(85),
                        valuationColor.withAlpha(3),
                      ],
              ),
            ),
          ),
        ],
      ),
    );

    final chartContainer = SizedBox(
      height:
          (BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.lg)
              ? 280
              : 100) *
          clampDouble(MediaQuery.of(context).size.height / 800, 0.2, 1),
      child: chart,
    );

    final interactiveChart = widget.onHover == null
        ? chartContainer
        : MouseRegion(onExit: (_) => _resetHover(), child: chartContainer);

    final chartWithOverlay = isNotEnoughData
        ? EvolutionChartInsufficientDataOverlay(child: interactiveChart)
        : interactiveChart;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        chartWithOverlay,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Wrap(
            spacing: 12,
            runSpacing: 6,
            children: [
              EvolutionChartLegendItem(
                color: valuationColor,
                label: widget.valuationLabel,
              ),
              EvolutionChartLegendItem(
                color: netContributionColor,
                label: widget.netContributionLabel,
              ),
            ],
          ),
        ),
      ],
    );
  }

  DateTimeRange? _effectiveTimeRange(
    List<AssetValuationContributionPoint> sortedPoints,
  ) {
    if (widget.timeRange != null) return widget.timeRange;
    if (sortedPoints.isEmpty) return null;

    final start = sortedPoints.first.date.justDay();
    final end = DateTime.now().justDay().add(const Duration(days: 1));

    return DateTimeRange(start: start, end: end);
  }

  ({
    List<FlSpot> valuationSpots,
    List<FlSpot> contributionSpots,
    Map<int, AssetValuationContributionPoint> pointsByX,
  }) _buildChartSeries(List<AssetValuationContributionPoint> sortedPoints) {
    final timeRange = _effectiveTimeRange(sortedPoints);

    if (timeRange == null) {
      return (
        valuationSpots: const [],
        contributionSpots: const [],
        pointsByX: const {},
      );
    }

    final filledSamples = fillTimeSeriesWithPreviousValue(
      data: sortedPoints,
      dateExtractor: (point) => point.date,
      valueExtractor: (point) => point.valuation,
      timeRange: timeRange,
    );

    return (
      valuationSpots: filledSamples
          .map(
            (sample) => FlSpot(
              sample.date.millisecondsSinceEpoch.toDouble(),
              sample.source.valuation,
            ),
          )
          .toList(),
      contributionSpots: filledSamples
          .map(
            (sample) => FlSpot(
              sample.date.millisecondsSinceEpoch.toDouble(),
              sample.source.netContribution,
            ),
          )
          .toList(),
      pointsByX: {
        for (final sample in filledSamples)
          sample.date.millisecondsSinceEpoch: sample.source,
      },
    );
  }

  String _lineLabel(BuildContext context, int index) {
    switch (index) {
      case 0:
        return widget.netContributionLabel;
      case 1:
        return widget.valuationLabel;
      default:
        return '';
    }
  }
}
