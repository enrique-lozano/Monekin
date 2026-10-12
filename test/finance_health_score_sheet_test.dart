import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_pillar_meta.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_score_sheet.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  Widget buildSheet({
    required FinanceHealthData current,
    FinanceHealthData? previous,
  }) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

    return TranslationProvider(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: colorScheme,
          extensions: [AppColors.fromColorScheme(colorScheme)],
        ),
        home: Scaffold(
          body: Builder(
            builder: (context) => FinanceHealthScoreSheet(
              current: current,
              previous: previous,
              pillars: buildFinanceHealthPillars(
                context,
                data: current,
                previous: previous,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void useNarrowScreen(WidgetTester tester) {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(() {
      tester.view.resetDevicePixelRatio();
      tester.view.resetPhysicalSize();
    });
  }

  testWidgets('fits a narrow screen with every indicator measured', (
    tester,
  ) async {
    useNarrowScreen(tester);

    await tester.pumpWidget(
      buildSheet(
        current: const FinanceHealthData(
          monthsWithoutIncome: 8,
          savingsPercentage: 24,
          debtToAssetRatio: 0.3,
          cashFlowConsistency: 75,
          investmentRatio: 12,
        ),
        previous: const FinanceHealthData(
          monthsWithoutIncome: 6,
          savingsPercentage: 18,
          debtToAssetRatio: 0.4,
          cashFlowConsistency: 60,
          investmentRatio: 8,
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text(t.financial_health.composition.total), findsOneWidget);
  });

  testWidgets('sums the indicators over the measurable points only', (
    tester,
  ) async {
    useNarrowScreen(tester);

    // Savings and investment on hold, so only 60 of the 100 points can be
    // earned and the total has to be read over those 60
    const current = FinanceHealthData(
      monthsWithoutIncome: 8,
      savingsPercentage: null,
      debtToAssetRatio: 0.3,
      cashFlowConsistency: 75,
      investmentRatio: null,
    );

    await tester.pumpWidget(buildSheet(current: current));

    expect(tester.takeException(), isNull);
    expect(current.measurableWeight, 60);
    expect(
      find.text(
        t.financial_health.points_of_total(
          earned: FinanceHealthData.pointsString(current.earnedPoints),
          total: '60',
        ),
      ),
      findsOneWidget,
    );
  });
}
