import 'package:flutter/material.dart' hide BottomNavigationBar;
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/layout/indexed_stacks/fade_indexed_stack.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/layout/widgets/app_bottom_bar.dart';
import 'package:monekin/app/transactions/animate_fab.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

/// This page is the entry point of the app once the user has complete onboarding
///
/// It contains the main layout structure with the selected page/destination and
/// the bottom navigation bar in mobile layouts
class PageSwitcher extends StatefulWidget {
  const PageSwitcher({super.key});

  @override
  State<PageSwitcher> createState() => PageSwitcherState();
}

class PageSwitcherState extends State<PageSwitcher> {
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
            (transactionsPageKey.currentState == null ||
                transactionsPageKey.currentState?.canPop == true)) {
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
            ? AppBottomBar(selectedDestination: selectedDestination!)
            : null,
      ),
    );
  }
}
