import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/budgets/components/budget_evolution_chart.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/chart_by_categories.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/widgets/no_results.dart';
import 'components/budget_card.dart';

class BudgetDetailsPage extends StatefulWidget {
  const BudgetDetailsPage({super.key, required this.budget});

  final Budget budget;

  @override
  State<BudgetDetailsPage> createState() => _BudgetDetailsPageState();
}

class _BudgetDetailsPageState extends State<BudgetDetailsPage> {
  double? budgetCurrentValue;
  double? budgetCurrentPercentage;

  List<StreamSubscription<double>> subscrList = [];

  @override
  void initState() {
    super.initState();

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
      })
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

          return DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: Text(t.budgets.details.title),
                bottom: TabBar(
                  tabAlignment:
                      BreakPoint.of(context).isSmallerThan(BreakpointID.md)
                          ? TabAlignment.fill
                          : TabAlignment.start,
                  isScrollable:
                      !BreakPoint.of(context).isSmallerThan(BreakpointID.md),
                  tabs: [
                    Tab(text: t.budgets.details.statistics),
                    Tab(text: t.transaction.display(n: 1)),
                  ],
                ),
                actions: [
                  MonekinPopupMenuButton(actionItems: [
                    ListTileActionItem(
                      label: t.budgets.form.edit,
                      icon: Icons.edit,
                      onClick: () {
                        RouteUtils.pushRoute(
                          context,
                          BudgetFormPage(
                              prevPage: const BudgetsPage(),
                              budgetToEdit: budget),
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
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(t.budgets.delete),
                            ));
                          }).catchError((err) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('$err')));
                          });
                        });
                      },
                    )
                  ])
                ],
              ),
              body: TabBarView(children: [
                Column(
                  children: [
                    BudgetCard(
                      budget: budget,
                      isHeader: true,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CardWithHeader(
                                title: t.budgets.details.expend_evolution,
                                body: BudgetEvolutionChart(budget: budget)),
                            const SizedBox(height: 16),
                            CardWithHeader(
                              title: t.stats.by_categories,
                              body: ChartByCategories(
                                filters: budget.trFilters,
                                datePeriodState: budget.periodState,
                              ),
                              footer: CardFooterWithSingleButton(
                                onButtonClick: () => RouteUtils.pushRoute(
                                  context,
                                  const StatsPage(initialIndex: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: TransactionListComponent(
                    heroTagBuilder: (tr) => 'budgets-page__tr-icon-${tr.id}',
                    filters: budget.trFilters,
                    prevPage: BudgetDetailsPage(budget: budget),
                    onEmptyList: NoResults(
                        title: t.general.empty_warn,
                        description: t.budgets.details.no_transactions),
                  ),
                )
              ]),
            ),
          );
        });
  }
}
