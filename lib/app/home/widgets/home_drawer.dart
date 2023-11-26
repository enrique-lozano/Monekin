import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/routes/destinations.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/services/filters/date_range_service.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../../core/presentation/widgets/user_avatar.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer(
      {super.key,
      required this.selectedIndex,
      this.onDestinationSelected,
      required this.dateRangeService});

  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  final DateRangeService dateRangeService;

  navigateToRoute(BuildContext context, Widget route) {
    // Close drawer:
    Navigator.pop(context);

    // Go to the route:
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    List<MainMenuDestination> drawerActions = getDestinations(context,
        dateRangeService: dateRangeService,
        showHome:
            BreakPoint.of(context) >= BreakPoint.getById(BreakpointID.md));

    return NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        children: [
          StreamBuilder(
              stream: UserSettingService.instance.getSettings(
                (p0) =>
                    p0.settingKey.equalsValue(SettingKey.userName) |
                    p0.settingKey.equalsValue(SettingKey.avatar),
              ),
              builder: (context, snapshot) {
                final userName = snapshot.data
                    ?.firstWhere(
                      (element) => element.settingKey == SettingKey.userName,
                    )
                    .settingValue;
                final userAvatar = snapshot.data
                    ?.firstWhere(
                      (element) => element.settingKey == SettingKey.avatar,
                    )
                    .settingValue;

                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  accountName: userName != null
                      ? Text(
                          userName,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        )
                      : const Skeleton(width: 25, height: 12),
                  currentAccountPicture: UserAvatar(avatar: userAvatar),
                  currentAccountPictureSize: const Size.fromRadius(24),
                  accountEmail: Text(
                    t.home.hello_day,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                );
              }),
          ...List.generate(drawerActions.length, (index) {
            final item = drawerActions[index];

            return item.toNavigationDrawerDestinationWidget();
          }),
        ]);
  }
}
