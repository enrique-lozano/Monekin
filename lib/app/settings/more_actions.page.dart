import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/categories/categories_list_page.dart';
import 'package:monekin/app/currencies/currency_manager.dart';
import 'package:monekin/app/goals/goals_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/about.page.dart';
import 'package:monekin/app/settings/help_us_page.dart';
import 'package:monekin/app/settings/settings_page.dart';
import 'package:monekin/app/settings/widgets/setting_card_item.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/tags/tag_list.page.dart';
import 'package:monekin/app/transactions/recurrent_transactions_page.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// "More Actions" Page that contains links to various other pages. Usually at last place in the main navbar
class MoreActionsPage extends StatefulWidget {
  const MoreActionsPage({super.key});

  @override
  State<MoreActionsPage> createState() => _MoreActionsPageState();
}

class _MoreActionsPageState extends State<MoreActionsPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.more.title_long,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            SettingCardItem(
              isPrimary: true,
              title: t.more.help_us.display,
              subtitle: t.more.help_us.description,
              icon: Icons.favorite_rounded,
              mainAxis: Axis.horizontal,
              onTap: () => RouteUtils.pushRoute(const HelpUsPage()),
            ),
            SettingCardItem(
              title: t.settings.title_long,
              subtitle: t.settings.description,
              icon: Icons.settings_rounded,
              mainAxis: Axis.horizontal,
              onTap: () => RouteUtils.pushRoute(const SettingsPage()),
            ),
            SettingCardItem(
              title: t.currencies.currency_manager,
              subtitle: t.currencies.currency_manager_descr,
              icon: Icons.currency_exchange,
              mainAxis: Axis.horizontal,
              onTap: () => RouteUtils.pushRoute(const CurrencyManagerPage()),
            ),
            SettingCardItem(
              title: t.more.about_us.display,
              subtitle: t.more.about_us.description,
              icon: Icons.info_outline_rounded,
              mainAxis: Axis.horizontal,
              onTap: () => RouteUtils.pushRoute(const AboutPage()),
            ),
            ..._buildDynamicNavItems(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDynamicNavItems(BuildContext context) {
    final t = Translations.of(context);
    final isLarge = BreakPoint.of(context).isLargerThan(BreakpointID.sm);
    final isExtraLarge = BreakPoint.of(context).isLargerThan(BreakpointID.lg);

    // 1. Get current active locations (bottom/side nav)
    final activeDestinations = getDestinations(
      context,
      showHome: true,
    ).map((e) => e.id).toSet();

    // 2. Define all possible items
    final allItems = [
      _ActionItem(
        title: t.goals.title,
        icon: Goal.icon,
        onTap: () => RouteUtils.pushRoute(const GoalsPage()),
        id: null, // Goals is not yet in the main menu enum/list
      ),
      _ActionItem(
        title: t.budgets.title,
        icon: Icons.pie_chart_rounded,
        onTap: () => RouteUtils.pushRoute(const BudgetsPage()),
        id: AppMenuDestinationsID.budgets,
      ),
      _ActionItem(
        title: t.stats.title,
        icon: Icons.area_chart_rounded,
        onTap: () => RouteUtils.pushRoute(const StatsPage()),
        id: AppMenuDestinationsID.stats,
      ),
      _ActionItem(
        title: t.recurrent_transactions.title_short,
        icon: Icons.repeat_rounded,
        onTap: () => RouteUtils.pushRoute(const RecurrentTransactionPage()),
        id: AppMenuDestinationsID.recurrentTransactions,
      ),
      _ActionItem(
        title: t.general.categories,
        icon: Icons.category_rounded,
        onTap: () => RouteUtils.pushRoute(const CategoriesListPage()),
        id: AppMenuDestinationsID.categories,
      ),
      _ActionItem(
        title: t.tags.display(n: 10),
        icon: Icons.label_outline_rounded,
        onTap: () => RouteUtils.pushRoute(const TagListPage()),
        id: null,
      ),
      _ActionItem(
        title: t.general.accounts,
        icon: Icons.account_balance_wallet_rounded,
        onTap: () => RouteUtils.pushRoute(const AllAccountsPage()),
        id: AppMenuDestinationsID.accounts,
      ),
    ];

    // 3. Filter only items not currently present in the nav
    final visibleItems = allItems
        .where(
          (item) => item.id == null || !activeDestinations.contains(item.id),
        )
        .toList();

    // 4. Calculate layout based on screen size
    final count = visibleItems.length;
    if (count == 0) return [];

    // Determine max columns allowed per row
    int maxColumns = 3; // Mobile default
    if (isExtraLarge) {
      maxColumns = 6;
    } else if (isLarge) {
      maxColumns = 4;
    }

    // Calculate optimal number of rows to avoid unbalanced grids (like 4 items in a row of 3 -> 3+1)
    // We want to distribute items as evenly as possible provided we don't exceed maxColumns.
    // Example for 5 items, max 4: ceil(5/4) = 2 rows. 5/2 = 2.5 -> rows of 3 and 2.
    final int numRows = (count / maxColumns).ceil();

    // Distribute items
    final int baseItemsPerRow = count ~/ numRows;
    final int extraItems = count % numRows;

    List<int> chunkSizes = [];
    for (int i = 0; i < numRows; i++) {
      // Add one extra item to the first 'extraItems' rows to distribute the remainder
      chunkSizes.add(baseItemsPerRow + (i < extraItems ? 1 : 0));
    }

    // 5. Build Widget Rows
    final List<Widget> rows = [];
    int index = 0;
    for (final size in chunkSizes) {
      if (index + size > visibleItems.length) break;
      final chunk = visibleItems.sublist(index, index + size);
      index += size;

      rows.add(
        Row(
          spacing: 8,
          children: chunk
              .map(
                (item) => Expanded(
                  child: SettingCardItem(
                    title: item.title,
                    icon: item.icon,
                    onTap: item.onTap,
                  ),
                ),
              )
              .toList(),
        ),
      );
    }

    return rows;
  }
}

class _ActionItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final AppMenuDestinationsID? id;

  _ActionItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.id,
  });
}
