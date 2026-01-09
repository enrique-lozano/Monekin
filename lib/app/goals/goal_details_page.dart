import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/goals/goal_form_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/app/widgets/financial_target_card.dart';
import 'package:monekin/core/database/services/goal/goal_service.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/models/mixins/financial_target_direction.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class GoalDetailsPage extends StatefulWidget {
  const GoalDetailsPage({super.key, required this.goal});

  final Goal goal;

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    // Reuse page framework style
    return StreamBuilder(
      stream: GoalService.instance.getGoalById(widget.goal.id),
      initialData: widget.goal,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        final goal = snapshot.data!;

        // Construct PeriodState for charts using goal dates
        // If end date is null, we might default to "now" or some logic,
        // but charts usually need a finite range.
        final periodState = DatePeriodState(
          datePeriod: DatePeriod.customRange(
            goal.startDate,
            goal.endDate ?? DateTime.now(),
          ),
        );

        return PageFramework(
          title: goal.name,
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
                    RouteUtils.pushRoute(GoalFormPage(goalToEdit: goal));
                  },
                ),
                ListTileActionItem(
                  label: t.ui_actions.delete,
                  icon: Icons.delete,
                  role: ListTileActionRole.delete,
                  onClick: () {
                    confirmDialog(
                      context,
                      dialogTitle: 'Delete Goal', // Add translation if needed
                      contentParagraphs: [
                        Text('Are you sure you want to delete this goal?'),
                      ],
                      confirmationText: t.ui_actions.confirm,
                      icon: Icons.delete,
                    ).then((confirmed) {
                      if (confirmed != true) return;

                      GoalService.instance
                          .deleteGoal(goal.id)
                          .then((value) {
                            RouteUtils.popRoute();
                            MonekinSnackbar.success(
                              SnackbarParams('Goal deleted successfully'),
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
              // Use a header similar to budget card header
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: TargetHeader(target: goal),
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
                                _GoalStatusCard(goal: goal),
                                // We can add evolution chart here later if implementing history
                              ],
                            ),
                          ),
                          ResponsiveRowColumnItem(
                            rowFit: FlexFit.tight,
                            child: CardWithHeader(
                              title: t.stats.by_categories,
                              body: PieChartByCategories(
                                filters: goal.trFilters,
                                datePeriodState: periodState,
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
                        heroTag: 'goal-page__tr-icon-${transaction.id}',
                      ),
                      filters: goal.trFilters,
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

class _GoalStatusCard extends StatelessWidget {
  const _GoalStatusCard({required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return CardWithHeader(
      title: 'Goal Status',
      bodyPadding: const EdgeInsets.all(16),
      body: Column(
        spacing: 4,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.labelMedium!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMMMd().format(goal.startDate)),
                if (goal.endDate != null)
                  Text(DateFormat.yMMMd().format(goal.endDate!))
                else
                  const Text('∞'),
              ],
            ),
          ),
          StreamBuilder(
            stream: goal.percentageAlreadyUsed,
            builder: (context, snapshot) {
              final goalPercent = snapshot.data;
              return AnimatedProgressBarWithIndicatorLabel(
                enableLabel: goal.todayPercent != null,
                indicatorLabelOptions: IndicatorLabelOptions(
                  label: Text(t.general.today),
                  isLabelBeforeBar: false,
                  labelPercent: (goal.todayPercent ?? 0) / 100,
                ),
                animatedProgressBar: AnimatedProgressBar(
                  width: 16,
                  radius: 99,
                  showPercentageText: true,
                  animationDuration: 1500,
                  value: goalPercent != null && goalPercent >= 1
                      ? 1
                      : goalPercent ?? 0,
                  color: goalPercent != null && goalPercent >= 1
                      ? AppColors.of(context).success
                      : (goal.targetDirection ==
                                FinancialTargetDirection.toExpense
                            ? AppColors.of(context).danger
                            : AppColors.of(context).success),
                ),
              );
            },
          ),
          SizedBox(height: goal.todayPercent != null ? 16 : 12),
          const Divider(height: 12),

          StreamBuilder(
            stream: goal.currentValue,
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Current:'),
                  CurrencyDisplayer(
                    amountToConvert: snapshot.data ?? 0,
                    showDecimals: true,
                    integerStyle: Theme.of(context).textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Target:'),
              CurrencyDisplayer(
                amountToConvert: goal.targetAmount,
                showDecimals: true,
                integerStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
