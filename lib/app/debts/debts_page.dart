import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:monekin/app/debts/debt_form_page.dart';
import 'package:monekin/app/debts/debt_list.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/debt/debt_direction.enum.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class DebtsPage extends StatefulWidget {
  const DebtsPage({super.key});

  @override
  State<DebtsPage> createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage>
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
    final tabBar = TabBar(
      controller: _tabController,
      tabAlignment: BreakPoint.of(context).isSmallerThan(BreakpointID.md)
          ? TabAlignment.fill
          : TabAlignment.start,
      isScrollable: !BreakPoint.of(context).isSmallerThan(BreakpointID.md),
      tabs: [
        Tab(text: "Active"),
        Tab(text: "Closed"),
      ],
    );

    return PageFramework(
      title: t.budgets.title,
      tabBar: tabBar,
      floatingActionButton: ifIsInTabs(context) ? null : const DebtFabButton(),
      floatingActionButtonLocation: ExpandableFab.location,

      body: TabBarView(
        controller: _tabController,
        children: [
          const DebtsView(isActive: true),
          const DebtsView(isActive: false),
        ],
      ),
    );
  }
}

class DebtsView extends StatelessWidget {
  const DebtsView({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Debt>>(
      stream: DebtServive.instance.getDebts(
        predicate: (debts, _) =>
            isActive ? debts.endDate.isNull() : debts.endDate.isNotNull(),
        orderBy: (debts, _) => drift.OrderBy([
          drift.OrderingTerm(
            expression: debts.startDate,
            mode: drift.OrderingMode.desc,
          ),
        ]),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final debts = snapshot.data!;

        if (debts.isEmpty) {
          return const Center(child: Text('No debts found'));
        }

        final lentDebts = debts
            .where((d) => d.type == DebtDirection.lent)
            .toList();
        final borrowedDebts = debts
            .where((d) => d.type == DebtDirection.borrowed)
            .toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (lentDebts.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    "Money Lent",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DebtList(
                  debts: lentDebts,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
              if (borrowedDebts.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    "Money Borrowed",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DebtList(
                  debts: borrowedDebts,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class DebtFabButton extends StatelessWidget {
  const DebtFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ExpandableFab(
      overlayStyle: ExpandableFabOverlayStyle(color: Colors.transparent),
      type: ExpandableFabType.up,
      pos: ExpandableFabPos.right,
      duration: const Duration(milliseconds: 250),
      distance: 56,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add_rounded),
        fabSize: ExpandableFabSize.regular,
      ),
      closeButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        backgroundColor: Colors.red.shade100,
        foregroundColor: Colors.red.shade400,
        fabSize: ExpandableFabSize.small,
      ),
      children: [
        buildFabOption(DebtDirection.lent),
        buildFabOption(DebtDirection.borrowed),
      ],
    );
  }

  Widget buildFabOption(DebtDirection direction) {
    return SizedBox(
      height: 48,
      child: FloatingActionButton.extended(
        heroTag: null,
        icon: Icon(direction.icon()),
        label: Text("Me prestaron"),
        onPressed: () {
          RouteUtils.pushRoute(DebtFormPage(type: direction));
        },
      ),
    );
  }
}
