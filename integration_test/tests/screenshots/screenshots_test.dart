import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Variable;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:monekin/app/budgets/budget_details_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/currencies/exchange_rate_details.dart';
import 'package:monekin/app/home/dashboard.page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/transactions/list/recurrent_transactions_page.dart';
import 'package:monekin/app/transactions/list/transactions.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/utils/demo_app_seeders.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/targets/financial_target_card.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:monekin/main.dart';

import '../helpers.dart';
import 'screenshots_config.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final locales = [
    for (final tag in ScreenshotConfig.localesArg.split(','))
      AppLocale.values.firstWhere(
        (l) => l.languageTag == tag,
        orElse: () => throw ArgumentError('Unknown locale: $tag'),
      ),
  ];

  setUpAll(() async {
    // Start from a fresh install. Only wipes a DB the script named explicitly,
    // never the user's real `database.db`.
    if (AppDB.instance.dbName != 'database.db') {
      final dbPath = await AppDB.instance.databasePath;
      for (final suffix in ['', '-wal', '-shm', '-journal']) {
        final file = File('$dbPath$suffix');
        if (file.existsSync()) await file.delete();
      }
    }

    await setupMonekin();
  });

  testWidgets('Capture store screenshots', (tester) async {
    final isDesktop = !Platform.isAndroid && !Platform.isIOS;

    // On desktop, emulate a phone so the mobile layout is captured.
    if (isDesktop) {
      tester.view.devicePixelRatio = ScreenshotConfig.phonePixelRatio;
      tester.view.physicalSize = ScreenshotConfig.phoneSize;
      addTearDown(tester.view.reset);
    }

    debugDefaultTargetPlatformOverride = ScreenshotConfig.simulatedPlatform;

    try {
      await _setAppLocale(locales.first);
      await startMonekin(tester);

      // Give the app some data to show instead of empty states.
      await fillWithDemoData();
      await tester.pumpAndSettle();

      for (final locale in locales) {
        await _setAppLocale(locale);
        await _localizeCategories(locale);

        // Restarting the widget tree (not the process) applies the new language
        // everywhere and brings every screen back to its initial state.
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpWidget(const MonekinAppEntryPoint());
        await tester.pumpAndSettle();
        expect(find.byType(DashboardPage), findsOneWidget);

        await _captureLocale(binding, tester, locale);
      }
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}

Future<void> _setAppLocale(AppLocale locale) async {
  await LocaleSettings.setLocale(locale);
  await UserSettingService.instance.setItem(
    SettingKey.appLanguage,
    locale.languageTag,
    updateGlobalState: true,
  );
}

/// Categories are seeded once in the device language, so rename them to the
/// language being captured.
Future<void> _localizeCategories(AppLocale locale) async {
  final db = AppDB.instance;
  final json =
      jsonDecode(
            await rootBundle.loadString('assets/sql/initial_categories.json'),
          )
          as List<dynamic>;

  final keys = [
    locale.languageTag.replaceAll('-', '_'),
    locale.languageCode,
    'en',
  ];

  // Names are unique, and some translations repeat, so those fall back to
  // English.
  final used = <String>{};
  String nameOf(Map<String, dynamic> names) {
    var name = names[keys.firstWhere(names.containsKey)] as String;
    if (used.contains(name)) name = names['en'] as String;
    used.add(name);
    return name;
  }

  Future<void> rename(String id, String name) => db.customUpdate(
    'UPDATE categories SET name = ? WHERE id = ?',
    variables: [Variable.withString(name), Variable.withString(id)],
    updates: {db.categories},
  );

  final names = <String, String>{};
  for (final category in json) {
    final id = '${category['id']}';
    names[id] = nameOf(category['names'] as Map<String, dynamic>);

    final subcategories = category['subcategories'] as List<dynamic>? ?? [];
    for (final (index, subcategory) in subcategories.indexed) {
      names['${id}_${index + 1}'] = nameOf(
        subcategory['names'] as Map<String, dynamic>,
      );
    }
  }

  // Names are unique, so free them first to avoid clashing with a name that
  // another category is about to be renamed away from.
  for (final id in names.keys) {
    await rename(id, id);
  }
  for (final MapEntry(:key, :value) in names.entries) {
    await rename(key, value);
  }
}

/// Collapses the large title of [page] without scrolling its content, by
/// telling `PageFramework` that its body scrolled past the header.
Future<void> _collapsePageTitle(WidgetTester tester, Type page) async {
  final scrollable = find
      .descendant(of: find.byType(page), matching: find.byType(Scrollable))
      .first;

  ScrollUpdateNotification(
    metrics: FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 1000,
      pixels: 1000,
      viewportDimension: 800,
      axisDirection: AxisDirection.down,
      devicePixelRatio: 1,
    ),
    context: tester.element(scrollable),
  ).dispatch(tester.element(scrollable));
  await tester.pumpAndSettle();
}

Future<void> _captureLocale(
  IntegrationTestWidgetsFlutterBinding binding,
  WidgetTester tester,
  AppLocale locale,
) async {
  final dir = '${locale.languageTag}/Screenshots';

  Future<void> shoot(ScreenshotName name) =>
      takeScreenshot(binding, tester, '$dir/${name.fileName}');

  // Dashboard on the 6 months range (also inherited by the stats page below).
  await tester.tap(find.text(t.home.date_ranges.half_year).first);
  await tester.pumpAndSettle();
  await shoot(ScreenshotName.dashboard);

  // Stats opened from the dashboard card, so it keeps the dashboard range.
  final healthCardAction = find.descendant(
    of: find.widgetWithText(CardWithHeader, t.financial_health.display),
    matching: find.byType(CardHeaderAction),
  );
  await tester.ensureVisible(healthCardAction);
  await tester.pumpAndSettle();
  await tester.tap(healthCardAction);
  await tester.pumpAndSettle();
  expect(find.byType(StatsPage), findsOneWidget);
  await _collapsePageTitle(tester, StatsPage);
  await shoot(ScreenshotName.stats);
  // `tester.pageBack()` looks for the English "Back" tooltip, which breaks in
  // every other locale.
  await tester.tap(find.backButton());
  await tester.pumpAndSettle();

  // Transactions is a bottom-nav tab, not a pushed route, so there's no
  // page to pop back from here (same as in dashboard_nav_test.dart).
  await tester.tap(find.text(t.transaction.display(n: 2)));
  await tester.pumpAndSettle();
  expect(find.byType(TransactionsPage), findsOneWidget);
  await _collapsePageTitle(tester, TransactionsPage);
  await shoot(ScreenshotName.transactions);

  await openMorePage(tester);
  await tester.tap(find.text(t.budgets.title));
  await tester.pumpAndSettle();
  expect(find.byType(BudgetsPage), findsOneWidget);
  await _collapsePageTitle(tester, BudgetsPage);
  await shoot(ScreenshotName.budgets);

  await tester.tap(find.byType(FinancialTargetCard).first);
  await tester.pumpAndSettle();
  expect(find.byType(BudgetDetailsPage), findsOneWidget);
  await _collapsePageTitle(tester, BudgetDetailsPage);
  await shoot(ScreenshotName.budgetDetails);
  await tester.tap(find.backButton());
  await tester.pumpAndSettle();
  await tester.tap(find.backButton());
  await tester.pumpAndSettle();

  await tester.tap(find.text(t.recurrent_transactions.title_short));
  await tester.pumpAndSettle();
  expect(find.byType(RecurrentTransactionPage), findsOneWidget);
  await _collapsePageTitle(tester, RecurrentTransactionPage);
  await shoot(ScreenshotName.subscriptions);
  await tester.tap(find.backButton());
  await tester.pumpAndSettle();

  await tester.tap(find.text(t.currencies.currency_manager));
  await tester.pumpAndSettle();
  final rateTile = find.widgetWithText(ListTile, demoForeignCurrencyCode).last;
  await tester.ensureVisible(rateTile);
  await tester.pumpAndSettle();
  await tester.tap(rateTile);
  await tester.pumpAndSettle();
  expect(find.byType(ExchangeRateDetailsPage), findsOneWidget);
  await _collapsePageTitle(tester, ExchangeRateDetailsPage);
  await shoot(ScreenshotName.exchangeRate);
}
