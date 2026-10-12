import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/monetary_evolution_chart_shared.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:rxdart/rxdart.dart';

/// A minimal, full-bleed area chart showing the evolution of the total balance
/// during the selected period. Designed to sit inside [EvolutionCard] as a
/// decorative-yet-interactive chart with a gradient fill.
class DashboardBalanceChart extends StatefulWidget {
  const DashboardBalanceChart({
    super.key,
    required this.dateRange,
    required this.lineColor,
    this.height,
  });

  final DatePeriodState dateRange;
  final Color lineColor;

  /// When null, the chart fills its parent (e.g. [EvolutionCard]).
  final double? height;

  @override
  State<DashboardBalanceChart> createState() => _DashboardBalanceChartState();
}

class _DashboardBalanceChartState extends State<DashboardBalanceChart> {
  late Stream<List<_BalancePoint>> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = _buildStream();
  }

  @override
  void didUpdateWidget(covariant DashboardBalanceChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.dateRange.startDate != widget.dateRange.startDate ||
        oldWidget.dateRange.endDate != widget.dateRange.endDate) {
      _dataStream = _buildStream();
    }
  }

  Stream<List<_BalancePoint>> _buildStream() {
    return AccountService.instance
        .getAccounts(predicate: (acc, curr) => acc.closingDate.isNull())
        .switchMap((accounts) {
          final now = DateTime.now();

          final start =
              widget.dateRange.startDate ??
              (accounts.isEmpty
                  ? now.subtract(const Duration(days: 30))
                  : accounts.map((e) => e.date).min);
          final end = widget.dateRange.endDate ?? now;

          if (!end.isAfter(start)) {
            return Stream.value(<_BalancePoint>[]);
          }

          final dates = <DateTime>[];
          final step = (end.difference(start).inDays / 60).ceil().clamp(
            1,
            3650,
          );

          DateTime cursor = start.justDay();
          while (cursor.isBefore(end)) {
            dates.add(cursor);
            cursor = cursor.add(Duration(days: step));
          }
          dates.add(end);

          final balances = dates
              .map((d) => AccountService.instance.getAccountsMoney(date: d))
              .toList();

          return Rx.combineLatest<double, List<_BalancePoint>>(
            balances,
            (values) => List.generate(
              values.length,
              (i) => _BalancePoint(date: dates[i], value: values[i]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final chart = StreamBuilder<List<_BalancePoint>>(
      stream: _dataStream,
      builder: (context, snapshot) {
        final points = snapshot.data ?? const <_BalancePoint>[];

        if (points.length < 2) {
          return const SizedBox.shrink();
        }

        return StreamBuilder(
          stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
          builder: (context, currencySnapshot) {
            return _buildChart(context, points, currencySnapshot.data);
          },
        );
      },
    );

    final height = widget.height;
    if (height == null) return chart;

    return SizedBox(height: height, child: chart);
  }

  Widget _buildChart(
    BuildContext context,
    List<_BalancePoint> points,
    CurrencyInDB? currency,
  ) {
    final spots = points
        .map((p) => FlSpot(p.date.millisecondsSinceEpoch.toDouble(), p.value))
        .toList();

    final domain = computeMonetaryChartYDomain(
      points.map((point) => point.value),
    );

    final color = widget.lineColor;

    return LineChart(
      LineChartData(
        minY: domain.minY,
        maxY: domain.maxY,
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipColor: (_) =>
                Theme.of(context).colorScheme.surfaceContainerHigh,
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
                  '${getMMMdDateFormatBasedOnYear(date).text}\n',
                  Theme.of(context).textTheme.bodySmall!,
                  textAlign: TextAlign.start,
                  children: UINumberFormatter.currency(
                    currency: currency,
                    amountToConvert: spot.y,
                    integerStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ).getTextSpanList(context),
                );
              }).toList();
            },
          ),
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(color: color.withValues(alpha: 0.4), strokeWidth: 1),
                FlDotData(
                  getDotPainter: (spot, percent, bar, i) => FlDotCirclePainter(
                    radius: 4,
                    color: color,
                    strokeWidth: 2,
                    strokeColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
              );
            }).toList();
          },
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.25,
            preventCurveOverShooting: true,
            color: color,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            shadow: Shadow(color: color.withValues(alpha: 0.5), blurRadius: 8),
            belowBarData: BarAreaData(
              show: true,
              applyCutOffY: true,
              cutOffY: domain.areaFillCutoffY,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withValues(alpha: 0.35),
                  color.withValues(alpha: 0.12),
                  color.withValues(alpha: 0),
                ],
                stops: const [0, 0.55, 1],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalancePoint {
  const _BalancePoint({required this.date, required this.value});

  final DateTime date;
  final double value;
}
