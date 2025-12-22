import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/home/widgets/click_tracker.dart';
import 'package:monekin/app/home/widgets/dashboard_cards.dart';
import 'package:monekin/app/home/widgets/horizontal_scrollable_account_list.dart';
import 'package:monekin/app/home/widgets/income_or_expense_card.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/edit_profile_modal.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/debug_page.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/models/transaction/transaction_type.enum.dart';
import '../../core/presentation/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DatePeriodState dateRangeService = const DatePeriodState();
  final ScrollController _scrollController = ScrollController();
  bool showSmallHeader = false;

  late Stream<double> _balanceVariationStream;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      _setSmallHeaderVisible();
    });

    _balanceVariationStream = AccountService.instance.getAccounts().switchMap(
      (accounts) => AccountService.instance.getAccountsMoneyVariation(
        accounts: accounts,
        startDate: dateRangeService.startDate,
        endDate: dateRangeService.endDate,
        convertToPreferredCurrency: true,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_setSmallHeaderVisible);
    _scrollController.dispose();
    super.dispose();
  }

  void _setSmallHeaderVisible() {
    final scrollLimit = _isIncomeExpenseAtSameLevel(context) ? 150 : 200;

    final shouldShowSmallHeader =
        _scrollController.position.pixels > scrollLimit;
    if (showSmallHeader != shouldShowSmallHeader) {
      setState(() {
        showSmallHeader = shouldShowSmallHeader;
      });
    }
  }

  bool _isIncomeExpenseAtSameLevel(BuildContext context) {
    return BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.sm);
  }

  @override
  Widget build(BuildContext context) {
    final accountService = AccountService.instance;

    return PageFramework(
      title: t.home.title,
      enableAppBar: false,
      appBarBackgroundColor:
          BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md)
          ? Colors.transparent
          : AppColors.of(context).consistentPrimary,
      floatingActionButton: ifIsInTabs(context)
          ? null
          : NewTransactionButton(
              key: const Key('dashboard--new-transaction-button'),
              scrollController: _scrollController,
            ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                buildDashboadHeader(context, accountService),

                HorizontalScrollableAccountList(
                  dateRangeService: dateRangeService,
                ),

                // ------------- STATS GENERAL CARDS --------------
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 0),
                  child: DashboardCards(dateRangeService: dateRangeService),
                ),

                if (kDebugMode)
                  TextButton(
                    onPressed: () {
                      RouteUtils.pushRoute(const DebugPage());
                    },
                    child: const Text('DEBUG PAGE'),
                  ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedExpanded(
              expand: showSmallHeader,
              child: buildSmallHeader(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDashboadHeader(
    BuildContext context,
    AccountService accountService,
  ) {
    final shouldHavePadding =
        !AppUtils.isDesktop && !AppUtils.isMobileLayout(context);

    return SkeletonizerConfig(
      data: _getSkeletonizerConfig(context),
      child: Card(
        color: AppColors.of(context).consistentPrimary,
        margin: EdgeInsets.only(
          bottom: 0,
          top: shouldHavePadding ? 8 : 0,
          left: shouldHavePadding ? 12 : 0,
          right: shouldHavePadding ? 12 : 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(getCardBorderRadius()),
            top: Radius.circular(shouldHavePadding ? getCardBorderRadius() : 0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            _isIncomeExpenseAtSameLevel(context) ? 24 : 16,
            16,
            _isIncomeExpenseAtSameLevel(context) ? 24 : 16,
            _isIncomeExpenseAtSameLevel(context) ? 24 : 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: buildWelcomeMsgAndAvatar(context)),
                  buildDatePeriodSelector(context),
                ],
              ),
              Divider(
                height: 16,
                color: AppColors.of(
                  context,
                ).onConsistentPrimary.withOpacity(0.5),
              ),
              const SizedBox(height: 8),
              Builder(
                builder: (context) {
                  final labelStyle = Theme.of(context).textTheme.labelMedium!
                      .copyWith(color: onHeaderSmallTextColor(context));

                  final incomeAndExpenseCards = [
                    IncomeOrExpenseCard(
                      type: TransactionType.E,
                      periodState: dateRangeService,
                      labelStyle: labelStyle,
                    ),
                    IncomeOrExpenseCard(
                      type: TransactionType.I,
                      periodState: dateRangeService,
                      labelStyle: labelStyle,
                    ),
                  ];

                  if (_isIncomeExpenseAtSameLevel(context)) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 16,
                      children: [
                        totalBalanceIndicator(context),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: incomeAndExpenseCards,
                        ),
                      ],
                    );
                  }

                  return Column(
                    spacing: 24,
                    children: [
                      totalBalanceIndicator(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: incomeAndExpenseCards,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ActionChip buildDatePeriodSelector(BuildContext context) {
    return ActionChip(
      label: Text(
        dateRangeService.getText(
          context,
          showLongMonth: MediaQuery.of(context).size.width > 360,
        ),
        style: TextStyle(color: AppColors.of(context).onConsistentPrimary),
      ),
      backgroundColor: AppColors.of(context).consistentPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          //   style: BorderStyle.none,
          color: AppColors.of(context).onConsistentPrimary,
        ),
      ),
      onPressed: () {
        openDatePeriodModal(
          context,
          DatePeriodModal(initialDatePeriod: dateRangeService.datePeriod),
        ).then((value) {
          if (value == null) return;

          setState(() {
            dateRangeService = dateRangeService.copyWith(
              periodModifier: 0,
              datePeriod: value,
            );
          });
        });
      },
    );
  }

  Tappable buildWelcomeMsgAndAvatar(BuildContext context) {
    return Tappable(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) {
            return const EditProfileModal();
          },
        );
      },
      bgColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 8, 24, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            UserAvatar(
              avatar: appStateSettings[SettingKey.avatar],
              backgroundColor: AppColors.of(
                context,
              ).onConsistentPrimary.darken(0.25),
              border: Border.all(
                width: 2,
                color: AppColors.of(context).onConsistentPrimary,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome again!",
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.fade,
                      color: onHeaderSmallTextColor(context),
                    ),
                  ),
                  Text(
                    appStateSettings[SettingKey.userName] ?? 'User',
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 18,
                      overflow: TextOverflow.fade,
                      color: AppColors.of(context).onConsistentPrimary,
                    ),
                  ),

                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSmallHeader(BuildContext context) {
    return SkeletonizerConfig(
      data: _getSkeletonizerConfig(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: AppColors.of(context).consistentPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.home.total_balance,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: onHeaderSmallTextColor(context),
                  ),
                ),
                StreamBuilder(
                  stream: AccountService.instance.getAccountsMoney(),
                  builder: (context, snapshot) {
                    return Skeletonizer(
                      enabled: !snapshot.hasData,
                      child: Builder(
                        builder: (context) {
                          if (!snapshot.hasData) {
                            return Text('9999', style: TextStyle(fontSize: 22));
                          }

                          return CurrencyDisplayer(
                            amountToConvert: snapshot.data!,
                            integerStyle: TextStyle(
                              fontSize:
                                  snapshot.data! >= 10000000 &&
                                      BreakPoint.of(
                                        context,
                                      ).isSmallerOrEqualTo(BreakpointID.xs)
                                  ? 22
                                  : 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.of(context).onConsistentPrimary,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(width: 12),
            Flexible(child: buildDatePeriodSelector(context)),
          ],
        ),
      ),
    );
  }

  Widget totalBalanceIndicator(BuildContext context) {
    final t = Translations.of(context);

    return SuccessiveTapDetector(
      delayTrackingAfterGoal: 4000,
      onClickGoalReached: () async {
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
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: _isIncomeExpenseAtSameLevel(context)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        spacing: 2,
        children: [
          Text(
            t.home.total_balance,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: onHeaderSmallTextColor(context),
            ),
          ),

          // ----- CURRENT BALANCE AMOUNT HEADER -----
          StreamBuilder(
            stream: AccountService.instance.getAccountsMoney(),
            builder: (context, snapshot) {
              return Skeletonizer(
                enabled: !snapshot.hasData,
                child: !snapshot.hasData
                    ? Bone(width: 90, height: 40)
                    : CurrencyDisplayer(
                        amountToConvert: snapshot.data!,
                        integerStyle: Theme.of(context).textTheme.headlineLarge!
                            .copyWith(
                              fontSize:
                                  snapshot.data! >= 100000000 &&
                                      BreakPoint.of(
                                        context,
                                      ).isSmallerOrEqualTo(BreakpointID.xs)
                                  ? 26
                                  : 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.of(context).onConsistentPrimary,
                            ),
                      ),
              );
            },
          ),

          //  ----- BALANCE TRENDING VALUE DURING THE SELECTED PERIOD -----
          if (dateRangeService.startDate != null &&
              dateRangeService.endDate != null)
            StreamBuilder(
              stream: _balanceVariationStream,
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: !snapshot.hasData,
                  child: TrendingValue(
                    percentage: snapshot.data ?? 0,
                    fontWeight: FontWeight.bold,
                    filled: true,
                    outlined: true,
                    fontSize: 16,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  SkeletonizerConfigData _getSkeletonizerConfig(BuildContext context) {
    return SkeletonizerConfigData(
      effect: ShimmerEffect(
        baseColor: AppColors.of(context).onConsistentPrimary.withOpacity(0.1),
        highlightColor: AppColors.of(
          context,
        ).onConsistentPrimary.withOpacity(0.25),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

Color onHeaderSmallTextColor(BuildContext context) =>
    AppColors.of(context).onConsistentPrimary.withOpacity(0.9);
