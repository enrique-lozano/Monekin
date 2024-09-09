import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:parsa/app/stats/widgets/movements_distribution/chart_by_categories.dart';
import 'package:parsa/core/database/services/tags/tags_service.dart';
import 'package:parsa/core/database/services/transaction/transaction_service.dart';
import 'package:parsa/core/models/tags/tag.dart';
import 'package:parsa/core/models/transaction/transaction.dart';
import 'package:parsa/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:parsa/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:parsa/i18n/translations.g.dart';

class TagStats extends StatelessWidget {
  const TagStats({super.key, required this.filters});

  final TransactionFilters filters;

  TrDistributionChartItem<Tag> getTagInfo(
    Tag tag,
    List<MoneyTransaction> transactions,
  ) {
    transactions = transactions
        .where((element) => element.tags.any((elTag) => elTag.id == tag.id))
        .toList();

    return TrDistributionChartItem<Tag>(
      category: tag,
      transactions: transactions,
      value: transactions.map((e) => e.currentValueInPreferredCurrency).sum,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
        stream: TransactionService.instance.getTransactions(filters: filters),
        builder: (context, trSnapshot) {
          if (!trSnapshot.hasData) {
            return const LinearProgressIndicator();
          }

          if (trSnapshot.data!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                t.general.insufficient_data,
                textAlign: TextAlign.center,
              ),
            );
          }

          return StreamBuilder(
              stream: TagService.instance.getTags(),
              builder: (context, tagsSnapshot) {
                if (!tagsSnapshot.hasData) {
                  return const LinearProgressIndicator();
                }

                final tags = tagsSnapshot.data!;

                final tagsInfo = tags
                    .map((e) => getTagInfo(e, trSnapshot.data!))
                    .where((element) => element.transactions.isNotEmpty)
                    .toList();

                tagsInfo.sort((a, b) => a.value.compareTo(b.value));

                if (tags.isEmpty || tagsInfo.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                        tags.isEmpty
                            ? t.tags.empty_list
                            : t.general.insufficient_data,
                        textAlign: TextAlign.center),
                  );
                }

                return ListView.builder(
                  itemCount: tagsInfo.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final dataTag = tagsInfo[index];

                    return ListTile(
                      title: Text(dataTag.category.name),
                      subtitle: Text(
                        '${dataTag.transactions.length} ${t.transaction.display(n: dataTag.transactions.length)}'
                            .toLowerCase(),
                      ),
                      trailing:
                          CurrencyDisplayer(amountToConvert: dataTag.value),
                      leading: dataTag.category.displayIcon(),
                    );
                  },
                );
              });
        });
  }
}
