import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/transactions/transaction_details.page.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/services/view-actions/transaction_view_actions_service.dart';
import 'package:monekin/core/utils/color_utils.dart';

class TransactionListComponent extends StatelessWidget {
  const TransactionListComponent(
      {super.key,
      required this.transactions,
      this.showGroupDivider = true,
      this.showRecurrentInfo = false,
      required this.prevPage});

  final List<MoneyTransaction> transactions;

  final bool showGroupDivider;

  /// Display info about the periodicity of the recurrent transactions, and the days to the next payment
  final bool showRecurrentInfo;

  final Widget prevPage;

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

  Widget dateSeparator(DateTime date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(DateFormat.yMMMMd().format(date)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactions.length + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (transactions.isEmpty) return Container();

          if (index == 0) {
            if (!showGroupDivider) return Container();
            return dateSeparator(transactions[0].date);
          }

          final transaction = transactions[index - 1];

          return ListTile(
            title: Row(
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
                    !showRecurrentInfo)
                  Icon(
                    transaction.status?.icon ?? Icons.repeat,
                    color: transaction.status?.color.darken(0.1) ??
                        Theme.of(context).colorScheme.primary,
                    size: 12,
                  )
              ],
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '${transaction.account.name} ${transaction.recurrentInfo.isRecurrent && showRecurrentInfo ? '' : ' • ${DateFormat.yMMMd().format(transaction.date)} • ${DateFormat.Hm().format(transaction.date)} '}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w300),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
                if (transaction.recurrentInfo.isRecurrent &&
                    showRecurrentInfo) ...[
                  const SizedBox(height: 2),
                  Builder(builder: (context) {
                    final dateDiff =
                        transaction.date.difference(DateTime.now()).inDays;

                    final isPending = dateDiff >= 0;

                    return Row(
                      children: [
                        Icon(
                          Icons.repeat_rounded,
                          size: 14,
                          color: isPending
                              ? Theme.of(context).colorScheme.primary
                              : CustomColors.of(context).danger,
                        ),
                        const SizedBox(width: 4),
                        Text(
                            isPending
                                ? 'In ${dateDiff} days'
                                : 'Pending, ${dateDiff * -1} days ago',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: isPending
                                  ? Theme.of(context).colorScheme.primary
                                  : CustomColors.of(context).danger,
                            ))
                      ],
                    );
                  }),
                  const SizedBox(height: 2),
                ]
              ],
            ),
            trailing: CurrencyDisplayer(
              amountToConvert: transaction.value,
              currency: transaction.account.currency,
              textStyle: TextStyle(
                  color: transaction.status == TransactionStatus.voided
                      ? Colors.grey.shade400
                      : transaction.type == TransactionType.income
                          ? CustomColors.of(context).success
                          : transaction.type == TransactionType.expense
                              ? CustomColors.of(context).danger
                              : null,
                  decoration: transaction.status == TransactionStatus.voided
                      ? TextDecoration.lineThrough
                      : null,
                  fontWeight: FontWeight.bold),
            ),
            leading: Hero(
              tag: 'transaction-icon-${transaction.id}',
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: transaction.color(context).lighten(0.82),
                    borderRadius: BorderRadius.circular(6)),
                child: transaction.isIncomeOrExpense
                    ? transaction.category!.icon.display(
                        color: transaction.color(context),
                        size: 28,
                      )
                    : const Icon(Icons.swap_vert, size: 28),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionDetailsPage(
                            transaction: transaction,
                            prevPage: prevPage,
                          )));
            },
            onLongPress: () => showTransactionActions(context, transaction),
          );
        },
        separatorBuilder: (context, index) {
          if (index == 0 ||
              transactions.isEmpty ||
              index >= transactions.length) {
            return Container();
          }

          if (!showGroupDivider ||
              index >= 1 &&
                  DateUtils.isSameDay(
                      transactions[index - 1].date, transactions[index].date)) {
            return const Divider(indent: 68);
          }

          return dateSeparator(transactions[index].date);
        });
  }
}
