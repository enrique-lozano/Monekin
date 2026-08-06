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
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';
import 'package:monekin/core/presentation/widgets/dates/date_range_chips.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
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
  late DatePeriodState _dateRange;
  _DetailTab _selectedTab = _DetailTab.movements;

  @override
  void initState() {
    super.initState();
    _dateRange = widget.dateRangeService;
  }

  void _onPeriodChanged(DatePeriod period) {
    setState(() {
      _dateRange = _dateRange.copyWith(periodModifier: 0, datePeriod: period);
    });
  }

  void _openCustomPeriodModal() {
    openDatePeriodModal(
      context,
      DatePeriodModal(initialDatePeriod: _dateRange.datePeriod),
    ).then((value) {
      if (value == null) return;
      _onPeriodChanged(value);
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
    final t = Translations.of(context);

    return StreamBuilder(
      stream: AccountService.instance.getAccountById(widget.account.id),
      initialData: widget.account,
      builder: (context, snapshot) {
        final account = snapshot.data ?? widget.account;
        final isInvestment = account.type == AccountType.investment;

        final menuActions = AccountDetailsActions.getAccountDetailsActions(
          context,
          account: account,
          navigateBackOnDelete: true,
        ).menu;

        return PageFramework(
          title: t.account.details,
          appBarActions: [
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              tooltip: t.ui_actions.edit,
              onPressed: () =>
                  RouteUtils.pushRoute(AccountFormPage(account: account)),
            ),
            if (menuActions.isNotEmpty)
              MonekinPopupMenuButton(actionItems: menuActions),
          ],
          // A SingleChildScrollView (not a ListView) is used on purpose: the
          // page mixes several StreamBuilder-backed sections and a ListView
          // would wrap each of them in a `_SelectionKeepAlive`, which
          // re-listens single-subscription streams on reactivation and
          // throws "Stream has already been listened to". Every section here
          // is bounded (the movements list is internally limited/paginated).
          //
          // The scroll view spans the full page width (rather than being
          // nested inside the centered/max-width content) so that on wide
          // screens the user can scroll from anywhere on the page, not just
          // while hovering over the centered column.
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ).withSafeBottom(context),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: BreakpointContainer(
                  lgBuilder: (context) =>
                      _buildDesktopLayout(account, isInvestment),
                  builder: (context) =>
                      _buildMobileLayout(account, isInvestment),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(Account account, bool isInvestment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildValueHeader(account, isInvestment),
        const SizedBox(height: 16),
        _buildChartSection(account),
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
  // Desktop layout: header row with inline action buttons, a combined
  // value/chart/stats card, and a two-column body (tabs+list / info card).
  // ---------------------------------------------------------------------------

  Widget _buildDesktopLayout(Account account, bool isInvestment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDesktopHeader(account, isInvestment),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildDesktopValueCard(account, isInvestment),
        ),
        const SizedBox(height: 20),
        _buildDesktopBody(account, isInvestment),
      ],
    );
  }

  Widget _buildDesktopHeader(Account account, bool isInvestment) {
    final theme = Theme.of(context);
    final actions = _resolveQuickActions(account, isInvestment);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _AccountIdentity(
              account: account,
              heroTag: widget.accountIconHeroTag ?? UniqueKey(),
              iconSize: 44,
              titleStyle: theme.textTheme.titleLarge,
              showTrackingMode: true,
            ),
          ),
          const SizedBox(width: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              for (var i = 0; i < actions.length; i++)
                _HeaderActionButton(action: actions[i], isPrimary: i == 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopValueCard(Account account, bool isInvestment) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: cardSurfaceDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildValueSection(account, isInvestment)),
              const SizedBox(width: 16),
              DateRangeChips(
                currentPeriod: _dateRange.datePeriod,
                onPresetSelected: _onPeriodChanged,
                onCustomTap: _openCustomPeriodModal,
                wrap: true,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildChartSection(account, showRangeChips: false),

          if (isInvestment) ...[
            const Divider(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildInvestmentStats(account, horizontalLayout: true),
            ),
          ] else ...[
            const SizedBox(height: 20),
            _buildIncomeExpenseStats(account),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopBody(Account account, bool isInvestment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildSegmentedSection(
            account,
            isInvestment,
            includeInfoTab: false,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildInfo(account, topGap: false),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Header: icon + name + type badge + value + period trend
  // ---------------------------------------------------------------------------

  Widget _buildValueHeader(Account account, bool isInvestment) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AccountIdentity(
            account: account,
            heroTag: widget.accountIconHeroTag ?? UniqueKey(),
            iconSize: 40,
            titleStyle: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          _buildValueSection(account, isInvestment),
        ],
      ),
    );
  }

  /// The "VALOR TOTAL" / "SALDO ACTUAL" label, big amount and trend row.
  /// Shared between the mobile header and the desktop value card.
  Widget _buildValueSection(Account account, bool isInvestment) {
    final theme = Theme.of(context);
    final endDate = _dateRange.endDate;
    final startDate = _dateRange.startDate;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isInvestment
              ? t.account.total_value.toUpperCase()
              : t.account.current_balance.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 2),
        StreamBuilder<double>(
          initialData: 0,
          stream: AccountService.instance.getAccountMoney(
            account: account,
            date: endDate,
          ),
          builder: (context, endSnapshot) {
            final endValue = endSnapshot.data ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle.merge(
                  style: theme.textTheme.headlineMedium!,
                  child: CurrencyDisplayer(
                    amountToConvert: endValue,
                    currency: account.currency,
                  ),
                ),
                const SizedBox(height: 2),
                _buildTrendRow(account, endValue, startDate),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrendRow(Account account, double endValue, DateTime? startDate) {
    // An all-time period has no starting point to compare the balance against.
    if (startDate == null) return const SizedBox.shrink();

    return StreamBuilder<double>(
      stream: AccountService.instance.getAccountMoney(
        account: account,
        date: startDate,
      ),
      builder: (context, startSnapshot) {
        if (!startSnapshot.hasData) return const SizedBox.shrink();

        final startValue = startSnapshot.data!;
        final change = endValue - startValue;
        final pct = startValue == 0 ? 0.0 : change / startValue.abs();

        return TrendingValue(
          percentage: pct,
          value: change,
          valueCurrency: account.currency,
          dataTypes: const [
            TrendingValueDataType.value,
            TrendingValueDataType.percentage,
          ],
          fontWeight: FontWeight.w600,
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Chart + range chips
  // ---------------------------------------------------------------------------

  Widget _buildChartSection(Account account, {bool showRangeChips = true}) {
    final chartRange = DateTimeRange(
      start: _dateRange.startDate ?? account.date,
      end: _dateRange.endDate ?? DateTime.now(),
    );

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FundEvolutionLineChart(
              accountsIds: [account.id],
              filters: TransactionFilterSet(accountsIDs: [account.id]),
              showYAxisTitles: false,
              timeRange: chartRange,
              loadingWidget: const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
        if (showRangeChips) ...[
          const SizedBox(height: 12),
          DateRangeChips(
            currentPeriod: _dateRange.datePeriod,
            onPresetSelected: _onPeriodChanged,
            onCustomTap: _openCustomPeriodModal,
          ),
        ],
      ],
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

  /// Resolves the account's primary quick actions (buy/sell, add/withdraw
  /// money, update snapshot, transfer...) depending on its type and tracking
  /// mode. Shared by the mobile icon-grid and the desktop header buttons.
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
              : () => RouteUtils.pushRoute(
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
              : () => RouteUtils.pushRoute(
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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _RangeAmountCard(
              account: account,
              type: TransactionType.income,
              dateRange: _dateRange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RangeAmountCard(
              account: account,
              type: TransactionType.expense,
              dateRange: _dateRange,
            ),
          ),
        ],
      ),
    );
  }

  /// [horizontalLayout] renders the composition bar/legend and the
  /// cost/P&L figures side by side (used inside the desktop value card,
  /// which already provides its own container/padding) instead of the
  /// default stacked layout wrapped in its own decorated container (used on
  /// mobile).
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

  /// [includeInfoTab] is false on desktop, where the account info is shown
  /// as a persistent card next to this section instead of behind a tab.
  Widget _buildSegmentedSection(
    Account account,
    bool isInvestment, {
    bool includeInfoTab = true,
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

    final content = switch (selected) {
      _DetailTab.movements => _buildMovements(account),
      _DetailTab.info => _buildInfo(account),
      _DetailTab.holdings =>
        account.trackingMode == AccountTrackingMode.holdings
            ? HoldingsSnapshotCard(account: account)
            : HoldingsCard(account: account),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (items.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ExpandingSegmentedTabs<_DetailTab>(
              items: items,
              selected: selected,
              onSelected: (v) => setState(() => _selectedTab = v),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: content,
        ),
      ],
    );
  }

  Widget _buildMovements(Account account) {
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
        const SizedBox(height: 16),
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

  /// [topGap] adds the spacing normally left below the tab bar. It's
  /// disabled when this card is shown standalone (e.g. the desktop sidebar),
  /// where it should align with the tab bar itself instead.
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

/// The account icon, its name and a single meta line describing it
/// (type · currency). Shared by the mobile and the desktop headers, which
/// differ in the icon size, the title style and how much fits in the meta
/// line.
class _AccountIdentity extends StatelessWidget {
  const _AccountIdentity({
    required this.account,
    required this.heroTag,
    required this.iconSize,
    required this.titleStyle,
    this.showTrackingMode = false,
  });

  final Account account;
  final Object heroTag;
  final double iconSize;
  final TextStyle? titleStyle;

  /// Only enabled on wide layouts: on a phone the meta line has no room
  /// left for it once the text is scaled up or translated.
  final bool showTrackingMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isInvestment = account.type == AccountType.investment;
    final metaColor = theme.colorScheme.outline;

    final meta = [
      account.type.title(context),
      if (isInvestment && showTrackingMode) account.trackingMode.title(context),
      account.currency.code,
    ].join(' · ');

    return Row(
      children: [
        Hero(
          tag: heroTag,
          child: account.displayIcon(context, size: iconSize),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      account.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle,
                    ),
                  ),
                  if (account.isClosed) ...[
                    const SizedBox(width: 6),
                    Tooltip(
                      message:
                          '${t.account.close_date}: ${DateFormat.yMMMd().format(account.closingDate!)}',
                      triggerMode: TooltipTriggerMode.tap,
                      child: const Icon(
                        Icons.archive_outlined,
                        size: 16,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(
                    account.type.icon,
                    size: 13,
                    color: isInvestment ? theme.colorScheme.primary : metaColor,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      meta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: metaColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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

/// Renders a [_QuickAction] as a pill-shaped button, used in the desktop
/// header next to the account name (as opposed to the icon-grid tiles used
/// by [_QuickAction] itself on mobile).
class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({required this.action, required this.isPrimary});

  final _QuickAction action;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      visualDensity: VisualDensity.compact,
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );

    final icon = Icon(action.icon, size: 18);
    final label = Text(action.label);

    if (isPrimary) {
      return FilledButton.icon(
        onPressed: action.onTap,
        style: style,
        icon: icon,
        label: label,
      );
    }

    return FilledButton.tonalIcon(
      onPressed: action.onTap,
      style: style,
      icon: icon,
      label: label,
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

class _RangeAmountCard extends StatelessWidget {
  const _RangeAmountCard({
    required this.account,
    required this.type,
    required this.dateRange,
  });

  final Account account;
  final TransactionType type;
  final DatePeriodState dateRange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIncome = type == TransactionType.income;

    final filters = TransactionFilterSet(
      accountsIDs: [account.id],
      transactionTypes: [type],
      minDate: dateRange.startDate,
      maxDate: dateRange.endDate,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (isIncome ? t.account.range_income : t.account.range_expense)
                .toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 4),
          StreamBuilder<double>(
            stream: TransactionService.instance.getTransactionsValueBalance(
              filters: filters,
              convertToPreferredCurrency: false,
            ),
            builder: (context, snapshot) {
              final value = (snapshot.data ?? 0).abs();

              return DefaultTextStyle.merge(
                style: theme.textTheme.titleLarge!,
                child: CurrencyDisplayer(
                  amountToConvert: value,
                  currency: account.currency,
                ),
              );
            },
          ),
          const SizedBox(height: 2),
          StreamBuilder<int>(
            stream: TransactionService.instance.countTransactions(
              filters: filters,
            ),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;

              return Text(
                count == 0
                    ? (isIncome
                          ? t.account.no_income_range
                          : t.account.no_expense_range)
                    : t.account.movements_count(n: count),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: count == 0
                      ? theme.colorScheme.outline
                      : (isIncome ? Colors.green : Colors.red),
                ),
              );
            },
          ),
        ],
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
