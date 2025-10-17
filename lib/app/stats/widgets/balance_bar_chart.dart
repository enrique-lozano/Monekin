import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';

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
    this.filters = const TransactionFilters(),
  });

  final DatePeriodState dateRange;

  final TransactionFilters filters;

  @override
  State<BalanceBarChart> createState() => _BalanceBarChartState();
}

class _BalanceBarChartState extends State<BalanceBarChart> {
  int touchedBarGroupIndex = -1;
  int touchedRodDataIndex = -1;

  Future<IncomeExpenseChartDataItem?> getDataByPeriods(
    DateTime? startDate,
    DateTime? endDate,
    DatePeriodState range,
  ) async {
    final accountService = AccountService.instance;
    final accounts = await widget.filters.accounts().first;

    final List<String> shortTitles = [];
    final List<String> longTitles = [];
    final List<double> income = [];
    final List<double> expense = [];
    final List<double> balance = [];

    final effectiveStart =
        startDate ??
        (accounts.isNotEmpty
            ? accounts.map((e) => e.date).min
            : DateTime(DateTime.now().year - 3));

    final effectiveEnd = endDate ?? DateTime.now();

    Future<double> getIncomeData(DateTime start, DateTime end) {
      return accountService
          .getAccountsBalance(
            filters: widget.filters.copyWith(
              transactionTypes: [TransactionType.I]
                  .intersectionWithNullable(widget.filters.transactionTypes)
                  .toList(),
              minDate: start,
              maxDate: end,
            ),
          )
          .first;
    }

    Future<double> getExpenseData(DateTime start, DateTime end) {
      return accountService
          .getAccountsBalance(
            filters: widget.filters.copyWith(
              transactionTypes: [TransactionType.E]
                  .intersectionWithNullable(widget.filters.transactionTypes)
                  .toList(),
              minDate: start,
              maxDate: end,
            ),
          )
          .first;
    }

    Future<void> addPeriodData({
      required DateTime start,
      required DateTime end,
      required String shortTitle,
      required String longTitle,
    }) async {
      final incomeValue = await getIncomeData(start, end);
      final expenseValue = await getExpenseData(start, end);

      shortTitles.add(shortTitle);
      longTitles.add(longTitle);
      income.add(incomeValue);
      expense.add(expenseValue);
      balance.add(incomeValue + expenseValue);
    }

    if (range.datePeriod.periodType == PeriodType.cycle) {
      if (endDate == null || startDate == null) {
        throw Exception('Dates cannot be null');
      }

      switch (range.datePeriod.periodicity) {
        case Periodicity.month:
          final ranges = [
            [1, 6],
            [6, 10],
            [10, 15],
            [15, 20],
            [20, 25],
            [25, null],
          ];

          for (final r in ranges) {
            final start = DateTime(startDate.year, startDate.month, r[0]!);
            final end = DateTime(
              start.year,
              r[1] == null ? start.month + 1 : start.month,
              r[1] ?? 1,
            );

            await addPeriodData(
              start: start,
              end: end,
              shortTitle: "${r[0]}-${r[1] ?? ''}",
              longTitle:
                  '${DateFormat.MMMd().format(start)} - ${DateFormat.MMMd().format(end)}',
            );
          }
          break;

        case Periodicity.year:
          for (
            var i = startDate.month;
            i <= endDate.subtract(const Duration(milliseconds: 1)).month;
            i++
          ) {
            final start = DateTime(startDate.year, i);
            final end = DateTime(start.year, i + 1);

            await addPeriodData(
              start: start,
              end: end,
              shortTitle: DateFormat.MMM().format(start),
              longTitle: DateFormat.MMMM().format(start),
            );
          }
          break;

        case Periodicity.week:
          for (var i = 0; i < DateTime.daysPerWeek; i++) {
            final start = startDate.add(Duration(days: i));
            final end = start.add(const Duration(days: 1));

            await addPeriodData(
              start: start,
              end: end,
              shortTitle: DateFormat.E().format(start),
              longTitle: DateFormat.yMMMEd().format(start),
            );
          }
          break;

        default:
          break;
      }
    } else if (range.datePeriod.periodType == PeriodType.dateRange ||
        range.datePeriod.periodType == PeriodType.lastDays) {
      final dayDiff = effectiveEnd.difference(effectiveStart).inDays;

      final Periodicity? periodicity = dayDiff <= 7
          ? Periodicity.week
          : dayDiff <= 31
          ? Periodicity.month
          : dayDiff <= 365 && effectiveStart.year == effectiveEnd.year
          ? Periodicity.year
          : null;

      return getDataByPeriods(
        effectiveStart,
        effectiveEnd,
        DatePeriodState(
          datePeriod: periodicity != null
              ? DatePeriod.withPeriods(periodicity)
              : const DatePeriod.allTime(),
        ),
      );
    } else {
      for (
        int year = max(effectiveStart.year, DateTime.now().year - 5);
        year <= effectiveEnd.year;
        year++
      ) {
        final start = DateTime(year);
        final end = DateTime(year + 1);

        await addPeriodData(
          start: start,
          end: end,
          shortTitle: DateFormat.y().format(start),
          longTitle: DateFormat.y().format(start),
        );
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
        stream: CurrencyService.instance.getUserPreferredCurrency(),
        builder: (context, userCurrencySnapshot) {
          return FutureBuilder(
            future: getDataByPeriods(
              widget.dateRange.startDate,
              widget.dateRange.endDate,
              widget.dateRange,
            ),
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
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              ),
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
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                ),
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

                      return defaultGridLine(
                        value,
                      ).copyWith(strokeWidth: 0.75, color: lightBorderColor);
                    },
                  ),
                  barGroups: List.generate(snapshot.data!.income.length, (i) {
                    return makeGroupData(
                      i,
                      snapshot.data!.income[i],
                      snapshot.data!.expense[i],
                      width: 75 / snapshot.data!.income.length,
                    );
                  }),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
