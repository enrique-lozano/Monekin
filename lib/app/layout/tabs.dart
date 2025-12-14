import 'package:flutter/material.dart' hide BottomNavigationBar;
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/layout/bottom_navigation_bar.dart';
import 'package:monekin/app/layout/lazy_indexed_stack.dart';
import 'package:monekin/app/transactions/animate_fab.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/page_context.dart';
import 'package:monekin/page_framework.dart';

/// This page is the entry point of the app once the user has complete onboarding
class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => TabsPageState();
}

class TabsPageState extends State<TabsPage> {
  AppMenuDestinationsID? selectedDestination;
  final allDestinations = getAllDestinations();

  void changePage(AppMenuDestinationsID destination) {
    navigationSidebarKey.currentState?.setSelectedDestination(destination);

    if (selectedDestination == destination) {
      return;
    }

    setState(() {
      selectedDestination = destination;
    });

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = getDestinations(context);
    selectedDestination ??= menuItems.first.id;

    final selectedIndex = allDestinations.indexWhere(
      (element) => element.id == selectedDestination,
    );

    return PopScope(
      canPop: selectedDestination == AppMenuDestinationsID.dashboard,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (selectedDestination != AppMenuDestinationsID.dashboard &&
            transactionsPageKey.currentState?.canPop == true) {
          changePage(AppMenuDestinationsID.dashboard);
          return;
        }
      },
      child: PageFramework(
        enableAppBar: false,
        body: PageContext(
          isInTabs: true,
          child: FadeIndexedStack(
            index: selectedIndex,
            duration: !AppUtils.isDesktop
                ? Duration.zero
                : const Duration(milliseconds: 300),
            children: allDestinations.map((e) => e.destination).toList(),
          ),
        ),
        floatingActionButton: AnimateFAB(
          condition:
              selectedDestination == AppMenuDestinationsID.transactions ||
              selectedDestination == AppMenuDestinationsID.dashboard ||
              selectedDestination == AppMenuDestinationsID.budgets,
          fab: Builder(
            builder: (context) {
              if (selectedDestination == AppMenuDestinationsID.budgets) {
                return const BudgetFabButton();
              }

              return NewTransactionButton(
                isExtended: BreakPoint.of(
                  context,
                ).isLargerThan(BreakpointID.md),
              );
            },
          ),
        ),
        bottomNavigationBar: AppUtils.isMobileLayout(context)
            ? BottomNavigationBar(selectedDestination: selectedDestination!)
            : null,
      ),
    );
  }
}

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit sizing;

  const FadeIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 250),
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
  });

  @override
  FadeIndexedStackState createState() => FadeIndexedStackState();
}

class FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: LazyIndexedStack(
        index: widget.index,
        alignment: widget.alignment,
        textDirection: widget.textDirection,
        sizing: widget.sizing,
        children: widget.children,
      ),
    );
  }
}
