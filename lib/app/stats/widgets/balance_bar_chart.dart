import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/date-utils/date_period_segments.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';

import '../../../core/models/transaction/transaction_type.enum.dart';
import '../../../core/presentation/app_colors.dart';

class IncomeExpenseChartDataItem {
  List<double> income;
  List<double> expense;
  List<double> balance;
  List<String> shortTitles;
  List<String> longTitles;

  IncomeExpenseChartDataItem({
    required this.income,
    required this.expense,
    required this.balance,
    required this.shortTitles,
    List<String>? longTitles,
  }) : longTitles = longTitles ?? shortTitles;
}

class BalanceBarChart extends StatefulWidget {
  const BalanceBarChart({
    super.key,
    required this.dateRange,
    this.filters = const TransactionFilterSet(),
  });

  final DatePeriodState dateRange;

  final TransactionFilterSet filters;

  @override
  State<BalanceBarChart> createState() => _BalanceBarChartState();
}

class _BalanceBarChartState extends State<BalanceBarChart> {
  int touchedBarGroupIndex = -1;
  int touchedRodDataIndex = -1;

  Future<IncomeExpenseChartDataItem> getDataByPeriods(
    DatePeriodState range,
  ) async {
    final transactionService = TransactionService.instance;
    final accounts = await widget.filters.accounts().first;

    final List<String> shortTitles = [];
    final List<String> longTitles = [];
    final List<double> income = [];
    final List<double> expense = [];
    final List<double> balance = [];

    Future<double> getIncomeData(DateTime start, DateTime end) {
      return transactionService
          .getTransactionsValueBalance(
            filters: widget.filters.copyWith(
              transactionTypes: [TransactionType.income]
                  .intersectionWithNullable(widget.filters.transactionTypes)
                  .toList(),
              minDate: start,
              maxDate: end,
            ),
          )
          .first;
    }

    Future<double> getExpenseData(DateTime start, DateTime end) {
      return transactionService
          .getTransactionsValueBalance(
            filters: widget.filters.copyWith(
              transactionTypes: [TransactionType.expense]
                  .intersectionWithNullable(widget.filters.transactionTypes)
                  .toList(),
              minDate: start,
              maxDate: end,
            ),
          )
          .first;
    }

    final segments = range.splitIntoSegments(
      oldestDate: accounts.isEmpty ? null : accounts.map((e) => e.date).min,
    );

    for (final segment in segments) {
      final incomeValue = await getIncomeData(segment.start, segment.end);
      final expenseValue = await getExpenseData(segment.start, segment.end);

      shortTitles.add(segment.shortTitle);
      longTitles.add(segment.longTitle);
      income.add(incomeValue);
      expense.add(expenseValue);
      balance.add(incomeValue + expenseValue);
    }

    return IncomeExpenseChartDataItem(
      income: income,
      expense: expense,
      balance: balance,
      shortTitles: shortTitles,
      longTitles: longTitles,
    );
  }

  BorderRadius getBarRadius({required double radius, bool isNegative = false}) {
    Radius circularRadius = Radius.circular(radius);

    return BorderRadius.only(
      topLeft: isNegative ? Radius.zero : circularRadius,
      topRight: isNegative ? Radius.zero : circularRadius,
      bottomLeft: isNegative ? circularRadius : Radius.zero,
      bottomRight: isNegative ? circularRadius : Radius.zero,
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double income,
    double expense, {
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    bool isTouched = touchedBarGroupIndex == x;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: income,
          color: isTouched
              ? AppColors.of(context).success.lighten(0.2)
              : AppColors.of(context).success,
          width: width * (isTouched ? 1.2 : 1),
          borderRadius: getBarRadius(
            radius: width / 6,
            isNegative: income.isNegative,
          ),
        ),
        BarChartRodData(
          toY: -expense,
          color: isTouched
              ? AppColors.of(context).danger.lighten(0.2)
              : AppColors.of(context).danger,
          width: width * (isTouched ? 1.2 : 1),
          borderRadius: getBarRadius(
            radius: width / 6,
            isNegative: (-expense).isNegative,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: StreamBuilder(
        stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
        builder: (context, userCurrencySnapshot) {
          return FutureBuilder(
            future: getDataByPeriods(widget.dateRange),
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

              final ultraLightBorderColor = isAppInLightBrightness(context)
                  ? Colors.black12
                  : Colors.white12;

              final lightBorderColor = isAppInLightBrightness(context)
                  ? Colors.black26
                  : Colors.white24;

              return LayoutBuilder(
                builder: (context, constraints) {
                  final groupCount = snapshot.data!.income.length;

                  // Scale the bar width to the available plot width (minus the
                  // left axis labels and right padding) so bars grow on wider
                  // screens instead of staying thin. Each group holds 2 rods.
                  final plotWidth = (constraints.maxWidth - 42 - 16).clamp(
                    0.0,
                    double.infinity,
                  );
                  final barWidth = groupCount == 0
                      ? 12.0
                      : (plotWidth * 0.62 / (groupCount * 2)).clamp(8.0, 42.0);

                  return BarChart(
                    BarChartData(
                      maxY:
                          snapshot.data!.expense.every((ex) => ex == 0) &&
                              snapshot.data!.income.every((inc) => inc == 0) &&
                              snapshot.data!.balance.every((bal) => bal == 0)
                          ? 10.2
                          : null,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          fitInsideVertically: true,
                          fitInsideHorizontally: true,
                          getTooltipColor: (spot) =>
                              Theme.of(context).colorScheme.surface,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final barRodsToY = group.barRods.map((e) => e.toY);

                            return BarTooltipItem(
                              '${snapshot.data!.longTitles[group.x]}\n',
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.start,
                              children: [
                                TextSpan(
                                  text: '↑ ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.of(context).success,
                                    decoration: TextDecoration.none,
                                  ),
                                  children: UINumberFormatter.currency(
                                    currency: userCurrencySnapshot.data,
                                    amountToConvert: barRodsToY.elementAt(0),
                                  ).getTextSpanList(context),
                                ),
                                const TextSpan(text: '\n'),
                                TextSpan(
                                  text: '↓ ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.of(context).danger,
                                    decoration: TextDecoration.none,
                                  ),
                                  children: UINumberFormatter.currency(
                                    currency: userCurrencySnapshot.data,
                                    amountToConvert: barRodsToY.elementAt(1),
                                  ).getTextSpanList(context),
                                ),
                              ],
                            );
                          },
                        ),
                        touchCallback: (event, barTouchResponse) {
                          if (!event.isInterestedForInteractions ||
                              barTouchResponse == null ||
                              barTouchResponse.spot == null) {
                            touchedBarGroupIndex = -1;
                            touchedRodDataIndex = -1;
                            return;
                          }

                          touchedBarGroupIndex =
                              barTouchResponse.spot!.touchedBarGroupIndex;

                          touchedRodDataIndex =
                              barTouchResponse.spot!.touchedRodDataIndex;

                          setState(() {});
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return SideTitleWidget(
                                meta: meta,
                                child: Text(
                                  snapshot.data!.shortTitles[value.toInt()],
                                  style: smallAxisTitleStyle(context),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value == meta.max) {
                                return Container();
                              }

                              return SideTitleWidget(
                                meta: meta,
                                child: BlurBasedOnPrivateMode(
                                  child: Text(
                                    meta.formattedValue,
                                    style: smallAxisTitleStyle(context),
                                  ),
                                ),
                              );
                            },
                            reservedSize: 42,
                          ),
                        ),
                        rightTitles: noAxisTitles,
                        topTitles: noAxisTitles,
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: ultraLightBorderColor,
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          if (value != 0) {
                            return defaultGridLine(value).copyWith(
                              strokeWidth: 0.5,
                              color: ultraLightBorderColor,
                            );
                          }

                          return defaultGridLine(value).copyWith(
                            strokeWidth: 0.75,
                            color: lightBorderColor,
                          );
                        },
                      ),
                      barGroups: List.generate(snapshot.data!.income.length, (
                        i,
                      ) {
                        return makeGroupData(
                          i,
                          snapshot.data!.income[i],
                          snapshot.data!.expense[i],
                          width: barWidth,
                        );
                      }),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
