import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/services/finance_health_service.dart';

void main() {
  FinanceHealthData createData({
    double? monthsWithoutIncome,
    double? savingsPercentage = 20,
    double? debtToAssetRatio,
    double? cashFlowConsistency,
    double? investmentRatio = 0,
  }) {
    return FinanceHealthData(
      monthsWithoutIncome: monthsWithoutIncome,
      savingsPercentage: savingsPercentage,
      debtToAssetRatio: debtToAssetRatio,
      cashFlowConsistency: cashFlowConsistency,
      investmentRatio: investmentRatio,
    );
  }

  group('FinanceHealthData', () {
    test('runway score approaches 100 without reaching an early cap', () {
      final sixMonths = createData(
        monthsWithoutIncome: 6,
      ).monthsWithoutIncomeScore.score!;
      final twelveMonths = createData(
        monthsWithoutIncome: 12,
      ).monthsWithoutIncomeScore.score!;
      final lifetime = createData(
        monthsWithoutIncome: 1000,
      ).monthsWithoutIncomeScore.score!;

      expect(sixMonths, closeTo(63.21, 0.01));
      expect(twelveMonths, closeTo(86.47, 0.01));
      expect(lifetime, greaterThan(twelveMonths));
      expect(lifetime, lessThanOrEqualTo(100));
    });

    test('savings percentage score is zero when nothing is saved', () {
      final noSavings = createData(
        savingsPercentage: 0,
      ).savingPercentageScore.score!;
      final smallSavings = createData(
        savingsPercentage: 8,
      ).savingPercentageScore.score!;

      expect(noSavings, 0);
      expect(smallSavings, greaterThan(noSavings));
      expect(smallSavings, lessThan(createData().savingPercentageScore.score!));
    });

    test('an outstanding saver earns the whole weight of the pillar', () {
      final score = createData(savingsPercentage: 80).savingPercentageScore;

      expect(score.score, closeTo(100, 0.01));
      expect(score.weightedValue, closeTo(score.weight, 0.01));
    });

    test('debt-to-asset score decreases as leverage rises', () {
      final debtFree = createData(debtToAssetRatio: 0).debtToAssetScore.score!;
      final halfLeveraged = createData(
        debtToAssetRatio: 0.5,
      ).debtToAssetScore.score!;
      final fullyLeveraged = createData(
        debtToAssetRatio: 1,
      ).debtToAssetScore.score!;

      expect(debtFree, 100);
      expect(halfLeveraged, closeTo(47.24, 0.01));
      expect(fullyLeveraged, closeTo(22.31, 0.01));
    });

    test('cash-flow consistency maps straight to its score', () {
      expect(
        createData(cashFlowConsistency: 0).cashFlowConsistencyScore.score,
        0,
      );
      expect(
        createData(cashFlowConsistency: 83.3).cashFlowConsistencyScore.score,
        closeTo(83.3, 0.01),
      );

      final perfect = createData(
        cashFlowConsistency: 100,
      ).cashFlowConsistencyScore;

      expect(perfect.weightedValue, closeTo(perfect.weight, 0.01));
    });

    test('investment ratio score rewards a higher share of income invested, '
        'and plateaus once that share is healthy', () {
      final none = createData(
        monthsWithoutIncome: 5,
        investmentRatio: 0,
      ).investmentRatioScore.score!;
      final fifteenPercent = createData(
        monthsWithoutIncome: 5,
        investmentRatio: 15,
      ).investmentRatioScore.score!;
      final healthy = createData(
        monthsWithoutIncome: 5,
        investmentRatio: FinanceHealthData.investmentRatioForFullScore,
      ).investmentRatioScore.score!;
      final everything = createData(
        monthsWithoutIncome: 5,
        investmentRatio: 100,
      ).investmentRatioScore.score!;

      expect(none, 0);
      expect(none, lessThan(fifteenPercent));
      expect(fifteenPercent, lessThan(healthy));
      expect(healthy, 100);
      // Investing beyond the healthy share is not extra credit: the risk of
      // running out of cash is the survival rate's business
      expect(everything, healthy);
    });

    test('investment score unlocks with five months of runway', () {
      const ratio = FinanceHealthData.investmentRatioForFullScore;
      final noRunway = createData(
        monthsWithoutIncome: 0,
        investmentRatio: ratio,
      ).investmentRatioScore.score!;
      final halfway = createData(
        monthsWithoutIncome: 2.5,
        investmentRatio: ratio,
      ).investmentRatioScore.score!;
      final funded = createData(
        monthsWithoutIncome: FinanceHealthData.emergencyFundTargetMonths,
        investmentRatio: ratio,
      ).investmentRatioScore.score!;

      expect(noRunway, 0);
      expect(halfway, closeTo(50, 0.01));
      expect(funded, 100);
    });

    test('investment score pauses when runway cannot be measured', () {
      final score = createData(
        monthsWithoutIncome: null,
        investmentRatio: 25,
      ).investmentRatioScore;

      expect(score.canNotBeCalculated, isTrue);
    });

    test('runway and savings percentage carry the largest weights', () {
      final data = createData();

      expect(data.monthsWithoutIncomeWeight, 30);
      expect(data.savingPercentageWeight, 30);
      expect(data.debtToAssetRatioWeight, 15);
      expect(data.cashFlowConsistencyWeight, 15);
      expect(data.investmentRatioWeight, 10);
    });

    test('renormalizes the score when optional pillars are unavailable', () {
      final data = createData(
        monthsWithoutIncome: null,
        debtToAssetRatio: 0.2,
        cashFlowConsistency: null,
        investmentRatio: null,
      );

      final expected =
          (data.savingPercentageScore.weightedValue! +
              data.debtToAssetScore.weightedValue!) /
          (data.savingPercentageWeight + data.debtToAssetRatioWeight) *
          100;

      expect(
        data.measurableWeight,
        greaterThanOrEqualTo(FinanceHealthData.minMeasurableWeight),
      );
      expect(data.healthyScore, closeTo(expected, 0.01));
    });

    test('pauses the pillars without anything to measure', () {
      final data = createData(savingsPercentage: null, investmentRatio: null);

      expect(data.savingPercentageScore.canNotBeCalculated, isTrue);
      expect(data.investmentRatioScore.canNotBeCalculated, isTrue);
      expect(data.measurableWeight, 0);
      expect(data.healthyScore, isNull);
    });

    test('earned, pending and paused points always add up to the total', () {
      final data = createData(
        monthsWithoutIncome: 6,
        savingsPercentage: 12,
        investmentRatio: null,
      );

      expect(data.totalWeight, 100);
      expect(data.measurableWeight, 60);
      expect(data.pausedWeight, 40);
      expect(
        data.earnedPoints + data.pendingPoints + data.pausedWeight,
        closeTo(data.totalWeight, 0.01),
      );
    });

    test('there is no score when too little weight can be measured', () {
      final onlyDebt = createData(
        savingsPercentage: null,
        investmentRatio: null,
        debtToAssetRatio: 0.1,
      );
      final savingsAndDebt = createData(
        investmentRatio: null,
        debtToAssetRatio: 0.1,
      );

      expect(
        onlyDebt.measurableWeight,
        lessThan(FinanceHealthData.minMeasurableWeight),
      );
      expect(onlyDebt.healthyScore, isNull);
      expect(
        savingsAndDebt.measurableWeight,
        greaterThanOrEqualTo(FinanceHealthData.minMeasurableWeight),
      );
      expect(savingsAndDebt.healthyScore, isNotNull);
    });

    test('the score is unreliable when most of the weight is paused', () {
      final onlySavings = createData(investmentRatio: null);
      final savingsAndRunway = createData(
        monthsWithoutIncome: 6,
        investmentRatio: null,
      );

      expect(onlySavings.measurableWeight, 30);
      expect(onlySavings.measurableScoresCount, 1);
      expect(onlySavings.hasLowReliability, isTrue);
      expect(savingsAndRunway.hasLowReliability, isFalse);
    });

    test('computes the weighted average of all available pillars', () {
      final data = createData(
        monthsWithoutIncome: 6,
        debtToAssetRatio: 0.5,
        cashFlowConsistency: 80,
        investmentRatio: 10,
      );

      final scores = [
        data.savingPercentageScore,
        data.monthsWithoutIncomeScore,
        data.debtToAssetScore,
        data.cashFlowConsistencyScore,
        data.investmentRatioScore,
      ];
      final totalWeight = scores.fold<int>(0, (sum, s) => sum + s.weight);
      final weightedSum = scores.fold<double>(
        0,
        (sum, s) => sum + s.weightedValue!,
      );

      expect(data.healthyScore, closeTo(weightedSum / totalWeight * 100, 0.01));
    });
  });
}
