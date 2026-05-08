import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/net_worth/net_worth_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/monetary_evolution_chart_shared.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class NetWorthEvolutionCard extends StatelessWidget {
  const NetWorthEvolutionCard({
    super.key,
    required this.filters,
    required this.dateRangeService,
  });

  final TransactionFilterSet filters;
  final DatePeriodState dateRangeService;

  Future<(List<_NetWorthPoint>, Currency?)> _loadEvolutionData() async {
    final now = DateTime.now();
    final endDate = dateRangeService.endDate ?? now;
    final startDate =
        dateRangeService.startDate ??
        endDate.subtract(const Duration(days: 30));
    final days = max(1, endDate.difference(startDate).inDays);
    final step = (days / 100).ceil();

    final points = <DateTime>[];
    for (
      var current = startDate;
      current.isBefore(endDate);
      current = current.add(Duration(days: step))
    ) {
      points.add(current);
    }
    if (points.isEmpty || points.last.isBefore(endDate)) {
      points.add(endDate);
    }

    final assetFutures = points.map(_getTotalAssets).toList();
    final debtsFutures = points.map(_getDebtsTotal).toList();

    final assetValues = await Future.wait(assetFutures);
    final debtsValues = await Future.wait(debtsFutures);

    return (
      List.generate(points.length, (index) {
        final assets = assetValues[index];
        final debts = debtsValues[index];
        return _NetWorthPoint(
          date: points[index],
          assets: assets,
          debts: debts,
          netWorth: assets - debts,
        );
      }),
      await CurrencyService.instance.ensureAndGetPreferredCurrency().first,
    );
  }

  Future<double> _getTotalAssets(DateTime date) async {
    return NetWorthService.instance
        .getGrossAssetsAtDate(date, trFilters: filters)
        .first;
  }

  Future<double> _getDebtsTotal(DateTime date) async {
    return NetWorthService.instance
        .getTotalDebtsInPreferredCurrency(exchangeRateAsOf: date)
        .first;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FutureBuilder(
      future: _loadEvolutionData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 260,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!.$1;
        if (data.isEmpty) {
          return Center(child: Text(t.general.insufficient_data));
        }

        final maxY = [
          data.map((p) => p.assets).reduce(max),
          data.map((p) => p.debts).reduce(max),
          data.map((p) => p.netWorth).reduce(max),
        ].reduce(max);

        final yMax = max(maxY * 1.15, 10.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 260,
              child: _NetWorthLineChart(
                data: data,
                currency: snapshot.data!.$2,
                yMax: yMax,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                EvolutionChartLegendItem(
                  color: Theme.of(context).colorScheme.primary,
                  label: t.assets.title,
                ),
                EvolutionChartLegendItem(
                  color: Theme.of(context).colorScheme.error,
                  label: t.debts.display(n: 2),
                ),
                EvolutionChartLegendItem(
                  color: Theme.of(context).colorScheme.secondary,
                  label: t.stats.net_worth,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _NetWorthLineChart extends StatefulWidget {
  const _NetWorthLineChart({
    required this.data,
    required this.currency,
    required this.yMax,
  });

  final List<_NetWorthPoint> data;
  final Currency? currency;
  final double yMax;

  @override
  State<_NetWorthLineChart> createState() => _NetWorthLineChartState();
}

class _NetWorthLineChartState extends State<_NetWorthLineChart> {
  final EvolutionDateHoverHaptics _dateHaptics = EvolutionDateHoverHaptics();

  String _lineLabel(BuildContext context, int index) {
    final t = Translations.of(context);
    switch (index) {
      case 0:
        return t.assets.title;
      case 1:
        return t.debts.display(n: 2);
      case 2:
      default:
        return t.stats.net_worth;
    }
  }

  LineChartBarData _buildLine({
    required Color color,
    required List<FlSpot> data,
  }) {
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0.1,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(0.35), color.withOpacity(0.05)],
        ),
      ),
      spots: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onExit: (_) => _dateHaptics.reset(),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: widget.yMax,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: widget.yMax / 5,
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, meta) {
                  if (value == meta.max || value == meta.min) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      meta.formattedValue,
                      style: Theme.of(context).textTheme.labelSmall,
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
            _buildLine(
              color: colorScheme.primary,
              data: data
                  .map(
                    (p) => FlSpot(
                      p.date.millisecondsSinceEpoch.toDouble(),
                      p.assets,
                    ),
                  )
                  .toList(),
            ),
            _buildLine(
              color: colorScheme.error,
              data: data
                  .map(
                    (p) => FlSpot(
                      p.date.millisecondsSinceEpoch.toDouble(),
                      p.debts,
                    ),
                  )
                  .toList(),
            ),
            _buildLine(
              color: colorScheme.secondary,
              data: data
                  .map(
                    (p) => FlSpot(
                      p.date.millisecondsSinceEpoch.toDouble(),
                      p.netWorth,
                    ),
                  )
                  .toList(),
            ),
          ],
          lineTouchData: LineTouchData(
            touchCallback: (event, touchResponse) {
              if (evolutionChartTouchEnded(event)) {
                _dateHaptics.reset();
                return;
              }
              final spots = touchResponse?.lineBarSpots;
              if (spots == null || spots.isEmpty) {
                _dateHaptics.reset();
                return;
              }
              _dateHaptics.onHoveredXMs(spots.first.x.toInt());
            },
            touchTooltipData: LineTouchTooltipData(
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipColor: (spot) => colorScheme.surface,
              tooltipPadding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
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
          ),
        ),
      ),
    );
  }
}

class _NetWorthPoint {
  _NetWorthPoint({
    required this.date,
    required this.assets,
    required this.debts,
    required this.netWorth,
  });

  final DateTime date;
  final double assets;
  final double debts;
  final double netWorth;
}
