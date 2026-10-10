import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Variable;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:monekin/app/assets/asset_details_page.dart';
import 'package:monekin/app/assets/assets_list_page.dart';
import 'package:monekin/app/budgets/budget_details_page.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/categories/selectors/category_button_selector.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/currencies/exchange_rate_details.dart';
import 'package:monekin/app/goals/goals_page.dart';
import 'package:monekin/app/home/dashboard.page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/transactions/form/dialogs/amount_selector.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_amount_block.dart';
import 'package:monekin/app/transactions/list/recurrent_transactions_page.dart';
import 'package:monekin/app/transactions/list/transactions.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/utils/demo_app_seeders.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/targets/financial_target_card.dart';
import 'package:monekin/core/routes/route_utils.dart';
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

  // The test wipes and seeds its DB, so it only runs on a disposable one
  // passed via `--dart-define=MONEKIN_DB_NAME=...`, never the real `database.db`.
  final usesRealDb = AppDB.instance.dbName == 'database.db';

  setUpAll(() async {
    if (usesRealDb) return;

    // Start from a fresh install.
    final dbPath = await AppDB.instance.databasePath;
    for (final suffix in ['', '-wal', '-shm', '-journal']) {
      final file = File('$dbPath$suffix');
      if (file.existsSync()) await file.delete();
    }

    await setupMonekin();
  });

  final styles = _selectStyles();

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

      // Android can only capture the app once its surface is an image.
      if (Platform.isAndroid) {
        await binding.convertFlutterSurfaceToImage();
        await tester.pumpAndSettle();
      }

      // Give the app some data to show instead of empty states.
      await fillWithDemoData();
      await tester.pumpAndSettle();

      for (final locale in locales) {
        await _setAppLocale(locale);
        await _localizeCategories(locale);

        for (final style in styles) {
          await _applyStyle(style);

          // Restarting the widget tree (not the process) applies the new
          // language and style everywhere and brings every screen back to its
          // initial state.
          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pumpWidget(const MonekinAppEntryPoint());
          await tester.pumpAndSettle();
          expect(find.byType(DashboardPage), findsOneWidget);

          await _captureLocale(binding, tester, locale, style);
        }
      }
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  }, skip: usesRealDb);
}

List<ScreenshotStyle> _selectStyles() {
  final all = [
    ...ScreenshotConfig.fullSetStyles,
    ...ScreenshotConfig.dashboardOnlyStyles,
  ];
  if (ScreenshotConfig.stylesArg == 'all') return all;

  return [
    for (final id in ScreenshotConfig.stylesArg.split(','))
      all.firstWhere(
        (s) => s.id == id,
        orElse: () => throw ArgumentError('Unknown style: $id'),
      ),
  ];
}

Future<void> _applyStyle(ScreenshotStyle style) async {
  final settings = UserSettingService.instance;
  await settings.setItem(SettingKey.themeMode, style.themeMode);
  await settings.setItem(SettingKey.amoledMode, style.amoled ? '1' : '0');
  await settings.setItem(SettingKey.accentColor, style.accent);
  await settings.setItem(SettingKey.font, style.font.toDB());
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

/// Waits (letting real async work such as DB queries run) until [finder] matches.
Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var i = 0; i < 100 && finder.evaluate().isEmpty; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.pumpAndSettle();
  expect(finder, findsWidgets);
}

Future<void> _openTransactionForm(
  WidgetTester tester, {
  required TransactionType mode,
}) async {
  // Always the bank account as source so the low-balance warning never shows.
  final bank = await AccountService.instance.getAccountById('acc2').first;
  final cash = await AccountService.instance.getAccountById('acc1').first;

  unawaited(
    RouteUtils.showResponsiveForm(
      TransactionFormPage(
        mode: mode,
        fromAccount: bank,
        toAccount: mode.isTransfer ? cash : null,
      ),
    ),
  );
  await tester.pumpAndSettle();
  expect(find.byType(TransactionFormPage), findsOneWidget);
}

/// Picks [categoryId] (and optionally one of its subcategories) in the category
/// sheet the form opens by itself.
Future<void> _pickCategory(
  WidgetTester tester, {
  required String categoryId,
  String? subcategoryId,
}) async {
  final picker = find.byType(CategoryPicker);
  await _pumpUntilFound(tester, picker);

  Future<String> nameOf(String id) async =>
      (await CategoryService.instance.getCategoryById(id).first)!.name;

  final categoryIcon = find.descendant(
    of: find.widgetWithText(CategoryButtonSelector, await nameOf(categoryId)),
    matching: find.byType(IconDisplayer),
  );
  await tester.ensureVisible(categoryIcon);
  await tester.tap(categoryIcon);
  await tester.pumpAndSettle();

  if (subcategoryId != null) {
    await tester.tap(
      find.widgetWithText(ChoiceChip, await nameOf(subcategoryId)),
    );
    await tester.pumpAndSettle();
  }

  await tester.tap(
    find.descendant(of: picker, matching: find.text(t.ui_actions.save)),
  );
  await tester.pumpAndSettle();
}

Future<void> _enterAmount(WidgetTester tester, String amount) async {
  await tester.enterText(
    find.descendant(
      of: find.byType(TransactionFormAmountBlock),
      matching: find.byType(TextField),
    ),
    amount,
  );
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
}

Future<void> _closeTransactionForm(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TransactionFormPage),
      matching: find.byIcon(Icons.close),
    ),
  );
  await tester.pumpAndSettle();
  expect(find.byType(DashboardPage), findsOneWidget);
}

Future<void> _captureTransactionForms(
  WidgetTester tester,
  Future<void> Function(ScreenshotName name) shoot,
) async {
  await _openTransactionForm(tester, mode: TransactionType.income);
  await _pickCategory(tester, categoryId: '10'); // Salary
  await _enterAmount(tester, '2850');
  await shoot(ScreenshotName.formIncome);
  await _closeTransactionForm(tester);

  await _openTransactionForm(tester, mode: TransactionType.expense);
  await _pickCategory(
    tester,
    categoryId: '2',
    subcategoryId: '2_2', // Groceries
  );
  await _enterAmount(tester, '84.5');
  await shoot(ScreenshotName.formExpense);
  await _closeTransactionForm(tester);

  // The amount sheet opens by itself on transfers.
  await _openTransactionForm(tester, mode: TransactionType.transfer);
  final amountSheet = find.byType(AmountSelector);
  await _pumpUntilFound(tester, amountSheet);
  for (final digit in '250'.split('')) {
    await tester.tap(
      find.descendant(of: amountSheet, matching: find.text(digit)),
    );
    await tester.pumpAndSettle();
  }
  await tester.tap(
    find.descendant(
      of: amountSheet,
      matching: find.byIcon(Icons.check_rounded),
    ),
  );
  await tester.pumpAndSettle();
  await shoot(ScreenshotName.formTransfer);
  await _closeTransactionForm(tester);
}

/// Scrolls [finder] to mid-screen so bars pinned at the edges don't cover it.
Future<void> _tapCentered(WidgetTester tester, Finder finder) async {
  await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _captureLocale(
  IntegrationTestWidgetsFlutterBinding binding,
  WidgetTester tester,
  AppLocale locale,
  ScreenshotStyle style,
) async {
  final dir = '${locale.languageTag}/Screenshots';
  final suffix = style == ScreenshotConfig.fullSetStyles.first
      ? ''
      : '_${style.id}';

  Future<void> shoot(ScreenshotName name) =>
      takeScreenshot(binding, tester, '$dir/${name.fileName}$suffix');

  // Dashboard on the 6 months range (also inherited by the stats page below).
  await tester.tap(find.text(t.home.date_ranges.half_year).first);
  await tester.pumpAndSettle();
  await shoot(ScreenshotName.dashboard);

  if (ScreenshotConfig.dashboardOnlyStyles.contains(style)) return;

  await _captureTransactionForms(tester, shoot);

  // Stats opened from the dashboard card, so it keeps the dashboard range.
  final healthCardAction = find.descendant(
    of: find.widgetWithText(CardWithHeader, t.financial_health.display),
    matching: find.byType(CardHeaderAction),
  );
  await _tapCentered(tester, healthCardAction);
  expect(find.byType(StatsPage), findsOneWidget);
  await _collapsePageTitle(tester, StatsPage);
  await shoot(ScreenshotName.stats);

  await tester.tap(find.text(t.stats.net_worth));
  await tester.pumpAndSettle();
  // The composition card loads its data asynchronously.
  final compositionCard = find.widgetWithText(
    CardWithHeader,
    t.stats.net_worth_composition,
  );
  await _pumpUntilFound(tester, compositionCard);
  await shoot(ScreenshotName.netWorth);
  await Scrollable.ensureVisible(tester.element(compositionCard));
  await tester.pumpAndSettle();
  await shoot(ScreenshotName.netWorthComposition);
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

  await _tapCentered(tester, find.text(t.goals.title));
  expect(find.byType(GoalsPage), findsOneWidget);
  await _pumpUntilFound(tester, find.byType(FinancialTargetCard));
  await _collapsePageTitle(tester, GoalsPage);
  await shoot(ScreenshotName.goals);
  await tester.tap(find.backButton());
  await tester.pumpAndSettle();

  await _tapCentered(tester, find.text(t.assets.title));
  expect(find.byType(AssetsListPage), findsOneWidget);
  final apartment = find.text('Apartment');
  await _pumpUntilFound(tester, apartment);
  await tester.tap(apartment.first);
  await tester.pumpAndSettle();
  expect(find.byType(AssetDetailsPage), findsOneWidget);
  await _collapsePageTitle(tester, AssetDetailsPage);
  await shoot(ScreenshotName.assetDetails);
  await tester.tap(find.backButton());
  await tester.pumpAndSettle();
  await tester.tap(find.backButton());
  await tester.pumpAndSettle();

  await _tapCentered(tester, find.text(t.recurrent_transactions.title_short));
  expect(find.byType(RecurrentTransactionPage), findsOneWidget);
  await _collapsePageTitle(tester, RecurrentTransactionPage);
  await shoot(ScreenshotName.subscriptions);
  await tester.tap(find.backButton());
  await tester.pumpAndSettle();

  await _tapCentered(tester, find.text(t.currencies.currency_manager));
  final rateTile = find.widgetWithText(ListTile, demoForeignCurrencyCode).last;
  await _tapCentered(tester, rateTile);
  expect(find.byType(ExchangeRateDetailsPage), findsOneWidget);
  await _collapsePageTitle(tester, ExchangeRateDetailsPage);
  await shoot(ScreenshotName.exchangeRate);
}
