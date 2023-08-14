import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../../core/presentation/widgets/user_avatar.dart';
import '../../budgets/budgets_page.dart';
import '../../settings/settings.page.dart';
import '../../transactions/recurrent_transactions_page.dart';
import '../../transactions/transactions.page.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

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

    List<ListTileActionItem> drawerActions = [
      ListTileActionItem(
        label: t.budgets.title,
        icon: Icons.calculate,
        onClick: () => navigateToRoute(context, const BudgetsPage()),
      ),
      ListTileActionItem(
        label: t.general.accounts,
        icon: Icons.account_balance_rounded,
        onClick: () => navigateToRoute(context, const AllAccountsPage()),
      ),
      ListTileActionItem(
        label: t.general.transactions,
        icon: Icons.app_registration_rounded,
        onClick: () => navigateToRoute(context, const TransactionsPage()),
      ),
      ListTileActionItem(
          label: t.recurrent_transactions.title,
          icon: Icons.auto_mode_rounded,
          onClick: () =>
              navigateToRoute(context, const RecurrentTransactionPage())),
      ListTileActionItem(
        label: t.stats.title,
        icon: Icons.auto_graph_rounded,
        onClick: () => navigateToRoute(context, const StatsPage()),
      ),
      ListTileActionItem(
        label: t.settings.title,
        icon: Icons.settings,
        onClick: () => navigateToRoute(context, const SettingsPage()),
      ),
    ];

    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
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
                accountName: userName != null
                    ? Text(userName)
                    : const Skeleton(width: 25, height: 12),
                currentAccountPicture: UserAvatar(avatar: userAvatar),
                currentAccountPictureSize: const Size.fromRadius(24),
                accountEmail: Text(
                  t.home.hello_day,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              );
            }),
        ...List.generate(drawerActions.length, (index) {
          final item = drawerActions[index];
          return ListTile(
            title: Text(item.label),
            leading: Icon(item.icon),
            onTap: item.onClick,
          );
        }),
      ]),
    );
  }
}
