import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/services/filters/date_range_service.dart';
import 'package:monekin/core/utils/color_utils.dart';

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
  const BalanceBarChart(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.dateRange,
      this.filters});

  final DateTime? startDate;
  final DateTime? endDate;
  final DateRange dateRange;

  final TransactionFilters? filters;

  @override
  State<BalanceBarChart> createState() => _BalanceBarChartState();
}

class _BalanceBarChartState extends State<BalanceBarChart> {
  int touchedBarGroupIndex = -1;
  int touchedRodDataIndex = -1;

  Future<IncomeExpenseChartDataItem?> getDataByPeriods(
      DateTime? startDate, DateTime? endDate, DateRange range) async {
    if (startDate == null && range != DateRange.infinite) return null;

    List<String> shortTitles = [];
    List<String> longTitles = [];

    List<double> income = [];
    List<double> expense = [];
    List<double> balance = [];

    final accountService = AccountService.instance;

    final accounts =
        await (widget.filters ?? const TransactionFilters()).accounts().first;
    final accountsIds = accounts.map((event) => event.id);

    getIncomeData(DateTime? startDate, DateTime? endDate) async =>
        await accountService
            .getAccountsData(
                accountIds: accountsIds,
                categoriesIds: widget.filters?.categories,
                accountDataFilter: AccountDataFilter.income,
                startDate: startDate,
                endDate: endDate)
            .first;

    getExpenseData(DateTime? startDate, DateTime? endDate) async =>
        await accountService
            .getAccountsData(
                accountIds: accountsIds,
                categoriesIds: widget.filters?.categories,
                accountDataFilter: AccountDataFilter.expense,
                startDate: startDate,
                endDate: endDate)
            .first;

    if (range == DateRange.monthly) {
      for (final range in [
        [1, 6],
        [6, 10],
        [10, 15],
        [15, 20],
        [20, 25],
        [25, null]
      ]) {
        shortTitles.add(
            "${range[0].toString()}-${range[1] != null ? range[1].toString() : ''}");

        startDate = DateTime(startDate!.year, startDate.month, range[0]!);

        DateTime endDate = DateTime(
            startDate.year,
            range[1] == null ? startDate.month + 1 : startDate.month,
            range[1] ?? 1);

        longTitles.add(
            '${DateFormat.MMMd().format(startDate)} - ${DateFormat.MMMd().format(endDate)}');

        final incomeToAdd = await getIncomeData(startDate, endDate);
        final expenseToAdd = await getExpenseData(startDate, endDate);

        income.add(incomeToAdd);
        expense.add(expenseToAdd);
        balance.add(incomeToAdd + expenseToAdd);
      }
    } else if (range == DateRange.annualy) {
      for (var i = 1; i <= 12; i++) {
        final selStartDate = DateTime(startDate!.year, i);
        final endDate = DateTime(startDate.year, i + 1);

        shortTitles.add(DateFormat.M().format(selStartDate));
        longTitles.add(DateFormat.MMMM().format(selStartDate));

        final incomeToAdd = await getIncomeData(selStartDate, endDate);
        final expenseToAdd = await getExpenseData(selStartDate, endDate);

        income.add(incomeToAdd);
        expense.add(expenseToAdd);
        balance.add(incomeToAdd + expenseToAdd);
      }
    } else if (range == DateRange.quaterly) {
      for (var i = startDate!.month; i < startDate.month + 3; i++) {
        final selStartDate = DateTime(startDate.year, i);
        final endDate = DateTime(startDate.year, i + 1);

        shortTitles.add(DateFormat.MMM().format(selStartDate));
        longTitles.add(DateFormat.MMMM().format(selStartDate));

        final incomeToAdd = await getIncomeData(selStartDate, endDate);
        final expenseToAdd = await getExpenseData(selStartDate, endDate);

        income.add(incomeToAdd);
        expense.add(expenseToAdd);
        balance.add(incomeToAdd + expenseToAdd);
      }
    } else if (range == DateRange.weekly) {
      for (var i = 0; i < DateTime.daysPerWeek; i++) {
        final selStartDate =
            DateTime(startDate!.year, startDate.month, startDate.day + i);
        final endDate =
            DateTime(startDate.year, startDate.month, startDate.day + i + 1);

        shortTitles.add(DateFormat.E().format(selStartDate));
        longTitles.add(DateFormat.yMMMEd().format(selStartDate));

        final incomeToAdd = await getIncomeData(selStartDate, endDate);
        final expenseToAdd = await getExpenseData(selStartDate, endDate);

        income.add(incomeToAdd);
        expense.add(expenseToAdd);
        balance.add(incomeToAdd + expenseToAdd);
      }
    } else if (range == DateRange.custom) {
      if (endDate == null) {
        throw Exception("End date can not be null");
      }

      final dateDiff = endDate.difference(startDate!).inDays;

      if (dateDiff <= 7) {
        return getDataByPeriods(startDate, endDate, DateRange.weekly);
      } else if (dateDiff <= 31) {
        return getDataByPeriods(startDate, endDate, DateRange.monthly);
      } else if (dateDiff <= 365) {
        return getDataByPeriods(startDate, endDate, DateRange.annualy);
      } else {
        return getDataByPeriods(startDate, endDate, DateRange.infinite);
      }
    } else {
      // INFINITE:

      final minDate = startDate ?? accounts.map((e) => e.date).min;

      for (var i = min(minDate.year, DateTime.now().year - 3);
          i <= DateTime.now().year;
          i++) {
        final selStartDate = DateTime(i);
        final endDate = DateTime(i + 1);

        shortTitles.add(DateFormat.y().format(selStartDate));
        longTitles.add(DateFormat.y().format(selStartDate));

        final incomeToAdd = await getIncomeData(selStartDate, endDate);
        final expenseToAdd = await getExpenseData(selStartDate, endDate);

        income.add(incomeToAdd);
        expense.add(expenseToAdd);
        balance.add(incomeToAdd + expenseToAdd);
      }
    }

    return IncomeExpenseChartDataItem(
      income: income,
      expense: expense,
      balance: balance,
      shortTitles: shortTitles,
      longTitles: longTitles,
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

    Radius radius = Radius.circular(width / 6);

    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          toY: income,
          color: isTouched && touchedRodDataIndex == 0
              ? CustomColors.of(context).success.darken(0.1)
              : CustomColors.of(context).success,
          width: width,
          borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: radius,
          ),
        ),
        BarChartRodData(
          toY: expense,
          color: isTouched && touchedRodDataIndex == 1
              ? CustomColors.of(context).danger.darken(0.1)
              : CustomColors.of(context).danger,
          width: width,
          borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
          ),
        )
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FutureBuilder(
          future: getDataByPeriods(
              widget.startDate, widget.endDate, widget.dateRange),
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

            final ultraLightBorderColor =
                Theme.of(context).brightness == Brightness.light
                    ? Colors.black12
                    : Colors.white12;

            final lightBorderColor =
                Theme.of(context).brightness == Brightness.light
                    ? Colors.black26
                    : Colors.white24;

            return BarChart(BarChartData(
              maxY: max(100, snapshot.data!.income.max),
              minY: min(-100, snapshot.data!.expense.min),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipMargin: -10,
                  tooltipBgColor: Theme.of(context).colorScheme.background,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${snapshot.data!.longTitles[group.x]}\n',
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      children: UINumberFormatter.decimal(
                              amountToConvert: rod.toY,
                              textStyle: const TextStyle(fontSize: 16))
                          .getTextSpanList(context),
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
                        axisSide: meta.axisSide,
                        child: Text(
                          snapshot.data!.shortTitles[value.toInt()],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 0,
                        child: Row(
                          children: [
                            Container(
                              width: 5,
                              height: 1,
                              color: ultraLightBorderColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              meta.formattedValue,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    reservedSize: 42,
                  ),
                ),
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(width: 1, color: ultraLightBorderColor),
                    right: BorderSide(width: 1, color: ultraLightBorderColor),
                  )),
              gridData: FlGridData(
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  if (value != 0) {
                    return defaultGridLine(value).copyWith(
                        strokeWidth: 0.5, color: ultraLightBorderColor);
                  }

                  return defaultGridLine(value)
                      .copyWith(strokeWidth: 0.75, color: lightBorderColor);
                },
              ),
              barGroups: List.generate(snapshot.data!.income.length, (i) {
                return makeGroupData(
                    i, snapshot.data!.income[i], snapshot.data!.expense[i],
                    width: 156 / snapshot.data!.income.length);
              }),
            ));
          }),
    );
  }
}
