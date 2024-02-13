import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/routes/app_router.dart';
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

  final PageRouteInfo destination;

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
  required bool shortLabels,
  bool showHome = true,
}) {
  final t = Translations.of(context);

  final bool isMobileMode =
      BreakPoint.of(context).isSmallerThan(BreakpointID.md);

  return <MainMenuDestination>[
    if (showHome || isMobileMode)
      MainMenuDestination(
        label: t.home.title,
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        destination: const DashboardRoute(),
      ),
    if (!isMobileMode) ...[
      MainMenuDestination(
        label: t.budgets.title,
        icon: Icons.calculate_outlined,
        selectedIcon: Icons.calculate,
        destination: const BudgetsRoute(),
      ),
      MainMenuDestination(
        label: t.general.accounts,
        icon: Icons.account_balance_rounded,
        destination: const AllAccountsRoute(),
      ),
    ],
    if (MediaQuery.of(context).size.height > 600 || isMobileMode)
      MainMenuDestination(
        label: t.transaction.display(n: 10),
        icon: Icons.app_registration_rounded,
        destination: TransactionsRoute(),
      ),
    if (!isMobileMode) ...[
      MainMenuDestination(
        label: shortLabels
            ? t.recurrent_transactions.title_short
            : t.recurrent_transactions.title,
        icon: Icons.auto_mode_rounded,
        destination: const RecurrentTransactionRoute(),
      ),
      if (MediaQuery.of(context).size.height > 650)
        MainMenuDestination(
          label: t.stats.title,
          icon: Icons.auto_graph_rounded,
          destination: StatsRoute(),
        ),
    ],
    MainMenuDestination(
      label: t.settings.title,
      selectedIcon: Icons.settings,
      icon: Icons.settings_outlined,
      destination: const SettingsRoute(),
    ),
  ];
}
