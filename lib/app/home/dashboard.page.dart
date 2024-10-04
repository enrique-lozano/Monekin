import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/details/account_details.dart';
import 'package:monekin/app/home/widgets/click_tracker.dart';
import 'package:monekin/app/home/widgets/home_drawer.dart';
import 'package:monekin/app/home/widgets/horizontal_scrollable_account_list.dart';
import 'package:monekin/app/home/widgets/income_or_expense_card.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/settings/edit_profile_modal.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/stats/widgets/balance_bar_chart.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_main_info.dart';
import 'package:monekin/app/stats/widgets/fund_evolution_line_chart.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/chart_by_categories.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/translations.g.dart';

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

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_setSmallHeaderVisible);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_setSmallHeaderVisible);
    _scrollController.dispose();
    super.dispose();
  }

  void _setSmallHeaderVisible() {
    final shouldShowSmallHeader = _scrollController.position.pixels > 150;
    if (showSmallHeader != shouldShowSmallHeader) {
      setState(() {
        showSmallHeader = shouldShowSmallHeader;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountService = AccountService.instance;

    final hideDrawerAndFloatingButton =
        BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md);

    return Scaffold(
        appBar: EmptyAppBar(
            color: Theme.of(context).colorSchemeExtended.dashboardHeader),
        floatingActionButton:
            hideDrawerAndFloatingButton ? null : const NewTransactionButton(),
        drawer: hideDrawerAndFloatingButton
            ? null
            : Drawer(
                child: Builder(builder: (context) {
                  final drawerItems = getDestinations(context,
                      showHome: false, shortLabels: false);

                  return HomeDrawer(
                    drawerActions: drawerItems,
                    onDestinationSelected: (e) {
                      Navigator.pop(context);

//                    context.router.push(drawerItems.elementAt(e).destination);
                    },
                    selectedIndex: -1,
                  );
                }),
              ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(children: [
                Card(
                  color: Theme.of(context).colorSchemeExtended.dashboardHeader,
                  margin: const EdgeInsets.only(bottom: 24),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildWelcomeMsgAndAvatar(context),
                              buildDatePeriodSelector(context),
                            ],
                          ),
                          Divider(
                            height: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          const SizedBox(height: 8),
                          StreamBuilder(
                              stream: AccountService.instance.getAccounts(),
                              builder: (context, accounts) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    totalBalanceIndicator(
                                        context, accounts, accountService),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                        ]),
                  ),
                ),

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
        ));
  }

  ActionChip buildDatePeriodSelector(BuildContext context) {
    return ActionChip(
      label: Text(dateRangeService.getText(context),
          style: TextStyle(
              color: Theme.of(context).colorSchemeExtended.onDashboardHeader)),
      backgroundColor: Theme.of(context).colorSchemeExtended.dashboardHeader,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          //   style: BorderStyle.none,
          color: Theme.of(context).colorSchemeExtended.onDashboardHeader,
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
          children: [
            if (BreakPoint.of(context).isSmallerThan(BreakpointID.md)) ...[
              StreamBuilder(
                  stream:
                      UserSettingService.instance.getSetting(SettingKey.avatar),
                  builder: (context, snapshot) {
                    return UserAvatar(
                      avatar: snapshot.data,
                      backgroundColor: Theme.of(context)
                          .colorSchemeExtended
                          .onDashboardHeader
                          .darken(0.25),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context)
                            .colorSchemeExtended
                            .onDashboardHeader,
                      ),
                    );
                  }),
              const SizedBox(width: 12),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome again!",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context)
                          .colorSchemeExtended
                          .onDashboardHeader),
                ),
                StreamBuilder(
                    stream: UserSettingService.instance
                        .getSetting(SettingKey.userName),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Skeleton(width: 70, height: 12);
                      }

                      return Text(
                        snapshot.data!,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Theme.of(context)
                                .colorSchemeExtended
                                .onDashboardHeader),
                      );
                    }),
                const SizedBox(width: 8),
              ],
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
          color: Theme.of(context).colorSchemeExtended.dashboardHeader),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.home.total_balance,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context)
                        .colorSchemeExtended
                        .onDashboardHeader),
              ),
              StreamBuilder(
                stream: AccountService.instance.getAccountsMoney(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CurrencyDisplayer(
                      amountToConvert: snapshot.data!,
                      integerStyle: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .colorSchemeExtended
                              .onDashboardHeader),
                    );
                  }

                  return const Skeleton(width: 90, height: 40);
                },
              ),
            ],
          ),
          buildDatePeriodSelector(context)
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.home.total_balance,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).colorSchemeExtended.onDashboardHeader),
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
                    integerStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context)
                            .colorSchemeExtended
                            .onDashboardHeader),
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
                    fontWeight: FontWeight.bold,
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

  Widget buildAccountList(List<Account> accounts) {
    return Builder(
      builder: (context) {
        if (accounts.isEmpty) {
          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        t.home.no_accounts,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.home.no_accounts_descr,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      FilledButton(
                          onPressed: () => RouteUtils.pushRoute(
                              context, const AccountFormPage()),
                          child: Text(t.account.form.create))
                    ],
                  ))
            ],
          );
        }

        return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: accounts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const Divider(indent: 56);
            },
            itemBuilder: (context, index) {
              final account = accounts[index];

              return ListTile(
                onTap: () => RouteUtils.pushRoute(
                    context,
                    AccountDetailsPage(
                        account: account,
                        accountIconHeroTag:
                            'dashboard-page__account-icon-${account.id}')),
                leading: Hero(
                    tag: 'dashboard-page__account-icon-${account.id}',
                    child: account.displayIcon(context)),
                trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                          initialData: 0.0,
                          stream: AccountService.instance
                              .getAccountMoney(account: account),
                          builder: (context, snapshot) {
                            return CurrencyDisplayer(
                              amountToConvert: snapshot.data!,
                              currency: account.currency,
                            );
                          }),
                      StreamBuilder(
                          initialData: 0.0,
                          stream: AccountService.instance
                              .getAccountsMoneyVariation(
                                  accounts: [account],
                                  startDate: dateRangeService.startDate,
                                  endDate: dateRangeService.endDate,
                                  convertToPreferredCurrency: false),
                          builder: (context, snapshot) {
                            return TrendingValue(
                              percentage: snapshot.data!,
                              decimalDigits: 0,
                            );
                          }),
                    ]),
                title: Text(account.name),
              );
            });
      },
    );
  }
}

class DashboardCards extends StatelessWidget {
  const DashboardCards({
    super.key,
    required this.dateRangeService,
  });

  final DatePeriodState dateRangeService;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ResponsiveRowColumn.withSymetricSpacing(
      direction: BreakPoint.of(context).isLargerThan(BreakpointID.md)
          ? Axis.horizontal
          : Axis.vertical,
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        ResponsiveRowColumnItem(
          rowFit: FlexFit.tight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CardWithHeader(
                title: t.financial_health.display,
                footer: CardFooterWithSingleButton(
                  onButtonClick: () => RouteUtils.pushRoute(
                    context,
                    StatsPage(
                        dateRangeService: dateRangeService, initialIndex: 0),
                  ),
                ),
                bodyPadding: const EdgeInsets.all(16),
                body: StreamBuilder(
                  stream: FinanceHealthService().getHealthyValue(
                    filters: TransactionFilters(
                      minDate: dateRangeService.startDate,
                      maxDate: dateRangeService.endDate,
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const LinearProgressIndicator();
                    }

                    final financeHealthData = snapshot.data!;

                    return FinanceHealthMainInfo(
                        financeHealthData: financeHealthData);
                  },
                ),
              ),
              const SizedBox(height: 16),
              CardWithHeader(
                title: t.stats.by_categories,
                body: ChartByCategories(datePeriodState: dateRangeService),
                footer: CardFooterWithSingleButton(
                  onButtonClick: () => RouteUtils.pushRoute(
                    context,
                    StatsPage(
                        dateRangeService: dateRangeService, initialIndex: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        ResponsiveRowColumnItem(
          rowFit: FlexFit.tight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CardWithHeader(
                title: t.stats.balance_evolution,
                bodyPadding: const EdgeInsets.all(16),
                body: FundEvolutionLineChart(dateRange: dateRangeService),
                footer: CardFooterWithSingleButton(onButtonClick: () {
                  RouteUtils.pushRoute(
                    context,
                    StatsPage(
                        dateRangeService: dateRangeService, initialIndex: 2),
                  );
                }),
              ),
              const SizedBox(height: 16),
              CardWithHeader(
                title: t.stats.by_periods,
                bodyPadding:
                    const EdgeInsets.only(bottom: 12, top: 24, right: 16),
                body: BalanceBarChart(
                  dateRange: dateRangeService,
                  filters: TransactionFilters(
                    minDate: dateRangeService.startDate,
                    maxDate: dateRangeService.endDate,
                  ),
                ),
                footer: CardFooterWithSingleButton(onButtonClick: () {
                  RouteUtils.pushRoute(
                    context,
                    StatsPage(
                        dateRangeService: dateRangeService, initialIndex: 3),
                  );
                }),
              )
            ],
          ),
        )
      ],
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
