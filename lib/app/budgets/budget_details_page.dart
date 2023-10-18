import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/budgets/components/budget_evolution_chart.dart';
import 'package:monekin/app/transactions/transaction_list.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/widgets/empty_indicator.dart';

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
          final budget = snapshot.data!;

          return DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: Text(t.budgets.details.title),
                bottom: TabBar(tabs: [
                  Tab(text: t.budgets.details.statistics),
                  Tab(text: t.transaction.display(n: 1)),
                ]),
                actions: [
                  MonekinPopuMenuButton(actionItems: [
                    ListTileActionItem(
                      label: t.budgets.form.edit,
                      icon: Icons.edit,
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BudgetFormPage(
                                  prevPage: const BudgetsPage(),
                                  budgetToEdit: budget),
                            ));
                      },
                    ),
                    ListTileActionItem(
                      label: t.general.delete,
                      icon: Icons.delete,
                      role: ListTileActionRole.delete,
                      onClick: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(t.budgets.delete),
                              content: Text(t.budgets.delete_warning),
                              actions: [
                                TextButton(
                                  child: Text(t.general.confirm),
                                  onPressed: () {
                                    BudgetServive.instance
                                        .deleteBudget(budget.id)
                                        .then((value) {
                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(t.general.delete)));
                                    }).catchError((err) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text('$err')));
                                    }).whenComplete(
                                            () => Navigator.pop(context));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ])
                ],
              ),
              body: TabBarView(children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CardWithHeader(
                        title: budget.name,
                        body: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        t.budgets.details.you_already_expend,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                      Builder(builder: (context) {
                                        if (budgetCurrentValue == null) {
                                          return const Skeleton(
                                              width: 25, height: 16);
                                        }

                                        return CurrencyDisplayer(
                                          amountToConvert: budgetCurrentValue!,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700),
                                        );
                                      }),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        t.budgets.details.budget_value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                      CurrencyDisplayer(
                                        amountToConvert: budget.limitAmount,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            AnimatedProgressBar(
                              value: budgetCurrentPercentage != null &&
                                      budgetCurrentPercentage! >= 1
                                  ? 1
                                  : budgetCurrentPercentage ?? 0,
                              color: budgetCurrentPercentage != null &&
                                      budgetCurrentPercentage! >= 1
                                  ? CustomColors.of(context).danger
                                  : null,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      CardWithHeader(
                          title: 'Info',
                          body: Column(
                            children: [
                              ListTile(
                                  title:
                                      Text(t.general.time.periodicity.display),
                                  trailing: Text(budget.intervalPeriod
                                          ?.allThePeriodsText(context) ??
                                      t.general.time.periodicity.no_repeat)),
                              const Divider(indent: 12),
                              ListTile(
                                  title: Text(t.general.time.start_date),
                                  trailing: Text(DateFormat.yMMMd()
                                      .format(budget.currentDateRange[0]))),
                              const Divider(indent: 12),
                              ListTile(
                                  title: Text(t.general.time.end_date),
                                  trailing: Text(DateFormat.yMMMd()
                                      .format(budget.currentDateRange[1]))),
                              const Divider(indent: 12),
                              ListTile(
                                title:
                                    Text(t.budgets.details.expend_diary_left),
                                trailing: Builder(builder: (context) {
                                  if (budgetCurrentValue == null) {
                                    return const Skeleton(
                                        width: 25, height: 16);
                                  }

                                  return CurrencyDisplayer(
                                      amountToConvert: ((budget.limitAmount -
                                                  budgetCurrentValue!) >
                                              0)
                                          ? ((budget.limitAmount -
                                                  budgetCurrentValue!) /
                                              budget.daysLeft)
                                          : 0);
                                }),
                              )
                            ],
                          )),
                      const SizedBox(height: 16),
                      CardWithHeader(
                          title: t.budgets.details.expend_evolution,
                          body: BudgetEvolutionChart(budget: budget))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: TransactionListComponent(
                    filters: TransactionFilters(
                      status: TransactionStatus.notIn({
                        TransactionStatus.pending,
                        TransactionStatus.voided
                      }),
                      minDate: budget.currentDateRange[0],
                      maxDate: budget.currentDateRange[1],
                      includeParentCategoriesInSearch: true,
                      categories: budget.categories,
                      accountsIDs: budget.accounts,
                    ),
                    prevPage: BudgetDetailsPage(budget: budget),
                    onEmptyList: EmptyIndicator(
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
