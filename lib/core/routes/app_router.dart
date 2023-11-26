import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_details.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/budgets/budget_details_page.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/app/categories/form/category_form.dart';
import 'package:monekin/app/currencies/currency_manager.dart';
import 'package:monekin/app/currencies/exchange_rate_details.dart';
import 'package:monekin/app/home/dashboard.page.dart';
import 'package:monekin/app/home/main_layout.dart';
import 'package:monekin/app/onboarding/intro.page.dart';
import 'package:monekin/app/onboarding/onboarding.dart';
import 'package:monekin/app/settings/about_page.dart';
import 'package:monekin/app/settings/appearance_settings_page.dart';
import 'package:monekin/app/settings/backup_settings_page.dart';
import 'package:monekin/app/settings/export_page.dart';
import 'package:monekin/app/settings/help_us_page.dart';
import 'package:monekin/app/settings/import_csv.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/tags/tag_form_page.dart';
import 'package:monekin/app/tags/tag_list.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/app/transactions/recurrent_transactions_page.dart';
import 'package:monekin/app/transactions/transaction_details.page.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';

part 'app_router.gr.dart';

class IntroSeenGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    AppDataService.instance
        .getAppDataItem(AppDataKey.introSeen)
        .first
        .then((value) {
      if (value == null || value != '1') {
        router.push(const IntroRoute());
        return;
      }

      return resolver.next(true);
    });
  }
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: IntroRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(
          page: MainLayoutRoute.page,
          initial: true,
          guards: [IntroSeenGuard()],
          children: [
            AutoRoute(
              page: DashboardRoute.page,
              initial: true,
            ),
            AutoRoute(page: BudgetsRoute.page),
            AutoRoute(page: BudgetDetailsRoute.page),
            AutoRoute(page: BudgetFormRoute.page),
            AutoRoute(page: AllAccountsRoute.page),
            AutoRoute(page: TransactionsRoute.page),
            AutoRoute(page: RecurrentTransactionRoute.page),
            AutoRoute(page: AccountFormRoute.page),
            AutoRoute(page: CurrencyManagerRoute.page),
            AutoRoute(page: CategoriesListRoute.page),
            AutoRoute(page: CategoryFormRoute.page),
            AutoRoute(page: ExchangeRateDetailsRoute.page),
            AutoRoute(page: TagFormRoute.page),
            AutoRoute(page: TagListRoute.page),
            AutoRoute(page: AccountDetailsRoute.page),
            AutoRoute(page: TransactionFormRoute.page),
            AutoRoute(page: TransactionDetailsRoute.page),
            AutoRoute(page: StatsRoute.page),
            AutoRoute(page: SettingsRoute.page),
            AutoRoute(page: AboutRoute.page),
            AutoRoute(page: HelpUsRoute.page),
            AutoRoute(page: ImportCSVRoute.page),
            AutoRoute(page: BackupSettingsRoute.page),
            AutoRoute(page: AdvancedSettingsRoute.page),
            AutoRoute(page: ExportDataRoute.page),
          ],
        ),
      ];
}
