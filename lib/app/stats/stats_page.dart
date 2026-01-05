import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/stats/widgets/balance_bar_chart.dart';
import 'package:monekin/app/stats/widgets/finance_health_details.dart';
import 'package:monekin/app/stats/widgets/fund_evolution_info.dart';
import 'package:monekin/app/stats/widgets/income_expense_comparason.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/tags_stats.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/segmented_calendar_button.dart';
import 'package:monekin/core/presentation/widgets/filter_row_indicator.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_sheet_modal.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../core/models/transaction/transaction_type.enum.dart';
import '../accounts/all_accounts_balance.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({
    super.key,
    this.initialIndex = 0,
    this.filters = const TransactionFilterSet(),
    this.dateRangeService = const DatePeriodState(),
  });

  final int initialIndex;

  final TransactionFilterSet filters;
  final DatePeriodState dateRangeService;

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  final accountService = AccountService.instance;

  late TransactionFilterSet filters;
  late DatePeriodState dateRangeService;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    filters = widget.filters;
    dateRangeService = widget.dateRangeService;

    _tabController = TabController(
      length: 4,
      initialIndex: widget.initialIndex,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildContainerWithPadding(
    List<Widget> children, {
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 16,
    ),
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

    return PageFramework(
      title: t.stats.title,
      appBarActions: [
        if (BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md)) ...[
          SizedBox(
            width: 300,
            child: SegmentedCalendarButton(
              initialDatePeriodService: dateRangeService,
              borderRadius: 499,
              buttonHeight: 32,
              onChanged: (value) {
                setState(() {
                  dateRangeService = value;
                });
              },
            ),
          ),
          const SizedBox(width: 12),
        ],
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
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ],
      tabBar: TabBar(
        tabAlignment: BreakPoint.of(context).isSmallerThan(BreakpointID.md)
            ? TabAlignment.center
            : TabAlignment.start,
        isScrollable: true,
        controller: _tabController,
        tabs: [
          Tab(text: t.financial_health.display),
          Tab(text: t.stats.distribution),
          Tab(text: t.stats.balance),
          Tab(text: t.stats.cash_flow),
        ],
      ),
      persistentFooterButtons:
          BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md)
          ? null
          : [
              PersistentFooterButton(
                child: SegmentedCalendarButton(
                  initialDatePeriodService: dateRangeService,
                  borderRadius: 8,
                  buttonHeight: 44,
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onChanged: (value) {
                    setState(() {
                      dateRangeService = value;
                    });
                  },
                ),
              ),
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
            const Divider(),
          ],
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildContainerWithPadding([
                  FinanceHealthDetails(
                    filters: filters.copyWith(
                      minDate: dateRangeService.startDate,
                      maxDate: dateRangeService.endDate,
                    ),
                  ),
                ]),
                buildContainerWithPadding([
                  CardWithHeader(
                    title: t.stats.by_categories,
                    body: PieChartByCategories(
                      datePeriodState: dateRangeService,
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
                        minDate: dateRangeService.startDate,
                        maxDate: dateRangeService.endDate,
                      ),
                    ),
                  ),
                ]),
                buildContainerWithPadding([
                  CardWithHeader(
                    title: t.stats.balance_evolution,
                    subtitle: t.stats.balance_evolution_subtitle,
                    bodyPadding: const EdgeInsets.only(
                      bottom: 12,
                      top: 16,
                      right: 16,
                      left: 16,
                    ),
                    body: FundEvolutionInfo(
                      showBalanceHeader: true,
                      dateRange: dateRangeService,
                      filters: filters,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AllAccountBalancePage(
                    date: dateRangeService.endDate ?? DateTime.now(),
                    filters: filters,
                  ),
                ]),
                buildContainerWithPadding([
                  CardWithHeader(
                    title: t.stats.cash_flow,
                    subtitle: t.stats.cash_flow_subtitle,
                    body: IncomeExpenseComparason(
                      startDate: dateRangeService.startDate,
                      endDate: dateRangeService.endDate,
                      filters: filters,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CardWithHeader(
                    title: t.stats.by_periods,
                    bodyPadding: const EdgeInsets.only(
                      bottom: 12,
                      top: 24,
                      right: 16,
                    ),
                    body: BalanceBarChart(
                      dateRange: dateRangeService,
                      filters: filters,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
