import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/utils/common_axis_titles.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
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

  Future<(List<_NetWorthPoint>, CurrencyInDB?)> _loadEvolutionData() async {
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
    final cashAccounts = await _getCashAccountsTotal(date);
    final investmentAccounts = await _getInvestmentAccountsTotal(date);
    final physicalAssets = await _getPhysicalAssetsTotal(date);

    return cashAccounts + investmentAccounts + physicalAssets;
  }

  Future<double> _getInvestmentAccountsTotal(DateTime date) async {
    final accounts = await AccountService.instance
        .getAccounts(
          predicate: (account, currency) =>
              account.type.equals(AccountType.investment.name),
        )
        .first;

    if (accounts.isEmpty) return 0.0;

    final values = await Future.wait<double>(
      accounts.map<Future<double>>((account) async {
        return await AccountService.instance
            .getAccountMoney(
              account: account,
              date: date,
              convertToPreferredCurrency: true,
            )
            .first;
      }),
    );

    return values.fold<double>(0.0, (sum, value) => sum + value);
  }

  Future<double> _getPhysicalAssetsTotal(DateTime date) async {
    return await InvestmentService.instance
        .getTotalAssetsValueAtDate(date: date, considerLinkedAccounts: false)
        .first;
  }

  Future<double> _getCashAccountsTotal(DateTime date) async {
    final accounts = await AccountService.instance
        .getAccounts(
          predicate: (account, currency) =>
              account.type.isNotValue(AccountType.investment.name),
        )
        .first;

    if (accounts.isEmpty) return 0.0;

    final values = await Future.wait<double>(
      accounts.map<Future<double>>((account) async {
        return await AccountService.instance
            .getAccountMoney(
              account: account,
              date: date,
              convertToPreferredCurrency: true,
            )
            .first;
      }),
    );

    return values.fold<double>(0.0, (sum, value) => sum + value);
  }

  Future<double> _getDebtsTotal(DateTime date) async {
    final preferredCurrency = await CurrencyService.instance
        .ensureAndGetPreferredCurrency()
        .first;

    final debts = await DebtService.instance.getDebts().first;
    if (debts.isEmpty) return 0.0;

    final values = await Future.wait<double>(
      debts.map<Future<double>>((debt) async {
        final remaining = await DebtService.instance
            .getDebtRemainingAmount(debt)
            .first;
        if (debt.currency.code == preferredCurrency.code) {
          return remaining;
        }

        return await ExchangeRateService.instance
            .calculateExchangeRateToPreferredCurrency(
              fromCurrency: debt.currency.code,
              amount: remaining,
              date: date,
            )
            .first;
      }),
    );

    return values.fold<double>(0.0, (sum, value) => sum + value);
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
        final byX = {
          for (final point in data) point.date.millisecondsSinceEpoch: point,
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 260,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: yMax,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: yMax / 5,
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
                      color: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).colorScheme.error,
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
                      color: Theme.of(context).colorScheme.secondary,
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
                    touchTooltipData: LineTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipColor: (spot) =>
                          Theme.of(context).colorScheme.surface,
                      tooltipPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      getTooltipItems: (touchedSpots) {
                        final date = DateTime.fromMillisecondsSinceEpoch(
                          touchedSpots.first.x.toInt(),
                        );

                        final dataTextStyle = const TextStyle(
                          fontSize: 12,
                          height: 1.25,
                        );

                        return [
                          ...touchedSpots.mapIndexed((index, spot) {
                            final label = _lineLabel(context, spot.barIndex);
                            return LineTooltipItem(
                              '${index == 0 ? "${DateFormat.MMMd().format(date)}\n" : ""}',
                              const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                height: 2,
                              ),

                              children: [
                                TextSpan(
                                  text: "◉ ",
                                  style: dataTextStyle.copyWith(
                                    color: spot.bar.color,
                                  ),
                                ),
                                TextSpan(
                                  text: "$label: ",
                                  style: dataTextStyle,
                                ),
                                ...UINumberFormatter.currency(
                                  currency: snapshot.data!.$2,
                                  amountToConvert: spot.y,
                                  integerStyle: dataTextStyle,
                                ).getTextSpanList(context),
                              ],
                            );
                          }),
                        ];
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildLegendDot(
                  context,
                  t.assets.title,
                  Theme.of(context).colorScheme.primary,
                ),
                _buildLegendDot(
                  context,
                  t.debts.display(n: 2),
                  Theme.of(context).colorScheme.error,
                ),
                _buildLegendDot(
                  context,
                  t.stats.net_worth,
                  Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

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

  Widget _buildLegendDot(BuildContext context, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
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
