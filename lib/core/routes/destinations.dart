import 'package:flutter/material.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/home/dashboard.page.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

// GlobalKeys for each destination page
final GlobalKey<State<StatefulWidget>> dashboardPageKey = GlobalKey();
final GlobalKey budgetsPageKey = GlobalKey();
final GlobalKey<TransactionsPageState> transactionsPageKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> statsPageKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> settingsPageKey = GlobalKey();

enum AppMenuDestinationsID {
  dashboard,
  budgets,
  transactions,
  recurrentTransactions,
  accounts,
  stats,
  settings,
  categories,
}

class MainMenuDestination {
  const MainMenuDestination(
    this.id, {
    required this.destination,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.pageKey,
  });

  final AppMenuDestinationsID id;
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final GlobalKey? pageKey;

  final Widget destination;

  NavigationDestination toNavigationDestinationWidget(BuildContext context) {
    return NavigationDestination(
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon ?? icon),
      label: label,
    );
  }

  NavigationDrawerDestination toNavigationDrawerDestinationWidget() {
    return NavigationDrawerDestination(
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon ?? icon),
      label: Text(label),
    );
  }

  NavigationRailDestination toNavigationRailDestinationWidget() {
    return NavigationRailDestination(
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon ?? icon),
      label: Text(
        label,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }
}

List<MainMenuDestination> getAllDestinations() {
  return <MainMenuDestination>[
    MainMenuDestination(
      AppMenuDestinationsID.dashboard,
      label: t.home.title,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      destination: DashboardPage(key: dashboardPageKey),
      pageKey: dashboardPageKey,
    ),
    MainMenuDestination(
      AppMenuDestinationsID.budgets,
      label: t.budgets.title,
      icon: Icons.calculate_outlined,
      selectedIcon: Icons.calculate,
      destination: BudgetsPage(key: budgetsPageKey),
      pageKey: budgetsPageKey,
    ),
    /*   MainMenuDestination(
      AppMenuDestinationsID.accounts,
      label: t.general.accounts,
      icon: Icons.account_balance_rounded,
      destination: const AllAccountsPage(),
    ), */
    MainMenuDestination(
      AppMenuDestinationsID.transactions,
      label: t.transaction.display(n: 10),
      icon: Icons.list,
      destination: TransactionsPage(key: transactionsPageKey),
      pageKey: transactionsPageKey,
    ),
    /*   MainMenuDestination(
      AppMenuDestinationsID.recurrentTransactions,
      label: shortLabels
          ? t.recurrent_transactions.title_short
          : t.recurrent_transactions.title,
      icon: Icons.auto_mode_rounded,
      destination: const RecurrentTransactionPage(),
    ), */
    MainMenuDestination(
      AppMenuDestinationsID.stats,
      label: t.stats.title,
      icon: Icons.auto_graph_rounded,
      destination: StatsPage(key: statsPageKey),
      pageKey: statsPageKey,
    ),
    MainMenuDestination(
      AppMenuDestinationsID.settings,
      label: t.more.title,
      selectedIcon: Icons.more_horiz_rounded,
      icon: Icons.more_horiz_rounded,
      destination: SettingsPage(key: settingsPageKey),
      pageKey: settingsPageKey,
    ),
  ];
}

List<MainMenuDestination> getDestinations(
  BuildContext context, {
  bool showHome = true,
}) {
  final bool isMobileMode = BreakPoint.of(
    context,
  ).isSmallerThan(BreakpointID.md);

  var toReturn = getAllDestinations();

  if (!showHome) {
    toReturn = toReturn
        .where((element) => element.id != AppMenuDestinationsID.dashboard)
        .toList();
  }

  if (isMobileMode) {
    toReturn = toReturn
        .where(
          (element) => [
            AppMenuDestinationsID.dashboard,
            AppMenuDestinationsID.transactions,
            AppMenuDestinationsID.settings,
          ].contains(element.id),
        )
        .toList();
  }

  return toReturn;
}
