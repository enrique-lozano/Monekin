import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TransactionListDateSeparator extends StatelessWidget {
  const TransactionListDateSeparator({
    super.key,
    required this.filters,
    required this.date,
  });

  final TransactionFilters filters;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final isFutureDate = date.isAfter(DateTime.now());

    return Opacity(
      opacity: isFutureDate ? 0.5 : 1.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 12,
          children: [
            DefaultTextStyle(
              style: Theme.of(context).textTheme.labelMedium!,
              child: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.d().format(date),
                    style: TextStyle(fontSize: 26),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        (DateUtils.isSameDay(date, DateTime.now())
                                ? t.general.today
                                : DateFormat.EEEE().format(date))
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(DateFormat.yMMMM().format(date)),
                    ],
                  ),
                ],
              ),
            ),
            if (!isFutureDate)
              StreamBuilder(
                initialData: 0.0,
                stream: TransactionService.instance.getTransactionsValueBalance(
                  filters: filters.copyWith(
                    minDate: DateTime(date.year, date.month, date.day),
                    maxDate: DateTime(date.year, date.month, date.day + 1),
                  ),
                ),
                builder: (context, snapshot) {
                  final partialBalance = snapshot.data!;

                  return CurrencyDisplayer(
                    amountToConvert: partialBalance,
                    integerStyle: Theme.of(context).textTheme.labelLarge!,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
