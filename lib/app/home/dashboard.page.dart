import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/home/widgets/click_tracker.dart';
import 'package:monekin/app/home/widgets/dashboard_cards.dart';
import 'package:monekin/app/home/widgets/horizontal_scrollable_account_list.dart';
import 'package:monekin/app/home/widgets/income_or_expense_card.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/settings/edit_profile_modal.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/debug_page.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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

  bool isFloatingButtonExtended = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      _setSmallHeaderVisible();

      bool shouldExtendButton =
          BreakPoint.of(context).isLargerThan(BreakpointID.md) ||
              _scrollController.offset <= 10 ||
              _scrollController.position.userScrollDirection !=
                  ScrollDirection.reverse;

      if (isFloatingButtonExtended != shouldExtendButton) {
        setState(() {
          isFloatingButtonExtended = shouldExtendButton;
        });
      }
    });
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
    return BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.lg);
  }

  @override
  Widget build(BuildContext context) {
    final accountService = AccountService.instance;

    return Scaffold(
      appBar: EmptyAppBar(color: AppColors.of(context).consistentPrimary),
      floatingActionButton:
          NewTransactionButton(isExtended: isFloatingButtonExtended),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(children: [
              buildDashboadHeader(context, accountService),

              HorizontalScrollableAccountList(
                dateRangeService: dateRangeService,
              ),

              // ------------- STATS GENERAL CARDS --------------

              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 20,
                  bottom: 64,
                ),
                child: DashboardCards(dateRangeService: dateRangeService),
              ),

              if (kDebugMode)
                TextButton(
                    onPressed: () {
                      RouteUtils.pushRoute(context, const DebugPage());
                    },
                    child: const Text('DEBUG PAGE'))
            ]),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedExpanded(
              expand: showSmallHeader,
              child: buildSmallHeader(context),
            ),
          )
        ],
      ),
    );
  }

  Card buildDashboadHeader(
      BuildContext context, AccountService accountService) {
    return Card(
      color: AppColors.of(context).consistentPrimary,
      margin: const EdgeInsets.only(bottom: 24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            _isIncomeExpenseAtSameLevel(context) ? 24 : 16,
            16,
            _isIncomeExpenseAtSameLevel(context) ? 24 : 16,
            _isIncomeExpenseAtSameLevel(context) ? 24 : 14),
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
              color: AppColors.of(context).onConsistentPrimary.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            StreamBuilder(
                stream: AccountService.instance.getAccounts(),
                builder: (context, accounts) {
                  if (_isIncomeExpenseAtSameLevel(context)) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        totalBalanceIndicator(
                            context, accounts, accountService),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IncomeOrExpenseCard(
                              type: TransactionType.E,
                              startDate: dateRangeService.startDate,
                              endDate: dateRangeService.endDate,
                            ),
                            IncomeOrExpenseCard(
                              type: TransactionType.I,
                              startDate: dateRangeService.startDate,
                              endDate: dateRangeService.endDate,
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      totalBalanceIndicator(context, accounts, accountService),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeOrExpenseCard(
                            type: TransactionType.E,
                            startDate: dateRangeService.startDate,
                            endDate: dateRangeService.endDate,
                          ),
                          IncomeOrExpenseCard(
                            type: TransactionType.I,
                            startDate: dateRangeService.startDate,
                            endDate: dateRangeService.endDate,
                          ),
                        ],
                      ),
                    ],
                  );
                })
          ],
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
          style: TextStyle(color: AppColors.of(context).onConsistentPrimary)),
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
          DatePeriodModal(
            initialDatePeriod: dateRangeService.datePeriod,
          ),
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
            });
      },
      bgColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 8, 24, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSettingFromDB(SettingKey.avatar),
                builder: (context, snapshot) {
                  return UserAvatar(
                    avatar: snapshot.data,
                    backgroundColor:
                        AppColors.of(context).onConsistentPrimary.darken(0.25),
                    border: Border.all(
                      width: 2,
                      color: AppColors.of(context).onConsistentPrimary,
                    ),
                  );
                }),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome again!",
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w300,
                          overflow: TextOverflow.fade,
                          color: AppColors.of(context).onConsistentPrimary,
                        ),
                  ),
                  StreamBuilder(
                    stream: UserSettingService.instance
                        .getSettingFromDB(SettingKey.userName),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Skeleton(width: 70, height: 12);
                      }

                      return Text(
                        snapshot.data!,
                        softWrap: false,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            overflow: TextOverflow.fade,
                            color: AppColors.of(context).onConsistentPrimary),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSmallHeader(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: AppColors.of(context).consistentPrimary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.home.total_balance,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColors.of(context).onConsistentPrimary),
              ),
              StreamBuilder(
                stream: AccountService.instance.getAccountsMoney(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CurrencyDisplayer(
                      amountToConvert: snapshot.data!,
                      integerStyle: TextStyle(
                          fontSize: snapshot.data! >= 10000000 &&
                                  BreakPoint.of(context)
                                      .isSmallerOrEqualTo(BreakpointID.xs)
                              ? 22
                              : 26,
                          fontWeight: FontWeight.w600,
                          color: AppColors.of(context).onConsistentPrimary),
                    );
                  }

                  return const Skeleton(width: 90, height: 40);
                },
              ),
            ],
          ),
          const SizedBox(width: 12),
          Flexible(child: buildDatePeriodSelector(context))
        ],
      ),
    );
  }

  Widget totalBalanceIndicator(
    BuildContext context,
    AsyncSnapshot<List<Account>> accounts,
    AccountService accountService,
  ) {
    final t = Translations.of(context);

    return SuccessiveTapDetector(
      delayTrackingAfterGoal: 4000,
      onClickGoalReached: () async {
        final sc = ScaffoldMessenger.of(context);
        final privateMode =
            await PrivateModeService.instance.privateModeStream.first;

        PrivateModeService.instance.setPrivateMode(!privateMode);

        await HapticFeedback.lightImpact();

        sc.showSnackBar(
          SnackBar(
            content: Text(!privateMode
                ? t.settings.security.private_mode_activated
                : t.settings.security.private_mode_deactivated),
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
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: AppColors.of(context).onConsistentPrimary),
          ),
          if (!accounts.hasData) ...[
            const Skeleton(width: 70, height: 40),
            const Skeleton(width: 30, height: 14),
          ],
          if (accounts.hasData) ...[
            StreamBuilder(
              stream: AccountService.instance.getAccountsMoney(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CurrencyDisplayer(
                    amountToConvert: snapshot.data!,
                    integerStyle: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(
                            fontSize: snapshot.data! >= 100000000 &&
                                    BreakPoint.of(context)
                                        .isSmallerOrEqualTo(BreakpointID.xs)
                                ? 26
                                : 32,
                            fontWeight: FontWeight.w600,
                            color: AppColors.of(context).onConsistentPrimary),
                  );
                }

                return const Skeleton(width: 90, height: 40);
              },
            ),
            if (dateRangeService.startDate != null &&
                dateRangeService.endDate != null)
              StreamBuilder(
                stream: accountService.getAccountsMoneyVariation(
                    accounts: accounts.data!,
                    startDate: dateRangeService.startDate,
                    endDate: dateRangeService.endDate,
                    convertToPreferredCurrency: true),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Skeleton(width: 52, height: 22);
                  }

                  return TrendingValue(
                    percentage: snapshot.data!,
                    fontWeight: FontWeight.w600,
                    filled: true,
                    outlined: true,
                    fontSize: 16,
                  );
                },
              ),
          ]
        ],
      ),
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;

  const EmptyAppBar({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }

  @override
  Size get preferredSize => const Size(0.0, 0.0);
}
