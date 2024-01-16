import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction_periodicity.dart';
import 'package:monekin/core/presentation/widgets/empty_indicator.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/translations.g.dart';

@RoutePage()
class RecurrentTransactionPage extends StatefulWidget {
  const RecurrentTransactionPage({super.key});

  @override
  State<RecurrentTransactionPage> createState() =>
      _RecurrentTransactionPageState();
}

class _RecurrentTransactionPageState extends State<RecurrentTransactionPage> {
  TransactionPeriodicity periodicity = TransactionPeriodicity.month;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.recurrent_transactions.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: StreamBuilder(
                stream: TransactionService.instance.countTransactions(
                  convertToPreferredCurrency: false,
                  predicate: const TransactionFilters(isRecurrent: true),
                ),
                builder: (context, snapshot) {
                  final nOfRes = snapshot.data?.numberOfRes ?? 0;

                  return Text(
                    '${nOfRes} ${t.transaction.display(n: nOfRes)}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  );
                }),
          ),
          Expanded(
            child: TransactionListComponent(
              filters: const TransactionFilters(isRecurrent: true),
              prevPage: const RecurrentTransactionPage(),
              periodicityInfo: periodicity,
              showGroupDivider: false,
              onEmptyList: Center(
                child: EmptyIndicator(
                    title: t.general.empty_warn,
                    description: t.recurrent_transactions.empty),
              ),
            ),
          ),
          const Divider(endIndent: 16, indent: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  periodicity = TransactionPeriodicity.values.firstWhereOrNull(
                        (element) => element.index == periodicity.index + 1,
                      ) ??
                      TransactionPeriodicity.day;

                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gasto total por periodo',
                              style: Theme.of(context).textTheme.titleMedium!,
                            ),
                            Text(
                              '* Sin considerar la fecha de inicio y fin de cada recurrencia',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          StreamBuilder(
                              stream: TransactionService.instance
                                  .getTransactions(
                                    filters: const TransactionFilters(
                                      isRecurrent: true,
                                    ),
                                  )
                                  .map(
                                    (event) => event
                                        .map(
                                          (transaction) => transaction
                                              .getUnifiedMoneyForAPeriod(
                                                  periodicity: periodicity),
                                        )
                                        .sum,
                                  ),
                              initialData: 0.0,
                              builder: (context, snapshot) {
                                return CurrencyDisplayer(
                                  amountToConvert: snapshot.data!,
                                  integerStyle:
                                      Theme.of(context).textTheme.titleLarge!,
                                );
                              }),
                          Text(
                            t.general.time.ranges.each_range(
                                n: 1,
                                range: periodicity
                                    .periodText(context, 1)
                                    .toLowerCase()),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      const Icon(Icons.swap_vert_rounded)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
