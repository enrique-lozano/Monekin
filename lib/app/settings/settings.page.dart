import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/categories/categories_list_page.dart';
import 'package:monekin/app/currencies/currency_manager.dart';
import 'package:monekin/app/settings/about_page.dart';
import 'package:monekin/app/settings/appearance_settings_page.dart';
import 'package:monekin/app/settings/backup_settings_page.dart';
import 'package:monekin/app/settings/help_us_page.dart';
import 'package:monekin/app/settings/widgets/setting_card_item.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/tags/tag_list.page.dart';
import 'package:monekin/app/transactions/recurrent_transactions_page.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
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

    return Scaffold(
        appBar: AppBar(
          title: Text(t.more.title_long),
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingCardItem(
                isPrimary: true,
                title: t.more.help_us.display,
                subtitle: t.more.help_us.description,
                icon: Icons.favorite_rounded,
                mainAxis: Axis.horizontal,
                onTap: () => RouteUtils.pushRoute(context, const HelpUsPage()),
              ),
              const SizedBox(height: 8),
              SettingCardItem(
                title: t.settings.title_long,
                subtitle: t.settings.description,
                icon: Icons.palette_outlined,
                mainAxis: Axis.horizontal,
                onTap: () =>
                    RouteUtils.pushRoute(context, const AdvancedSettingsPage()),
              ),
              const SizedBox(height: 8),
              SettingCardItem(
                title: t.currencies.currency_manager,
                subtitle: t.currencies.currency_manager_descr,
                icon: Icons.currency_exchange,
                mainAxis: Axis.horizontal,
                onTap: () =>
                    RouteUtils.pushRoute(context, const CurrencyManagerPage()),
              ),
              const SizedBox(height: 8),
              SettingCardItem(
                title: t.more.data.display,
                subtitle: t.more.data.display_descr,
                icon: Icons.storage_rounded,
                mainAxis: Axis.horizontal,
                onTap: () =>
                    RouteUtils.pushRoute(context, const BackupSettingsPage()),
              ),
              const SizedBox(height: 8),
              SettingCardItem(
                title: t.more.about_us.display,
                subtitle: t.more.about_us.description,
                icon: Icons.info_outline_rounded,
                mainAxis: Axis.horizontal,
                onTap: () => RouteUtils.pushRoute(context, const AboutPage()),
              ),
              if (BreakPoint.of(context).isSmallerThan(BreakpointID.md)) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SettingCardItem(
                        title: t.stats.title,
                        icon: Icons.area_chart_rounded,
                        onTap: () =>
                            RouteUtils.pushRoute(context, const StatsPage()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SettingCardItem(
                        title: t.budgets.title,
                        icon: Icons.pie_chart_rounded,
                        onTap: () =>
                            RouteUtils.pushRoute(context, const BudgetsPage()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SettingCardItem(
                        title: t.recurrent_transactions.title_short,
                        icon: Icons.repeat_rounded,
                        onTap: () => RouteUtils.pushRoute(
                            context, const RecurrentTransactionPage()),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SettingCardItem(
                      title: t.general.categories,
                      icon: Icons.category_rounded,
                      onTap: () => RouteUtils.pushRoute(
                          context, const CategoriesListPage()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SettingCardItem(
                      title: t.tags.display(n: 10),
                      icon: Icons.label_outline_rounded,
                      onTap: () =>
                          RouteUtils.pushRoute(context, const TagListPage()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SettingCardItem(
                      title: t.general.accounts,
                      icon: Icons.account_balance_wallet_rounded,
                      onTap: () => RouteUtils.pushRoute(
                          context, const AllAccountsPage()),
                    ),
                  ),
                  if (BreakPoint.of(context).isLargerThan(BreakpointID.sm)) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: SettingCardItem(
                        title: t.recurrent_transactions.title_short,
                        icon: Icons.repeat_rounded,
                        onTap: () => RouteUtils.pushRoute(
                            context, const RecurrentTransactionPage()),
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ));
  }
}
