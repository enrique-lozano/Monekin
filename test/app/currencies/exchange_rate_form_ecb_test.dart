import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  for (final width in [390.0, 1280.0]) {
    testWidgets('ECB autofill, edit, and restore at width $width', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final db = AppDB.forTesting(NativeDatabase.memory());
      addTearDown(db.close);
      final api = FrankfurterEcbClient(
        client: MockClient(
          (_) async => http.Response('{"date":"2026-10-29","rate":1.2}', 200),
        ),
      );
      addTearDown(api.close);
      final boundary = GlobalKey();
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            theme: ThemeData(
              inputDecorationTheme: const InputDecorationThemeData(
                fillColor: Colors.white,
              ),
            ),
            home: Scaffold(
              body: RepaintBoundary(
                key: boundary,
                child: ExchangeRateFormDialog(
                  currency: Currency(name: 'Euro', code: 'EUR', symbol: 'EUR'),
                  preferredCurrency: Currency(
                    name: 'US dollar',
                    code: 'USD',
                    symbol: 'USD',
                  ),
                  exchangeRates: ExchangeRateService.forTesting(db),
                  ecbClient: api,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final field = find.byType(TextFormField).last;
      TextEditingController controller() =>
          tester.widget<TextFormField>(field).controller!;
      expect(controller().text, '1.2');
      expect(find.text(frankfurterEcbCredit), findsOneWidget);
      await tester.enterText(field, '1.75');
      await tester.pumpAndSettle();
      expect(
        find.text(t.currencies.exchange_rate_form.ecb_use_value),
        findsOneWidget,
      );
      expect(controller().text, '1.75');
      await tester.tap(
        find.text(t.currencies.exchange_rate_form.ecb_use_value),
      );
      await tester.pumpAndSettle();
      expect(controller().text, '1.2');
      expect(tester.takeException(), isNull);

      final output = Platform.environment['MONEKIN_REVIEW_IMAGES'];
      if (output != null) {
        await tester.runAsync(() async {
          final render =
              boundary.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary;
          final image = await render.toImage();
          try {
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            await Directory(output).create(recursive: true);
            await File(
              '$output/ecb-form-${width.toInt()}.png',
            ).writeAsBytes(bytes!.buffer.asUint8List());
          } finally {
            image.dispose();
          }
        });
      }
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
