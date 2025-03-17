import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/categories/categories_list_page.dart';
import 'package:monekin/app/categories/form/category_form.dart';
import 'package:monekin/app/currencies/currency_manager.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/app/settings/about_page.dart';
import 'package:monekin/app/settings/appearance_settings_page.dart';
import 'package:monekin/app/settings/backup_settings_page.dart';
import 'package:monekin/app/settings/export_page.dart';
import 'package:monekin/app/settings/help_us_page.dart';
import 'package:monekin/app/settings/import_csv.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/app/settings/widgets/language_selector.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/tags/tag_form_page.dart';
import 'package:monekin/app/tags/tag_list.page.dart';
import 'package:monekin/app/transactions/recurrent_transactions_page.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';

import '../helpers.dart';

void main() {
  setUpAll(() async {
    await setupMonekin();
  });

  testWidgets('More Actions Page navigation', (tester) async {

    final settingsPage = find.byType(SettingsPage);

    await startMonekin(tester);
    await openMorePage(tester);

    await tester.tap(find.text('Help us'));
    await tester.pumpAndSettle();
    expect(find.byType(HelpUsPage), findsOneWidget);
    expect(find.text('Thank you!'), findsAny);
    await tester.pageBack();
    await tester.pumpAndSettle();

    
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Settings and appearance'));
    await tester.pumpAndSettle();
    expect(find.byType(AdvancedSettingsPage), findsOneWidget);
    await tester.tap(find.text('App language'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(LanguageSelector, 'App language'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Theme'));
    await tester.pumpAndSettle();
    expect(find.text('Light'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Currency manager'));
    await tester.pumpAndSettle();
    expect(find.byType(CurrencyManagerPage), findsOneWidget);
    await tester.tap(find.text('Preferred/base currency'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(CurrencySelectorModal, 'Select a currency'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ExchangeRateFormDialog, 'Add exchange rate'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle(); 
    await tester.pageBack();
    await tester.pumpAndSettle();
    
    
    final backupSettings = find.byType(BackupSettingsPage);
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Data'));
    await tester.pumpAndSettle();
    expect(backupSettings, findsOneWidget);
    await tester.tap(find.text('Restore Backup'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(Dialog, 'Overwrite all data'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(backupSettings, findsOneWidget);
    await tester.tap(find.text('Manual import'));
    await tester.pumpAndSettle();
    expect(find.byType(ImportCSVPage), findsOneWidget);
    expect(find.text('Select your file'), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();

    expect(backupSettings, findsOneWidget);
    await tester.tap(find.text('Export your data'));
    await tester.pumpAndSettle();
    expect(find.byType(ExportDataPage), findsOneWidget);
    expect(find.text('Full backup'), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(backupSettings, findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    
    
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('App information'));
    await tester.pumpAndSettle();
    expect(find.byType(AboutPage), findsOneWidget);
    expect(find.text('Monekin'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    
    
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Statistics'));
    await tester.pumpAndSettle();
    expect(find.byType(StatsPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    
    
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Budgets'));
    await tester.pumpAndSettle();
    expect(find.byType(BudgetsPage), findsOneWidget);
    await tester.tap(find.widgetWithText(FloatingActionButton, 'Add budget'));
    await tester.pumpAndSettle();
    expect(find.byType(BudgetFormPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(BudgetsPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    
   
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Rec. transactions'));
    await tester.pumpAndSettle();
    expect(find.byType(RecurrentTransactionPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Categories'));
    await tester.pumpAndSettle();
    expect(find.byType(CategoriesListPage), findsOneWidget);
    await tester.tap(find.widgetWithText(FloatingActionButton, 'Create category'));
    await tester.pumpAndSettle();
    expect(find.byType(CategoryFormPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(CategoriesListPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Tags'));
    await tester.pumpAndSettle();
    expect(find.byType(TagListPage), findsOneWidget);
    await tester.tap(find.widgetWithText(FloatingActionButton, 'Add tag'));
    await tester.pumpAndSettle();
    expect(find.byType(TagFormPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(TagListPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    
    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text('Accounts'));
    await tester.pumpAndSettle();
    expect(find.byType(AllAccountsPage), findsOneWidget);
    await tester.tap(find.widgetWithText(FloatingActionButton, 'Create account'));
    await tester.pumpAndSettle();
    expect(find.byType(AccountFormPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(AllAccountsPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(settingsPage, findsOneWidget);
  });
}
