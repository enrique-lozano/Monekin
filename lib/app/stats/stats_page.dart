import 'package:flutter/material.dart';
import 'package:monekin/app/stats/footer_segmented_calendar_button.dart';
import 'package:monekin/app/stats/widgets/balance_bar_chart.dart';
import 'package:monekin/app/stats/widgets/finance_health_details.dart';
import 'package:monekin/app/stats/widgets/fund_evolution_line_chart.dart';
import 'package:monekin/app/stats/widgets/income_expense_comparason.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/chart_by_categories.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/tags_stats.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/filter_row_indicator.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/filter_sheet_modal.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/services/filters/date_range_service.dart';
import '../accounts/all_accounts_balance.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final dateRangeService = DateRangeService();
  final accountService = AccountService.instance;

  late DateTime? currentStartDate;

  late DateTime? currentEndDate;

  late DateRange currentDateRange;

  TransactionFilters filters = const TransactionFilters();

  @override
  void initState() {
    super.initState();

    final dates = dateRangeService.getDateRange(0);

    currentStartDate = dates[0];
    currentEndDate = dates[1];
    currentDateRange = dateRangeService.selectedDateRange;
  }

  Widget buildContainerWithPadding(
    List<Widget> children, {
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  }) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DefaultTabController(
      initialIndex: widget.initialIndex,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.stats.title),
          actions: [
            IconButton(
                onPressed: () async {
                  final modalRes = await openFilterSheetModal(
                    context,
                    FilterSheetModal(
                      preselectedFilter: filters,
                      showDateFilter: false,
                    ),
                  );

                  if (modalRes != null) {
                    setState(() {
                      filters = modalRes;
                    });
                  }
                },
                icon: const Icon(Icons.filter_alt_outlined)),
          ],
          bottom: TabBar(tabs: [
            Tab(text: t.financial_health.display),
            Tab(text: t.stats.distribution),
            Tab(text: t.stats.balance),
            Tab(text: t.stats.cash_flow),
          ], isScrollable: true),
        ),
        persistentFooterButtons: [
          FooterSegmentedCalendarButton(
            onDateRangeChanged: (newStartDate, newEndDate, newDateRange) {
              setState(() {
                currentStartDate = newStartDate;
                currentEndDate = newEndDate;
                currentDateRange = newDateRange;
              });
            },
          )
        ],
        body: Column(
          children: [
            if (filters.hasFilter) ...[
              FilterRowIndicator(
                filters: filters,
                onChange: (newFilters) {
                  setState(() {
                    filters = newFilters;
                  });
                },
              ),
              const Divider()
            ],
            Expanded(
              child: TabBarView(children: [
                buildContainerWithPadding(
                  [
                    FinanceHealthDetails(
                      filters: filters.copyWith(
                          minDate: currentStartDate, maxDate: currentEndDate),
                    )
                  ],
                ),
                buildContainerWithPadding([
                  CardWithHeader(
                    title: t.stats.by_categories,
                    body: ChartByCategories(
                      startDate: currentStartDate,
                      endDate: currentEndDate,
                      showList: true,
                      initialSelectedType: TransactionType.expense,
                      filters: filters,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CardWithHeader(
                    title: t.stats.by_tags,
                    body: TagStats(
                      filters: filters.copyWith(
                        minDate: currentStartDate,
                        maxDate: currentEndDate,
                      ),
                    ),
                  ),
                ]),
                buildContainerWithPadding([
                  CardWithHeader(
                    title: t.stats.balance_evolution,
                    body: FundEvolutionLineChart(
                      showBalanceHeader: true,
                      startDate: currentStartDate,
                      endDate: currentEndDate,
                      dateRange: currentDateRange,
                      filters: filters,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AllAccountBalancePage(
                    date: currentEndDate ?? DateTime.now(),
                    filters: filters,
                  ),
                ]),
                buildContainerWithPadding([
                  CardWithHeader(
                    title: t.stats.cash_flow,
                    body: IncomeExpenseComparason(
                      startDate: currentStartDate,
                      endDate: currentEndDate,
                      filters: filters,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CardWithHeader(
                    title: t.stats.by_periods,
                    body: Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 16),
                      child: BalanceBarChart(
                        startDate: currentStartDate,
                        endDate: currentEndDate,
                        dateRange: currentDateRange,
                        filters: filters,
                      ),
                    ),
                  )
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
