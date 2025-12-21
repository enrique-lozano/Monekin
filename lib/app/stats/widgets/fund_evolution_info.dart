import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

class LineChartDataItem {
  List<double> balance;
  List<String> labels;

  LineChartDataItem({required this.balance, required this.labels});
}

class FundEvolutionInfo extends StatelessWidget {
  const FundEvolutionInfo({
    super.key,
    this.filters = const TransactionFilters(),
    required this.dateRange,
    this.showBalanceHeader = false,
  });

  final DatePeriodState dateRange;

  final bool showBalanceHeader;

  final TransactionFilters filters;

  @override
  Widget build(BuildContext context) {
    final accountService = AccountService.instance;

    final t = Translations.of(context);

    return StreamBuilder(
      stream: filters.accounts(),
      builder: (context, accountsSnapshot) {
        return Column(
          children: [
            if (showBalanceHeader)
              Builder(
                builder: (context) {
                  if (!accountsSnapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Final balance - ${dateRange.getText(context)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Skeleton(width: 70, height: 40),
                        const Skeleton(width: 30, height: 14),
                      ],
                    );
                  }

                  final accounts = accountsSnapshot.data!;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.stats.final_balance,
                            style: const TextStyle(fontSize: 12),
                          ),
                          StreamBuilder(
                            stream: accountService.getAccountsMoney(
                              accountIds: accounts.map((e) => e.id),
                              trFilters: filters,
                              date: dateRange.endDate,
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Skeleton(width: 70, height: 40);
                              }

                              return CurrencyDisplayer(
                                amountToConvert: snapshot.data!,
                                integerStyle: Theme.of(
                                  context,
                                ).textTheme.headlineSmall!,
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            t.stats.compared_to_previous_period,
                            style: const TextStyle(fontSize: 12),
                          ),
                          StreamBuilder(
                            stream: accountService.getAccountsMoneyVariation(
                              accounts: accounts,
                              startDate: dateRange.startDate,
                              endDate: dateRange.endDate,
                              trFilters: filters,
                              convertToPreferredCurrency: true,
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Skeleton(width: 52, height: 22);
                              }

                              return TrendingValue(
                                percentage: snapshot.data!,
                                filled: false,
                                fontWeight: Theme.of(
                                  context,
                                ).textTheme.headlineSmall!.fontWeight!,
                                fontSize: Theme.of(
                                  context,
                                ).textTheme.headlineSmall!.fontSize!,
                                outlined: false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            const SizedBox(height: 24),
            SizedBox(
              height: 260,
              child: Builder(
                builder: (context) {
                  const loadingWidget = Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    ],
                  );

                  if (!accountsSnapshot.hasData) {
                    return loadingWidget;
                  }

                  final sortedAccounts = accountsSnapshot.data!.sorted(
                    (a, b) => a.date.compareTo(b.date),
                  );

                  final chartDateRange = sortedAccounts.isEmpty
                      ? dateRange.toDateTimeRange
                      : DateTimeRange(
                          start:
                              dateRange.startDate ?? sortedAccounts.first.date,
                          end: dateRange.endDate ?? DateTime.now(),
                        );

                  return FundEvolutionLineChart(
                    filters: filters,
                    loadingWidget: loadingWidget,
                    timeRange: chartDateRange,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class FundEvolutionLineChart extends StatefulWidget {
  const FundEvolutionLineChart({
    super.key,
    this.timeRange,
    required this.filters,
    required this.loadingWidget,
  });

  final DateTimeRange? timeRange;
  final TransactionFilters filters;
  final Widget loadingWidget;

  @override
  State<FundEvolutionLineChart> createState() => _FundEvolutionLineChartState();
}

class _FundEvolutionLineChartState extends State<FundEvolutionLineChart> {
  late Stream<LineChartDataItem?> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = getEvolutionData();
  }

  @override
  void didUpdateWidget(covariant FundEvolutionLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.timeRange != widget.timeRange ||
        oldWidget.filters != widget.filters) {
      _dataStream = getEvolutionData();
    }
  }

  Stream<LineChartDataItem?> getEvolutionData() {
    final timeRange = widget.timeRange;

    if (timeRange == null) {
      return Stream.value(null);
    }

    List<Stream<double>> balance = [];
    List<String> labels = [];

    DateTime currentDay = timeRange.start.justDay();

    final dayRange = (timeRange.end.difference(timeRange.start).inDays / 100)
        .ceil();

    while (currentDay.compareTo(timeRange.end) < 0) {
      labels.add(
        currentDay.year == currentYear
            ? DateFormat.MMMMd().format(currentDay)
            : DateFormat.yMMMd().format(currentDay),
      );

      balance.add(
        AccountService.instance.getAccountsMoney(
          trFilters: widget.filters,
          date: currentDay,
        ),
      );

      currentDay = currentDay.add(Duration(days: dayRange));
    }

    return Rx.combineLatest(
      balance,
      (values) => LineChartDataItem(balance: values, labels: labels),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lineColor = Theme.of(context).colorScheme.primary;

    return StreamBuilder(
      stream: _dataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget;
        }

        final ultraLightBorderColor = isAppInLightBrightness(context)
            ? Colors.black12
            : Colors.white12;

        return StreamBuilder(
          stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
          builder: (context, userCurrencySnapshot) {
            return Stack(
              children: [
                LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) =>
                          defaultGridLine(value).copyWith(
                            color: ultraLightBorderColor,
                            strokeWidth: 0.5,
                          ),
                    ),
                    lineTouchData: LineTouchData(
                      enabled: snapshot.hasData,
                      touchTooltipData: LineTouchTooltipData(
                        fitInsideVertically: true,
                        fitInsideHorizontally: true,
                        getTooltipColor: (spot) =>
                            Theme.of(context).colorScheme.surface,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((barSpot) {
                            final flSpot = barSpot;
                            if (flSpot.x == 0 || flSpot.x == 6) {
                              return null;
                            }

                            return LineTooltipItem(
                              '${snapshot.data!.labels[flSpot.x.toInt()]} \n',
                              const TextStyle(fontSize: 12),
                              textAlign: TextAlign.start,
                              children: UINumberFormatter.currency(
                                currency: userCurrencySnapshot.data,
                                amountToConvert:
                                    snapshot.data!.balance[flSpot.x.toInt()],
                                integerStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ).getTextSpanList(context),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    minY: snapshot.hasData
                        ? (snapshot.data!.balance.allItemsEqual()
                              ? snapshot.data!.balance.first - 10.2
                              : null)
                        : 2,
                    maxY: snapshot.hasData
                        ? (snapshot.data!.balance.allItemsEqual()
                              ? snapshot.data!.balance.first + 10.2
                              : null)
                        : 5,
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: noAxisTitles,
                      topTitles: noAxisTitles,
                      bottomTitles: noAxisTitles,
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: snapshot.hasData,
                          reservedSize: 28,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.max || value == meta.min) {
                              return Container();
                            }

                            return SideTitleWidget(
                              meta: meta,
                              child: BlurBasedOnPrivateMode(
                                child: Text(
                                  meta.formattedValue,
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  softWrap: false,
                                  overflow: TextOverflow.visible,
                                  style: smallAxisTitleStyle(context),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                      border: Border(
                        bottom: BorderSide(
                          color: ultraLightBorderColor,
                          width: 1,
                        ),
                        right: BorderSide(
                          color: ultraLightBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: snapshot.hasData
                            ? List.generate(
                                snapshot.data!.balance.length,
                                (index) => FlSpot(
                                  index.toDouble(),
                                  snapshot.data!.balance[index],
                                ),
                              )
                            : [
                                const FlSpot(0, 3),
                                const FlSpot(2.6, 2.2),
                                const FlSpot(4.9, 4.3),
                                const FlSpot(6.8, 3.1),
                                const FlSpot(8, 4),
                                const FlSpot(9.5, 3),
                                const FlSpot(11, 4),
                              ],
                        isCurved: true,
                        curveSmoothness: snapshot.hasData ? 0.025 : 0.2,
                        color: snapshot.hasData
                            ? lineColor
                            : Colors.grey.withOpacity(0.2),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          applyCutOffY: true,
                          cutOffY: 0,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: snapshot.hasData
                                ? [
                                    lineColor.withAlpha(100),
                                    lineColor.withAlpha(1),
                                  ]
                                : [Colors.grey, Colors.grey.lighten(0.3)]
                                      .map((color) => color.withOpacity(0.15))
                                      .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!snapshot.hasData)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        t.general.insufficient_data,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
