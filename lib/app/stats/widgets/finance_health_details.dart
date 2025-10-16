import 'package:flutter/material.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_main_info.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class FinanceHealthDetails extends StatefulWidget {
  const FinanceHealthDetails({super.key, required this.filters});

  final TransactionFilters filters;

  @override
  State<FinanceHealthDetails> createState() => _FinanceHealthDetailsState();
}

class _FinanceHealthDetailsState extends State<FinanceHealthDetails> {
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
              body: FinanceHealthMainInfo(financeHealthData: financeHealthData),
            ),
            const SizedBox(height: 16),
            Builder(
              builder: (context) {
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
                    : t.financial_health.savings_percentage.text.very_bad;

                return CardWithHeader(
                  title: t.stats.finance_health_breakdown,
                  body: Column(
                    children: [
                      _FinanceHealthDetailTile(
                        attrScore: financeHealthData.monthsWithoutIncomeScore,
                        title: t.financial_health.months_without_income.title,
                        subtitle:
                            t.financial_health.months_without_income.subtitle,
                        text:
                            '${financeHealthData.getMonthsWithoutIncomeResume(context)}\n\n${t.financial_health.months_without_income.suggestion}',
                        index: 0,
                      ),
                      _FinanceHealthDetailTile(
                        attrScore: financeHealthData.savingPercentageScore,
                        title: t.financial_health.savings_percentage.title,
                        subtitle:
                            t.financial_health.savings_percentage.subtitle,
                        text:
                            '$savingsText\n\n${t.financial_health.savings_percentage.suggestion}',
                        index: 1,
                      ),
                    ],
                    //elevation: 0,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _FinanceHealthDetailTile extends StatelessWidget {
  const _FinanceHealthDetailTile({
    required this.attrScore,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.text,
  });

  final FinanceHealthAttrScore attrScore;
  final int index;
  final String title;
  final String subtitle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.topLeft,

      title: ListTile(
        title: Text(title),
        leading: SizedBox(
          width: 32,
          child: Column(
            children: [
              Text(
                attrScore.weightedValue?.toStringAsFixed(0) ?? '--',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: FinanceHealthData.getHealthyValueColor(
                    attrScore.score,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'pts',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: FinanceHealthData.getHealthyValueColor(
                    attrScore.score,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        minTileHeight: 20,
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.all(0),
        subtitle: Text(subtitle),
      ),
      //   subtitle: Text(subtitle),
      childrenPadding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      children: [
        HTMLText(
          tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
          htmlString: text,
        ),
      ],
    );
  }
}
