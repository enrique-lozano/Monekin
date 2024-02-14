import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/home/dashboard.page.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/transactions/recurrent_transactions_page.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/i18n/translations.g.dart';

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
  });

  final AppMenuDestinationsID id;
  final String label;
  final IconData icon;
  final IconData? selectedIcon;

  final Widget destination;

  NavigationDestination toNavigationDestinationWidget() {
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

List<MainMenuDestination> getAllDestinations(
  BuildContext context, {
  required bool shortLabels,
}) {
  final t = Translations.of(context);

  return <MainMenuDestination>[
    MainMenuDestination(
      AppMenuDestinationsID.dashboard,
      label: t.home.title,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      destination: const DashboardPage(),
    ),
    MainMenuDestination(
      AppMenuDestinationsID.budgets,
      label: t.budgets.title,
      icon: Icons.calculate_outlined,
      selectedIcon: Icons.calculate,
      destination: const BudgetsPage(),
    ),
    MainMenuDestination(
      AppMenuDestinationsID.accounts,
      label: t.general.accounts,
      icon: Icons.account_balance_rounded,
      destination: const AllAccountsPage(),
    ),
    MainMenuDestination(
      AppMenuDestinationsID.transactions,
      label: t.transaction.display(n: 10),
      icon: Icons.app_registration_rounded,
      destination: TransactionsPage(),
    ),
    MainMenuDestination(
      AppMenuDestinationsID.recurrentTransactions,
      label: shortLabels
          ? t.recurrent_transactions.title_short
          : t.recurrent_transactions.title,
      icon: Icons.auto_mode_rounded,
      destination: RecurrentTransactionPage(),
    ),
    if (MediaQuery.of(context).size.height > 650)
      MainMenuDestination(
        AppMenuDestinationsID.stats,
        label: t.stats.title,
        icon: Icons.auto_graph_rounded,
        destination: StatsPage(),
      ),
    MainMenuDestination(
      AppMenuDestinationsID.settings,
      label: t.settings.title,
      selectedIcon: Icons.settings,
      icon: Icons.settings_outlined,
      destination: const SettingsPage(),
    ),
  ];
}

List<MainMenuDestination> getDestinations(
  BuildContext context, {
  required bool shortLabels,
  bool showHome = true,
}) {
  final bool isMobileMode =
      BreakPoint.of(context).isSmallerThan(BreakpointID.md);

  var toReturn = getAllDestinations(context, shortLabels: shortLabels);

  if (!showHome) {
    toReturn = toReturn
        .where((element) => element.id != AppMenuDestinationsID.dashboard)
        .toList();
  }

  if (isMobileMode) {
    toReturn = toReturn
        .where((element) => [
              AppMenuDestinationsID.dashboard,
              AppMenuDestinationsID.transactions,
              AppMenuDestinationsID.settings,
            ].contains(element.id))
        .toList();
  }

  return toReturn;
}
