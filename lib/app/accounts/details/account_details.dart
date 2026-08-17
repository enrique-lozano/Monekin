import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/details/account_details_actions.dart';
import 'package:monekin/app/accounts/details/account_snapshots.dart';
import 'package:monekin/app/accounts/details/holdings_card.dart';
import 'package:monekin/app/accounts/details/holdings_snapshot_card.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/stats/widgets/fund_evolution_info.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/app/transactions/list/transactions.page.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/page_content.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/date_range_chips.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/evolution_card.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/income_expense_flow_card.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/label_value_info_list.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

enum _DetailTab { movements, info, holdings }

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({
    super.key,
    required this.account,
    required this.accountIconHeroTag,
    this.dateRangeService = const DatePeriodState(
      datePeriod: defaultDatePeriod,
    ),
  });

  final Account account;

  final Object? accountIconHeroTag;
  final DatePeriodState dateRangeService;

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double?> _hoveredValue = ValueNotifier(null);
  late DatePeriodState _dateRange;
  _DetailTab _selectedTab = _DetailTab.movements;

  @override
  void initState() {
    super.initState();
    _dateRange = widget.dateRangeService;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hoveredValue.dispose();
    super.dispose();
  }

  void _onPeriodChanged(DatePeriod period) {
    _hoveredValue.value = null;
    setState(() {
      _dateRange = _dateRange.copyWith(periodModifier: 0, datePeriod: period);
    });
  }

  LabelValueInfoListItem _buildCopyableTile(String title, String value) {
    return LabelValueInfoListItem(
      label: title,
      value: Text(value, softWrap: false, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: value))
              .then((_) {
                MonekinSnackbar.success(
                  SnackbarParams(t.general.clipboard.success(x: title)),
                );
              })
              .catchError((_) {
                MonekinSnackbar.error(
                  SnackbarParams(t.general.clipboard.error),
                );
              });
        },
        icon: const Icon(Icons.copy_rounded),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AccountService.instance.getAccountById(widget.account.id),
      initialData: widget.account,
      builder: (context, snapshot) {
        final account = snapshot.data ?? widget.account;
        final isInvestment = account.type == AccountType.investment;
        final isWide = BreakPoint.of(
          context,
        ).isLargerOrEqualTo(BreakpointID.lg);

        return PageFramework(
          title: account.name,
          subtitle: Text(
            [
              if (account.groupName != null) account.groupName!,
              account.type.title(context),
              account.currency.code,
            ].join(' · '),
          ),
          icon: Hero(
            tag: widget.accountIconHeroTag ?? UniqueKey(),
            child: account.displayIcon(context),
          ),
          appBarActions: _buildAppBarActions(
            account,
            isInvestment,
            wide: isWide,
          ),
          // Not ListView: keep-alive would re-listen single-subscription streams.
          body: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ).withSafeBottom(context),
            child: PageContent(
              child: BreakpointContainer(
                lgBuilder: (context) =>
                    _buildDesktopLayout(account, isInvestment),
                builder: (context) => _buildMobileLayout(account, isInvestment),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildAppBarActions(
    Account account,
    bool isInvestment, {
    required bool wide,
  }) {
    final menuActions = AccountDetailsActions.getAccountDetailsActions(
      context,
      account: account,
      navigateBackOnDelete: true,
    ).menu;

    return [
      if (wide) ...[
        for (final action in _resolveQuickActions(account, isInvestment))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton.icon(
              onPressed: action.onTap,
              icon: Icon(action.icon, size: 18, color: action.color),
              label: Text(action.label),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                side: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outlineVariant.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        const SizedBox(width: 8),
        SizedBox(
          height: 24,
          child: VerticalDivider(
            width: 1,
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(width: 8),
      ],
      IconButton(
        icon: const Icon(Icons.edit_rounded),
        tooltip: t.ui_actions.edit,
        onPressed: () =>
            RouteUtils.showResponsiveForm(AccountFormPage(account: account)),
      ),
      if (menuActions.isNotEmpty)
        MonekinPopupMenuButton(actionItems: menuActions),
    ];
  }

  Widget _buildMobileLayout(Account account, bool isInvestment) {
    final evolutionCard = _buildEvolutionCard(account, isInvestment);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: evolutionCard,
          )
        else
          evolutionCard,
        const SizedBox(height: 20),
        _buildQuickActions(account, isInvestment),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: isInvestment
              ? _buildInvestmentStats(account)
              : _buildIncomeExpenseStats(account),
        ),
        const SizedBox(height: 20),
        _buildSegmentedSection(account, isInvestment),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Desktop layout: an 8/4 grid with account activity and supporting details.
  // ---------------------------------------------------------------------------

  Widget _buildDesktopLayout(Account account, bool isInvestment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildEvolutionCard(
                account,
                isInvestment,
                footer: isInvestment
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _buildInvestmentStats(
                          account,
                          horizontalLayout: true,
                        ),
                      )
                    : null,
              ),
              if (!isInvestment) ...[
                const SizedBox(height: 16),
                _buildIncomeExpenseStats(account),
              ],
              const SizedBox(height: 16),
              if (isInvestment)
                _buildSegmentedSection(
                  account,
                  isInvestment,
                  includeInfoTab: false,
                  horizontalPadding: 0,
                )
              else
                _buildMovements(account, topGap: false),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfo(account, topGap: false),
              if (!isInvestment) ...[
                const SizedBox(height: 16),
                CardWithHeader(
                  title: t.stats.by_categories,
                  subtitle: _dateRange.getText(context),
                  bodyPadding: const EdgeInsets.only(bottom: 12),
                  body: PieChartByCategories(
                    datePeriodState: _dateRange,
                    filters: TransactionFilterSet(accountsIDs: [account.id]),
                    showList: true,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEvolutionCard(
    Account account,
    bool isInvestment, {
    Widget? footer,
  }) {
    return StreamBuilder<({double endValue, double? startValue})>(
      initialData: (endValue: 0, startValue: null),
      stream: _watchAccountValues(account),
      builder: (context, snapshot) {
        final values = snapshot.data!;

        return EvolutionCard(
          valueLabel: isInvestment
              ? t.account.total_value
              : t.account.current_balance,
          initialValue: values.startValue,
          finalValue: values.endValue,
          highlightedValue: _hoveredValue,
          currency: account.currency,
          chart: _buildEvolutionChart(account),
          currentPeriod: _dateRange.datePeriod,
          onPresetSelected: _onPeriodChanged,
          footer: footer,
        );
      },
    );
  }

  Stream<({double endValue, double? startValue})> _watchAccountValues(
    Account account,
  ) {
    final startDate = _dateRange.startDate;
    final endDate = _dateRange.endDate;

    if (startDate == null) {
      return AccountService.instance
          .getAccountMoney(account: account, date: endDate)
          .map((endValue) => (endValue: endValue, startValue: null));
    }

    return Rx.combineLatest2(
      AccountService.instance.getAccountMoney(account: account, date: endDate),
      AccountService.instance.getAccountMoney(
        account: account,
        date: startDate,
      ),
      (double endValue, double startValue) =>
          (endValue: endValue, startValue: startValue),
    );
  }

  Widget _buildEvolutionChart(Account account) {
    final chartRange = DateTimeRange(
      start: _dateRange.startDate ?? account.date,
      end: _dateRange.endDate ?? DateTime.now(),
    );

    return FundEvolutionLineChart(
      accountsIds: [account.id],
      filters: TransactionFilterSet(accountsIDs: [account.id]),
      showYAxisTitles: false,
      expand: true,
      timeRange: chartRange,
      loadingWidget: const Center(child: CircularProgressIndicator()),
      onHover: (point) => _hoveredValue.value = point?.value,
    );
  }

  // ---------------------------------------------------------------------------
  // Quick actions
  // ---------------------------------------------------------------------------

  Widget _buildQuickActions(Account account, bool isInvestment) {
    final actions = _resolveQuickActions(account, isInvestment);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < actions.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(child: actions[i]),
          ],
        ],
      ),
    );
  }

  /// Resolves quick actions shared by the mobile grid and desktop app bar.
  List<_QuickAction> _resolveQuickActions(Account account, bool isInvestment) {
    final disabled = account.isClosed;

    final List<_QuickAction> actions;

    if (!isInvestment) {
      actions = [
        _QuickAction(
          icon: Icons.add_rounded,
          label: t.account.add_money,
          color: Colors.green,
          onTap: disabled
              ? null
              : () => RouteUtils.showResponsiveForm(
                  TransactionFormPage(
                    mode: TransactionType.income,
                    fromAccount: account,
                  ),
                ),
        ),
        _QuickAction(
          icon: Icons.remove_rounded,
          label: t.account.withdraw_money,
          color: Colors.red,
          onTap: disabled
              ? null
              : () => RouteUtils.showResponsiveForm(
                  TransactionFormPage(
                    mode: TransactionType.expense,
                    fromAccount: account,
                  ),
                ),
        ),
        _QuickAction(
          icon: TransactionType.transfer.icon,
          label: t.transfer.create,
          onTap: disabled
              ? null
              : () => AccountDetailsActions.navigateToTransferOrWarn(
                  context,
                  fromAccount: account,
                ),
        ),
      ];
    } else if (account.trackingMode == AccountTrackingMode.holdings) {
      actions = [
        _QuickAction(
          icon: Icons.published_with_changes_rounded,
          label: t.assets.holdings.snapshots.update,
          color: Theme.of(context).colorScheme.primary,
          onTap: disabled ? null : () => _updateSnapshot(account),
        ),
        _QuickAction(
          icon: Icons.add_rounded,
          label: t.account.add_money,
          onTap: disabled
              ? null
              : () => AccountDetailsActions.navigateToTransferOrWarn(
                  context,
                  toAccount: account,
                ),
        ),
        _QuickAction(
          icon: Icons.remove_rounded,
          label: t.account.withdraw_money,
          onTap: disabled
              ? null
              : () => AccountDetailsActions.navigateToTransferOrWarn(
                  context,
                  fromAccount: account,
                ),
        ),
      ];
    } else {
      actions = [
        _QuickAction(
          icon: Icons.add_rounded,
          label: t.assets.holdings.buy,
          color: Colors.green,
          onTap: disabled ? null : () => _startTrade(account, isBuy: true),
        ),
        _QuickAction(
          icon: Icons.remove_rounded,
          label: t.assets.holdings.sell,
          color: Colors.red,
          onTap: disabled ? null : () => _startTrade(account, isBuy: false),
        ),
        _QuickAction(
          icon: Icons.account_balance_wallet_rounded,
          label: t.account.add_money,
          onTap: disabled
              ? null
              : () => AccountDetailsActions.navigateToTransferOrWarn(
                  context,
                  toAccount: account,
                ),
        ),
      ];
    }

    return actions;
  }

  Future<void> _startTrade(Account account, {required bool isBuy}) async {
    final security = await showSecurityPicker(context);
    if (security == null || !mounted) return;

    await showTradeSheet(
      context,
      account: account,
      security: security,
      isBuy: isBuy,
    );
  }

  Future<void> _updateSnapshot(Account account) async {
    final current = await HoldingService.instance
        .getEffectiveSnapshot(account.id)
        .first;

    if (!mounted) return;

    await showPortfolioSnapshotEditor(
      context,
      account: account,
      snapshotToEdit: current,
      prefillPositions: current?.positions,
    );
  }

  // ---------------------------------------------------------------------------
  // Range stats
  // ---------------------------------------------------------------------------

  Widget _buildIncomeExpenseStats(Account account) {
    final filters = TransactionFilterSet(accountsIDs: [account.id]);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: IncomeExpenseFlowCard(
              type: TransactionType.income,
              periodState: _dateRange,
              filters: filters,
              currency: account.currency,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: IncomeExpenseFlowCard(
              type: TransactionType.expense,
              periodState: _dateRange,
              filters: filters,
              currency: account.currency,
            ),
          ),
        ],
      ),
    );
  }

  /// Side-by-side composition + cost/P&L on desktop; stacked card on mobile.
  Widget _buildInvestmentStats(
    Account account, {
    bool horizontalLayout = false,
  }) {
    final theme = Theme.of(context);
    final endDate = _dateRange.endDate;

    return StreamBuilder<(double total, List<HoldingValuationAtDate> vals)>(
      stream: Rx.combineLatest2(
        AccountService.instance.getAccountMoney(
          account: account,
          date: endDate,
        ),
        HoldingService.instance.getHoldingValuationsAtDate(endDate),
        (total, vals) => (total, vals),
      ),
      builder: (context, snapshot) {
        final total = snapshot.data?.$1 ?? 0;
        final vals = (snapshot.data?.$2 ?? [])
            .where((v) => v.accountId == account.id)
            .toList();

        final market = vals.fold<double>(0, (s, v) => s + v.market);
        final cost = vals.fold<double>(0, (s, v) => s + v.cost);
        final positionsCount = vals.where((v) => v.market != 0).length;
        final cash = total - market;
        final pnl = market - cost;
        final pnlPct = cost == 0 ? 0.0 : pnl / cost;

        final ratioAndLegend = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RatioBar(
              investments: market < 0 ? 0 : market,
              cash: cash < 0 ? 0 : cash,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  _LegendDot(color: theme.colorScheme.primary),
                  const SizedBox(width: 4),
                  Text(t.account.investments, style: theme.textTheme.bodySmall),
                  const SizedBox(width: 4),
                  CurrencyDisplayer(
                    amountToConvert: market,
                    currency: account.currency,
                    integerStyle: theme.textTheme.bodySmall!,
                  ),
                  const Spacer(),
                  _LegendDot(color: theme.colorScheme.outline),
                  const SizedBox(width: 4),
                  Text(t.account.cash, style: theme.textTheme.bodySmall),
                  const SizedBox(width: 4),
                  CurrencyDisplayer(
                    amountToConvert: cash,
                    currency: account.currency,
                    integerStyle: theme.textTheme.bodySmall!,
                  ),
                ],
              ),
            ),
          ],
        );

        final costColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatLabel(
              label: t.account.total_cost.toUpperCase(),
              tooltip: t.account.total_cost_help,
            ),
            const SizedBox(height: 2),
            DefaultTextStyle.merge(
              style: theme.textTheme.titleMedium!,
              child: CurrencyDisplayer(
                amountToConvert: cost,
                currency: account.currency,
              ),
            ),
            Text(
              t.assets.holdings.snapshots.positions_count(n: positionsCount),
              style: theme.textTheme.bodySmall,
            ),
          ],
        );

        final pnlColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatLabel(
              label: t.assets.securities.unrealized_pnl.toUpperCase(),
              tooltip: t.account.unrealized_pnl_help,
            ),
            const SizedBox(height: 2),
            TrendingValue(
              percentage: pnlPct,
              value: pnl,
              valueCurrency: account.currency,
              dataTypes: const [TrendingValueDataType.value],
              fontSize: theme.textTheme.titleMedium!.fontSize!,
              fontWeight: FontWeight.w600,
            ),
            TrendingValue(
              percentage: pnlPct,
              dataTypes: const [TrendingValueDataType.percentage],
              fontSize: theme.textTheme.bodySmall!.fontSize!,
            ),
          ],
        );

        if (horizontalLayout) {
          final divider = VerticalDivider(
            width: 33,
            thickness: 1,
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
          );

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ratioAndLegend,
                  ),
                ),
                divider,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: costColumn,
                  ),
                ),
                divider,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: pnlColumn,
                  ),
                ),
              ],
            ),
          );
        }

        final costAndPnl = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: costColumn),
            const SizedBox(width: 12),
            Expanded(child: pnlColumn),
          ],
        );

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ratioAndLegend,
              ),
              const Divider(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: costAndPnl,
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Segmented section: movements / info / holdings
  // ---------------------------------------------------------------------------

  /// [includeInfoTab] is false on desktop when info is a persistent sidebar card.
  Widget _buildSegmentedSection(
    Account account,
    bool isInvestment, {
    bool includeInfoTab = true,
    double horizontalPadding = 16,
  }) {
    if (!isInvestment && _selectedTab == _DetailTab.holdings) {
      _selectedTab = _DetailTab.movements;
    }

    final selected = (!includeInfoTab && _selectedTab == _DetailTab.info)
        ? _DetailTab.movements
        : _selectedTab;

    final items = <SegmentedTabItem<_DetailTab>>[
      SegmentedTabItem(
        value: _DetailTab.movements,
        icon: Icons.swap_vert_rounded,
        label: t.account.tabs.movements,
      ),
      if (includeInfoTab)
        SegmentedTabItem(
          value: _DetailTab.info,
          icon: Icons.info_outline_rounded,
          label: t.account.tabs.info,
        ),
      if (isInvestment)
        SegmentedTabItem(
          value: _DetailTab.holdings,
          icon: Icons.account_balance_wallet_outlined,
          label: t.assets.holdings.title,
        ),
    ];

    final showTabs = items.length > 1;

    final content = switch (selected) {
      _DetailTab.movements => _buildMovements(account, topGap: showTabs),
      _DetailTab.info => _buildInfo(account),
      _DetailTab.holdings =>
        account.trackingMode == AccountTrackingMode.holdings
            ? HoldingsSnapshotCard(account: account)
            : HoldingsCard(account: account),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTabs)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ExpandingSegmentedTabs<_DetailTab>(
              items: items,
              selected: selected,
              onSelected: (v) => setState(() => _selectedTab = v),
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: content,
        ),
      ],
    );
  }

  /// [topGap] is false when shown without tabs, to align with the sidebar.
  Widget _buildMovements(Account account, {bool topGap = true}) {
    const transactionsToShow = 8;

    final filters = TransactionFilterSet(
      status: TransactionStatus.notIn({
        TransactionStatus.pending,
        TransactionStatus.voided,
      }),
      accountsIDs: [account.id],
    );

    return Column(
      children: [
        if (topGap) const SizedBox(height: 16),
        CardWithHeader(
          title: t.home.last_transactions,
          bodyPadding: const EdgeInsets.symmetric(vertical: 6),
          footer: StreamBuilder(
            stream: TransactionService.instance.countTransactions(
              filters: filters,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data! < transactionsToShow) {
                return const SizedBox.shrink();
              }

              return CardFooterWithSingleButton(
                onButtonClick: () {
                  RouteUtils.pushRoute(
                    TransactionsPage(
                      filters: TransactionFilterSet(accountsIDs: [account.id]),
                    ),
                  );
                },
              );
            },
          ),
          body: TransactionListComponent(
            tileBuilder: (transaction) => TransactionListTile(
              transaction: transaction,
              showAccount: false,
              heroTag: 'account-details-page__tr-icon-${transaction.id}',
            ),
            filters: filters,
            limit: transactionsToShow,
            showGroupDivider: false,
            onEmptyList: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                t.transaction.list.empty,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// [topGap] is false when shown without tabs, to align with the sidebar.
  Widget _buildInfo(Account account, {bool topGap = true}) {
    return Column(
      children: [
        if (topGap) const SizedBox(height: 16),
        CardWithHeader(
          title: t.account.tabs.info,
          body: LabelValueInfoList(
            items: [
              LabelValueInfoListItem(
                value: Text(
                  DateFormat.yMMMMEEEEd().add_Hm().format(account.date),
                ),
                label: t.account.date,
              ),
              if (account.isClosed)
                LabelValueInfoListItem(
                  label: t.account.close_date,
                  value: Text(
                    DateFormat.yMMMMEEEEd().add_Hm().format(
                      account.closingDate!,
                    ),
                  ),
                ),
              LabelValueInfoListItem(
                label: t.account.types.title,
                value: Text(account.type.title(context)),
                trailing: Icon(account.type.icon, size: 22),
              ),
              LabelValueInfoListItem(
                label: t.currencies.currency,
                value: Text(
                  '${account.currency.code} · ${account.currency.name}',
                ),
                trailing: ClipOval(
                  child: Currency.fromDB(
                    currencyInDB: account.currency,
                  ).displayFlagIcon(size: 24),
                ),
              ),
              if (account.iban != null)
                _buildCopyableTile(t.account.form.iban, account.iban!),
              if (account.swift != null)
                _buildCopyableTile(t.account.form.swift, account.swift!),
              if (account.description != null)
                LabelValueInfoListItem(
                  label: t.account.form.notes,
                  value: Text(account.description!),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Small building blocks
// ---------------------------------------------------------------------------

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = onTap != null;
    final accent = color ?? theme.colorScheme.onSurface;

    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            child: Column(
              children: [
                Icon(icon, color: accent, size: 24),
                const SizedBox(height: 6),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// A small stat title with an info icon that reveals [tooltip] on tap/hover.
class _StatLabel extends StatelessWidget {
  const _StatLabel({required this.label, required this.tooltip});

  final String label;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.outline;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(color: color),
          ),
        ),
        const SizedBox(width: 3),
        Tooltip(
          message: tooltip,
          triggerMode: TooltipTriggerMode.tap,
          showDuration: const Duration(seconds: 8),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Icon(Icons.info_outline_rounded, size: 13, color: color),
        ),
      ],
    );
  }
}

class _RatioBar extends StatelessWidget {
  const _RatioBar({required this.investments, required this.cash});

  final double investments;
  final double cash;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = investments + cash;

    final investFlex = total == 0 ? 1 : (investments / total * 1000).round();
    final cashFlex = total == 0 ? 1 : (cash / total * 1000).round();

    return ClipRRect(
      borderRadius: BorderRadius.circular(99999),
      child: Container(
        color: Colors.red.withValues(alpha: 0.2),
        height: 12,
        child: Row(
          children: [
            Expanded(
              flex: investFlex == 0 ? 1 : investFlex,
              child: Container(color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 2),
            Expanded(
              flex: cashFlex == 0 ? 1 : cashFlex,
              child: Container(color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}

class ArchiveWarnDialog extends StatefulWidget {
  const ArchiveWarnDialog({
    super.key,
    required this.currentBalance,
    required this.account,
  });

  final double currentBalance;
  final Account account;

  @override
  State<ArchiveWarnDialog> createState() => _ArchiveWarnDialogState();
}

class _ArchiveWarnDialogState extends State<ArchiveWarnDialog> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TransactionService.instance.countTransactions(
        filters: TransactionFilterSet(
          accountsIDs: [widget.account.id],
          minDate: date,
        ),
        convertToPreferredCurrency: false,
      ),
      builder: (context, snapshot) {
        final hasNoTransactions = !snapshot.hasData || snapshot.data! == 0;

        return ModalContainer(
          title: t.account.close.title,
          footer: BottomSheetFooter(
            submitText: t.ui_actions.continue_text,
            submitIcon: Icons.check,
            onSaved: !hasNoTransactions || widget.currentBalance != 0
                ? null
                : () {
                    AccountService.instance
                        .updateAccount(
                          widget.account.copyWith(
                            closingDate: drift.Value(date),
                          ),
                        )
                        .then((value) {
                          RouteUtils.popRoute(true);

                          MonekinSnackbar.success(
                            SnackbarParams(t.account.close.success),
                          );
                        })
                        .catchError((err) {
                          RouteUtils.popRoute();

                          MonekinSnackbar.error(SnackbarParams.fromError(err));
                        });
                  },
          ),
          bodyPadding: const EdgeInsets.symmetric(horizontal: 16),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(t.account.close.warn),
              const SizedBox(height: 22),
              DateTimeFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.event),
                  labelText: '${t.account.close_date} *',
                ),
                initialDate: date,
                firstDate: widget.account.date,
                lastDate: DateTime.now(),
                dateFormat: DateFormat.yMMMd().add_jm(),
                validator: (e) =>
                    e == null ? t.general.validations.required : null,
                onDateSelected: (DateTime value) {
                  setState(() {
                    date = value;
                  });
                },
              ),
              if (!hasNoTransactions || widget.currentBalance != 0) ...[
                const SizedBox(height: 12),
                InlineInfoCard(
                  mode: InlineInfoCardMode.warn,
                  text: widget.currentBalance != 0
                      ? t.account.close.should_have_zero_balance
                      : t.account.close.should_have_no_transactions,
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
