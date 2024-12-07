import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../../core/presentation/widgets/user_avatar.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer(
      {super.key,
      required this.selectedIndex,
      this.onDestinationSelected,
      required this.drawerActions});

  final int selectedIndex;
  final List<MainMenuDestination> drawerActions;
  final void Function(int)? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
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

                if (BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.lg)) {
                  return DrawerHeader(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              UserAvatar(avatar: userAvatar),
                              const SizedBox(width: 12),
                              UserGreting(userName: userName)
                            ],
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: NewTransactionButton(isExtended: true),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  accountName: UserGreting(userName: userName),
                  currentAccountPicture: UserAvatar(avatar: userAvatar),
                  currentAccountPictureSize: const Size.fromRadius(24),
                  accountEmail: null,
                );
              }),
          ...List.generate(drawerActions.length, (index) {
            final item = drawerActions[index];

            return item.toNavigationDrawerDestinationWidget();
          }),
        ]);
  }
}

class UserGreting extends StatelessWidget {
  const UserGreting({
    super.key,
    required this.userName,
  });
  final String? userName;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.home.hello_day,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (userName == null)
          const Skeleton(width: 25, height: 12)
        else
          Text(
            userName!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
      ],
    );
  }
}
