import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:monekin/app/debts/components/debt_fab_button.dart';
import 'package:monekin/app/debts/components/debt_list.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/debt/debt_direction.enum.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

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
      stream: DebtServive.instance
          .getDebts(
            orderBy: (debts, _) => drift.OrderBy([
              drift.OrderingTerm(
                expression: debts.startDate,
                mode: drift.OrderingMode.desc,
              ),
            ]),
          )
          .switchMap((debts) {
            if (debts.isEmpty) return Stream.value(<Debt>[]);
            return Rx.combineLatestList(
              debts.map(
                (debt) => DebtServive.instance
                    .getDebtRemainingAmount(debt)
                    .map((remaining) => (debt: debt, remaining: remaining)),
              ),
            ).map(
              (entries) => entries
                  .where((e) => isActive ? e.remaining > 0 : e.remaining == 0)
                  .map((e) => e.debt)
                  .toList(),
            );
          }),
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
                _SectionHeader(direction: DebtDirection.lent),
                DebtList(
                  debts: lentDebts,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  showOverdueWarning: isActive,
                ),
              ],
              if (lentDebts.isNotEmpty && borrowedDebts.isNotEmpty) ...[
                const SizedBox(height: 8),
                Divider(height: 8, indent: 12, endIndent: 12),
              ],
              if (borrowedDebts.isNotEmpty) ...[
                _SectionHeader(direction: DebtDirection.borrowed),
                DebtList(
                  debts: borrowedDebts,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  showOverdueWarning: isActive,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.direction});

  final DebtDirection direction;

  @override
  Widget build(BuildContext context) {
    final color = direction.color(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        spacing: 8,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(direction.icon(), size: 14, color: color),
          ),
          Text(
            direction.title(context),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
