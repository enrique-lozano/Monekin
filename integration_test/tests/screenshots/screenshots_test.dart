import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/transactions/list/transactions.page.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/utils/demo_app_seeders.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../helpers.dart';

/// The locale to capture screenshots in. Set via
/// `--dart-define=SCREENSHOT_LOCALE=es` from [generate_screenshots.sh].
/// Falls back to English when not provided (e.g. when running this file
/// directly from an IDE).
const _localeCode = String.fromEnvironment(
  'SCREENSHOT_LOCALE',
  defaultValue: 'en',
);

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await setupMonekin();

    final locale = AppLocale.values.firstWhere(
      (l) => l.languageCode == _localeCode,
      orElse: () => AppLocale.en,
    );
    await LocaleSettings.setLocale(locale);
    await UserSettingService.instance.setItem(
      SettingKey.appLanguage,
      locale.languageCode,
    );
  });

  testWidgets('Capture store screenshots', (tester) async {
    await startMonekin(tester);

    // Give the dashboard some data to show instead of empty states.
    await fillWithDemoData();
    await tester.pumpAndSettle();

    await binding.takeScreenshot('$_localeCode/Screenshots/01_dashboard');

    // Transactions is a bottom-nav tab, not a pushed route, so there's no
    // page to pop back from here (same as in dashboard_nav_test.dart).
    await tester.tap(find.text(t.transaction.display(n: 2)));
    await tester.pumpAndSettle();
    expect(find.byType(TransactionsPage), findsOneWidget);
    await binding.takeScreenshot('$_localeCode/Screenshots/02_transactions');

    await openMorePage(tester);

    await tester.tap(find.text(t.stats.title));
    await tester.pumpAndSettle();
    expect(find.byType(StatsPage), findsOneWidget);
    await binding.takeScreenshot('$_localeCode/Screenshots/03_stats');
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.budgets.title));
    await tester.pumpAndSettle();
    expect(find.byType(BudgetsPage), findsOneWidget);
    await binding.takeScreenshot('$_localeCode/Screenshots/04_budgets');
  });
}
