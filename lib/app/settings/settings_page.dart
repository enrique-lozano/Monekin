import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/pages/appareance_settings.page.dart';
import 'package:monekin/app/settings/pages/backup/backup_settings.page.dart';
import 'package:monekin/app/settings/pages/general_settings.page.dart';
import 'package:monekin/app/settings/pages/transactions_settings.page.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.settings.title_short,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16).withSafeBottom(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingRouteTile(
              title: t.settings.general.menu_title,
              subtitle: t.settings.general.menu_descr,
              icon: Icons.settings_rounded,
              onTap: () => RouteUtils.pushRoute(const GeneralSettingsPage()),
            ),
            SettingRouteTile(
              title: t.settings.transactions.menu_title,
              subtitle: t.settings.transactions.menu_descr,
              icon: Icons.list,
              onTap: () =>
                  RouteUtils.pushRoute(const TransactionsSettingsPage()),
            ),
            SettingRouteTile(
              title: t.settings.appearance.menu_title,
              subtitle: t.settings.appearance.menu_descr,
              icon: Icons.color_lens_rounded,
              onTap: () => RouteUtils.pushRoute(const AppareanceSettingsPage()),
            ),
            SettingRouteTile(
              title: t.more.data.display,
              subtitle: t.more.data.display_descr,
              icon: Icons.save_rounded,
              onTap: () => RouteUtils.pushRoute(const BackupSettingsPage()),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingRouteTile extends StatelessWidget {
  const SettingRouteTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      subtitle: Text(subtitle),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
