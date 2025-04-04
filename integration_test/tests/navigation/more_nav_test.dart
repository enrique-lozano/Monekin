import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/budgets/budget_form_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/categories/categories_list_page.dart';
import 'package:monekin/app/categories/form/category_form.dart';
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
import 'package:monekin/i18n/generated/translations.g.dart';

import '../helpers.dart';

void main() {
  setUpAll(() async {
    await setupMonekin();
  });

  testWidgets('More Actions Page navigation', (tester) async {
    final settingsPage = find.byType(SettingsPage);

    await startMonekin(tester);
    await openMorePage(tester);

    await tester.tap(find.text(t.more.help_us.display));
    await tester.pumpAndSettle();
    expect(find.byType(HelpUsPage), findsOneWidget);
    expect(find.text(t.more.help_us.thanks), findsAny);
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text(t.settings.title_long));
    await tester.pumpAndSettle();
    expect(find.byType(AdvancedSettingsPage), findsOneWidget);

    await tester.tap(find.text(t.settings.lang_title));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(LanguageSelector, t.settings.lang_title),
        findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.settings.theme));
    await tester.pumpAndSettle();
    expect(find.text(t.settings.theme_light), findsOneWidget); // "Light"
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text(t.more.data.display));
    await tester.pumpAndSettle();
    expect(find.byType(BackupSettingsPage), findsOneWidget);

    await tester.tap(find.text(t.settings.title_short));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(Dialog, t.more.data.delete_all_header1),
        findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.more.data.display));
    await tester.pumpAndSettle();
    expect(find.byType(ImportCSVPage), findsOneWidget);
    expect(
        find.text(t.backup.import.manual_import.steps.first), findsOneWidget);

    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.more.data.display)); // "Export your data"
    await tester.pumpAndSettle();
    expect(find.byType(ExportDataPage), findsOneWidget);
    expect(find.text(t.backup.export.all), findsOneWidget);

    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(BackupSettingsPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(settingsPage, findsOneWidget);
    await tester.tap(find.text(t.more.about_us.display));
    await tester.pumpAndSettle();
    expect(find.byType(AboutPage), findsOneWidget);
    expect(find.text('Monekin'), findsOneWidget); // Assuming static app name
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.stats.title)); // "Statistics"
    await tester.pumpAndSettle();
    expect(find.byType(StatsPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.budgets.title)); // "Budgets"
    await tester.pumpAndSettle();
    expect(find.byType(BudgetsPage), findsOneWidget);
    await tester
        .tap(find.widgetWithText(FloatingActionButton, t.budgets.form.create));
    await tester.pumpAndSettle();
    expect(find.byType(BudgetFormPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(BudgetsPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester
        .tap(find.text(t.recurrent_transactions.title)); // "Rec. transactions"
    await tester.pumpAndSettle();
    expect(find.byType(RecurrentTransactionPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.general.categories)); // "Categories"
    await tester.pumpAndSettle();
    expect(find.byType(CategoriesListPage), findsOneWidget);
    await tester
        .tap(find.widgetWithText(FloatingActionButton, t.categories.create));
    await tester.pumpAndSettle();
    expect(find.byType(CategoryFormPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(CategoriesListPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.tags.display(n: 2))); // "Tags"
    await tester.pumpAndSettle();
    expect(find.byType(TagListPage), findsOneWidget);
    await tester.tap(find.widgetWithText(FloatingActionButton, t.tags.create));
    await tester.pumpAndSettle();
    expect(find.byType(TagFormPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(TagListPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.general.accounts)); // "Accounts"
    await tester.pumpAndSettle();
    expect(find.byType(AllAccountsPage), findsOneWidget);
    await tester
        .tap(find.widgetWithText(FloatingActionButton, t.account.form.create));
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
