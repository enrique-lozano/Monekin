import 'package:flutter/material.dart';
import 'package:monekin/app/home/widgets/home_drawer.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
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
  double maxWidthNavigation = 270;

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
    final menuItems = getDestinations(context,
        shortLabels: BreakPoint.of(context).isSmallerThan(BreakpointID.xl));

    selectedDestination ??= menuItems.elementAt(0);

    final selectedNavItemIndex = menuItems
        .indexWhere((element) => element.id == selectedDestination!.id);

    onDestinationSelected(int e) {
      RouteUtils.popAllRoutesExceptFirst();
      tabsPageKey.currentState?.changePage(menuItems.elementAt(e));
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOutCubicEmphasized,
      width: getNavigationSidebarWidth(context),
      child: BreakpointContainer(
        mdChild: SafeArea(
          child: NavigationRail(
              leading: const Column(
                children: [
                  SizedBox(height: 16),
                  NewTransactionButton(isExtended: false),
                  SizedBox(height: 16),
                ],
              ),
              trailing: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 16),
                    child: StreamBuilder(
                        stream: UserSettingService.instance
                            .getSettingFromDB(SettingKey.avatar),
                        builder: (context, snapshot) {
                          return UserAvatar(avatar: snapshot.data);
                        }),
                  ),
                ),
              ),
              labelType: NavigationRailLabelType.all,
              destinations: menuItems
                  .map((e) => e.toNavigationRailDestinationWidget())
                  .toList(),
              onDestinationSelected: onDestinationSelected,
              selectedIndex:
                  selectedNavItemIndex < 0 ? null : selectedNavItemIndex),
        ),
        xlChild: SafeArea(
          child: HomeDrawer(
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
