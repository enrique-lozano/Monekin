import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/models/transaction/transaction_type.enum.dart';
import '../../../core/presentation/app_colors.dart';

class IncomeExpenseComparason extends StatelessWidget {
  const IncomeExpenseComparason(
      {super.key,
      this.startDate,
      this.endDate,
      this.filters = const TransactionFilters()});

  final DateTime? startDate;
  final DateTime? endDate;

  final TransactionFilters filters;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.general.balance),
                StreamBuilder(
                  stream: AccountService.instance.getAccountsBalance(
                    filters: filters.copyWith(
                      minDate: startDate,
                      maxDate: endDate,
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Skeleton(width: 35, height: 32);
                    }

                    return CurrencyDisplayer(
                        amountToConvert: snapshot.data!,
                        integerStyle:
                            Theme.of(context).textTheme.headlineSmall!);
                  },
                )
              ],
            )
          ]),
        ),
        StreamBuilder(
          stream: Rx.combineLatest2(
              AccountService.instance.getAccountsBalance(
                filters: filters.copyWith(
                  transactionTypes: [TransactionType.I]
                      .intersectionWithNullable(filters.transactionTypes)
                      .toList(),
                  minDate: startDate,
                  maxDate: endDate,
                ),
              ),
              AccountService.instance.getAccountsBalance(
                filters: filters.copyWith(
                  transactionTypes: [TransactionType.E]
                      .intersectionWithNullable(filters.transactionTypes)
                      .toList(),
                  minDate: startDate,
                  maxDate: endDate,
                ),
              ),
              (a, b) => [a, b]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LinearProgressIndicator();
            }

            final income = snapshot.data![0];
            final expense = snapshot.data![1] * -1;

            return Column(children: [
              IncomeExpenseTile(
                type: TransactionType.I,
                value: income,
                total: income + expense,
              ),
              IncomeExpenseTile(
                type: TransactionType.E,
                value: expense,
                total: income + expense,
              ),
            ]);
          },
        ),
      ],
    );
  }
}

class IncomeExpenseTile extends StatelessWidget {
  const IncomeExpenseTile({
    super.key,
    required this.value,
    required this.total,
    required this.type,
  });

  final TransactionType type;
  final double value;
  final double total;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.of(context).light,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          type.icon,
          color: type.color(context),
        ),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(type == TransactionType.E
                ? t.transaction.types.expense(n: 1)
                : t.transaction.types.income(n: 1)),
            CurrencyDisplayer(amountToConvert: value)
          ],
        ),
      ]),
      subtitle: AnimatedProgressBar(
        value: total > 0 ? max(value / total, 0) : 0,
        color: type.color(context),
      ),
    );
  }
}
