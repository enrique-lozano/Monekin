import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:rxdart/rxdart.dart';

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
          padding: const EdgeInsets.all(12),
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
                        textStyle: Theme.of(context).textTheme.headlineSmall!);
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
                  transactionTypes: [TransactionType.income],
                  minDate: startDate,
                  maxDate: endDate,
                ),
              ),
              AccountService.instance.getAccountsBalance(
                filters: filters.copyWith(
                  transactionTypes: [TransactionType.expense],
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
            final expense = snapshot.data![1].abs();

            return Column(children: [
              ListTile(
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.transaction.types.income(n: 1)),
                        CurrencyDisplayer(amountToConvert: income)
                      ],
                    ),
                    AnimatedProgressBar(
                        value: income + expense > 0
                            ? (income / (income + expense))
                            : 0,
                        color: CustomColors.of(context).success),
                  ])),
              ListTile(
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.transaction.types.expense(n: 1)),
                        CurrencyDisplayer(amountToConvert: expense)
                      ],
                    ),
                    AnimatedProgressBar(
                        value: income + expense > 0
                            ? (expense / (income + expense))
                            : 0,
                        color: CustomColors.of(context).danger),
                  ]))
            ]);
          },
        ),
      ],
    );
  }
}
