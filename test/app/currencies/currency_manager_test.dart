import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/currencies/currency_manager.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/services/exchange-rate/ecb_rate_sync.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  Future<BuildContext> buildApp(WidgetTester tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          scaffoldMessengerKey: snackbarKey,
          home: const Scaffold(body: SizedBox.expand()),
        ),
      ),
    );
    return tester.element(find.byType(Scaffold));
  }

  Future<void> dismissSnackbar(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  }

  for (final width in [400.0, 1200.0]) {
    testWidgets('repeated unsupported results give feedback at width $width', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = Size(width, 800);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final context = await buildApp(tester);

      for (final added in [1, 0]) {
        showEcbSyncResultSnackbar(
          context,
          EcbSyncResult(
            addedRates: added,
            unpublishedCurrencies: const ['ANG'],
            connectionFailed: false,
          ),
        );
        await tester.pumpAndSettle();

        final content = tester.widget<MonekinSnackbarContent>(
          find.byType(MonekinSnackbarContent),
        );
        expect(content.icon, Icons.warning_amber_rounded);
        expect(
          content.title,
          t.currencies.update_rates_unavailable(currencies: 'ANG'),
        );
        expect(
          content.message,
          added > 0
              ? t.currencies.update_rates_success(n: added)
              : t.currencies.update_rates_supported_up_to_date,
        );
        expect(find.text(t.currencies.update_rates_loading), findsNothing);
        expect(tester.takeException(), isNull);
        await dismissSnackbar(tester);
      }
    });
  }

  testWidgets('partial connection failures are warnings, not successes', (
    tester,
  ) async {
    final context = await buildApp(tester);
    showEcbSyncResultSnackbar(
      context,
      const EcbSyncResult(
        addedRates: 1,
        unpublishedCurrencies: ['ANG'],
        connectionFailed: true,
      ),
    );
    await tester.pumpAndSettle();

    final content = tester.widget<MonekinSnackbarContent>(
      find.byType(MonekinSnackbarContent),
    );
    expect(content.icon, Icons.warning_amber_rounded);
    expect(content.title, contains(t.currencies.update_rates_error));
    expect(
      content.title,
      contains(t.currencies.update_rates_unavailable(currencies: 'ANG')),
    );
    expect(content.message, t.currencies.update_rates_success(n: 1));
    await dismissSnackbar(tester);
  });

  testWidgets('connection-only partial failures also produce a warning', (
    tester,
  ) async {
    final context = await buildApp(tester);
    showEcbSyncResultSnackbar(
      context,
      const EcbSyncResult(
        addedRates: 1,
        unpublishedCurrencies: [],
        connectionFailed: true,
      ),
    );
    await tester.pumpAndSettle();

    final content = tester.widget<MonekinSnackbarContent>(
      find.byType(MonekinSnackbarContent),
    );
    expect(content.icon, Icons.warning_amber_rounded);
    expect(content.title, t.currencies.update_rates_error);
    expect(content.message, t.currencies.update_rates_success(n: 1));
    await dismissSnackbar(tester);
  });

  testWidgets(
    'total connection failure is an error and keeps unsupported detail',
    (tester) async {
      final context = await buildApp(tester);
      showEcbSyncResultSnackbar(
        context,
        const EcbSyncResult(
          addedRates: 0,
          unpublishedCurrencies: ['ANG'],
          connectionFailed: true,
        ),
      );
      await tester.pumpAndSettle();

      final content = tester.widget<MonekinSnackbarContent>(
        find.byType(MonekinSnackbarContent),
      );
      expect(content.icon, Icons.error_outline);
      expect(content.title, t.currencies.update_rates_error);
      expect(
        content.message,
        t.currencies.update_rates_unavailable(currencies: 'ANG'),
      );
      await dismissSnackbar(tester);
    },
  );

  for (final added in [0, 1]) {
    testWidgets('successful result with $added additions is acknowledged', (
      tester,
    ) async {
      final context = await buildApp(tester);
      showEcbSyncResultSnackbar(
        context,
        EcbSyncResult(
          addedRates: added,
          unpublishedCurrencies: const [],
          connectionFailed: false,
        ),
      );
      await tester.pumpAndSettle();

      final content = tester.widget<MonekinSnackbarContent>(
        find.byType(MonekinSnackbarContent),
      );
      expect(content.icon, Icons.check_circle_outline);
      expect(
        content.title,
        added > 0
            ? t.currencies.update_rates_success(n: added)
            : t.currencies.update_rates_up_to_date,
      );
      await dismissSnackbar(tester);
    });
  }
}
