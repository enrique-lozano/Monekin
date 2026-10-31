import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/currencies/widgets/currency_manager_menu.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  Future<void> buildMenu(
    WidgetTester tester, {
    bool busy = false,
    VoidCallback? onUpdate,
    Future<void> Function()? onDelete,
    double width = 390,
  }) async {
    tester.view.physicalSize = Size(width, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final colors = ColorScheme.fromSeed(seedColor: Colors.blue);
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: colors,
            extensions: [AppColors.fromColorScheme(colors)],
          ),
          home: Scaffold(
            appBar: AppBar(
              actions: [
                CurrencyManagerMenu(
                  busy: busy,
                  onUpdate: onUpdate ?? () {},
                  onDelete: onDelete ?? () async {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
  }

  for (final width in [390.0, 1280.0]) {
    testWidgets('menu updates rates at width $width', (tester) async {
      var updated = false;
      await buildMenu(tester, width: width, onUpdate: () => updated = true);
      expect(find.byType(PopupMenuItem<int>), findsNWidgets(2));
      await tester.tap(find.text(t.currencies.update_rates));
      await tester.pumpAndSettle();
      expect(updated, isTrue);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('deletion requires confirmation at width $width', (
      tester,
    ) async {
      var deleted = false;
      await buildMenu(
        tester,
        width: width,
        onDelete: () async => deleted = true,
      );
      await tester.tap(find.text(t.currencies.exchange_rate_form.remove_all));
      await tester.pumpAndSettle();
      expect(deleted, isFalse);
      expect(find.text(t.currencies.remove_all_rates_warning), findsOneWidget);
      await tester.tap(find.text(t.ui_actions.cancel));
      await tester.pumpAndSettle();
      expect(deleted, isFalse);

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.currencies.exchange_rate_form.remove_all));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.ui_actions.delete));
      await tester.pumpAndSettle();
      expect(deleted, isTrue);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('both menu actions are disabled during a mutation', (
    tester,
  ) async {
    await buildMenu(tester, busy: true);
    final items = tester.widgetList<PopupMenuItem<int>>(
      find.byType(PopupMenuItem<int>),
    );
    expect(items.every((item) => !item.enabled), isTrue);
  });

  testWidgets('dismissing confirmation does not delete rates', (tester) async {
    var deleted = false;
    await buildMenu(tester, onDelete: () async => deleted = true);
    await tester.tap(find.text(t.currencies.exchange_rate_form.remove_all));
    await tester.pumpAndSettle();
    Navigator.of(
      tester.element(find.text(t.currencies.remove_all_rates_warning)),
    ).pop();
    await tester.pumpAndSettle();
    expect(deleted, isFalse);
  });
}
