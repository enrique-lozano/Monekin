import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/app/stats/widgets/fund_evolution_info.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class BudgetEvolutionChart extends StatelessWidget {
  const BudgetEvolutionChart({super.key, required this.budget});

  final Budget budget;

  Future<LineChartDataItem?> getEvolutionData(
    BuildContext context,
  ) async {
    List<Future<double>> balance = [];
    List<String> labels = [];

    final startDate = budget.currentDateRange.start;
    final endDate = budget.currentDateRange.end;

    DateTime currentDay =
        DateTime(startDate.year, startDate.month, startDate.day);

    final dayRange = (endDate.difference(startDate).inDays / 100).ceil();

    while (currentDay.compareTo(endDate) < 0) {
      labels.add(DateFormat.yMMMMd().format(currentDay));

      balance.add(budget.getValueOnDate(currentDay).first);

      currentDay = currentDay.add(Duration(days: dayRange));
    }

    return LineChartDataItem(
        balance: await Future.wait(balance), labels: labels);
  }

  @override
  Widget build(BuildContext context) {
    final lineColor = Theme.of(context).colorScheme.primary;
    final t = Translations.of(context);

    return SizedBox(
      height: 300,
      child: FutureBuilder(
          future: getEvolutionData(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ],
              );
            }

            return LineChart(LineChartData(
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              extraLinesData: ExtraLinesData(horizontalLines: [
                HorizontalLine(
                    y: budget.limitAmount,
                    color: Theme.of(context).colorScheme.tertiary,
                    dashArray: [12, 2],
                    label: HorizontalLineLabel(
                      show: true,
                      padding: const EdgeInsets.only(left: 2),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      labelResolver: (p0) => t.budgets.details.budget_value,
                    ))
              ]),
              lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (spot) =>
                    Theme.of(context).colorScheme.surface,
                tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                tooltipMargin: -10,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((barSpot) {
                    final flSpot = barSpot;
                    if (flSpot.x == 0 || flSpot.x == 6) {
                      return null;
                    }

                    return LineTooltipItem(
                        '${snapshot.data!.labels[flSpot.x.toInt()]} \n',
                        const TextStyle(),
                        children: [
                          TextSpan(
                              text:
                                  '${snapshot.data!.balance[flSpot.x.toInt()]}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ]);
                  }).toList();
                },
              )),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: noAxisTitles,
                topTitles: noAxisTitles,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        snapshot.data!.labels[int.parse(meta.formattedValue)],
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w200),
                      );
                    },
                  ),
                ),
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
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              minY: 0,
              maxY: max(
                  snapshot.data!.balance.max + snapshot.data!.balance.max * 0.1,
                  budget.limitAmount * 1.1),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                      snapshot.data!.balance.length,
                      (index) => FlSpot(
                          index.toDouble(), snapshot.data!.balance[index])),
                  isCurved: true,
                  curveSmoothness: 0.025,
                  color: lineColor,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(
                    show: false,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    applyCutOffY: true,
                    cutOffY: 0,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        lineColor.withAlpha(100),
                        lineColor.withAlpha(1)
                      ],
                    ),
                  ),
                ),
              ],
            ));
          }),
    );
  }
}
