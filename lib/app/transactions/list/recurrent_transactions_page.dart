// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' show OrderBy, OrderingMode, OrderingTerm;
import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class RecurrentTransactionPage extends StatefulWidget {
  const RecurrentTransactionPage({super.key});

  @override
  State<RecurrentTransactionPage> createState() =>
      _RecurrentTransactionPageState();
}

class _RecurrentTransactionPageState extends State<RecurrentTransactionPage> {
  Periodicity periodicity = Periodicity.month;

  /// Type of recurrency being displayed. When `null`, all of them are shown
  TransactionType? typeFilter = TransactionType.expense;

  TransactionFilterSet get filters => TransactionFilterSet(
    isRecurrent: true,
    transactionTypes: typeFilter == null ? null : [typeFilter!],
  );

  /// Title of the footer card, which sums whatever the current [typeFilter]
  /// shows and therefore can't always talk about expenses
  String totalTitle(Translations t) => switch (typeFilter) {
    TransactionType.expense => t.recurrent_transactions.total_expense_title,
    TransactionType.income => t.recurrent_transactions.total_income_title,
    _ => t.recurrent_transactions.total_all_title,
  };

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.recurrent_transactions.title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                ExpandingSegmentedTabs<TransactionType?>(
                  items: [
                    SegmentedTabItem<TransactionType?>(
                      value: null,
                      icon: Icons.all_inclusive_rounded,
                      label: t.general.all,
                    ),
                    for (final type in [
                      TransactionType.expense,
                      TransactionType.income,
                    ])
                      SegmentedTabItem<TransactionType?>(
                        value: type,
                        icon: type.icon,
                        label: type.displayName(context, plural: true),
                        color: type.color(context),
                      ),
                  ],
                  selected: typeFilter,
                  onSelected: (value) => setState(() => typeFilter = value),
                ),
                StreamBuilder(
                  stream: TransactionService.instance.countTransactions(
                    convertToPreferredCurrency: false,
                    filters: filters,
                  ),
                  builder: (context, snapshot) {
                    final nOfRes = snapshot.data ?? 0;

                    return Text(
                      '${nOfRes} ${t.transaction.display(n: nOfRes)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: TransactionListComponent(
              filters: filters,
              showGroupDivider: false,
              isScrollable: true,
              separateUpcoming: false,
              // Soonest payment first, so the page reads as an agenda of the
              // user subscriptions
              orderBy: (t, a, ac, ra, rac, c, pc) => OrderBy([
                OrderingTerm(expression: t.date, mode: OrderingMode.asc),
              ]),
              tileBuilder: (transaction) => TransactionListTile(
                transaction: transaction,
                heroTag:
                    'recurrent-transactions-page__tr-icon-${transaction.id}',
                periodicityInfo: periodicity,
              ),
              onEmptyList: Center(
                child: NoResults(
                  title: t.general.empty_warn,
                  description: typeFilter == null
                      ? t.recurrent_transactions.empty
                      : t.recurrent_transactions.empty_for_type,
                ),
              ),
            ),
          ),
          //
          // --------**---------- FOOTER ----------**---------
          //
          const Divider(endIndent: 16, indent: 16),
          Padding(
            padding: const EdgeInsets.all(16).withSafeBottom(context),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  periodicity =
                      Periodicity.values.firstWhereOrNull(
                        (element) => element.index == periodicity.index + 1,
                      ) ??
                      Periodicity.day;

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
                              totalTitle(t),
                              style: Theme.of(context).textTheme.titleMedium!,
                            ),
                            Text(
                              t.recurrent_transactions.total_expense_descr,
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          StreamBuilder(
                            stream: TransactionService.instance
                                .getTransactions(filters: filters)
                                .map(
                                  (event) => event
                                      .map(
                                        (transaction) => transaction
                                            .getUnifiedMoneyForAPeriod(
                                              periodicity: periodicity,
                                            ),
                                      )
                                      .sum,
                                ),
                            initialData: 0.0,
                            builder: (context, snapshot) {
                              return CurrencyDisplayer(
                                amountToConvert: snapshot.data!,
                                compactView:
                                    snapshot.data! <= 10000000000 &&
                                        BreakPoint.of(
                                          context,
                                        ).isLargerOrEqualTo(BreakpointID.xl)
                                    ? false
                                    : true,
                                integerStyle: Theme.of(
                                  context,
                                ).textTheme.titleLarge!,
                              );
                            },
                          ),
                          Text(
                            t.general.time.ranges.each_range(
                              n: 1,
                              range: periodicity
                                  .periodText(context, isPlural: false)
                                  .toLowerCase(),
                            ),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      const Icon(Icons.swap_vert_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
