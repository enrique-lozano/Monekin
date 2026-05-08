import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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
  });

  final List<AssetValuationContributionPoint> points;
  final CurrencyInDB currency;
  final String valuationLabel;
  final String netContributionLabel;
  final void Function(AssetValuationContributionPoint?)? onHover;

  @override
  State<AssetValuationContributionChart> createState() =>
      _AssetValuationContributionChartState();
}

class _AssetValuationContributionChartState
    extends State<AssetValuationContributionChart> {
  int? _lastHoveredX;

  void _resetHover() {
    _lastHoveredX = null;
    widget.onHover?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final valuationColor = colorScheme.primary;
    final netContributionColor = colorScheme.tertiary;

    final sortedPoints = List<AssetValuationContributionPoint>.from(
      widget.points,
    )..sort((a, b) => a.date.compareTo(b.date));

    final pointsByX = <int, AssetValuationContributionPoint>{
      for (final point in sortedPoints)
        point.date.millisecondsSinceEpoch: point,
    };

    final valuationSpots = sortedPoints
        .map(
          (point) => FlSpot(
            point.date.millisecondsSinceEpoch.toDouble(),
            point.valuation,
          ),
        )
        .toList();
    final contributionSpots = sortedPoints
        .map(
          (point) => FlSpot(
            point.date.millisecondsSinceEpoch.toDouble(),
            point.netContribution,
          ),
        )
        .toList();

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
                    if (touchedSpots.isEmpty) {
                      return const [];
                    }

                    final point = pointsByX[touchedSpots.first.x.toInt()];
                    if (point == null) {
                      return const [];
                    }
                    final date = DateTime.fromMillisecondsSinceEpoch(
                      touchedSpots.first.x.toInt(),
                    );

                    final dataTextStyle = const TextStyle(
                      fontSize: 12,
                      height: 1.25,
                    );

                    return [
                      ...touchedSpots.mapIndexed((index, spot) {
                        final label = _lineLabel(context, spot.barIndex);
                        return LineTooltipItem(
                          index == 0
                              ? '${DateFormat.MMMd().format(date)}\n'
                              : '',

                          const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 2,
                          ),

                          children: [
                            TextSpan(
                              text: '◉ ',
                              style: dataTextStyle.copyWith(
                                color: spot.bar.color,
                              ),
                            ),
                            TextSpan(text: '$label: ', style: dataTextStyle),
                            ...UINumberFormatter.currency(
                              currency: widget.currency,
                              amountToConvert: spot.y,
                              integerStyle: dataTextStyle,
                            ).getTextSpanList(context),
                          ],
                        );
                      }),
                    ];
                  },
                ),
                touchCallback: (event, touchResponse) {
                  if (event is FlPanEndEvent ||
                      event is FlLongPressEnd ||
                      event is FlTapUpEvent) {
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

                  final currentX = hoveredSpot.x.toInt();
                  if (_lastHoveredX != currentX) {
                    HapticFeedback.selectionClick();
                    _lastHoveredX = currentX;
                  }

                  widget.onHover?.call(pointsByX[currentX]);
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
                ? const [FlSpot(0, 2), FlSpot(1, 3), FlSpot(2, 2.6)]
                : contributionSpots,
            isCurved: true,
            curveSmoothness: 0.05,
            color: isNotEnoughData
                ? colorScheme.outlineVariant
                : netContributionColor,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: netContributionColor),
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
              ? 180
              : 140) *
          clampDouble(MediaQuery.of(context).size.height / 800, 0.25, 1),
      child: chart,
    );

    final interactiveChart = widget.onHover == null
        ? chartContainer
        : MouseRegion(onExit: (_) => _resetHover(), child: chartContainer);

    final chartWithOverlay = isNotEnoughData
        ? Stack(
            alignment: Alignment.center,
            children: [
              interactiveChart,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  t.general.insufficient_data,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          )
        : interactiveChart;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        chartWithOverlay,
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          children: [
            _LegendItem(color: valuationColor, label: widget.valuationLabel),
            _LegendItem(
              color: netContributionColor,
              label: widget.netContributionLabel,
            ),
          ],
        ),
      ],
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

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
