import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/home/widgets/home_drawer.dart';
import 'package:monekin/app/home/widgets/income_or_expense_card.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/stats/widgets/balance_bar_chart_small.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_main_info.dart';
import 'package:monekin/app/stats/widgets/fund_evolution_line_chart.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/chart_by_categories.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/app_colors.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DatePeriodState dateRangeService = const DatePeriodState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final accountService = AccountService.instance;

    final hideDrawerAndFloatingButton =
        BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !hideDrawerAndFloatingButton,
        title: const Text('Monekin'),
        elevation: 1,
        centerTitle: !hideDrawerAndFloatingButton,
        actions: [
          if (BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md))
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ActionChip(
                label: Text(dateRangeService.getText(context)),
                backgroundColor:
                    AppColors.of(context).primaryContainer.darken(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: AppColors.of(context).onPrimary,
                  ),
                ),
                onPressed: () {
                  openDatePeriodModal(
                      context,
                      DatePeriodModal(
                        initialDatePeriod: dateRangeService.datePeriod,
                      )).then((_) => setState(() {}));
                },
              ),
            ),
          if (BreakPoint.of(context).isSmallerThan(BreakpointID.md))
            IconButton(
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
                icon: const Icon(Icons.calendar_today))
        ],
      ),
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

                    context.router.push(drawerItems.elementAt(e).destination);
                  },
                  selectedIndex: -1,
                );
              }),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTextStyle.merge(
              style: TextStyle(
                  color: Theme.of(context).appBarTheme.foregroundColor),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    )),
                padding: EdgeInsets.fromLTRB(
                    16,
                    BreakPoint.of(context).isLargerThan(BreakpointID.md)
                        ? 8
                        : 24,
                    16,
                    8),
                child: ResponsiveRowColumn(
                  direction:
                      BreakPoint.of(context).isLargerThan(BreakpointID.md)
                          ? Axis.horizontal
                          : Axis.vertical,
                  rowSpacing: 40,
                  columnSpacing: 18,
                  children: [
                    ResponsiveRowColumnItem(
                      child: StreamBuilder(
                          stream: AccountService.instance.getAccounts(),
                          builder: (context, accounts) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: BreakPoint.of(context)
                                      .isLargerThan(BreakpointID.md)
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${t.home.total_balance} - ${dateRangeService.getText(context)}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                if (!accounts.hasData) ...[
                                  const Skeleton(width: 70, height: 40),
                                  const Skeleton(width: 30, height: 14),
                                ],
                                if (accounts.hasData) ...[
                                  StreamBuilder(
                                      stream: accountService.getAccountsMoney(
                                          accountIds:
                                              accounts.data!.map((e) => e.id)),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return CurrencyDisplayer(
                                            amountToConvert: snapshot.data!,
                                            integerStyle: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w600),
                                          );
                                        }

                                        return const Skeleton(
                                            width: 90, height: 40);
                                      }),
                                  if (dateRangeService.startDate != null &&
                                      dateRangeService.endDate != null)
                                    StreamBuilder(
                                      stream: accountService
                                          .getAccountsMoneyVariation(
                                              accounts: accounts.data!,
                                              startDate:
                                                  dateRangeService.startDate,
                                              endDate: dateRangeService.endDate,
                                              convertToPreferredCurrency: true),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Skeleton(
                                              width: 52, height: 22);
                                        }

                                        return TrendingValue(
                                          percentage: snapshot.data!,
                                          filled: true,
                                          fontWeight: FontWeight.bold,
                                          outlined: true,
                                        );
                                      },
                                    ),
                                ]
                              ],
                            );
                          }),
                    ),
                    ResponsiveRowColumnItem(
                      child: ResponsiveRowColumn(
                        direction:
                            BreakPoint.of(context).isLargerThan(BreakpointID.md)
                                ? Axis.vertical
                                : Axis.horizontal,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveRowColumnItem(
                            child: IncomeOrExpenseCard(
                              type: TransactionType.income,
                              startDate: dateRangeService.startDate,
                              endDate: dateRangeService.endDate,
                            ),
                          ),
                          ResponsiveRowColumnItem(
                            child: IncomeOrExpenseCard(
                              type: TransactionType.expense,
                              startDate: dateRangeService.startDate,
                              endDate: dateRangeService.endDate,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: AccountService.instance.getAccounts(
                        predicate: (acc, curr) => acc.closingDate.isNull(),
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CardWithHeader(
                              title: t.home.active_accounts,
                              body: const LinearProgressIndicator());
                        } else {
                          final accounts = snapshot.data!;

                          return CardWithHeader(
                              title: t.home.active_accounts,
                              headerButtonIcon: Icons.add_rounded,
                              onHeaderButtonClick: accounts.isEmpty
                                  ? null
                                  : () {
                                      context.pushRoute(AccountFormRoute());
                                    },
                              body: buildAccountList(accounts));
                        }
                      }),
                  const SizedBox(height: 16),
                  StreamBuilder(
                      stream: TransactionService.instance
                          .checkIfCreateTransactionIsPossible(),
                      builder: (context, accountSnapshot) {
                        return CardWithHeader(
                            title: t.home.last_transactions,
                            onHeaderButtonClick:
                                accountSnapshot.hasData && accountSnapshot.data!
                                    ? () {
                                        context.pushRoute(TransactionsRoute());
                                      }
                                    : null,
                            body: TransactionListComponent(
                              filters: TransactionFilters(
                                minDate: dateRangeService.startDate,
                                maxDate: dateRangeService.endDate,
                              ),
                              limit: 5,
                              showGroupDivider: false,
                              prevPage: const DashboardPage(),
                              onEmptyList: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  t.transaction.list.empty,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ));
                      }),
                  const SizedBox(height: 16),
                  ResponsiveRowColumn.withSymetricSpacing(
                    spacing: 16,
                    direction:
                        BreakPoint.of(context).isLargerThan(BreakpointID.md)
                            ? Axis.horizontal
                            : Axis.vertical,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFit: FlexFit.tight,
                        child: CardWithHeader(
                          title: t.financial_health.display,
                          onHeaderButtonClick: () =>
                              context.pushRoute(StatsRoute(initialIndex: 0)),
                          bodyPadding: const EdgeInsets.only(right: 8),
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
                      ),
                      ResponsiveRowColumnItem(
                        rowFit: FlexFit.tight,
                        child: CardWithHeader(
                            title: t.stats.balance_evolution,
                            body: FundEvolutionLineChart(
                              dateRange: dateRangeService,
                            ),
                            onHeaderButtonClick: () {
                              context.pushRoute(StatsRoute(initialIndex: 2));
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ResponsiveRowColumn.withSymetricSpacing(
                    spacing: 16,
                    direction:
                        BreakPoint.of(context).isLargerThan(BreakpointID.md)
                            ? Axis.horizontal
                            : Axis.vertical,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFit: FlexFit.tight,
                        child: CardWithHeader(
                            title: t.stats.by_categories,
                            body: ChartByCategories(
                                datePeriodState: dateRangeService),
                            onHeaderButtonClick: () {
                              context.pushRoute(StatsRoute(initialIndex: 1));
                            }),
                      ),
                      ResponsiveRowColumnItem(
                        rowFit: FlexFit.tight,
                        child: CardWithHeader(
                            title: t.stats.cash_flow,
                            body: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              child: BalanceChartSmall(
                                  dateRangeService: dateRangeService),
                            ),
                            onHeaderButtonClick: () {
                              context.pushRoute(StatsRoute(initialIndex: 3));
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: hideDrawerAndFloatingButton ? 8 : 64),
                ],
              ),
            )
          ],
        ),
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
                          onPressed: () =>
                              context.pushRoute(AccountFormRoute()),
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
                onTap: () =>
                    context.pushRoute(AccountDetailsRoute(account: account)),
                leading: Hero(
                    tag: 'account-icon-${account.id}',
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
