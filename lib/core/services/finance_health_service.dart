import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/asset_service.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/database/services/net_worth/net_worth_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period_segments.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

import '../models/transaction/transaction_type.enum.dart';

class FinanceHealthAttrScore {
  /// A number between 0 and 100
  final double? score;

  /// The weight of this stat in the financial health
  final int weight;

  const FinanceHealthAttrScore({required this.score, required this.weight});

  bool get canNotBeCalculated => score == null;

  double? get weightedValue {
    if (score == null) return null;

    return weight * score! / 100;
  }

  String weightedValueString({int decimalPlaces = 1}) {
    final toConvert = weightedValue;

    if (toConvert == null) return 'NA';

    return FinanceHealthData.pointsString(
      toConvert,
      decimalPlaces: decimalPlaces,
    );
  }

  String getScoreReviewTitle(
    BuildContext context, {
    GenderContext genderContext = GenderContext.male,
  }) => FinanceHealthData.getHealthyValueReviewTitle(
    context,
    value: score,
    genderContext: genderContext,
  );
}

class FinanceHealthData {
  /// Number of months you could survive without any income
  final double? monthsWithoutIncome;

  /// Percentage of income that is not spent. Null when there was no income in
  /// the period, since there is nothing to save from
  final double? savingsPercentage;

  /// Outstanding debt divided by gross assets
  final double? debtToAssetRatio;

  /// Percentage of the period (measured over its segments) in which the
  /// spending stayed within the share of the income that falls in them
  final double? cashFlowConsistency;

  /// Percentage of income that was put into securities (gross buys) during this
  /// period. Null for users that do not invest at all
  final double? investmentRatio;

  const FinanceHealthData({
    required this.monthsWithoutIncome,
    required this.savingsPercentage,
    required this.debtToAssetRatio,
    required this.cashFlowConsistency,
    required this.investmentRatio,
  });

  /// Wheter or not the healthy score is calculable (i.e. has a value)
  bool get healthyScoreCalculable => healthyScore != null;

  List<FinanceHealthAttrScore> get allScores => [
    savingPercentageScore,
    monthsWithoutIncomeScore,
    debtToAssetScore,
    cashFlowConsistencyScore,
    investmentRatioScore,
  ];

  /// Weight of every pillar, no matter if it can be measured or not (100)
  int get totalWeight => allScores.fold(0, (sum, score) => sum + score.weight);

  /// Weight of the pillars that can be measured with the data of this period
  int get measurableWeight => allScores
      .where((score) => !score.canNotBeCalculated)
      .fold(0, (sum, score) => sum + score.weight);

  /// Weight of the pillars that are on hold because the user does not track
  /// that part of their finances yet
  int get pausedWeight => totalWeight - measurableWeight;

  /// Points already earned, on the [totalWeight] scale
  double get earnedPoints => allScores
      .where((score) => !score.canNotBeCalculated)
      .fold(0, (sum, score) => sum + score.weightedValue!);

  /// Points that are still within reach in the pillars we can measure today
  double get pendingPoints => measurableWeight - earnedPoints;

  /// Number of pillars that can be measured with the data of this period
  int get measurableScoresCount =>
      allScores.where((score) => !score.canNotBeCalculated).length;

  /// Whether less than half of the weight can be measured, so the score leans
  /// on too few indicators to be taken at face value
  bool get hasLowReliability => measurableWeight < totalWeight * 0.55;

  /// Least amount of weight that has to be measurable for the score to be
  /// published, instead of renormalizing a couple of secondary indicators into
  /// a full grade
  static const int minMeasurableWeight = 42;

  double? get healthyScore {
    if (measurableWeight < minMeasurableWeight) return null;

    return clampDouble(earnedPoints / measurableWeight * 100, 0, 100);
  }

  String healthyScoreString({int decimalPlaces = 0}) {
    final toConvert = healthyScore;

    if (toConvert == null) return 'NA';

    return pointsString(toConvert, decimalPlaces: decimalPlaces);
  }

  /// Formats an amount of points, dropping the decimals when they add nothing
  /// (so a full 15 is not displayed as "15.0").
  static String pointsString(double points, {int decimalPlaces = 1}) =>
      points == points.roundToDouble()
      ? points.toStringAsFixed(0)
      : points.toStringAsFixed(decimalPlaces);

  FinanceHealthAttrScore get monthsWithoutIncomeScore {
    return FinanceHealthAttrScore(
      score: monthsWithoutIncome == null
          ? null
          : 100 * (1 - exp(-monthsWithoutIncome! / 6)),
      weight: monthsWithoutIncomeWeight,
    );
  }

  FinanceHealthAttrScore get savingPercentageScore {
    final savingsPercentage = this.savingsPercentage;

    if (savingsPercentage == null) {
      return FinanceHealthAttrScore(
        score: null,
        weight: savingPercentageWeight,
      );
    }

    late double toReturn;

    if (savingsPercentage <= 10.109) {
      // To desmos: \frac{100}{1+e^{-5-0.95\left(x-\ 15\right)}}-2
      toReturn = 100 / (1 + exp(-5 - 0.95 * (savingsPercentage - 15))) - 2;
    } else {
      // To desmos: \frac{100}{1+e^{-1.25+-0.2\left(x-\ 15\right)}}
      toReturn = 100 / (1 + exp(-1.25 - 0.2 * (savingsPercentage - 15))) - 2;
    }

    return FinanceHealthAttrScore(
      score: clampDouble(toReturn / _sigmoidCeiling * 100, 0, 100),
      weight: savingPercentageWeight,
    );
  }

  FinanceHealthAttrScore get debtToAssetScore {
    return FinanceHealthAttrScore(
      score: debtToAssetRatio == null
          ? null
          : clampDouble(100 * exp(-1.5 * debtToAssetRatio!), 0, 100),
      weight: debtToAssetRatioWeight,
    );
  }

  /// The metric is already the percentage of the period kept within budget, so
  /// it maps to the score without any curve in between.
  FinanceHealthAttrScore get cashFlowConsistencyScore {
    return FinanceHealthAttrScore(
      score: cashFlowConsistency,
      weight: cashFlowConsistencyWeight,
    );
  }

  FinanceHealthAttrScore get investmentRatioScore {
    final investmentRatio = this.investmentRatio;
    final monthsWithoutIncome = this.monthsWithoutIncome;

    if (investmentRatio == null || monthsWithoutIncome == null) {
      return FinanceHealthAttrScore(score: null, weight: investmentRatioWeight);
    }

    // Same sigmoid shape as [savingPercentageScore], stretched so that
    // [investmentRatioForFullScore] already earns every point of the pillar.
    // Subtracting curve(0) makes investing nothing worth exactly zero.
    double curve(double ratio) =>
        100 / (1 + exp(-1.25 - 0.2 * (ratio - 15))) - 2;

    final baseScore =
        (curve(investmentRatio) - curve(0)) /
        (curve(investmentRatioForFullScore) - curve(0)) *
        100;
    final emergencyFundProgress = clampDouble(
      monthsWithoutIncome / emergencyFundTargetMonths,
      0,
      1,
    );

    return FinanceHealthAttrScore(
      score: clampDouble(baseScore, 0, 100) * emergencyFundProgress,
      weight: investmentRatioWeight,
    );
  }

  /// The sigmoids used by the savings and investment pillars are shifted down
  /// by 2 points so their lower end reaches zero. That shift also lowers their
  /// upper end, so scores are stretched back over this ceiling to let a great
  /// period earn the full weight of the pillar.
  static const double _sigmoidCeiling = 98;

  /// Share of the income invested that already earns every point of the
  /// investment pillar. Going further is not extra credit: it usually means
  /// deploying savings from previous periods, and the risk of leaving yourself
  /// without a cash cushion is already measured by the survival rate.
  static const double investmentRatioForFullScore = 25;

  /// Runway that unlocks the full investment-ratio score.
  static const double emergencyFundTargetMonths = 5;

  // Runway and savings percentage are the most telling signals of day-to-day
  // financial health, so they carry the most weight.
  final int monthsWithoutIncomeWeight = 30;
  final int savingPercentageWeight = 30;
  final int debtToAssetRatioWeight = 15;
  final int cashFlowConsistencyWeight = 15;
  final int investmentRatioWeight = 10;

  static Color getHealthyValueColor(double? healthyValue) =>
      healthyValue == null
      ? Colors.grey
      : HSLColor.fromAHSL(
          1,
          clampDouble(healthyValue, 0, 100),
          1,
          0.35,
        ).toColor();

  Color getHealthyScoreColor() => getHealthyValueColor(healthyScore);

  String getHealthyScoreReviewDescr(BuildContext context) {
    final t = Translations.of(context);

    if (healthyScore == null) {
      return t.financial_health.review.descr.insufficient_data;
    } else if (healthyScore! < 20) {
      return t.financial_health.review.descr.very_bad;
    } else if (healthyScore! < 40) {
      return t.financial_health.review.descr.bad;
    } else if (healthyScore! < 60) {
      return t.financial_health.review.descr.normal;
    } else if (healthyScore! < 80) {
      return t.financial_health.review.descr.good;
    } else {
      return t.financial_health.review.descr.very_good;
    }
  }

  String getHealthyScoreReviewTitle(BuildContext context) {
    return getHealthyValueReviewTitle(
      context,
      value: healthyScore,
      genderContext: GenderContext.female,
    );
  }

  static String getHealthyValueReviewTitle(
    BuildContext context, {
    required double? value,
    GenderContext genderContext = GenderContext.male,
  }) {
    final t = Translations.of(context);

    if (value == null) {
      return t.financial_health.review.insufficient_data(
        context: genderContext,
      );
    } else if (value < 20) {
      return t.financial_health.review.very_bad(context: genderContext);
    } else if (value < 40) {
      return t.financial_health.review.bad(context: genderContext);
    } else if (value < 60) {
      return t.financial_health.review.normal(context: genderContext);
    } else if (value < 80) {
      return t.financial_health.review.good(context: genderContext);
    } else {
      return t.financial_health.review.very_good(context: genderContext);
    }
  }

  String getMonthsWithoutIncomeResume(BuildContext context) {
    final t = Translations.of(context);

    if (monthsWithoutIncome == null) {
      return t.financial_health.months_without_income.insufficient_data;
    }

    if (monthsWithoutIncome == 0) {
      return t.financial_health.months_without_income.text_zero;
    }

    if (monthsWithoutIncome == 1) {
      return t.financial_health.months_without_income.text_one;
    }

    if (monthsWithoutIncome! > 999) {
      return t.financial_health.months_without_income.text_infinite;
    }

    return t.financial_health.months_without_income.text_other(
      n: monthsWithoutIncome!.toStringAsFixed(0),
    );
  }
}

class FinanceHealthService {
  /// Returns the number of months that the user can live without income, taking into account their spending rate in the last 12 months.
  Stream<double?> getMonthsWithoutIncome({
    required TransactionFilterSet filters,
  }) {
    final minDate = filters.minDate ?? kDefaultFirstSelectableDate;
    final maxDate = filters.maxDate ?? DateTime.now();

    return Rx.combineLatest3(
      TransactionService.instance.countTransactions(filters: filters),
      AccountService.instance.getAccountsMoney(
        accountIds: filters.accountsIDs,
        trFilters: filters.copyWithNull(minDate: true),
        date: maxDate,
      ),
      TransactionService.instance
          .getTransactionsValueBalance(
            filters: filters.copyWith(
              transactionTypes: [TransactionType.expense],
            ),
          )
          .map((e) => e.abs()),
      (numberOfTransactions, accountsMoney, expense) {
        if (numberOfTransactions < 4 || expense == 0) {
          return null;
        }

        final dateDiff = maxDate.difference(minDate).inDays;
        final monthlyExpense = expense / dateDiff * 30;

        return max(accountsMoney / monthlyExpense, 0);
      },
    );
  }

  /// Returns a number (from 0 to 100) with the user's savings percentage for a
  /// given period (if specified), or null when the period does not hold enough
  /// activity to judge it
  Stream<double?> getSavingPercentage({required TransactionFilterSet filters}) {
    return Rx.combineLatest3(
      TransactionService.instance.getTransactionsValueBalance(
        filters: filters.copyWith(transactionTypes: [TransactionType.income]),
      ),
      TransactionService.instance.getTransactionsValueBalance(
        filters: filters.copyWith(transactionTypes: [TransactionType.expense]),
      ),
      TransactionService.instance.countTransactions(filters: filters),
      (income, expense, transactionCount) {
        if (income <= 0) return transactionCount >= 10 ? 0.0 : null;

        return max(((income + expense) / income) * 100, 0);
      },
    );
  }

  /// Outstanding debt over gross assets, or null while the user does not track
  /// any debt nor asset
  Stream<double?> getDebtToAssetRatio({required TransactionFilterSet filters}) {
    final date = filters.maxDate ?? DateTime.now();

    return Rx.combineLatest4(
      NetWorthService.instance.getGrossAssetsAtDate(date, trFilters: filters),
      NetWorthService.instance.getTotalDebtsInPreferredCurrency(
        exchangeRateAsOf: date,
      ),
      DebtService.instance.getDebts(limit: 1).map((debts) => debts.isNotEmpty),
      AssetService.instance
          .getAssets(limit: 1)
          .map((assets) => assets.isNotEmpty),
      (grossAssets, debts, hasAnyDebt, hasAnyAsset) {
        if (!hasAnyDebt && !hasAnyAsset) return null;
        if (grossAssets <= 0 && debts <= 0) return null;
        if (grossAssets <= 0) return double.infinity;

        return debts / grossAssets;
      },
    );
  }

  /// Percentage of [dateRange] in which the spending stayed within the income,
  /// measured over the same segments that the "by periods" bar chart draws.
  ///
  /// The income of the whole range is spread across the segments proportionally
  /// to the days elapsed in each one instead of being read segment by segment.
  /// Otherwise the segment where the payday lands would be the only one in the
  /// green, and the pillar would end up measuring when the user gets paid.
  /// Spending that share or less earns the whole segment, spending twice as
  /// much earns nothing, and in between the credit is proportional.
  ///
  /// Segments that have not started yet are out of the picture, and the ones
  /// without activity neither add nor subtract.
  ///
  /// Null when there is not enough of a pattern to read: fewer than
  /// [_minConsistencySegments] segments with activity, or no income to spread
  Stream<double?> getCashFlowConsistency({
    required TransactionFilterSet filters,
    required DatePeriodState dateRange,
  }) {
    final now = DateTime.now();

    return filters.accounts().switchMap((accounts) {
      // Segments that have barely started are left out: they hold too few
      // transactions for their balance to mean anything, and their spending
      // would be compared against a whole segment worth of income
      final segments = dateRange
          .splitIntoSegments(
            oldestDate: accounts.isEmpty
                ? null
                : accounts.map((account) => account.date).min,
            includeFutureSegments: false,
          )
          .where(
            (segment) =>
                segment.elapsedDaysAt(now) >= _minConsistencySegmentDays,
          )
          .toList();

      if (segments.length < _minConsistencySegments) {
        return Stream.value(null);
      }

      return TransactionService.instance
          .getTransactions(
            filters: filters.copyWith(
              transactionTypes: [
                TransactionType.income,
                TransactionType.expense,
              ],
              status: TransactionStatus.getStatusThatCountsForStats(
                filters.status,
              ),
              minDate: segments.first.start,
              maxDate: segments.last.end,
            ),
          )
          .map((transactions) => _consistencyOf(segments, transactions));
    });
  }

  double? _consistencyOf(
    List<DatePeriodSegment> segments,
    List<MoneyTransaction> transactions,
  ) {
    final now = DateTime.now();

    final income = List.filled(segments.length, 0.0);
    final expense = List.filled(segments.length, 0.0);

    for (final transaction in transactions) {
      final index = segments.indexWhere(
        (segment) => segment.contains(transaction.date),
      );

      if (index == -1) continue;

      if (transaction.type == TransactionType.income) {
        income[index] += transaction.currentValueInPreferredCurrency;
      } else {
        expense[index] += transaction.currentValueInPreferredCurrency.abs();
      }
    }

    final active = [
      for (var i = 0; i < segments.length; i++)
        if (income[i] != 0 || expense[i] != 0) i,
    ];

    if (active.length < _minConsistencySegments) return null;

    final totalIncome = active.fold(0.0, (sum, i) => sum + income[i]);
    if (totalIncome <= 0) return null;

    final totalDays = active.fold(
      0,
      (sum, i) => sum + segments[i].elapsedDaysAt(now),
    );

    final earned = active.fold(0.0, (sum, i) {
      final share = totalIncome * segments[i].elapsedDaysAt(now) / totalDays;

      return sum + clampDouble(2 - expense[i] / share, 0, 1);
    });

    return earned / active.length * 100;
  }

  /// Percentage of income put into securities (gross buys, not netted against
  /// sells) during [filters]' date range. Null when no investment account was
  /// open in that range
  Stream<double?> getInvestmentRatio({required TransactionFilterSet filters}) {
    final minDate = filters.minDate ?? kDefaultFirstSelectableDate;
    final maxDate = filters.maxDate ?? DateTime.now();

    return filters.accounts().switchMap((accounts) {
      final investmentAccounts = accounts
          .where(
            (account) =>
                account.type == AccountType.investment &&
                !account.date.isAfter(maxDate) &&
                (account.closingDate == null ||
                    !account.closingDate!.isBefore(minDate)),
          )
          .toList();

      if (investmentAccounts.isEmpty) return Stream.value(null);

      final transactionAccountIds = investmentAccounts
          .where(
            (account) =>
                account.trackingMode == AccountTrackingMode.transactions,
          )
          .map((account) => account.id)
          .toList();
      final holdingsAccountIds = investmentAccounts
          .where(
            (account) => account.trackingMode == AccountTrackingMode.holdings,
          )
          .map((account) => account.id)
          .toList();

      final transactionBuys = transactionAccountIds.isEmpty
          ? Stream.value(0.0)
          : TransactionService.instance.getInvestmentBuyVolume(
              filters: filters.copyWith(
                accountsIDs: transactionAccountIds,
                includeReceivingAccountsInAccountFilters: false,
              ),
            );
      final snapshotContributions = HoldingService.instance
          .getSnapshotInvestmentContributions(
            accountIds: holdingsAccountIds,
            minDate: minDate,
            maxDate: maxDate,
          );

      return Rx.combineLatest3(
        TransactionService.instance.getTransactionsValueBalance(
          filters: filters.copyWith(transactionTypes: [TransactionType.income]),
        ),
        transactionBuys,
        snapshotContributions,
        (income, transactionAmount, snapshotAmount) {
          final investedAmount = transactionAmount + snapshotAmount;
          if (income <= 0) return investedAmount > 0 ? 100.0 : 0.0;

          return investedAmount / income * 100;
        },
      );
    });
  }

  /// Return a decimal number between 0 and 100 with the healthy value
  Stream<FinanceHealthData> getHealthyValue({
    required TransactionFilterSet filters,
    required DatePeriodState dateRange,
  }) {
    return Rx.combineLatest5(
      getMonthsWithoutIncome(filters: filters),
      getSavingPercentage(filters: filters),
      getDebtToAssetRatio(filters: filters),
      getCashFlowConsistency(filters: filters, dateRange: dateRange),
      getInvestmentRatio(filters: filters),
      (
        monthsWithoutIncome,
        savingsPercentage,
        debtToAssetRatio,
        cashFlowConsistency,
        investmentRatio,
      ) => FinanceHealthData(
        monthsWithoutIncome: monthsWithoutIncome,
        savingsPercentage: savingsPercentage,
        debtToAssetRatio: debtToAssetRatio,
        cashFlowConsistency: cashFlowConsistency,
        investmentRatio: investmentRatio,
      ),
    );
  }
}

/// Segments with fewer days than this hold too few transactions for their
/// balance to mean anything: a single weekly shop would sink the day it lands on
const _minConsistencySegmentDays = 3;

/// Fewer segments with activity than this leave no pattern to read
const _minConsistencySegments = 3;
