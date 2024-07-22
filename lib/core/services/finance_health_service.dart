import 'dart:math';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:rxdart/rxdart.dart';

import '../models/transaction/transaction_type.enum.dart';

class FinanceHealthAttrScore {
  /// A number between 0 and 100
  final double? score;

  /// The weight of this stat in the financial health
  final int weight;

  const FinanceHealthAttrScore({
    required this.score,
    required this.weight,
  });

  bool get canNotBeCalculated => score == null;

  double? get weightedValue {
    if (score == null) return null;

    return weight * score! / 100;
  }

  String weightedValueString({int decimalPlaces = 0}) {
    final toConvert = weightedValue;

    if (toConvert == null) return 'NA';

    return toConvert.toStringAsFixed(decimalPlaces);
  }

  String getScoreReviewTitle(
    BuildContext context, {
    GenderContext genderContext = GenderContext.male,
  }) =>
      FinanceHealthData.getHealthyValueReviewTitle(
        context,
        value: score,
        genderContext: genderContext,
      );
}

class FinanceHealthData {
  /// Number of months you could survive without any income
  final double? monthsWithoutIncome;

  /// Percentage of income that is not spent
  final double savingsPercentage;

  const FinanceHealthData({
    required this.monthsWithoutIncome,
    required this.savingsPercentage,
  });

  /// Wheter or not the healthy score is calculable (i.e. has a value)
  bool get healthyScoreCalculable => healthyScore != null;

  double? get healthyScore {
    if ([savingPercentageScore, monthsWithoutIncomeScore]
        .any((element) => element.canNotBeCalculated)) {
      return null;
    }

    return savingPercentageScore.weightedValue! +
        monthsWithoutIncomeScore.weightedValue!;
  }

  String healthyScoreString({int decimalPlaces = 0}) {
    final toConvert = healthyScore;

    if (toConvert == null) return 'NA';

    return toConvert.toStringAsFixed(decimalPlaces);
  }

  FinanceHealthAttrScore get monthsWithoutIncomeScore {
    return FinanceHealthAttrScore(
        score: monthsWithoutIncome == null
            ? null
            : min(monthsWithoutIncome! * 10, 100),
        weight: monthsWithoutIncomeWeight);
  }

  FinanceHealthAttrScore get savingPercentageScore {
    late double toReturn;

    if (savingsPercentage <= 10.109) {
      // To desmos: \frac{100}{1+e^{-5-0.95\left(x-\ 15\right)}}-2
      toReturn = 100 / (1 + exp(-5 - 0.95 * (savingsPercentage - 15))) - 2;
    }

    // To desmos: \frac{100}{1+e^{-1.25+-0.2\left(x-\ 15\right)}}
    toReturn = 100 / (1 + exp(-1.25 - 0.2 * (savingsPercentage - 15))) - 2;

    return FinanceHealthAttrScore(
        score: toReturn, weight: savingPercentageWeight);
  }

  final int savingPercentageWeight = 50;
  final int monthsWithoutIncomeWeight = 50;

  static Color getHealthyValueColor(double? healthyValue) =>
      healthyValue == null
          ? Colors.grey
          : HSLColor.fromAHSL(1, healthyValue, 1, 0.35).toColor();

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

  String getHealthyScoreReviewTitle(BuildContext context) =>
      getHealthyValueReviewTitle(
        context,
        value: healthyScore,
        genderContext: GenderContext.female,
      );

  static String getHealthyValueReviewTitle(
    BuildContext context, {
    required double? value,
    GenderContext genderContext = GenderContext.male,
  }) {
    final t = Translations.of(context);

    if (value == null) {
      return t.financial_health.review
          .insufficient_data(context: genderContext);
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

    return t.financial_health.months_without_income
        .text_other(n: monthsWithoutIncome!.toStringAsFixed(0));
  }
}

class FinanceHealthService {
  /// Returns the number of months that the user can live without income, taking into account their spending rate in the last 12 months.
  Stream<double?> getMonthsWithoutIncome({
    required TransactionFilters filters,
  }) {
    final minDate = filters.minDate ?? kDefaultFirstSelectableDate;
    final maxDate = filters.maxDate ?? DateTime.now();

    return Rx.combineLatest4(
        TransactionService.instance
            .countTransactions(predicate: filters)
            .map((event) => event.numberOfRes),
        AccountService.instance.getAccountsBalance(
          filters: filters,
        ),
        AccountService.instance
            .getAccountsBalance(
              filters: filters.copyWith(
                transactionTypes: [TransactionType.E],
              ),
            )
            .map((e) => e.abs()),
        AccountService.instance
            .getAccountsMoney(
              date: minDate,
              trFilters: filters.copyWith(minDate: null),
            )
            .map((event) => max(event, 0)),
        (numberOfTransactions, balance, expense, initialMoney) {
      if (numberOfTransactions < 4 || expense == 0) {
        return null;
      }

      final dateDiff = maxDate.difference(minDate).inDays;

      return (initialMoney + balance) / expense / dateDiff * 30;
    });
  }

  /// Returns a number (from 0 to 100) with the user's savings percentage for a given period (if specified)
  Stream<double> getSavingPercentage({
    required TransactionFilters filters,
  }) {
    return StreamZip([
      AccountService.instance.getAccountsBalance(
        filters: filters.copyWith(
          transactionTypes: [TransactionType.I],
        ),
      ),
      AccountService.instance.getAccountsBalance(
        filters: filters.copyWith(
          transactionTypes: [TransactionType.E],
        ),
      ),
    ]).map((res) {
      final income = res[0];
      final expense = res[1];

      double result = 0;
      if (income == 0 || (income == 0 && expense == 0)) {
        return result;
      } else {
        result = ((income + expense) / income) * 100;
      }

      if (result <= 0) {
        result = 0;
      }

      return result;
    });
  }

  /// Return a decimal number between 0 and 100 with the healthy value
  Stream<FinanceHealthData> getHealthyValue({
    required TransactionFilters filters,
  }) {
    return Rx.combineLatest2(
      getMonthsWithoutIncome(filters: filters),
      getSavingPercentage(filters: filters),
      (res0, res1) =>
          FinanceHealthData(monthsWithoutIncome: res0, savingsPercentage: res1),
    );
  }
}
