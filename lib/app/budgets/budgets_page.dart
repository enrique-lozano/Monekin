import 'package:flutter/material.dart';
import 'package:parsa/app/budgets/budget_form_page.dart';
import 'package:parsa/core/database/services/budget/budget_service.dart';
import 'package:parsa/core/presentation/widgets/no_results.dart';
import 'package:parsa/core/routes/route_utils.dart';
import 'package:parsa/i18n/translations.g.dart';

import 'components/budget_card.dart';

class BudgetsPage extends StatelessWidget {
  const BudgetsPage({super.key});

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
            heroTag: UniqueKey(),
            icon: const Icon(Icons.add_rounded),
            label: Text(t.budgets.form.create),
            onPressed: () => RouteUtils.pushRoute(
                  context,
                  const BudgetFormPage(prevPage: BudgetsPage()),
                )),
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
                          child: NoResults(
                              title: t.general.empty_warn,
                              description: t.budgets.no_budgets)),
                    ],
                  );
                }

                return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      final budget = budgets[index];

                      return BudgetCard(budget: budget);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox.shrink();
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
                          child: NoResults(
                              title: t.general.empty_warn,
                              description: t.budgets.no_budgets)),
                    ],
                  );
                }

                return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      final budget = budgets[index];

                      return BudgetCard(budget: budget);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox.shrink();
                    },
                    itemCount: budgets.length);
              }),
        ]),
      ),
    );
  }
}
