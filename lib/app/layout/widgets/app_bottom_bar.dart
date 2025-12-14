import 'package:flutter/material.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

/// Bottom navigation bar used in mobile layout
class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key, required this.selectedDestination});

  final AppMenuDestinationsID selectedDestination;

  @override
  Widget build(BuildContext context) {
    final menuItems = getDestinations(context);

    int selectedNavItemIndex = menuItems.indexWhere(
      (element) => element.id == selectedDestination,
    );

    if (!(0 <= selectedNavItemIndex &&
        selectedNavItemIndex < menuItems.length)) {
      selectedNavItemIndex = menuItems.indexWhere(
        (element) => element.id == AppMenuDestinationsID.settings,
      );

      if (selectedNavItemIndex < 0) {
        selectedNavItemIndex = 0;
      }
    }

    return NavigationBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      destinations: menuItems
          .map((e) => e.toNavigationDestinationWidget(context))
          .toList(),
      selectedIndex: selectedNavItemIndex,
      onDestinationSelected: (e) =>
          tabsPageKey.currentState?.changePage(menuItems.elementAt(e).id),
    );
  }
}
