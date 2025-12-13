import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/app/layout/navigation_drawer.dart';
import 'package:monekin/app/layout/window_bar.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

double getNavigationSidebarWidth(BuildContext context) {
  final padding = MediaQuery.viewPaddingOf(context).left;

  if (AppUtils.isMobileLayout(context)) {
    return 0;
  } else if (BreakPoint.of(context).isSmallerThan(BreakpointID.xl)) {
    return 108 + padding;
  }

  double screenPercent = 0.3;
  double maxWidthNavigation = 240 + padding;

  return min(
    maxWidthNavigation,
    MediaQuery.sizeOf(context).width * screenPercent,
  );
}

class NavigationSidebar extends StatefulWidget {
  const NavigationSidebar({super.key});

  @override
  State<NavigationSidebar> createState() => NavigationSidebarState();
}

class NavigationSidebarState extends State<NavigationSidebar> {
  AppMenuDestinationsID? selectedDestination;

  void setSelectedDestination(AppMenuDestinationsID? destination) {
    setState(() {
      selectedDestination = destination;
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = getDestinations(context);

    selectedDestination ??= menuItems.elementAt(0).id;

    final selectedNavItemIndex = menuItems.indexWhere(
      (element) => element.id == selectedDestination!,
    );

    onDestinationSelected(int e) {
      RouteUtils.popAllRoutesExceptFirst();
      tabsPageKey.currentState?.changePage(menuItems.elementAt(e).id);
    }

    final navSidebarWidth = getNavigationSidebarWidth(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOutCubicEmphasized,
      width: navSidebarWidth,
      child: Builder(
        builder: (context) {
          if (navSidebarWidth == 0) {
            return const SizedBox.shrink();
          }

          return BreakpointContainer(
            xlChild: SideNavigationDrawer(
              drawerActions: menuItems,
              onDestinationSelected: onDestinationSelected,
              selectedIndex: selectedNavItemIndex,
            ),
            child: NavigationRail(
              destinations: menuItems
                  .map((e) => e.toNavigationRailDestinationWidget())
                  .toList(),
              onDestinationSelected: onDestinationSelected,
              leading: const SizedBox(height: 2),
              backgroundColor: getWindowBackgroundColor(context),
              labelType: NavigationRailLabelType.all,
              scrollable: true,
              leadingAtTop: true,
              trailingAtBottom: true,
              selectedIndex: selectedNavItemIndex < 0
                  ? null
                  : selectedNavItemIndex,
              trailing: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.bottomCenter,
                child: UserAvatar(
                  avatar: appStateSettings[SettingKey.avatar],
                  backgroundColor: AppColors.of(
                    context,
                  ).onConsistentPrimary.darken(0.25),
                  border: Border.all(
                    width: 2,
                    color: AppColors.of(context).onConsistentPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
