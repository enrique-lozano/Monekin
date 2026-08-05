import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/home/widgets/dashboard_account_list.dart';
import 'package:monekin/app/home/widgets/dashboard_balance_chart.dart';
import 'package:monekin/app/home/widgets/dashboard_flow_card.dart';
import 'package:monekin/app/home/widgets/finance_health_donut.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/edit_profile_modal.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/debug_page.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';
import 'package:monekin/core/presentation/widgets/dates/date_range_chips.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
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
  late final String _welcomeGreeting = _pickWelcomeGreeting();

  @override
  void initState() {
    super.initState();

    _loadSavedDatePeriod();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedDatePeriod() async {
    final savedPeriodJson = appStateData[AppDataKey.lastDashboardDatePeriod];

    if (savedPeriodJson != null) {
      try {
        final period = DatePeriod.fromJsonString(savedPeriodJson);
        setState(() {
          dateRangeService = dateRangeService.copyWith(datePeriod: period);
        });
      } catch (_) {
        // Fall back to default
      }
    }
  }

  Stream<_BalanceStats> _getBalanceStatsStream() {
    final start = dateRangeService.startDate;
    final end = dateRangeService.endDate;

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
    });
  }

  void _openCustomPeriodModal() {
    openDatePeriodModal(
      context,
      DatePeriodModal(initialDatePeriod: dateRangeService.datePeriod),
    ).then((value) {
      if (value == null) return;
      _onPeriodChanged(value);
    });
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
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(bottom: 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1150),
              child: _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final isWide = _isWide(context);

    final flowCards = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DashboardFlowCard(
              type: TransactionType.expense,
              periodState: dateRangeService,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DashboardFlowCard(
              type: TransactionType.income,
              periodState: dateRangeService,
            ),
          ),
        ],
      ),
    );

    final accountsCard = DashboardAccountList(
      dateRangeService: dateRangeService,
    );
    final healthCard = FinanceHealthCard(dateRangeService: dateRangeService);
    final categoriesCard = _buildCategoriesCard(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildBalanceHero(context),
          const SizedBox(height: 16),
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
          if (kDebugMode)
            TextButton(
              onPressed: () => RouteUtils.pushRoute(const DebugPage()),
              child: const Text('DEBUG PAGE'),
            ),
        ],
      ),
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
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) => const EditProfileModal(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserAvatar(avatar: appStateSettings[SettingKey.avatar]),
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
                    appStateSettings[SettingKey.userName] ?? 'User',
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
    final isWide = _isWide(context);
    final accent = Theme.of(context).colorScheme.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Only place the chips at the top-right of the card when there is
        // genuinely enough room for the balance AND the whole chip row in a
        // single line. We measure the locally available width (which already
        // accounts for the sidebar on large windows) and compare it against the
        // `lg` breakpoint. Narrower layouts fall back to the mobile layout: a
        // compact, horizontally-scrollable chip row below the chart.
        final chipsTopRight = BreakPoint.fromWidth(
          constraints.maxWidth,
        ).isLargerOrEqualTo(BreakpointID.lg);

        final balanceInfo = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.home.total_balance.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.of(context).textHint,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            _buildTotalBalance(context, accent),
            const SizedBox(height: 6),
            _buildVariationRow(context),
          ],
        );

        final hero = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (chipsTopRight)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: balanceInfo),
                  const SizedBox(width: 16),
                  DateRangeChips(
                    currentPeriod: dateRangeService.datePeriod,
                    onPresetSelected: _onPeriodChanged,
                    onCustomTap: _openCustomPeriodModal,
                    shrink: true,
                    padding: EdgeInsets.zero,
                  ),
                ],
              )
            else
              balanceInfo,
            const SizedBox(height: 12),
            DashboardBalanceChart(
              dateRange: dateRangeService,
              lineColor: accent,
              height: isWide ? 150 : 110,
            ),
            if (!chipsTopRight) ...[
              const SizedBox(height: 14),
              DateRangeChips(
                currentPeriod: dateRangeService.datePeriod,
                onPresetSelected: _onPeriodChanged,
                onCustomTap: _openCustomPeriodModal,
                padding: EdgeInsets.zero,
              ),
            ],
          ],
        );

        if (!isWide) return hero;

        return DecoratedBox(
          decoration: cardSurfaceDecoration(context, radius: 24),
          child: Padding(padding: const EdgeInsets.all(24), child: hero),
        );
      },
    );
  }

  Widget _buildTotalBalance(BuildContext context, Color accent) {
    return StreamBuilder(
      stream: AccountService.instance.getAccountsMoney(),
      builder: (context, snapshot) {
        return Skeletonizer(
          enabled: !snapshot.hasData,
          child: !snapshot.hasData
              ? const Bone(width: 180, height: 46)
              : CurrencyDisplayer(
                  amountToConvert: snapshot.data!,
                  integerStyle: Theme.of(context).textTheme.displaySmall!
                      .copyWith(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 1.05,
                      ),
                  decimalsStyle: Theme.of(context).textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w700, color: accent),
                  currencyStyle: Theme.of(context).textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w700, color: accent),
                ),
        );
      },
    );
  }

  Widget _buildVariationRow(BuildContext context) {
    return StreamBuilder<_BalanceStats>(
      stream: _getBalanceStatsStream(),
      builder: (context, snapshot) {
        final stats = snapshot.data;
        final delta = stats?.delta ?? 0;
        final pct = stats?.percentage ?? 0;

        final periodText = dateRangeService.getText(
          context,
          showLongMonth: false,
        );

        return Skeletonizer(
          enabled: !snapshot.hasData,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              TrendingValue(
                value: delta,
                percentage: pct.isNaN ? 0 : pct,
                dataTypes: const [
                  TrendingValueDataType.value,
                  TrendingValueDataType.percentage,
                ],
                showValueDecimals: false,
                compactValue: delta.abs() >= 100000,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                padding: EdgeInsets.zero,
              ),
              Text(
                '·  $periodText',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.of(context).textHint,
                ),
              ),
            ],
          ),
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
