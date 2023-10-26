import 'package:flutter/material.dart';
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
  List<bool> _isOpen = [false, false];

  ExpansionPanel buildExpansionPanel({
    required FinanceHealthAttrScore attrScore,
    required int index,
    required String title,
    required String subtitle,
    required String text,
  }) {
    return ExpansionPanel(
        isExpanded: _isOpen[index],
        canTapOnHeader: true,
        headerBuilder: (context, isExpanded) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        attrScore.weightedValueString(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: FinanceHealthData.getHealthyValueColor(
                                  attrScore.score),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Container(
                        width: 32,
                        height: 1, // Thickness
                        color: Theme.of(context).dividerColor,
                      ),
                      Text(
                        attrScore.weight.toStringAsFixed(0),
                        style: const TextStyle(fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(title),
                  subtitle: Text(subtitle),
                ),
              ),
            ],
          );
        },
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: HTMLText(
            tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
            htmlString: text,
          ),
        ));
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
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text:
                                        financeHealthData.healthyScoreString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: FinanceHealthData
                                              .getHealthyValueColor(
                                                  financeHealthData
                                                      .healthyScore),
                                          fontWeight: FontWeight.w700,
                                        )),
                                TextSpan(text: " / 100"),
                              ]),
                            ),
                            Text(
                              financeHealthData
                                  .getHealthyValueReviewTitle(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color:
                                        FinanceHealthData.getHealthyValueColor(
                                            financeHealthData.healthyScore),
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        VerticalDivider(),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            "Este indicador te sirve para conocer como de bien estan tus finanzas, basandose en los criterios que se muestran a continuación",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text("Calculo de la salud financiera:"),
              ),
              Builder(builder: (context) {
                final savings_text = financeHealthData.savingsPercentage > 20
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

                return ExpansionPanelList(
                  children: [
                    buildExpansionPanel(
                        attrScore: financeHealthData.monthsWithoutIncomeScore,
                        title: t.financial_health.months_without_income.title,
                        subtitle:
                            t.financial_health.months_without_income.subtitle,
                        text: '${financeHealthData.monthsWithoutIncome == null ? t.financial_health.months_without_income.insufficient_data : t.financial_health.months_without_income.text(
                            n: financeHealthData.monthsWithoutIncome!.round(),
                          )}\n\n${t.financial_health.months_without_income.suggestion}',
                        index: 0),
                    buildExpansionPanel(
                        attrScore: financeHealthData.savingPercentageScore,
                        title: t.financial_health.savings_percentage.title,
                        subtitle:
                            t.financial_health.savings_percentage.subtitle,
                        text:
                            '$savings_text\n\n${t.financial_health.savings_percentage.suggestion}',
                        index: 1)
                  ],
                  //elevation: 0,
                  expansionCallback: (panelIndex, isExpanded) => setState(() {
                    _isOpen[panelIndex] = isExpanded;
                  }),
                );
              }),
            ],
          );
        });
  }
}
