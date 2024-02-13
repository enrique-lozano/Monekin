import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/home/main_layout_observer.dart';
import 'package:monekin/app/home/widgets/home_drawer.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/routes/destinations.dart';

@RoutePage()
class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  @override
  Widget build(BuildContext context) {
    final menuItems = getDestinations(context,
        shortLabels: BreakPoint.of(context).isSmallerThan(BreakpointID.xl));

    return HeroControllerScope(
      controller: HeroController(),
      child: Scaffold(
        body: StreamBuilder(
            stream: layoutInsideRouteName.stream,
            builder: (context, snapshot) {
              final selectedNavItemIndex = menuItems.indexWhere(
                  (element) => element.destination.routeName == snapshot.data);

              return BreakpointContainer(
                  mdChild: SafeArea(
                    child: Row(
                      children: [
                        NavigationRail(
                            leading: const Column(
                              children: [
                                SizedBox(height: 16),
                                NewTransactionButton(),
                                SizedBox(height: 16),
                              ],
                            ),
                            trailing: Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 16, top: 16),
                                  child: StreamBuilder(
                                      stream: UserSettingService.instance
                                          .getSetting(SettingKey.avatar),
                                      builder: (context, snapshot) {
                                        return UserAvatar(
                                            avatar: snapshot.data);
                                      }),
                                ),
                              ),
                            ),
                            labelType: NavigationRailLabelType.all,
                            destinations: menuItems
                                .map((e) =>
                                    e.toNavigationRailDestinationWidget())
                                .toList(),
                            onDestinationSelected: (e) {
                              if (e == selectedNavItemIndex) return;

                              AutoRouter.of(context)
                                  .push(menuItems.elementAt(e).destination);
                            },
                            selectedIndex: selectedNavItemIndex < 0
                                ? null
                                : selectedNavItemIndex),
                        const VerticalDivider(thickness: 2, width: 1),
                        const _RightWidgetContainer()
                      ],
                    ),
                  ),
                  xlChild: SafeArea(
                    child: Row(
                      children: [
                        HomeDrawer(
                          drawerActions: menuItems,
                          onDestinationSelected: (e) {
                            if (e == selectedNavItemIndex) return;

                            AutoRouter.of(context)
                                .navigate(menuItems.elementAt(e).destination);
                          },
                          selectedIndex: selectedNavItemIndex,
                        ),
                        const _RightWidgetContainer()
                      ],
                    ),
                  ),
                  child: AutoTabsRouter(
                    key: tabsLayoutKey,

                    // The routes here should be sub-routes of the MainLayoutRoute
                    routes: menuItems.map((e) => e.destination).toList(),
                    transitionBuilder: (context, child, animation) =>
                        FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    builder: (context, child) {
                      // -- We can also use the context insted of the tabsLayoutKey:
                      // final tabsRouter = AutoTabsRouter.of(context);

                      return Scaffold(
                          body: child,
                          bottomNavigationBar: NavigationBar(
                            selectedIndex: tabsLayoutKey
                                .currentState!.controller!.activeIndex,
                            onDestinationSelected: (e) {
                              tabsLayoutKey.currentState!.controller!
                                  .setActiveIndex(e);
                            },
                            destinations: menuItems
                                .map((e) => e.toNavigationDestinationWidget())
                                .toList(),
                          ));
                    },
                  ));
            }),
      ),
    );
  }
}

class _RightWidgetContainer extends StatelessWidget {
  const _RightWidgetContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          clipBehavior: Clip.hardEdge,
          child: AutoRouter(
            key: mainLayoutRouterKey,
            navigatorObservers: () => [MainLayoutNavObserver()],
          ),
        ),
      ),
    );
  }
}
