import 'package:flutter/material.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/targets/target_list_with_empty_indicator.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final tabBar = TabBar(
      controller: _tabController,
      tabAlignment: BreakPoint.of(context).isSmallerThan(BreakpointID.md)
          ? TabAlignment.fill
          : TabAlignment.start,
      isScrollable: !BreakPoint.of(context).isSmallerThan(BreakpointID.md),
      tabs: [
        Tab(text: t.budgets.repeated),
        Tab(text: t.budgets.one_time),
      ],
    );

    return PageFramework(
      title: t.budgets.title,
      tabBar: tabBar,
      floatingActionButton: ifIsInTabs(context)
          ? null
          : const BudgetFabButton(),
      body: TabBarView(
        controller: _tabController,
        children: [
          StreamBuilder(
            stream: BudgetServive.instance.getBudgets(
              predicate: (p0, trF) => p0.intervalPeriod.isNotNull(),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Column(children: [LinearProgressIndicator()]);
              }

              final budgets = snapshot.data!;

              return TargetListWithEmptyIndicator(
                targets: budgets,
                emptyDescription: t.budgets.no_budgets,
              );
            },
          ),
          StreamBuilder(
            stream: BudgetServive.instance.getBudgets(
              predicate: (p0, trF) => p0.intervalPeriod.isNull(),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Column(children: [LinearProgressIndicator()]);
              }

              final budgets = snapshot.data!;

              return TargetListWithEmptyIndicator(
                targets: budgets,
                emptyDescription: t.budgets.no_budgets,
              );
            },
          ),
        ],
      ),
    );
  }
}

class BudgetFabButton extends StatelessWidget {
  const BudgetFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FloatingActionButton.extended(
      heroTag: UniqueKey(),
      icon: const Icon(Icons.add_rounded),
      label: Text(t.budgets.form.create),
      onPressed: () =>
          RouteUtils.pushRoute(const BudgetFormPage(prevPage: BudgetsPage())),
    );
  }
}
