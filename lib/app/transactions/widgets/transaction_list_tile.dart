import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_periodicity.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/core/services/view-actions/transaction_view_actions_service.dart';
import 'package:monekin/core/utils/color_utils.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile(
      {super.key,
      required this.transaction,
      required this.prevPage,
      this.showDate = true,
      this.showTime = true,
      this.periodicityInfo});

  final MoneyTransaction transaction;

  final Widget prevPage;
  final TransactionPeriodicity? periodicityInfo;
  final bool showDate;
  final bool showTime;

  showTransactionActions(BuildContext context, MoneyTransaction transaction) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Column(
              mainAxisSize: MainAxisSize.min,
              children: (TransactionViewActionService()
                  .transactionDetailsActions(context, transaction: transaction)
                  .map(
                    (e) => ListTile(
                      leading: Icon(e.icon),
                      title: Text(e.label),
                      onTap: e.onClick == null
                          ? null
                          : () {
                              Navigator.pop(context);
                              e.onClick!();
                            },
                    ),
                  )).toList());
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    transaction.displayName(context),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
                const SizedBox(width: 4),
                if ((transaction.status != null ||
                        transaction.recurrentInfo.isRecurrent) &&
                    periodicityInfo == null)
                  Icon(
                    transaction.status?.icon ?? Icons.repeat,
                    color: transaction.status?.color.darken(0.1) ??
                        Theme.of(context).colorScheme.primary,
                    size: 12,
                  )
              ],
            ),
          ),
          CurrencyDisplayer(
            amountToConvert: periodicityInfo != null
                ? transaction.getUnifiedMoneyForAPeriod(
                    periodicity: periodicityInfo!)
                : transaction.value,
            currency: transaction.account.currency,
            textStyle: TextStyle(
                color: transaction.status == TransactionStatus.voided
                    ? Colors.grey.shade400
                    : transaction.isIncomeOrExpense
                        ? transaction.type.color(context)
                        : null,
                decoration: transaction.status == TransactionStatus.voided
                    ? TextDecoration.lineThrough
                    : null,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: DefaultTextStyle(
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(fontWeight: FontWeight.w300),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Builder(builder: (context) {
                      String secondaryText = '';

                      if (!(transaction.recurrentInfo.isRecurrent &&
                          periodicityInfo != null)) {
                        if (showDate) {
                          secondaryText =
                              DateFormat.yMMMd().format(transaction.date);
                        } else {
                          secondaryText = transaction.notes ?? '';
                        }
                      }

                      return Text(
                        '${transaction.account.name} ${secondaryText.isNotEmpty ? ('• $secondaryText') : ''}',
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      );
                    }),
                  ),
                  if (transaction.recurrentInfo.isRecurrent &&
                      periodicityInfo != null) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      decoration: BoxDecoration(
                        color: transaction.nextPayStatus!
                            .color(context)
                            .withOpacity(0.2),
                        border: Border.all(
                          color: transaction.nextPayStatus!.color(context),
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            transaction.nextPayStatus!.icon,
                            size: 14,
                            color: transaction.nextPayStatus!.color(context),
                          ),
                          const SizedBox(width: 4),
                          Text(
                              transaction.nextPayStatus!.displayDaysToPay(
                                  context, transaction.daysToPay()),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color:
                                    transaction.nextPayStatus!.color(context),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                  ]
                ],
              ),
            ),
            if (showTime) Text(DateFormat.Hm().format(transaction.date)),
            if (periodicityInfo != null &&
                transaction.recurrentInfo.isRecurrent)
              Text.rich(
                TextSpan(children: [
                  ...UINumberFormatter.currency(
                          amountToConvert: transaction.value,
                          currency: transaction.account.currency)
                      .getTextSpanList(context),
                  if (transaction.recurrentInfo.intervalEach! != 1)
                    TextSpan(
                        text:
                            ' / ${transaction.recurrentInfo.intervalEach!.toStringAsFixed(0)}'),
                  if (transaction.recurrentInfo.intervalEach! == 1)
                    const TextSpan(text: ' / '),
                  TextSpan(
                      text: transaction.recurrentInfo.intervalPeriod!
                          .periodText(
                            context,
                            transaction.recurrentInfo.intervalEach!,
                          )
                          .toLowerCase())
                ]),
              )
          ],
        ),
      ),
      leading: Hero(
        tag: 'transaction-icon-${transaction.id}',
        child: transaction.isIncomeOrExpense
            ? IconDisplayer.fromCategory(
                category: transaction.category!,
                size: 28,
                padding: 6,
              )
            : IconDisplayer(
                icon: TransactionType.transfer.icon,
                mainColor: TransactionType.transfer.color(context),
                size: 28,
                padding: 6,
              ),
      ),
      onTap: () {
        context.pushRoute(
          TransactionDetailsRoute(transaction: transaction, prevPage: prevPage),
        );
      },
      onLongPress: () => showTransactionActions(context, transaction),
    );
  }
}
