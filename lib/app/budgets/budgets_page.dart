import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/budgets/budget_details_page.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/empty_indicator.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/i18n/translations.g.dart';

class BudgetsPage extends StatelessWidget {
  const BudgetsPage({super.key});

  Widget buildBudgetCard(BuildContext context, Budget budget) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BudgetDetailsPage(budget: budget))),
      child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    budget.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Chip(
                      side:
                          const BorderSide(width: 0, color: Colors.transparent),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      padding: const EdgeInsets.all(0),
                      label: Text(
                        budget.intervalPeriod?.allThePeriodsText(context) ??
                            '${DateFormat.yMMMd().format(budget.currentDateRange[0])} - ${DateFormat.yMMMd().format(budget.currentDateRange[1])}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ))
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                      stream: budget.currentValue,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Skeleton(width: 25, height: 16);
                        }

                        return CurrencyDisplayer(
                          amountToConvert: snapshot.data!,
                          showDecimals: false,
                        );
                      }),
                  CurrencyDisplayer(
                    amountToConvert: budget.limitAmount,
                    showDecimals: false,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              StreamBuilder(
                  stream: budget.percentageAlreadyUsed,
                  builder: (context, snapshot) {
                    final budgetValue = snapshot.data;

                    return AnimatedProgressBar(
                      value: budgetValue != null && budgetValue >= 1
                          ? 1
                          : budgetValue ?? 0,
                      color: budgetValue != null && budgetValue >= 1
                          ? Colors.red
                          : null,
                    );
                  })
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.budgets.title),
          bottom: TabBar(
            tabs: [
              Tab(text: t.budgets.repeated),
              Tab(text: t.budgets.one_time),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.add_rounded),
            label: Text(t.budgets.form.create),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BudgetFormPage(
                                prevPage: BudgetsPage(),
                              )))
                }),
        body: TabBarView(children: [
          StreamBuilder(
              stream: BudgetServive.instance
                  .getBudgets(predicate: (p0) => p0.intervalPeriod.isNotNull()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [LinearProgressIndicator()],
                  );
                }

                final budgets = snapshot.data!;

                if (budgets.isEmpty) {
                  return Column(
                    children: [
                      Expanded(
                          child: EmptyIndicator(
                              title: t.general.empty_warn,
                              description: t.budgets.no_budgets)),
                    ],
                  );
                }

                return ListView.separated(
                    itemBuilder: (context, index) {
                      final budget = budgets[index];

                      return buildBudgetCard(context, budget);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: budgets.length);
              }),
          StreamBuilder(
              stream: BudgetServive.instance
                  .getBudgets(predicate: (p0) => p0.intervalPeriod.isNull()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [LinearProgressIndicator()],
                  );
                }

                final budgets = snapshot.data!;

                if (budgets.isEmpty) {
                  return Column(
                    children: [
                      Expanded(
                          child: EmptyIndicator(
                              title: t.general.empty_warn,
                              description: t.budgets.no_budgets)),
                    ],
                  );
                }

                return ListView.separated(
                    itemBuilder: (context, index) {
                      final budget = budgets[index];

                      return buildBudgetCard(context, budget);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: budgets.length);
              }),
        ]),
      ),
    );
  }
}
