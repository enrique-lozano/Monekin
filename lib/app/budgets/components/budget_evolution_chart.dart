import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/presentation/widgets/time_series_evolution_chart.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class BudgetEvolutionChart extends StatelessWidget {
  const BudgetEvolutionChart({super.key, required this.budget});

  final Budget budget;

  Future<List<_BudgetEvolutionPoint>> _getEvolutionData(
    BuildContext context,
  ) async {
    final List<Future<double>> values = [];
    final List<String> labels = [];
    final List<DateTime> dates = [];

    final startDate = budget.currentDateRange.start;
    final endDate = budget.currentDateRange.end;

    DateTime currentDay = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );

    final dayRange = (endDate.difference(startDate).inDays / 100).ceil();

    while (currentDay.compareTo(endDate) < 0) {
      dates.add(currentDay);
      labels.add(getMMMdDateFormatBasedOnYear(currentDay).text);
      values.add(budget.getValueOnDate(currentDay).first);
      currentDay = currentDay.add(Duration(days: dayRange));
    }

    final resolved = await Future.wait(values);

    return List.generate(
      resolved.length,
      (i) => _BudgetEvolutionPoint(
        date: dates[i],
        value: resolved[i],
        label: labels[i],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return SizedBox(
      height: 300,
      child: FutureBuilder(
        future: _getEvolutionData(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ],
            );
          }

          final points = snapshot.data ?? const <_BudgetEvolutionPoint>[];
          final maxValue = points.isEmpty
              ? 0.0
              : points.map((e) => e.value).reduce(max);
          final maxY = max(maxValue + maxValue * 0.1, budget.limitAmount * 1.1);

          return StreamBuilder(
            stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
            builder: (context, userCurrencySnapshot) {
              final limitLineColor = Theme.of(context).colorScheme.tertiary;

              return TimeSeriesEvolutionChart<_BudgetEvolutionPoint>(
                data: points,
                dateExtractor: (p) => p.date,
                valueExtractor: (p) => p.value,
                currency: userCurrencySnapshot.data,
                tooltipTitleBuilder: (p) => p.label,
                minY: 0,
                maxY: maxY,
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: budget.limitAmount,
                      color: limitLineColor,
                      dashArray: [12, 2],
                      label: HorizontalLineLabel(
                        show: true,
                        padding: const EdgeInsets.only(left: 2),
                        style: TextStyle(color: limitLineColor),
                        labelResolver: (_) => t.budgets.details.budget_value,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _BudgetEvolutionPoint {
  final DateTime date;
  final double value;
  final String label;

  _BudgetEvolutionPoint({
    required this.date,
    required this.value,
    required this.label,
  });
}
