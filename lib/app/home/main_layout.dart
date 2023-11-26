import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/home/main_layout_observer.dart';
import 'package:monekin/app/home/widgets/home_drawer.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/routes/destinations.dart';

@RoutePage()
class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({Key? key}) : super(key: key);

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  @override
  Widget build(BuildContext context) {
    final menuItems = getDestinations(context);

    return HeroControllerScope(
      controller: HeroController(),
      child: Scaffold(
        body: StreamBuilder(
            stream: layoutInsideRouteName.stream,
            builder: (context, snapshot) {
              final selectedNavItemIndex = menuItems.indexWhere(
                  (element) => element.destination.routeName == snapshot.data);

              return BreakpointContainer(
                mdChild: Row(
                  children: [
                    NavigationRail(
                        destinations: menuItems
                            .map((e) => e.toNavigationRailDestinationWidget())
                            .toList(),
                        onDestinationSelected: (e) {
                          if (e == selectedNavItemIndex) return;

                          AutoRouter.of(context)
                              .push(menuItems.elementAt(e).destination);
                        },
                        selectedIndex: selectedNavItemIndex < 0
                            ? null
                            : selectedNavItemIndex),
                    Expanded(
                      child: AutoRouter(
                        key: mainLayoutRouterKey,
                        navigatorObservers: () => [MainLayoutNavObserver()],
                      ),
                    )
                  ],
                ),
                lgChild: Row(
                  children: [
                    HomeDrawer(
                      drawerActions: menuItems,
                      onDestinationSelected: (e) {
                        if (e == selectedNavItemIndex) return;

                        AutoRouter.of(context)
                            .push(menuItems.elementAt(e).destination);
                      },
                      selectedIndex: selectedNavItemIndex,
                    ),
                    Expanded(
                      child: AutoRouter(
                        key: mainLayoutRouterKey,
                        navigatorObservers: () => [MainLayoutNavObserver()],
                      ),
                    )
                  ],
                ),
                child: AutoRouter(
                  key: mainLayoutRouterKey,
                  navigatorObservers: () => [MainLayoutNavObserver()],
                ),
              );
            }),
      ),
    );
  }
}
