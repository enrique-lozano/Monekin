import 'package:flutter/material.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_main_info.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/translations.g.dart';

class FinanceHealthDetails extends StatefulWidget {
  const FinanceHealthDetails({super.key, required this.filters});

  final TransactionFilters filters;

  @override
  State<FinanceHealthDetails> createState() => _FinanceHealthDetailsState();
}

class _FinanceHealthDetailsState extends State<FinanceHealthDetails> {
  Widget buildExpansionPanel({
    required FinanceHealthAttrScore attrScore,
    required int index,
    required String title,
    required String subtitle,
    required String text,
  }) {
    return ExpansionTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 16,
                color: FinanceHealthData.getHealthyValueColor(attrScore.score),
              ),
              const SizedBox(width: 4),
              Text(
                attrScore.getScoreReviewTitle(context),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: FinanceHealthData.getHealthyValueColor(
                          attrScore.score),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
      subtitle: Text(subtitle),
      childrenPadding: const EdgeInsets.all(16),
      children: [
        HTMLText(
          tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
          htmlString: text,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
        stream: FinanceHealthService().getHealthyValue(filters: widget.filters),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          }

          final financeHealthData = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardWithHeader(
                title: t.stats.finance_health_resume,
                bodyPadding: const EdgeInsets.all(16),
                body:
                    FinanceHealthMainInfo(financeHealthData: financeHealthData),
              ),
              const SizedBox(height: 16),
              Builder(builder: (context) {
                final savingsText = financeHealthData.savingsPercentage > 20
                    ? t.financial_health.savings_percentage.text.good(
                        value: financeHealthData.savingsPercentage
                            .toStringAsFixed(2),
                      )
                    : financeHealthData.savingsPercentage > 10
                        ? t.financial_health.savings_percentage.text.normal(
                            value: financeHealthData.savingsPercentage
                                .toStringAsFixed(2),
                          )
                        : financeHealthData.savingsPercentage > 0
                            ? t.financial_health.savings_percentage.text.bad(
                                value: financeHealthData.savingsPercentage
                                    .toStringAsFixed(2),
                              )
                            : t.financial_health.savings_percentage.text
                                .very_bad;

                return CardWithHeader(
                  title: t.stats.finance_health_breakdown,
                  body: Column(
                    children: [
                      buildExpansionPanel(
                          attrScore: financeHealthData.monthsWithoutIncomeScore,
                          title: t.financial_health.months_without_income.title,
                          subtitle:
                              t.financial_health.months_without_income.subtitle,
                          text:
                              '${financeHealthData.getMonthsWithoutIncomeResume(context)}\n\n${t.financial_health.months_without_income.suggestion}',
                          index: 0),
                      buildExpansionPanel(
                          attrScore: financeHealthData.savingPercentageScore,
                          title: t.financial_health.savings_percentage.title,
                          subtitle:
                              t.financial_health.savings_percentage.subtitle,
                          text:
                              '$savingsText\n\n${t.financial_health.savings_percentage.suggestion}',
                          index: 1)
                    ],
                    //elevation: 0,
                  ),
                );
              }),
            ],
          );
        });
  }
}
