import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/home/widgets/dashboard_account_list.dart';
import 'package:monekin/app/home/widgets/dashboard_balance_chart.dart';
import 'package:monekin/app/home/widgets/finance_health_donut.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/edit_profile_modal.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/debug_page.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/page_content.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';
import 'package:monekin/core/presentation/widgets/dates/date_range_chips.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/evolution_card.dart';
import 'package:monekin/core/presentation/widgets/income_expense_flow_card.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/presentation/widgets/user_profile_builder.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/database/services/app-data/app_data_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

typedef _BalanceStats = ({double delta, double percentage});

class _DashboardPageState extends State<DashboardPage> {
  DatePeriodState dateRangeService = const DatePeriodState(
    datePeriod: defaultDatePeriod,
  );
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showStickyBalanceHeader = ValueNotifier(false);
  late final String _welcomeGreeting = _pickWelcomeGreeting();
  late final Stream<double> _currentBalanceStream;
  late Stream<(double, _BalanceStats)> _balanceSummaryStream;

  @override
  void initState() {
    super.initState();

    _currentBalanceStream = AccountService.instance
        .getAccountsMoney()
        .distinct()
        .shareReplay(maxSize: 1);
    _refreshBalanceSummaryStream();
    _scrollController.addListener(_updateStickyBalanceHeader);
    _loadSavedDatePeriod();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateStickyBalanceHeader);
    _scrollController.dispose();
    _showStickyBalanceHeader.dispose();
    super.dispose();
  }

  Future<void> _loadSavedDatePeriod() async {
    final savedPeriodJson = appStateData[AppDataKey.lastDashboardDatePeriod];

    if (savedPeriodJson != null) {
      try {
        final period = DatePeriod.fromJsonString(savedPeriodJson);
        if (!mounted) return;
        setState(() {
          dateRangeService = dateRangeService.copyWith(datePeriod: period);
          _refreshBalanceSummaryStream();
        });
      } catch (_) {
        // Fall back to default
      }
    }
  }

  Stream<_BalanceStats> _getBalanceStatsStream(DatePeriodState dateRange) {
    final start = dateRange.startDate;
    final end = dateRange.endDate;

    if (start == null || end == null) {
      return Stream.value((delta: 0, percentage: 0));
    }

    return Rx.combineLatest2(
      AccountService.instance.getAccountsMoney(date: start),
      AccountService.instance.getAccountsMoney(date: end),
      (double startBalance, double endBalance) {
        final delta = endBalance - startBalance;

        const eps = 1e-10;
        final percentage = startBalance.abs() < eps
            ? (endBalance.abs() < eps ? 0.0 : double.nan)
            : delta / startBalance;

        return (delta: delta, percentage: percentage);
      },
    );
  }

  void _refreshBalanceSummaryStream() {
    _balanceSummaryStream = Rx.combineLatest2(
      _currentBalanceStream,
      _getBalanceStatsStream(dateRangeService),
      (double current, _BalanceStats stats) => (current, stats),
    ).distinct().shareReplay(maxSize: 1);
  }

  void _onPeriodChanged(DatePeriod period) {
    AppDataService.instance.setItem(
      AppDataKey.lastDashboardDatePeriod,
      period.toJsonString(),
    );

    setState(() {
      dateRangeService = dateRangeService.copyWith(
        periodModifier: 0,
        datePeriod: period,
      );
      _refreshBalanceSummaryStream();
    });
  }

  void _updateStickyBalanceHeader() {
    if (!_scrollController.hasClients) return;

    final show = _scrollController.offset > 180;
    if (show != _showStickyBalanceHeader.value) {
      _showStickyBalanceHeader.value = show;
    }
  }

  Future<void> _openDatePeriodSelector() async {
    final period = await openDatePeriodModal(
      context,
      DatePeriodModal(initialDatePeriod: dateRangeService.datePeriod),
    );

    if (period != null) _onPeriodChanged(period);
  }

  Future<void> _togglePrivateMode() async {
    final privateMode =
        await PrivateModeService.instance.privateModeStream.first;

    PrivateModeService.instance.setPrivateMode(!privateMode);
    await HapticFeedback.lightImpact();

    MonekinSnackbar.success(
      SnackbarParams(
        !privateMode
            ? t.settings.security.private_mode_activated
            : t.settings.security.private_mode_deactivated,
      ),
    );
  }

  bool _isWide(BuildContext context) =>
      BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md);

  /// On very large screens the income/expense flow cards join the left column
  /// (below the accounts card) instead of spanning a full-width row, giving the
  /// right column more vertical room.
  bool _isVeryWide(BuildContext context) =>
      BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.xxl);

  @override
  Widget build(BuildContext context) {
    return PageFramework(
      title: t.home.title,
      enableAppBar: false,
      floatingActionButton: ifIsInTabs(context)
          ? null
          : NewTransactionButton(
              key: const Key('dashboard--new-transaction-button'),
              scrollController: _scrollController,
            ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 32),
              child: PageContent(child: _buildContent(context)),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ValueListenableBuilder<bool>(
                valueListenable: _showStickyBalanceHeader,
                child: _buildStickyBalanceHeader(context),
                builder: (context, showHeader, child) => IgnorePointer(
                  ignoring: !showHeader,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    offset: showHeader ? Offset.zero : const Offset(0, -1),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 120),
                      opacity: showHeader ? 1 : 0,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyBalanceHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      elevation: 3,
      shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.16),
      shape: Border(
        bottom: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.home.total_balance,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.of(context).textHint,
                    ),
                  ),
                  StreamBuilder<double>(
                    stream: _currentBalanceStream,
                    builder: (context, snapshot) => Skeletonizer(
                      enabled: !snapshot.hasData,
                      child: CurrencyDisplayer(
                        amountToConvert: snapshot.data ?? 9999,
                        integerStyle: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: FilledButton.icon(
                onPressed: _openDatePeriodSelector,
                icon: const Icon(Icons.calendar_month_rounded, size: 18),
                label: Text(
                  dateRangeService.getText(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final isWide = _isWide(context);
    final isVeryWide = _isVeryWide(context);

    final flowCards = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: IncomeExpenseFlowCard(
              type: TransactionType.expense,
              periodState: dateRangeService,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: IncomeExpenseFlowCard(
              type: TransactionType.income,
              periodState: dateRangeService,
            ),
          ),
        ],
      ),
    );

    final accountsCard = DashboardAccountList(
      dateRangeService: dateRangeService,
      maxRowsToShow: isWide ? 5 : 3,
    );
    final healthCard = FinanceHealthCard(dateRangeService: dateRangeService);
    final categoriesCard = _buildCategoriesCard(context);

    final balanceHero = _buildBalanceHero(context);

    const gutter = EdgeInsets.symmetric(horizontal: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: _buildHeader(context),
        ),
        const SizedBox(height: 20),
        // On mobile the chart runs full-bleed (its label/chips keep their inset
        // via EvolutionCard.contentInset); once decorated it sits in a card and
        // is padded to stay aligned with the rest of the content.
        if (isWide)
          Padding(padding: gutter, child: balanceHero)
        else
          balanceHero,
        const SizedBox(height: 16),
        Padding(
          padding: gutter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isVeryWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          flowCards,
                          const SizedBox(height: 16),
                          accountsCard,
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          healthCard,
                          const SizedBox(height: 16),
                          categoriesCard,
                        ],
                      ),
                    ),
                  ],
                )
              else ...[
                flowCards,
                const SizedBox(height: 16),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: accountsCard),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            healthCard,
                            const SizedBox(height: 16),
                            categoriesCard,
                          ],
                        ),
                      ),
                    ],
                  )
                else ...[
                  accountsCard,
                  const SizedBox(height: 16),
                  healthCard,
                  const SizedBox(height: 16),
                  categoriesCard,
                ],
              ],
              if (kDebugMode)
                TextButton(
                  onPressed: () => RouteUtils.pushRoute(const DebugPage()),
                  child: const Text('DEBUG PAGE'),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------- Header -------------------------

  String _pickWelcomeGreeting() {
    final timeOfDayGreeting = switch (DateTime.now().hour) {
      >= 6 && < 12 => t.home.welcome_back_morning,
      >= 12 && < 19 => t.home.welcome_back_afternoon,
      >= 19 && < 23 => t.home.welcome_back_evening,
      _ => t.home.welcome_back_night,
    };

    final greetings = [
      timeOfDayGreeting,
      t.home.welcome_back_1,
      t.home.welcome_back_2,
      t.home.welcome_back_3,
      t.home.welcome_back_4,
      t.home.welcome_back_5,
      t.home.welcome_back_6,
    ];

    return greetings[Random().nextInt(greetings.length)];
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildWelcome(context)),
        _buildPrivateModeButton(context),
      ],
    );
  }

  Widget _buildWelcome(BuildContext context) {
    return Tappable(
      bgColor: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        RouteUtils.showResponsiveSheet(
          context: context,
          builder: (context) => const EditProfileModal(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: UserProfileBuilder(
          builder: (context, userName, avatar) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserAvatar(avatar: avatar),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _welcomeGreeting,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.of(context).textHint,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Text(
                      userName ?? 'User',
                      softWrap: false,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivateModeButton(BuildContext context) {
    return Tappable(
      bgColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      shape: const CircleBorder(),
      onTap: _togglePrivateMode,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: PrivateModeService.instance.privateModeStream,
          initialData: false,
          builder: (context, snapshot) {
            return Icon(
              (snapshot.data ?? false)
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            );
          },
        ),
      ),
    );
  }

  // ---------------------- Balance hero ----------------------

  Widget _buildBalanceHero(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;

    return StreamBuilder(
      stream: _balanceSummaryStream,
      builder: (context, snapshot) {
        final current = snapshot.data?.$1 ?? 0;
        final stats = snapshot.data?.$2;

        return EvolutionCard(
          valueLabel: t.home.total_balance,
          finalValue: current,
          changeValue: snapshot.hasData ? stats?.delta : null,
          changePercentage: snapshot.hasData ? stats?.percentage : null,
          loading: !snapshot.hasData,
          chart: DashboardBalanceChart(
            dateRange: dateRangeService,
            lineColor: accent,
          ),
          currentPeriod: dateRangeService.datePeriod,
          onPresetSelected: _onPeriodChanged,
        );
      },
    );
  }

  Widget _buildCategoriesCard(BuildContext context) {
    return CardWithHeader(
      title: t.stats.by_categories,
      bodyPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
      headerAction: CardHeaderAction(
        onTap: () => RouteUtils.pushRoute(
          StatsPage(
            dateRangeService: dateRangeService,
            initialIndex: StatsTab.distribution,
          ),
        ),
      ),
      body: PieChartByCategories(datePeriodState: dateRangeService),
    );
  }
}
