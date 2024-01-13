import 'package:async/async.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/services/filters/date_range_service.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../../core/presentation/app_colors.dart';

class BalanceChartSmall extends StatefulWidget {
  const BalanceChartSmall({super.key, required this.dateRangeService});

  final DateRangeService dateRangeService;

  @override
  State<BalanceChartSmall> createState() => _BalanceChartSmallState();
}

class _BalanceChartSmallState extends State<BalanceChartSmall> {
  int touchedGroupIndex = -1;

  BarChartGroupData makeGroupData(int x, double expense, double income,
      {bool disabled = false, required AppColors colors}) {
    const double width = 56;

    const radius = BorderRadius.vertical(
        bottom: Radius.zero, top: Radius.circular(width / 6));

    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: expense,
          color: disabled
              ? Colors.grey.withOpacity(0.175)
              : x == 0
                  ? colors.danger.withOpacity(0.4)
                  : colors.danger,
          borderRadius: radius,
          width: width,
        ),
        BarChartRodData(
          toY: income,
          color: disabled
              ? Colors.grey.withOpacity(0.175)
              : x == 0
                  ? colors.success.withOpacity(0.4)
                  : colors.success,
          borderRadius: radius,
          width: width,
        ),
      ],
    );
  }

  FlTitlesData getTitlesData(Color borderColor) {
    return FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 32,
        getTitlesWidget: (value, meta) {
          return Row(
            children: [
              Container(
                width: 5,
                height: 1,
                color: borderColor,
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
          );
        },
      )),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 24,
          getTitlesWidget: (value, meta) {
            return Text(
              value == 0 ? 'Periodo anterior' : 'Este periodo',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return SizedBox(
      height: BreakPoint.of(context).isLargerThan(BreakpointID.md) ? 325 : 250,
      child: StreamBuilder(
          stream: AccountService.instance.getAccounts(),
          builder: (context, accountsSnapshot) {
            if (!accountsSnapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final accounts = accountsSnapshot.data!;

            final ultraLightBorderColor =
                Theme.of(context).brightness == Brightness.light
                    ? Colors.black12
                    : Colors.white12;

            if (accounts.isEmpty) {
              return Stack(
                children: [
                  BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (a, b, c, d) => null,
                        ),
                      ),
                      titlesData: getTitlesData(ultraLightBorderColor),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: ultraLightBorderColor),
                        ),
                      ),
                      barGroups: [
                        makeGroupData(0, 4, 2,
                            disabled: true, colors: AppColors.of(context)),
                        makeGroupData(1, 5, 7,
                            disabled: true, colors: AppColors.of(context)),
                      ],
                      gridData: const FlGridData(show: false),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          t.general.insufficient_data,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                  )
                ],
              );
            }

            return StreamBuilder(
                stream: StreamZip([
                  AccountService.instance.getAccountsBalance(
                      filters: TransactionFilters(
                    transactionTypes: [TransactionType.expense],
                    minDate: widget.dateRangeService.getDateRange(-1)[0],
                    maxDate: widget.dateRangeService.getDateRange(-1)[1],
                  )),
                  AccountService.instance.getAccountsBalance(
                      filters: TransactionFilters(
                    transactionTypes: [TransactionType.income],
                    minDate: widget.dateRangeService.getDateRange(-1)[0],
                    maxDate: widget.dateRangeService.getDateRange(-1)[1],
                  )),
                  AccountService.instance.getAccountsBalance(
                      filters: TransactionFilters(
                    transactionTypes: [TransactionType.expense],
                    minDate: widget.dateRangeService.startDate,
                    maxDate: widget.dateRangeService.endDate,
                  )),
                  AccountService.instance.getAccountsBalance(
                      filters: TransactionFilters(
                    transactionTypes: [TransactionType.income],
                    minDate: widget.dateRangeService.startDate,
                    maxDate: widget.dateRangeService.endDate,
                  )),
                ]),
                builder: (context, snapshpot) {
                  if (!snapshpot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  return BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: AppColors.of(context).background,
                          getTooltipItem: (a, b, c, d) => null,
                        ),
                      ),
                      titlesData: getTitlesData(ultraLightBorderColor),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: ultraLightBorderColor),
                          right: BorderSide(
                              width: 1, color: ultraLightBorderColor),
                        ),
                      ),
                      barGroups: [
                        makeGroupData(
                            0, -snapshpot.data![0], snapshpot.data![1],
                            colors: AppColors.of(context)),
                        makeGroupData(
                            1, -snapshpot.data![2], snapshpot.data![3],
                            colors: AppColors.of(context)),
                      ],
                      gridData: const FlGridData(show: false),
                    ),
                  );
                });
          }),
    );
  }
}
