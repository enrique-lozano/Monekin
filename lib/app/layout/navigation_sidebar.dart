import 'package:flutter/material.dart';
import 'package:monekin/app/layout/navigation_drawer.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/main.dart';

double getNavigationSidebarWidth(BuildContext context) {
  if (BreakPoint.of(context).isSmallerThan(BreakpointID.md)) {
    return 0;
  }

  if (BreakPoint.of(context).isSmallerThan(BreakpointID.xl)) {
    return 108;
  }

  double screenPercent = 0.3;
  double maxWidthNavigation = 240;

  return (MediaQuery.sizeOf(context).width * screenPercent > maxWidthNavigation
          ? maxWidthNavigation
          : MediaQuery.sizeOf(context).width * screenPercent) +
      MediaQuery.viewPaddingOf(context).left;
}

class NavigationSidebar extends StatefulWidget {
  const NavigationSidebar({super.key});

  @override
  State<NavigationSidebar> createState() => NavigationSidebarState();
}

class NavigationSidebarState extends State<NavigationSidebar> {
  MainMenuDestination? selectedDestination;

  setSelectedDestination(MainMenuDestination? destination) {
    setState(() {
      selectedDestination = destination;
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = getDestinations(
      context,
      shortLabels: BreakPoint.of(context).isSmallerThan(BreakpointID.xl),
    );

    selectedDestination ??= menuItems.elementAt(0);

    final selectedNavItemIndex = menuItems.indexWhere(
      (element) => element.id == selectedDestination!.id,
    );

    onDestinationSelected(int e) {
      RouteUtils.popAllRoutesExceptFirst();
      tabsPageKey.currentState?.changePage(menuItems.elementAt(e));
    }

    final navSidebarWidth = getNavigationSidebarWidth(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOutCubicEmphasized,
      width: navSidebarWidth,
      child: BreakpointContainer(
        mdChild: SafeArea(
          child: NavigationRail(
            leading: const SizedBox(height: 8),
            backgroundColor: Theme.of(context).cardColor,
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  child: DisplayAppIcon(height: navSidebarWidth - 48),
                ),
              ),
            ),
            labelType: NavigationRailLabelType.all,
            destinations: menuItems
                .map((e) => e.toNavigationRailDestinationWidget())
                .toList(),
            onDestinationSelected: onDestinationSelected,
            selectedIndex: selectedNavItemIndex < 0
                ? null
                : selectedNavItemIndex,
          ),
        ),
        xlChild: SafeArea(
          child: SideNavigationDrawer(
            drawerActions: menuItems,
            onDestinationSelected: onDestinationSelected,
            selectedIndex: selectedNavItemIndex,
          ),
        ),
        child: Container(),
      ),
    );
  }
}
