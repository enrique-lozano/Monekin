import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/models/goal/goal_type.enum.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/models/mixins/target_pace.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

/// Cumulative value of a target over its period, against the target amount,
/// the linear pace to reach it and the projection at the current pace.
///
/// X values are days since the start of the period.
class TargetEvolutionChart extends StatefulWidget {
  const TargetEvolutionChart({super.key, required this.target});

  final FinancialTargetMixin target;

  @override
  State<TargetEvolutionChart> createState() => _TargetEvolutionChartState();
}

class _TargetEvolutionChartState extends State<TargetEvolutionChart> {
  static const _paceDash = [6, 4];
  static const _projectedDash = [2, 4];

  FinancialTargetMixin get target => widget.target;

  late Stream<({_ChartData data, CurrencyInDB currency})> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _buildStream();
  }

  @override
  void didUpdateWidget(covariant TargetEvolutionChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.target != widget.target) _stream = _buildStream();
  }

  Stream<({_ChartData data, CurrencyInDB currency})> _buildStream() {
    return Rx.combineLatest2(
      target.currentValue.asyncMap((_) => _loadData(DateTime.now())),
      CurrencyService.instance.ensureAndGetPreferredCurrency(),
      (data, currency) => (data: data, currency: currency),
    );
  }

  Future<_ChartData> _loadData(DateTime now) async {
    final range = target.periodState.toDateTimeRange;
    final start = (range?.start ?? target.periodState.startDate!).justDay();
    final end = range?.end ?? now.justDay(dayOffset: 1);
    final totalDays = max(end.dayDifference(start), 1);

    if (now.isBefore(start)) {
      return _ChartData(start: start, totalDays: totalDays, actual: const []);
    }

    final isActive = now.isBefore(end);
    final lastX = isActive
        ? (now.dayDifference(start) + 1).clamp(1, totalDays)
        : totalDays;
    final step = (lastX / 100).ceil();

    // Value before each sampled day, plus the value right now at the end
    final xs = [for (var x = 0; x < lastX; x += step) x, lastX];
    final values = await Future.wait(
      xs.map(
        (x) => target
            .getValueOnDate(
              x == lastX && isActive ? now : start.justDay(dayOffset: x),
            )
            .first,
      ),
    );

    return _ChartData(
      start: start,
      totalDays: totalDays,
      actual: [
        for (var i = 0; i < xs.length; i++) FlSpot(xs[i].toDouble(), values[i]),
      ],
      pace: TargetPace.of(target, currentValue: values.last, now: now),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildLegend(context),
            ),
            SizedBox(
              height: 200,
              child: snapshot.hasData
                  ? _buildChart(
                      context,
                      snapshot.data!.data,
                      snapshot.data!.currency,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
    );
  }

  String _actualLabel(Translations t) {
    if (target is Goal && (target as Goal).type == GoalType.income) {
      return t.targets.chart.saved;
    }
    return t.targets.chart.spent;
  }

  String _targetLabel(Translations t) {
    return target is Budget
        ? t.budgets.details.budget_value
        : t.goals.details.goal_value;
  }

  Widget _buildLegend(BuildContext context) {
    final t = Translations.of(context);
    final colors = Theme.of(context).colorScheme;
    final hasRange = target.periodState.toDateTimeRange != null;

    return Wrap(
      spacing: 14,
      runSpacing: 6,
      children: [
        _LegendLine(color: colors.primary, label: _actualLabel(t)),
        if (target.isActive && hasRange)
          _LegendLine(
            color: colors.primary,
            label: t.targets.chart.projected,
            dashArray: _projectedDash,
          ),
        if (hasRange)
          _LegendLine(
            color: colors.tertiary,
            label: t.targets.chart.pace,
            dashArray: _paceDash,
          ),
        _LegendLine(color: colors.tertiary, label: _targetLabel(t)),
      ],
    );
  }

  Widget _buildChart(
    BuildContext context,
    _ChartData data,
    CurrencyInDB currency,
  ) {
    final t = Translations.of(context);
    final colors = Theme.of(context).colorScheme;
    final actualColor = colors.primary;
    final targetColor = colors.tertiary;
    final total = data.totalDays.toDouble();
    final pace = data.pace;
    final hasRange = target.periodState.toDateTimeRange != null;
    final todayX = pace != null && data.actual.isNotEmpty
        ? data.actual.last.x
        : null;

    final dataMaxY = [
      target.targetAmount,
      target.initialValue,
      ?pace?.projectedValue,
      ...data.actual.map((s) => s.y),
    ].reduce(max);
    final yInterval = target.targetAmount > 0
        ? target.targetAmount / 4
        : max(dataMaxY, 1.0) / 4;
    // Some headroom so the target line is not clipped at the top
    final maxY = max(dataMaxY, yInterval) * 1.04;

    String formatAmount(double value, {bool compact = true}) {
      return UINumberFormatter.currency(
        amountToConvert: value,
        currency: currency,
        showDecimals: !compact,
        compactView: compact,
      ).getFormattedAmount();
    }

    final lines = <LineChartBarData>[
      if (hasRange)
        LineChartBarData(
          spots: [
            FlSpot(0, target.initialValue),
            FlSpot(total, target.targetAmount),
          ],
          color: targetColor.withValues(alpha: 0.75),
          barWidth: 1.5,
          dashArray: _paceDash,
          dotData: const FlDotData(show: false),
        ),
      if (pace != null && todayX != null)
        LineChartBarData(
          spots: [
            FlSpot(todayX, data.actual.last.y),
            FlSpot(total, pace.projectedValue),
          ],
          color: actualColor,
          barWidth: 2,
          dashArray: _projectedDash,
          dotData: const FlDotData(show: false),
        ),
      if (data.actual.isNotEmpty)
        LineChartBarData(
          spots: data.actual,
          color: actualColor,
          barWidth: 2.5,
          isCurved: true,
          curveSmoothness: 0.1,
          preventCurveOverShooting: true,
          dotData: FlDotData(
            checkToShowDot: (spot, _) => spot.x == todayX,
            getDotPainter: (spot, _, _, _) => FlDotCirclePainter(
              radius: 4,
              color: actualColor,
              strokeColor: colors.surface,
              strokeWidth: 1.5,
            ),
          ),
        ),
    ];
    final actualBarIndex = data.actual.isEmpty ? -1 : lines.length - 1;

    Widget bottomTitle(double value, TitleMeta meta) {
      final x = value.round();
      final isToday = todayX != null && x == todayX.round();
      final isEdge = x == 0 || x == data.totalDays;

      // Avoid overlapping the today label with the start/end labels
      final todayIsFarFromEdges =
          todayX != null && todayX > total * 0.18 && todayX < total * 0.82;

      if (!isEdge && !(isToday && todayIsFarFromEdges)) {
        return const SizedBox.shrink();
      }

      // Open-ended targets end at the current day
      final date = isToday || (x == data.totalDays && !hasRange)
          ? DateTime.now()
          : data.start.justDay(dayOffset: x);

      return SideTitleWidget(
        meta: meta,
        fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
        child: Text(
          getShortDateLabel(date),
          style: smallAxisTitleStyle(
            context,
          ).copyWith(color: isToday && !isEdge ? targetColor : null),
        ),
      );
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: total,
        minY: 0,
        maxY: maxY,
        clipData: const FlClipData.all(),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: yInterval,
          getDrawingHorizontalLine: (_) => FlLine(
            color: colors.outlineVariant.withValues(alpha: 0.4),
            strokeWidth: 1,
          ),
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: target.targetAmount,
              color: targetColor,
              strokeWidth: 2,
            ),
          ],
          verticalLines: [
            if (todayX != null)
              VerticalLine(
                x: todayX,
                color: colors.outline.withValues(alpha: 0.6),
                strokeWidth: 1,
              ),
          ],
        ),
        titlesData: FlTitlesData(
          topTitles: noAxisTitles,
          rightTitles: noAxisTitles,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              interval: yInterval,
              maxIncluded: false,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                meta: meta,
                child: BlurBasedOnPrivateMode(
                  child: Text(
                    formatAmount(value),
                    maxLines: 1,
                    style: smallAxisTitleStyle(context),
                  ),
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              interval: 1,
              getTitlesWidget: bottomTitle,
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          enabled: actualBarIndex >= 0,
          getTouchedSpotIndicator: (bar, indexes) => bar.dashArray == null
              ? defaultTouchedIndicators(bar, indexes)
              : [for (final _ in indexes) null],
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipColor: (_) => colors.surface,
            tooltipPadding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 10,
            ),
            getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
              if (spot.barIndex != actualBarIndex) return null;

              final date = spot.x == todayX
                  ? DateTime.now()
                  : data.start.justDay(dayOffset: spot.x.round());

              return LineTooltipItem(
                '${getShortDateLabel(date)}\n',
                const TextStyle(fontSize: 12),
                textAlign: TextAlign.start,
                children: [
                  TextSpan(
                    text: '${_actualLabel(t)}: ',
                    style: const TextStyle(fontSize: 12),
                  ),
                  TextSpan(
                    text: formatAmount(spot.y, compact: false),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        lineBarsData: lines,
      ),
    );
  }
}

class _ChartData {
  const _ChartData({
    required this.start,
    required this.totalDays,
    required this.actual,
    this.pace,
  });

  final DateTime start;
  final int totalDays;

  /// Cumulative value, ending at the current day for active targets
  final List<FlSpot> actual;
  final TargetPace? pace;
}

class _LegendLine extends StatelessWidget {
  const _LegendLine({required this.color, required this.label, this.dashArray});

  final Color color;
  final String label;
  final List<int>? dashArray;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        CustomPaint(
          size: const Size(18, 2),
          painter: _LegendLinePainter(color: color, dashArray: dashArray),
        ),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

class _LegendLinePainter extends CustomPainter {
  const _LegendLinePainter({required this.color, this.dashArray});

  final Color color;
  final List<int>? dashArray;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;
    final y = size.height / 2;
    final dash = dashArray;

    if (dash == null) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      return;
    }

    var x = 0.0;
    var i = 0;
    while (x < size.width) {
      final length = dash[i % dash.length].toDouble();
      if (i.isEven) {
        canvas.drawLine(
          Offset(x, y),
          Offset(min(x + length, size.width), y),
          paint,
        );
      }
      x += length;
      i++;
    }
  }

  @override
  bool shouldRepaint(_LegendLinePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.dashArray != dashArray;
}
