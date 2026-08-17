import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/stats/widgets/balance_bar_chart.dart';
import 'package:monekin/app/stats/widgets/finance_health_details.dart';
import 'package:monekin/app/stats/widgets/fund_evolution_info.dart';
import 'package:monekin/app/stats/widgets/income_expense_comparason.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/tags_stats.dart';
import 'package:monekin/app/stats/widgets/net_worth/net_worth_tab.dart';
import 'package:monekin/app/stats/widgets/portfolio/portfolio_composition_card.dart';
import 'package:monekin/app/stats/widgets/portfolio/portfolio_treemap_card.dart';
import 'package:monekin/app/stats/widgets/stats_cards_layout.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/segmented_calendar_button.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/filter_row_indicator.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/filter_side_pane.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_sheet_modal.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../core/models/transaction/transaction_type.enum.dart';
import '../accounts/all_accounts_balance.dart';

enum StatsTab {
  financialHealth,
  distribution,
  netWorth,
  portfolio,
  balance,
  cashFlow;

  static StatsTab fromIndex(int index) => StatsTab.values[index];

  /// Net worth and portfolio are computed from holdings/asset valuations, not
  /// from transactions, so the transaction-specific filters (category, tag,
  /// type, status, amount) don't affect them. Only the account scope applies.
  bool get usesTransactionRefinements =>
      this != StatsTab.netWorth && this != StatsTab.portfolio;
}

class StatsPage extends StatefulWidget {
  const StatsPage({
    super.key,
    this.initialIndex = StatsTab.financialHealth,
    this.filters = const TransactionFilterSet(),
    this.dateRangeService = const DatePeriodState(),
  });

  final StatsTab initialIndex;

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

  bool filterPaneExpanded = false;

  @override
  void initState() {
    super.initState();

    filters = widget.filters;
    dateRangeService = widget.dateRangeService;

    _tabController = TabController(
      length: StatsTab.values.length,
      initialIndex: widget.initialIndex.index,
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
    final isDesktopLayout = BreakPoint.of(
      context,
    ).isLargerThan(BreakpointID.md);

    // On desktop the tabs live at the top of the body (fixed, below the app
    // bar) as a segmented control instead of a swipeable TabBar.
    final segmentedTabs = !isDesktopLayout
        ? null
        : SegmentedTabBar<int>(
            selected: _tabController.index,
            onSelected: (value) => setState(() => _tabController.index = value),
            items: [
              SegmentedTabItem(
                value: StatsTab.financialHealth.index,
                icon: Icons.monitor_heart_outlined,
                label: t.financial_health.display,
              ),
              SegmentedTabItem(
                value: StatsTab.distribution.index,
                icon: Icons.pie_chart_outline_rounded,
                label: t.stats.distribution,
              ),
              SegmentedTabItem(
                value: StatsTab.netWorth.index,
                icon: Icons.account_balance_outlined,
                label: t.stats.net_worth,
              ),
              SegmentedTabItem(
                value: StatsTab.portfolio.index,
                icon: Icons.candlestick_chart_outlined,
                label: t.stats.portfolio,
              ),
              SegmentedTabItem(
                value: StatsTab.balance.index,
                icon: Icons.show_chart_rounded,
                label: t.stats.balance,
              ),
              SegmentedTabItem(
                value: StatsTab.cashFlow.index,
                icon: Icons.swap_vert_rounded,
                label: t.stats.cash_flow,
              ),
            ],
          );

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
        // Split-pane owns filtering on wide layouts; app-bar button is mobile-only.
        if (!isDesktopLayout)
          IconButton(
            onPressed: () async {
              final modalRes = await openFilterSheetModal(
                context,
                FilterSheetModal(
                  preselectedFilter: filters,
                  showDateFilter: false,
                  showTransactionRefinements: StatsTab.fromIndex(
                    _tabController.index,
                  ).usesTransactionRefinements,
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
      tabBar: isDesktopLayout
          ? null
          : TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              controller: _tabController,
              tabs: [
                Tab(text: t.financial_health.display),
                Tab(text: t.stats.distribution),
                Tab(text: t.stats.net_worth),
                Tab(text: t.stats.portfolio),
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

      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                ?segmentedTabs,
                if (filters.hasFilter && !isDesktopLayout) ...[
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
                    physics: isDesktopLayout
                        ? const NeverScrollableScrollPhysics()
                        : null,
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
                        StatsCardsLayout(
                          cards: [
                            CardWithHeader(
                              title: t.stats.by_categories,
                              body: PieChartByCategories(
                                datePeriodState: dateRangeService,
                                showList: true,
                                initialSelectedType: TransactionType.expense,
                                filters: filters,
                              ),
                            ),
                            CardWithHeader(
                              title: t.stats.by_tags,
                              body: TagStats(
                                filters: filters.copyWith(
                                  minDate: dateRangeService.startDate,
                                  maxDate: dateRangeService.endDate,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                      buildContainerWithPadding([
                        NetWorthTab(
                          dateRangeService: dateRangeService,
                          filters: filters,
                        ),
                      ]),
                      buildContainerWithPadding([
                        StatsCardsLayout(
                          cards: [
                            CardWithHeader(
                              title: t.stats.portfolio_composition,
                              subtitle: t.stats.portfolio_composition_subtitle,
                              bodyPadding: const EdgeInsets.only(
                                bottom: 12,
                                top: 16,
                                right: 16,
                                left: 16,
                              ),
                              body: PortfolioCompositionCard(
                                date:
                                    dateRangeService.endDate ?? DateTime.now(),
                                filters: filters,
                              ),
                            ),
                            CardWithHeader(
                              title: t.stats.portfolio_heat_map,
                              subtitle: t.stats.portfolio_heat_map_subtitle,
                              bodyPadding: const EdgeInsets.all(16),
                              body: PortfolioTreemapCard(
                                date:
                                    dateRangeService.endDate ?? DateTime.now(),
                                filters: filters,
                              ),
                            ),
                          ],
                        ),
                      ]),
                      buildContainerWithPadding([
                        StatsCardsLayout(
                          cards: [
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
                            AllAccountBalancePage(
                              date: dateRangeService.endDate ?? DateTime.now(),
                              filters: filters,
                            ),
                          ],
                        ),
                      ]),
                      buildContainerWithPadding([
                        StatsCardsLayout(
                          cards: [
                            CardWithHeader(
                              title: t.stats.cash_flow,
                              subtitle: t.stats.cash_flow_subtitle,
                              body: IncomeExpenseComparason(
                                startDate: dateRangeService.startDate,
                                endDate: dateRangeService.endDate,
                                filters: filters,
                              ),
                            ),
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
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isDesktopLayout)
            // Rebuild the pane when the active tab changes so it can adapt its
            // facets (and the "inapplicable filters" notice) to the tab.
            AnimatedBuilder(
              animation: _tabController,
              builder: (context, _) {
                return FilterSidePane(
                  filters: filters,
                  onChanged: (newFilters) {
                    setState(() {
                      filters = newFilters;
                    });
                  },
                  expanded: filterPaneExpanded,
                  onToggle: () {
                    setState(() {
                      filterPaneExpanded = !filterPaneExpanded;
                    });
                  },
                  showDateFilter: false,
                  showTransactionRefinements: StatsTab.fromIndex(
                    _tabController.index,
                  ).usesTransactionRefinements,
                );
              },
            ),
        ],
      ),
    );
  }
}
