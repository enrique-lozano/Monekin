import 'package:flutter/material.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
    required this.drawerActions,
  });

  final int selectedIndex;
  final List<MainMenuDestination> drawerActions;
  final void Function(int)? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return DrawerTheme(
      data: const DrawerThemeData(shape: RoundedRectangleBorder()),
      child: NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: Theme.of(context).cardColor,
        children: [
          const SizedBox(height: 24),
          ...List.generate(drawerActions.length, (index) {
            final item = drawerActions[index];

            return item.toNavigationDrawerDestinationWidget();
          }),

          // Solution thanks to: https://github.com/flutter/flutter/issues/127621#issuecomment-1566294032
          // TODO: Waiting for a Flutter fix to have a better way of creating a footer here
          SizedBox(
            height: MediaQuery.of(context).size.height -
                (61 * drawerActions.length),
            child: Column(
              children: [
                Expanded(child: Container()),
                const Divider(thickness: 1.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const DisplayAppIcon(height: 48),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FutureBuilder(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Skeleton(width: 100, height: 32);
                              }

                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title:
                                    Text(snapshot.data!.appName.capitalize()),
                                subtitle: Text('v${snapshot.data!.version}'),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
