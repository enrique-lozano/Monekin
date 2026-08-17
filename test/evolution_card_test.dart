import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/evolution_card.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  testWidgets('keeps value header stable across chip breakpoint changes', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1200, 800);
    addTearDown(() {
      tester.view.resetDevicePixelRatio();
      tester.view.resetPhysicalSize();
    });

    final highlightedValue = ValueNotifier<double?>(null);
    addTearDown(highlightedValue.dispose);
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: colorScheme,
            extensions: [AppColors.fromColorScheme(colorScheme)],
          ),
          home: Scaffold(
            body: EvolutionCard(
              valueLabel: 'Current value',
              initialValue: 80,
              finalValue: 100,
              highlightedValue: highlightedValue,
              currency: Currency(name: 'Euro', code: 'EUR', symbol: '€'),
              chart: const SizedBox.expand(),
              currentPeriod: const DatePeriod.lastDays(30),
              onPresetSelected: (_) {},
            ),
          ),
        ),
      ),
    );

    tester.view.physicalSize = const Size(800, 800);
    highlightedValue.value = 90;
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
