import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/budgets/components/budget_evolution_chart.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/budget/target_progress_status.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/presentation/widgets/no_results.dart';
import 'components/budget_card.dart';

class BudgetDetailsPage extends StatefulWidget {
  const BudgetDetailsPage({super.key, required this.budget});

  final Budget budget;

  @override
  State<BudgetDetailsPage> createState() => _BudgetDetailsPageState();
}

class _BudgetDetailsPageState extends State<BudgetDetailsPage>
    with SingleTickerProviderStateMixin {
  double? budgetCurrentValue;
  double? budgetCurrentPercentage;

  List<StreamSubscription<double>> subscrList = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    subscrList.addAll([
      widget.budget.currentValue.asBroadcastStream().listen((event) {
        setState(() {
          budgetCurrentValue = event;
        });
      }),
      widget.budget.percentageAlreadyUsed.asBroadcastStream().listen((event) {
        setState(() {
          budgetCurrentPercentage = event;
        });
      }),
    ]);
  }

  @override
  void dispose() {
    for (final element in subscrList) {
      element.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
      stream: BudgetServive.instance.getBudgetById(widget.budget.id),
      initialData: widget.budget,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        final budget = snapshot.data!;

        return PageFramework(
          title: Translations.of(context).budgets.details.title,
          tabBar: TabBar(
            controller: _tabController,
            tabAlignment: BreakPoint.of(context).isSmallerThan(BreakpointID.md)
                ? TabAlignment.fill
                : TabAlignment.start,
            isScrollable: !BreakPoint.of(
              context,
            ).isSmallerThan(BreakpointID.md),
            tabs: [
              Tab(text: t.budgets.details.statistics),
              Tab(text: t.transaction.display(n: 10)),
            ],
          ),
          appBarActions: [
            MonekinPopupMenuButton(
              actionItems: [
                ListTileActionItem(
                  label: t.budgets.form.edit,
                  icon: Icons.edit,
                  onClick: () {
                    RouteUtils.pushRoute(
                      BudgetFormPage(
                        prevPage: const BudgetsPage(),
                        budgetToEdit: budget,
                      ),
                    );
                  },
                ),
                ListTileActionItem(
                  label: t.ui_actions.delete,
                  icon: Icons.delete,
                  role: ListTileActionRole.delete,
                  onClick: () {
                    confirmDialog(
                      context,
                      dialogTitle: t.budgets.delete,
                      contentParagraphs: [Text(t.budgets.delete_warning)],
                      confirmationText: t.ui_actions.confirm,
                      icon: Icons.delete,
                    ).then((confirmed) {
                      if (confirmed != true) return;

                      BudgetServive.instance
                          .deleteBudget(budget.id)
                          .then((value) {
                            RouteUtils.popRoute();

                            MonekinSnackbar.success(
                              SnackbarParams(t.budgets.delete),
                            );
                          })
                          .catchError((err) {
                            MonekinSnackbar.error(
                              SnackbarParams.fromError(err),
                            );
                          });
                    });
                  },
                ),
              ],
            ),
          ],

          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: BudgetMainHeaderInfo(budget: budget),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: ResponsiveRowColumn.withSymetricSpacing(
                        direction:
                            BreakPoint.of(context).isLargerThan(BreakpointID.md)
                            ? Axis.horizontal
                            : Axis.vertical,
                        spacing: 16,
                        columnMainAxisSize: MainAxisSize.min,
                        rowCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveRowColumnItem(
                            rowFit: FlexFit.tight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 16,
                              children: [
                                MainStatusCard(
                                  budget: budget,
                                  budgetCurrentValue: budgetCurrentValue,
                                ),
                                CardWithHeader(
                                  title: t.budgets.details.expend_evolution,
                                  body: BudgetEvolutionChart(budget: budget),
                                ),
                              ],
                            ),
                          ),
                          ResponsiveRowColumnItem(
                            rowFit: FlexFit.tight,
                            child: CardWithHeader(
                              title: t.stats.by_categories,
                              body: PieChartByCategories(
                                filters: budget.trFilters,
                                datePeriodState: budget.periodState,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TransactionListComponent(
                      isScrollable: true,
                      tileBuilder: (transaction) => TransactionListTile(
                        transaction: transaction,
                        heroTag: 'budgets-page__tr-icon-${transaction.id}',
                      ),
                      filters: budget.trFilters,
                      onEmptyList: NoResults(
                        title: t.general.empty_warn,
                        description: t.budgets.details.no_transactions,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MainStatusCard extends StatelessWidget {
  const MainStatusCard({
    super.key,
    required this.budget,
    required this.budgetCurrentValue,
  });

  final Budget budget;
  final double? budgetCurrentValue;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return CardWithHeader(
      title: budget.timelineStatusLabel(context),
      titleBuilder: (title) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [budget.timelineStatus.icon(size: 16), Text(title)],
        ),
      ),
      subtitle: budget.isPast
          ? '${budget.daysToTheEnd.abs()} ${t.budgets.since_expiration}'
          : budget.isFuture
          ? '${budget.daysToTheStart} ${t.budgets.days_to_start}'
          : null,
      bodyPadding: EdgeInsets.all(16),
      body: Column(
        spacing: 4,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.labelMedium!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMMMd().format(budget.currentDateRange.start)),
                Text(DateFormat.yMMMd().format(budget.currentDateRange.end)),
              ],
            ),
          ),

          StreamBuilder(
            stream: budget.percentageAlreadyUsed,

            builder: (context, snapshot) {
              final budgetValue = snapshot.data;

              return AnimatedProgressBarWithIndicatorLabel(
                indicatorLabelOptions: IndicatorLabelOptions(
                  label: Text(t.general.today),
                  isLabelBeforeBar: false,
                  labelPercent: budget.todayPercent / 100,
                ),
                animatedProgressBar: AnimatedProgressBar(
                  width: 16,
                  radius: 99,
                  showPercentageText: true,
                  animationDuration: 1500,
                  value: budgetValue != null && budgetValue >= 1
                      ? 1
                      : budgetValue ?? 0,
                  color: budgetValue != null && budgetValue >= 1
                      ? AppColors.of(context).danger
                      : null,
                ),
              );
            },
          ),

          if (!budget.isFuture) ...[
            const SizedBox(height: 12),
            const Divider(height: 24),
          ],

          if (!budget.isFuture)
            StreamBuilder(
              stream: CurrencyService.instance
                  .ensureAndGetPreferredCurrency()
                  .switchMap((userCurrency) {
                    return budget.progressStatus.map((progressStatus) {
                      return (
                        userCurrency: userCurrency,
                        progressStatus: progressStatus,
                      );
                    });
                  }),
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: !snapshot.hasData,
                  child: Row(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 6,
                          children: [
                            Text(
                              (snapshot.data?.progressStatus ??
                                      TargetProgressStatus.success)
                                  .displayName(context),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              !snapshot.hasData ||
                                      snapshot.data?.progressStatus == null
                                  ? 'Quis deserunt cupidatat ullamco elit velit quis in exercitation nulla. Consequat fugiat consectetur magna deserunt labore duis. Qui et in labore amet velit quis in ad excepteur.'
                                  : (snapshot.data!.progressStatus!)
                                        .description(
                                          context,
                                          dailyAmountLeft:
                                              ((budget.limitAmount -
                                                  (budgetCurrentValue ?? 0)) /
                                              budget.daysToTheEnd),
                                          currency: snapshot.data?.userCurrency,
                                          daysLeft: budget.daysToTheEnd,
                                          failedByAmount:
                                              (budget.limitAmount -
                                                      (budgetCurrentValue ?? 0))
                                                  .abs(),
                                        ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: snapshot.data?.progressStatus == null
                              ? null
                              : snapshot.data!.progressStatus!.color
                                    .lighten(0.2)
                                    .withOpacity(0.2),
                        ),
                        child: Icon(
                          snapshot.data?.progressStatus?.iconData ??
                              Icons.question_mark,
                          size: 20,
                          color: snapshot.data?.progressStatus?.color,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

          // if (budget.isActiveBudget) ...[
          //   const SizedBox(height: 12),
          //   Row(
          //     mainAxisAlignment:
          //         MainAxisAlignment.center,
          //     children: [
          //       StreamBuilder(
          //         stream: CurrencyService.instance
          //             .ensureAndGetPreferredCurrency(),
          //         builder: (context, snapshot) {
          //           return StreamBuilder(
          //             stream: budget.currentValue,
          //             builder: (context, budgetCurrentValue) {
          //               return Text(
          //                 t.budgets.details.expend_diary_left(
          //                   dailyAmount:
          //                       NumberFormat.currency(
          //                         symbol:
          //                             snapshot
          //                                 .data
          //                                 ?.symbol ??
          //                             '',
          //                         decimalDigits: 0,
          //                       ).format(
          //                         ((budget.limitAmount -
          //                                     (budgetCurrentValue.data ??
          //                                         0)) >
          //                                 0)
          //                             ? ((budget.limitAmount -
          //                                       (budgetCurrentValue.data ??
          //                                           0)) /
          //                                   budget
          //                                       .daysToTheEnd)
          //                             : 0,
          //                       ),
          //                   remainingDays:
          //                       budget.daysToTheEnd,
          //                 ),
          //                 textAlign:
          //                     TextAlign.center,
          //               );
          //             },
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // ],
        ],
      ),
    );
  }
}
