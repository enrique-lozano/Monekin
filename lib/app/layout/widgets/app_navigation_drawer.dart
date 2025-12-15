import 'package:flutter/material.dart';
import 'package:monekin/app/layout/window_bar.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Sidebar navigation drawer used in desktop layouts only
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
        backgroundColor: getWindowBackgroundColor(context),
        indicatorColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        header: SizedBox(height: AppUtils.isDesktop ? 8 : 12),
        footer: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            spacing: 12,
            children: [
              UserAvatar(
                avatar: appStateSettings[SettingKey.avatar],
                backgroundColor: AppColors.of(
                  context,
                ).onConsistentPrimary.darken(0.25),
                border: Border.all(
                  width: 2,
                  color: AppColors.of(context).onConsistentPrimary,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Skeleton(width: 100, height: 32);
                    }

                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        appStateSettings[SettingKey.userName] ?? 'User',
                        softWrap: false,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 18,
                          overflow: TextOverflow.fade,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      subtitle: Text('Thanks for trust us ❤️'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        children: List.generate(drawerActions.length, (index) {
          final item = drawerActions[index];

          return item.toNavigationDrawerDestinationWidget();
        }),
      ),
    );
  }
}
