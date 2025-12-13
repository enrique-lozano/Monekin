import 'package:flutter/material.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/layout/scaffold_configuration.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:monekin/page_framework.dart';

import 'components/budget_card.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage>
    with PageWithScaffold, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  ScaffoldConfiguration get scaffoldConfiguration {
    final t = Translations.of(context);

    return ScaffoldConfiguration(
      title: t.budgets.title,
      tabBar: TabBar(
        controller: _tabController,
        tabAlignment: BreakPoint.of(context).isSmallerThan(BreakpointID.md)
            ? TabAlignment.fill
            : TabAlignment.start,
        isScrollable: !BreakPoint.of(context).isSmallerThan(BreakpointID.md),
        tabs: [
          Tab(text: t.budgets.repeated),
          Tab(text: t.budgets.one_time),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey(),
        icon: const Icon(Icons.add_rounded),
        label: Text(t.budgets.form.create),
        onPressed: () => RouteUtils.pushRoute(
          context,
          const BudgetFormPage(prevPage: BudgetsPage()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      scaffoldConfiguration: scaffoldConfiguration,
      body: TabBarView(
        controller: _tabController,
        children: [
          StreamBuilder(
            stream: BudgetServive.instance.getBudgets(
              predicate: (p0) => p0.intervalPeriod.isNotNull(),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Column(children: [LinearProgressIndicator()]);
              }

              final budgets = snapshot.data!;

              if (budgets.isEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: NoResults(
                        title: t.general.empty_warn,
                        description: t.budgets.no_budgets,
                      ),
                    ),
                  ],
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 74,
                ).withSafeBottom(context),
                itemBuilder: (context, index) {
                  final budget = budgets[index];

                  return BudgetCard(budget: budget);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox.shrink();
                },
                itemCount: budgets.length,
              );
            },
          ),
          StreamBuilder(
            stream: BudgetServive.instance.getBudgets(
              predicate: (p0) => p0.intervalPeriod.isNull(),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Column(children: [LinearProgressIndicator()]);
              }

              final budgets = snapshot.data!;

              if (budgets.isEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: NoResults(
                        title: t.general.empty_warn,
                        description: t.budgets.no_budgets,
                      ),
                    ),
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
                itemCount: budgets.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
