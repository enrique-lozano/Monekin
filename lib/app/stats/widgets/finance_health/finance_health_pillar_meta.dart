import 'package:flutter/material.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// One financial-health pillar with its copy and scores already resolved for
/// the UI, so the widgets do not have to know which indicator they display.
class FinanceHealthPillarMeta {
  const FinanceHealthPillarMeta({
    required this.icon,
    required this.title,
    required this.aboutText,
    required this.formulaText,
    required this.unlockText,
    required this.valueText,
    required this.descriptionHtml,
    required this.attrScore,
    required this.prevAttrScore,
  });

  final IconData icon;
  final String title;

  /// Short explanation of what this indicator measures.
  final String aboutText;

  /// Short explanation of how the raw value is calculated.
  final String formulaText;

  /// What the user has to do so this indicator can start giving points.
  final String unlockText;

  /// Compact current value, e.g. "18 %" or "4.8 months".
  final String valueText;

  /// Longer, HTML-capable explanation + suggestion for the detail sheet.
  final String descriptionHtml;

  final FinanceHealthAttrScore attrScore;
  final FinanceHealthAttrScore? prevAttrScore;

  /// Whether this indicator has nothing meaningful to measure yet, so its
  /// points are on hold instead of counting as a zero.
  bool get isPaused => attrScore.canNotBeCalculated;
}

/// Builds the 5 financial-health pillars for [data], optionally comparing
/// against the [previous] period (when available).
///
/// The ones that can be measured come first, so the indicators on hold do not
/// get in the way of the ones the user can actually act on.
List<FinanceHealthPillarMeta> buildFinanceHealthPillars(
  BuildContext context, {
  required FinanceHealthData data,
  required FinanceHealthData? previous,
}) {
  final t = Translations.of(context);

  final monthsWithoutIncome = data.monthsWithoutIncome;
  final monthsValueText = monthsWithoutIncome == null
      ? '—'
      : monthsWithoutIncome > 999
      ? '∞'
      : t.financial_health.months_without_income.value_short(
          n: monthsWithoutIncome.toStringAsFixed(1),
        );

  final savingsPercentage = data.savingsPercentage;
  final savingsText = savingsPercentage == null
      ? t.financial_health.savings_percentage.insufficient_data
      : savingsPercentage > 20
      ? t.financial_health.savings_percentage.text.good(
          value: savingsPercentage.toStringAsFixed(2),
        )
      : savingsPercentage > 10
      ? t.financial_health.savings_percentage.text.normal(
          value: savingsPercentage.toStringAsFixed(2),
        )
      : savingsPercentage > 0
      ? t.financial_health.savings_percentage.text.bad(
          value: savingsPercentage.toStringAsFixed(2),
        )
      : t.financial_health.savings_percentage.text.very_bad;

  final debtToAssetRatio = data.debtToAssetRatio;
  final debtToAssetText = debtToAssetRatio == null
      ? t.financial_health.debt_to_asset_ratio.insufficient_data
      : debtToAssetRatio.isInfinite
      ? t.financial_health.debt_to_asset_ratio.text.no_assets
      : t.financial_health.debt_to_asset_ratio.text.value(
          value: (debtToAssetRatio * 100).toStringAsFixed(1),
        );
  final debtToAssetValueText = debtToAssetRatio == null
      ? '—'
      : debtToAssetRatio.isInfinite
      ? '∞'
      : '${(debtToAssetRatio * 100).toStringAsFixed(0)} %';

  final netWorthTrend = data.netWorthTrend;
  final netWorthTrendText = netWorthTrend == null
      ? t.financial_health.net_worth_trend.insufficient_data
      : netWorthTrend > 0
      ? t.financial_health.net_worth_trend.text.positive(
          value: (netWorthTrend * 100).toStringAsFixed(1),
        )
      : netWorthTrend < 0
      ? t.financial_health.net_worth_trend.text.negative(
          value: (netWorthTrend.abs() * 100).toStringAsFixed(1),
        )
      : t.financial_health.net_worth_trend.text.flat;
  final netWorthTrendValueText = netWorthTrend == null
      ? '—'
      : '${netWorthTrend > 0 ? '+' : ''}${(netWorthTrend * 100).toStringAsFixed(1)} %';

  final investmentRatio = data.investmentRatio;
  final investmentRatioText = investmentRatio == null
      ? t.financial_health.investment_ratio.insufficient_data
      : investmentRatio > 0
      ? t.financial_health.investment_ratio.text.value(
          value: investmentRatio.toStringAsFixed(2),
        )
      : t.financial_health.investment_ratio.text.none;

  String describe(String text, String suggestion, {required bool isPaused}) =>
      isPaused ? text : '$text\n\n$suggestion';

  final pillars = [
    FinanceHealthPillarMeta(
      icon: Icons.shield_outlined,
      title: t.financial_health.months_without_income.title,
      aboutText: t.financial_health.months_without_income.subtitle,
      formulaText: t.financial_health.months_without_income.formula,
      unlockText: t.financial_health.months_without_income.unlock,
      valueText: monthsValueText,
      descriptionHtml: describe(
        data.getMonthsWithoutIncomeResume(context),
        t.financial_health.months_without_income.suggestion,
        isPaused: monthsWithoutIncome == null,
      ),
      attrScore: data.monthsWithoutIncomeScore,
      prevAttrScore: previous?.monthsWithoutIncomeScore,
    ),
    FinanceHealthPillarMeta(
      icon: Icons.savings_outlined,
      title: t.financial_health.savings_percentage.title,
      aboutText: t.financial_health.savings_percentage.subtitle,
      formulaText: t.financial_health.savings_percentage.formula,
      unlockText: t.financial_health.savings_percentage.unlock,
      valueText: savingsPercentage == null
          ? '—'
          : '${savingsPercentage.toStringAsFixed(0)} %',
      descriptionHtml: describe(
        savingsText,
        t.financial_health.savings_percentage.suggestion,
        isPaused: savingsPercentage == null,
      ),
      attrScore: data.savingPercentageScore,
      prevAttrScore: previous?.savingPercentageScore,
    ),
    FinanceHealthPillarMeta(
      icon: Icons.balance_outlined,
      title: t.financial_health.debt_to_asset_ratio.title,
      aboutText: t.financial_health.debt_to_asset_ratio.subtitle,
      formulaText: t.financial_health.debt_to_asset_ratio.formula,
      unlockText: t.financial_health.debt_to_asset_ratio.unlock,
      valueText: debtToAssetValueText,
      descriptionHtml: describe(
        debtToAssetText,
        t.financial_health.debt_to_asset_ratio.suggestion,
        isPaused: debtToAssetRatio == null,
      ),
      attrScore: data.debtToAssetScore,
      prevAttrScore: previous?.debtToAssetScore,
    ),
    FinanceHealthPillarMeta(
      icon: Icons.show_chart_rounded,
      title: t.financial_health.net_worth_trend.title,
      aboutText: t.financial_health.net_worth_trend.subtitle,
      formulaText: t.financial_health.net_worth_trend.formula,
      unlockText: t.financial_health.net_worth_trend.unlock,
      valueText: netWorthTrendValueText,
      descriptionHtml: describe(
        netWorthTrendText,
        t.financial_health.net_worth_trend.suggestion,
        isPaused: netWorthTrend == null,
      ),
      attrScore: data.netWorthTrendScore,
      prevAttrScore: previous?.netWorthTrendScore,
    ),
    FinanceHealthPillarMeta(
      icon: Icons.candlestick_chart_outlined,
      title: t.financial_health.investment_ratio.title,
      aboutText: t.financial_health.investment_ratio.subtitle,
      formulaText: t.financial_health.investment_ratio.formula,
      unlockText: t.financial_health.investment_ratio.unlock,
      valueText: investmentRatio == null
          ? '—'
          : '${investmentRatio.toStringAsFixed(0)} %',
      descriptionHtml: describe(
        investmentRatioText,
        t.financial_health.investment_ratio.suggestion,
        isPaused: investmentRatio == null,
      ),
      attrScore: data.investmentRatioScore,
      prevAttrScore: previous?.investmentRatioScore,
    ),
  ];

  return [
    ...pillars.where((pillar) => !pillar.isPaused),
    ...pillars.where((pillar) => pillar.isPaused),
  ];
}
