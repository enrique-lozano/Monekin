import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/transactions/recurrent_transactions_page.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/core/services/filters/date_range_service.dart';
import 'package:monekin/i18n/translations.g.dart';

class MainMenuDestination {
  const MainMenuDestination({
    required this.destination,
    required this.label,
    required this.icon,
    this.selectedIcon,
  });

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
      label: Text(label),
    );
  }
}

List<MainMenuDestination> getDestinations(
  BuildContext context, {
  bool showHome = true,
  required DateRangeService dateRangeService,
}) {
  final t = Translations.of(context);

  return <MainMenuDestination>[
    MainMenuDestination(
      label: t.budgets.title,
      icon: Icons.calculate,
      destination: const BudgetsPage(),
    ),
    MainMenuDestination(
      label: t.general.accounts,
      icon: Icons.account_balance_rounded,
      destination: const AllAccountsPage(),
    ),
    MainMenuDestination(
      label: t.transaction.display(n: 1),
      icon: Icons.app_registration_rounded,
      destination: const TransactionsPage(),
    ),
    MainMenuDestination(
      label: t.recurrent_transactions.title,
      icon: Icons.auto_mode_rounded,
      destination: const RecurrentTransactionPage(),
    ),
    MainMenuDestination(
      label: t.stats.title,
      icon: Icons.auto_graph_rounded,
      destination: const StatsPage(),
    ),
    MainMenuDestination(
      label: t.settings.title,
      icon: Icons.settings,
      destination: const SettingsPage(),
    ),
  ];
}
