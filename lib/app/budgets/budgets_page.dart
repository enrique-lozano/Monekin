import 'package:flutter/material.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/targets/target_list_with_empty_indicator.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/app_utils.dart';
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
    final isMobile = AppUtils.isMobileLayout(context);

    // On desktop, Flutter's swipeable TabBar feels foreign, so we drive the
    // content with a segmented control placed at the top of the body (fixed,
    // not inside the app bar).
    final segmentedTabs = isMobile
        ? null
        : SegmentedTabBar<int>(
            selected: _tabController.index,
            onSelected: (value) => setState(() => _tabController.index = value),
            items: [
              SegmentedTabItem(
                value: 0,
                icon: Icons.repeat_rounded,
                label: t.budgets.repeated,
              ),
              SegmentedTabItem(
                value: 1,
                icon: Icons.event_rounded,
                label: t.budgets.one_time,
              ),
            ],
          );

    return PageFramework(
      title: t.budgets.title,
      tabBar: isMobile
          ? TabBar(
              controller: _tabController,
              tabAlignment: TabAlignment.fill,
              isScrollable: false,
              tabs: [
                Tab(text: t.budgets.repeated),
                Tab(text: t.budgets.one_time),
              ],
            )
          : null,
      // Wide: create action in app bar; mobile: FAB.
      appBarActions: isMobile
          ? null
          : [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton.icon(
                  style: getMediumButtonStyle(context),
                  onPressed: () => RouteUtils.showResponsiveForm(
                    const BudgetFormPage(prevPage: BudgetsPage()),
                  ),
                  icon: const Icon(Icons.add_rounded),
                  label: Text(t.budgets.form.create),
                ),
              ),
            ],
      floatingActionButton: (ifIsInTabs(context) || !isMobile)
          ? null
          : const BudgetFabButton(),
      body: Column(
        children: [
          ?segmentedTabs,
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: isMobile ? null : const NeverScrollableScrollPhysics(),
              children: [
                StreamBuilder(
                  stream: BudgetServive.instance.getBudgets(
                    predicate: (p0, trF) => p0.intervalPeriod.isNotNull(),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Column(
                        children: [LinearProgressIndicator()],
                      );
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
                      return const Column(
                        children: [LinearProgressIndicator()],
                      );
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
      onPressed: () => RouteUtils.showResponsiveForm(
        const BudgetFormPage(prevPage: BudgetsPage()),
      ),
    );
  }
}
