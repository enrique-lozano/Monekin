import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/time_series_evolution_chart.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class _FundEvolutionPoint {
  final DateTime date;
  final double value;
  final String label;

  _FundEvolutionPoint({
    required this.date,
    required this.value,
    required this.label,
  });
}

class FundEvolutionInfo extends StatelessWidget {
  const FundEvolutionInfo({
    super.key,
    this.filters = const TransactionFilterSet(),
    required this.dateRange,
    this.showBalanceHeader = false,
  });

  final DatePeriodState dateRange;

  final bool showBalanceHeader;

  final TransactionFilterSet filters;

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
                  final accounts = accountsSnapshot.data;

                  return Skeletonizer(
                    enabled: accounts == null,
                    child: Row(
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
                            if (accounts == null)
                              Text(
                                '--',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            if (accounts != null)
                              StreamBuilder(
                                stream: accountService.getAccountsMoney(
                                  accountIds: accounts.map((e) => e.id),
                                  trFilters: filters,
                                  date: dateRange.endDate,
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Bone(width: 70, height: 40);
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
                            if (accounts != null)
                              StreamBuilder(
                                stream: accountService
                                    .getAccountsMoneyVariation(
                                      accounts: accounts,
                                      startDate: dateRange.startDate,
                                      endDate: dateRange.endDate,
                                      trFilters: filters,
                                      convertToPreferredCurrency: true,
                                    ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Bone(width: 52, height: 22);
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
                    ),
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
                    accountsIds: accountsSnapshot.data?.map((e) => e.id),
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
    this.accountsIds,
  });

  final DateTimeRange? timeRange;
  final TransactionFilterSet filters;
  final Iterable<String>? accountsIds;
  final Widget loadingWidget;

  @override
  State<FundEvolutionLineChart> createState() => _FundEvolutionLineChartState();
}

class _FundEvolutionLineChartState extends State<FundEvolutionLineChart> {
  late Stream<List<_FundEvolutionPoint>?> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = getEvolutionData();
  }

  @override
  void didUpdateWidget(covariant FundEvolutionLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.timeRange != widget.timeRange ||
        oldWidget.filters != widget.filters ||
        oldWidget.accountsIds != widget.accountsIds) {
      _dataStream = getEvolutionData();
    }
  }

  Stream<List<_FundEvolutionPoint>?> getEvolutionData() {
    final timeRange = widget.timeRange;

    if (timeRange == null) {
      return Stream.value(null);
    }

    final List<DateTime> dates = [];
    final List<String> labels = [];
    final List<Stream<double>> balances = [];

    DateTime currentDay = timeRange.start.justDay();

    final dayRange = (timeRange.end.difference(timeRange.start).inDays / 100)
        .ceil();

    while (currentDay.compareTo(timeRange.end) < 0) {
      dates.add(currentDay);
      labels.add(
        currentDay.year == currentYear
            ? DateFormat.MMMMd().format(currentDay)
            : DateFormat.yMMMd().format(currentDay),
      );

      balances.add(
        AccountService.instance.getAccountsMoney(
          accountIds: widget.accountsIds,
          trFilters: widget.filters,
          date: currentDay,
        ),
      );

      currentDay = currentDay.add(Duration(days: dayRange));
    }

    return Rx.combineLatest<double, List<_FundEvolutionPoint>>(
      balances,
      (values) => List.generate(
        values.length,
        (i) => _FundEvolutionPoint(
          date: dates[i],
          value: values[i],
          label: labels[i],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _dataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget;
        }

        final points = snapshot.data ?? const <_FundEvolutionPoint>[];

        return StreamBuilder(
          stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
          builder: (context, userCurrencySnapshot) {
            return TimeSeriesEvolutionChart<_FundEvolutionPoint>(
              data: points,
              dateExtractor: (p) => p.date,
              valueExtractor: (p) => p.value,
              currency: userCurrencySnapshot.data,
              tooltipTitleBuilder: (p) => p.label,
            );
          },
        );
      },
    );
  }
}
