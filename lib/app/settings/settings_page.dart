import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/categories/categories_list_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/pages/appareance_settings.page.dart';
import 'package:monekin/app/settings/pages/backup/backup_settings.page.dart';
import 'package:monekin/app/settings/pages/general_settings.page.dart';
import 'package:monekin/app/settings/pages/transactions_settings.page.dart';
import 'package:monekin/app/tags/tag_list.page.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/saved_filters_list_page.dart';
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
            _SettingRouteTile(
              title: t.settings.general.menu_title,
              subtitle: t.settings.general.menu_descr,
              icon: Icons.settings_rounded,
              onTap: () => RouteUtils.pushRoute(const GeneralSettingsPage()),
            ),
            _SettingRouteTile(
              title: t.settings.transactions.menu_title,
              subtitle: t.settings.transactions.menu_descr,
              icon: Icons.list,
              onTap: () =>
                  RouteUtils.pushRoute(const TransactionsSettingsPage()),
            ),
            _SettingRouteTile(
              title: t.settings.appearance.menu_title,
              subtitle: t.settings.appearance.menu_descr,
              icon: Icons.color_lens_rounded,
              onTap: () => RouteUtils.pushRoute(const AppareanceSettingsPage()),
            ),
            _SettingRouteTile(
              title: t.more.data.display,
              subtitle: t.more.data.display_descr,
              icon: Icons.save_rounded,
              onTap: () => RouteUtils.pushRoute(const BackupSettingsPage()),
            ),

            const SizedBox(height: 12),
            const Divider(),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 12,
                bottom: 8,
              ),
              //color: Theme.of(context).colorScheme.surfaceContainer,
              child: Text(
                t.settings.app_structures.title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.of(context).textBody,
                ),
              ),
            ),
            _SettingRouteTile(
              title: t.general.categories,
              subtitle: t.settings.app_structures.categories,
              icon: Icons.category_rounded,
              onTap: () => RouteUtils.pushRoute(const CategoriesListPage()),
            ),
            _SettingRouteTile(
              title: t.tags.display(n: 10),
              subtitle: t.settings.app_structures.tags,
              icon: Icons.label_outline_rounded,
              onTap: () => RouteUtils.pushRoute(const TagListPage()),
            ),
            _SettingRouteTile(
              title: t.general.accounts,
              subtitle: t.settings.app_structures.accounts,
              icon: Icons.account_balance_wallet_rounded,
              onTap: () => RouteUtils.pushRoute(const AllAccountsPage()),
            ),
            _SettingRouteTile(
              title: t.general.filters,
              subtitle: t.settings.app_structures.filters,
              icon: Icons.filter_alt,
              onTap: () => RouteUtils.pushRoute(const SavedFiltersListPage()),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingRouteTile extends StatelessWidget {
  const _SettingRouteTile({
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
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      onTap: onTap,
    );
  }
}
