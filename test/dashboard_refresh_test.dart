import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/home/widgets/dashboard_balance_chart.dart';
import 'package:monekin/app/layout/page_switcher.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/pie_chart_by_categories.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/evolution_card.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/page_refresh.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  late Directory directory;
  final db = AppDB.instance;

  setUpAll(() async {
    directory = await Directory.systemTemp.createTemp('monekin-refresh-test-');
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
      call,
    ) async {
      if (call.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      throw MissingPluginException('Unexpected path request: ${call.method}');
    });
    // Verify isolation before opening any production singleton.
    expect((await getApplicationDocumentsDirectory()).path, directory.path);
    await db.customSelect('SELECT 1').get();
    await UserSettingService.instance.setItem(
      SettingKey.preferredCurrency,
      'EUR',
    );
    await UserSettingService.instance.initializeGlobalStateMap();
    for (final (id, initial) in [('refresh-account', 100.0), ('other', 0.0)]) {
      await db
          .into(db.accounts)
          .insert(
            AccountInDB(
              id: id,
              name: id,
              groupName: 'Group',
              iniValue: initial,
              date: DateTime.now().subtract(const Duration(days: 10)),
              type: AccountType.money,
              trackingMode: AccountTrackingMode.transactions,
              isSaving: false,
              iconId: 'wallet',
              displayOrder: 0,
              currencyId: 'EUR',
            ),
          );
    }
  });

  tearDownAll(() async {
    await db.close();
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
    for (final name in ['database.db', 'database.db-wal', 'database.db-shm']) {
      final file = File('${directory.path}${Platform.pathSeparator}$name');
      if (await file.exists()) await file.delete();
    }
    await directory.delete();
    appStateData.clear();
    appStateSettings.clear();
  });

  Future<void> waitUntil(WidgetTester tester, bool Function() condition) async {
    for (var attempt = 0; attempt < 100; attempt++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump(const Duration(milliseconds: 100));
      if (condition()) return;
      final error = tester.takeException();
      if (error != null) fail('$error');
    }
    fail('Dashboard did not deliver refreshed data');
  }

  testWidgets(
    'refresh replaces cached queries and preserves page selections',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1400, 1000);
      addTearDown(() {
        tester.view.resetDevicePixelRatio();
        tester.view.resetPhysicalSize();
      });
      final historical = DatePeriod.customRange(DateTime(2020), DateTime(2021));
      appStateData[AppDataKey.lastDashboardDatePeriod] = historical
          .toJsonString();
      final scheme = ColorScheme.fromSeed(seedColor: Colors.blue);
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            scaffoldMessengerKey: snackbarKey,
            theme: ThemeData(
              colorScheme: scheme,
              extensions: [AppColors.fromColorScheme(scheme)],
            ),
            home: PageSwitcher(key: tabsPageKey),
          ),
        ),
      );
      await waitUntil(tester, () {
        final cards = find.byType(EvolutionCard);
        return cards.evaluate().isNotEmpty &&
            !tester.widget<EvolutionCard>(cards).loading &&
            find.byType(ExpansionTile).evaluate().isNotEmpty;
      });
      final before = tester.widget<EvolutionCard>(find.byType(EvolutionCard));
      final chartBefore = tester.widget<DashboardBalanceChart>(
        find.byType(DashboardBalanceChart),
      );
      expect(before.finalValue, 100);
      expect(before.currentPeriod.customDateRange, historical.customDateRange);

      // Other tabs keep loading indicators running, so pumpAndSettle never ends.
      tabsPageKey.currentState!.changePage(AppMenuDestinationsID.budgets);
      await tester.pump(const Duration(milliseconds: 400));
      tabsPageKey.currentState!.changePage(AppMenuDestinationsID.dashboard);
      await tester.pump(const Duration(milliseconds: 400));

      final categories = find.byType(PieChartByCategories);
      final income = find.descendant(
        of: categories,
        matching: find.text(t.transaction.types.income(n: 1)),
      );
      await waitUntil(tester, () => income.evaluate().isNotEmpty);
      await tester.ensureVisible(income);
      await tester.tap(income);
      await tester.pump();
      final group = find.byType(ExpansionTile);
      await tester.ensureVisible(group);
      await tester.tap(find.text('Group'));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.runAsync(() async {
        final categories = await db.select(db.categories).get();
        await db
            .into(db.transactions)
            .insert(
              TransactionInDB(
                id: 'later-income',
                accountID: 'refresh-account',
                categoryID: categories.first.id,
                date: DateTime.now(),
                value: 25,
                type: TransactionType.income,
                isHidden: false,
              ),
            );
      });
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 100)),
      );
      await tester.pump();
      expect(
        tester.widget<EvolutionCard>(find.byType(EvolutionCard)).finalValue,
        125,
      );

      // Keyboard refresh works away from the top without losing scroll context.
      final scroll = tester
          .widget<SingleChildScrollView>(
            find
                .descendant(
                  of: find.byType(PageRefresh),
                  matching: find.byType(SingleChildScrollView),
                )
                .first,
          )
          .controller!;
      final offset = scroll.offset;
      await tester.sendKeyEvent(LogicalKeyboardKey.f5);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await waitUntil(
        tester,
        () =>
            tester
                    .widget<EvolutionCard>(find.byType(EvolutionCard))
                    .finalValue ==
                125 &&
            find.byType(RefreshProgressIndicator).evaluate().isEmpty,
      );

      final after = tester.widget<EvolutionCard>(find.byType(EvolutionCard));
      final chartAfter = tester.widget<DashboardBalanceChart>(
        find.byType(DashboardBalanceChart),
      );
      expect(chartAfter.key, isNot(chartBefore.key));
      expect(after.currentPeriod.customDateRange, historical.customDateRange);
      expect(after.changeValue, before.changeValue);
      expect(scroll.offset, closeTo(offset, 1));
      final tabs = tester.widget<ExpandingSegmentedTabs<TransactionType>>(
        find.descendant(
          of: categories,
          matching: find.byType(ExpandingSegmentedTabs<TransactionType>),
        ),
      );
      expect(tabs.selected, TransactionType.income);
      await tester.ensureVisible(group);
      expect(find.text('refresh-account'), findsOneWidget);
      final maxPeriod = find.text(t.home.date_ranges.max);
      await tester.ensureVisible(maxPeriod);
      await tester.tap(maxPeriod);
      final line = find.descendant(
        of: find.byType(DashboardBalanceChart),
        matching: find.byType(LineChart),
      );
      await waitUntil(tester, () {
        return line.evaluate().isNotEmpty &&
            tester
                    .widget<LineChart>(line)
                    .data
                    .lineBarsData
                    .single
                    .spots
                    .last
                    .y ==
                125;
      });
      final previousEnd = tester
          .widget<LineChart>(line)
          .data
          .lineBarsData
          .single
          .spots
          .last
          .x;
      await tester.sendKeyEvent(LogicalKeyboardKey.f5);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await waitUntil(tester, () {
        return line.evaluate().isNotEmpty &&
            tester
                    .widget<LineChart>(line)
                    .data
                    .lineBarsData
                    .single
                    .spots
                    .last
                    .x >
                previousEnd &&
            find.byType(RefreshProgressIndicator).evaluate().isEmpty;
      });
      expect(
        tester.widget<LineChart>(line).data.lineBarsData.single.spots.last.y,
        125,
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    },
    variant: TargetPlatformVariant({TargetPlatform.windows}),
  );
}
