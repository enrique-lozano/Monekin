import 'package:flutter/material.dart';
import 'package:monekin/app/goals/goal_form_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/goal/goal_service.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/targets/financial_target_card.dart';
import 'package:monekin/core/presentation/widgets/targets/target_status_card.dart';
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

    return StreamBuilder(
      stream: GoalService.instance.getGoalById(widget.goal.id),
      initialData: widget.goal,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        final goal = snapshot.data!;

        final periodState = DatePeriodState(
          datePeriod: DatePeriod.customRange(
            goal.startDate,
            goal.endDate ?? DateTime.now(),
          ),
        );

        final isMobile = BreakPoint.of(context).isSmallerThan(BreakpointID.md);

        final segmentedTabs = isMobile
            ? null
            : SegmentedTabBar<int>(
                selected: _tabController.index,
                onSelected: (value) =>
                    setState(() => _tabController.index = value),
                items: [
                  SegmentedTabItem(
                    value: 0,
                    icon: Icons.bar_chart_rounded,
                    label: t.goals.details.statistics,
                  ),
                  SegmentedTabItem(
                    value: 1,
                    icon: Icons.swap_vert_rounded,
                    label: t.transaction.display(n: 10),
                  ),
                ],
              );

        return PageFramework(
          title: goal.name,
          subtitle: Text(goal.type.title(context)),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: goal.type.color(context).withValues(alpha: 0.2),
            ),
            child: Icon(Goal.icon, color: goal.type.color(context), size: 22),
          ),
          tabBar: isMobile
              ? TabBar(
                  controller: _tabController,
                  tabAlignment: TabAlignment.fill,
                  isScrollable: false,
                  tabs: [
                    Tab(text: t.goals.details.statistics),
                    Tab(text: t.transaction.display(n: 10)),
                  ],
                )
              : null,
          appBarActions: [
            MonekinPopupMenuButton(
              actionItems: [
                ListTileActionItem(
                  label: t.goals.form.edit_title,
                  icon: Icons.edit,
                  onClick: () {
                    RouteUtils.showResponsiveForm(
                      GoalFormPage(goalToEdit: goal),
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
                      dialogTitle: t.goals.delete,
                      contentParagraphs: [Text(t.goals.delete_warning)],
                      confirmationText: t.ui_actions.confirm,
                      icon: Icons.delete,
                    ).then((confirmed) {
                      if (confirmed != true) return;

                      GoalService.instance
                          .deleteGoal(goal.id)
                          .then((value) {
                            RouteUtils.popRoute();
                            MonekinSnackbar.success(
                              SnackbarParams(t.general.delete_success),
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
                child: TargetHeader(target: goal, showIdentity: false),
              ),
              ?segmentedTabs,
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: isMobile
                      ? null
                      : const NeverScrollableScrollPhysics(),
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
                                StreamBuilder<double>(
                                  stream: goal.currentValue,
                                  builder: (context, currentValueSnapshot) {
                                    return FinancialTargetStatusCard(
                                      target: goal,
                                      currentValue: currentValueSnapshot.data,
                                    );
                                  },
                                ),
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
