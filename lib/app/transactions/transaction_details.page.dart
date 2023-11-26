import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/monekin_quick_actions_buttons.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/services/view-actions/transaction_view_actions_service.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:slang/builder/utils/string_extensions.dart';
import 'package:uuid/uuid.dart';

class TransactionDetailAction {
  final String label;
  final IconData icon;

  final void Function() onClick;

  TransactionDetailAction({
    required this.label,
    required this.icon,
    required this.onClick,
  });
}

@RoutePage()
class TransactionDetailsPage extends StatefulWidget {
  const TransactionDetailsPage({
    super.key,
    required this.transaction,
    required this.prevPage,
  });

  final MoneyTransaction transaction;

  /// Widget to navigate if the transaction is removed
  final Widget prevPage;

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  List<ListTileActionItem> _getPayActions(
    BuildContext context,
    MoneyTransaction transaction,
  ) {
    final t = Translations.of(context);

    payTransaction(DateTime datetime) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(t.transaction.next_payments.accept_dialog_title),
            content: SingleChildScrollView(
              child: Text(
                transaction.recurrentInfo.isRecurrent
                    ? t.transaction.next_payments.accept_dialog_msg(
                        date: DateFormat.yMMMd().format(datetime),
                      )
                    : t.transaction.next_payments.accept_dialog_msg_single,
              ),
            ),
            actions: [
              TextButton(
                child: Text(t.general.continue_text),
                onPressed: () {
                  final newId = transaction.recurrentInfo.isRecurrent
                      ? const Uuid().v4()
                      : transaction.id;

                  const nullValue = drift.Value(null);

                  TransactionService.instance
                      .insertOrUpdateTransaction(transaction.copyWith(
                    date: datetime,
                    status: nullValue,
                    id: newId,

                    // The new transaction will be no-recurrent always
                    intervalEach: nullValue,
                    intervalPeriod: nullValue,
                    endDate: nullValue,
                    remainingTransactions: nullValue,
                  ))
                      .then((value) {
                    if (value <= 0) return;

                    // Transaction created/updated successfully with a new empty status

                    if (transaction.recurrentInfo.isRecurrent) {
                      if (transaction.isOnLastPayment) {
                        // NO MORE PAYMENTS NEEDED

                        TransactionService.instance
                            .deleteTransaction(transaction.id)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${t.transaction.new_success}. ${t.transaction.next_payments.recurrent_rule_finished}'),
                            ),
                          );

                          Navigator.pop(context);
                          Navigator.pop(context);
                        });

                        return;
                      }

                      // Change the next payment date and the remaining iterations (if required)
                      int? remainingIterations = transaction.recurrentInfo
                          .ruleRecurrentLimit!.remainingIterations;

                      TransactionService.instance
                          .insertOrUpdateTransaction(
                        transaction.copyWith(
                            date: transaction.followingDateToNext,
                            remainingTransactions: remainingIterations != null
                                ? drift.Value(remainingIterations - 1)
                                : const drift.Value(null)),
                      )
                          .then((inserted) {
                        if (inserted <= 0) return;

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(t.transaction.new_success),
                        ));

                        Navigator.pop(context);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(t.transaction.edit_success),
                      ));

                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ],
          );
        },
      );
    }

    return [
      ListTileActionItem(
        label: t.transaction.next_payments.accept_in_required_date(
          date: DateFormat.yMd().format(transaction.date),
        ),
        icon: Icons.today_rounded,
        onClick: transaction.date.compareTo(DateTime.now()) < 0
            ? () => payTransaction(transaction.date)
            : null,
      ),
      ListTileActionItem(
        label: t.transaction.next_payments.accept_today,
        icon: Icons.event_available_rounded,
        onClick: () => payTransaction(DateTime.now()),
      ),
    ];
  }

  showSkipTransactionModal(BuildContext context, MoneyTransaction transaction) {
    final nextPaymentDate = transaction.followingDateToNext;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(t.transaction.next_payments.skip_dialog_title),
            content: SingleChildScrollView(
              child: Text(nextPaymentDate != null
                  ? t.transaction.next_payments.skip_dialog_msg(
                      date: DateFormat.yMMMd().format(nextPaymentDate),
                    )
                  : t.recurrent_transactions.details.last_payment_info),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (nextPaymentDate == null) {
                    TransactionService.instance
                        .deleteTransaction(transaction.id)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${t.transaction.next_payments.skip_success}. ${t.transaction.next_payments.recurrent_rule_finished}'),
                        ),
                      );

                      Navigator.pop(context);
                      Navigator.pop(context);
                    });

                    return;
                  }

                  // Change the next payment date and the remaining iterations (if required)
                  int? remainingIterations = transaction
                      .recurrentInfo.ruleRecurrentLimit!.remainingIterations;

                  TransactionService.instance
                      .insertOrUpdateTransaction(transaction.copyWith(
                          date: transaction.followingDateToNext,
                          remainingTransactions: remainingIterations != null
                              ? drift.Value(remainingIterations - 1)
                              : const drift.Value(null)))
                      .then((inserted) {
                    if (inserted == 0) return;

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(t.transaction.next_payments.skip_success),
                    ));

                    Navigator.pop(context);
                  });
                },
                child: Text(t.general.continue_text),
              ),
            ],
          );
        });
  }

  Widget cardPay({
    required MoneyTransaction transaction,
    required DateTime date,
    bool isNext = false,
  }) {
    return ListTile(
      subtitleTextStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: isNext
                ? transaction.nextPayStatus!.color(context)
                : appColorScheme(context).onSecondary,
          ),
      leading: Icon(
        isNext ? transaction.nextPayStatus!.icon : Icons.access_time,
        color: isNext ? transaction.nextPayStatus!.color(context) : null,
      ),
      title: Text(
        DateFormat.yMMMd().format(date),
        style: TextStyle(color: appColorScheme(context).onSecondary),
      ),
      subtitle: !isNext
          ? null
          : Text(
              transaction.nextPayStatus!
                  .displayDaysToPay(context, transaction.daysToPay()),
            ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          color: CustomColors.of(context).danger,
          disabledColor: CustomColors.of(context).danger.withOpacity(0.3),
          icon: const Icon(Icons.cancel_rounded),
          tooltip: t.transaction.next_payments.skip,
          onPressed: !isNext
              ? null
              : () => showSkipTransactionModal(context, transaction),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: !isNext ? null : () => showPayModal(context, transaction),
          color: appColorScheme(context).primaryContainer,
          tooltip: t.transaction.next_payments.accept,
          disabledColor:
              appColorScheme(context).primaryContainer.withOpacity(0.3),
          icon: const Icon(Icons.price_check_rounded),
        ),
      ]),
    );
  }

  showPayModal(BuildContext context, MoneyTransaction transaction) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...(_getPayActions(context, transaction).map(
                  (e) => ListTile(
                    leading: Icon(e.icon),
                    title: Text(e.label),
                    enabled: e.onClick != null,
                    onTap: e.onClick == null
                        ? null
                        : () {
                            Navigator.pop(context);
                            e.onClick!();
                          },
                  ),
                )).toList(),
                if (transaction.isOnLastPayment)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 14,
                          weight: 200,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            t.recurrent_transactions.details.last_payment_info,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          );
        });
  }

  Widget statusDisplayer(MoneyTransaction transaction) {
    if (transaction.status == null && transaction.recurrentInfo.isNoRecurrent) {
      throw Exception('Error');
    }

    final bool showRecurrencyStatus = (transaction.recurrentInfo.isRecurrent);
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    final color = showRecurrencyStatus
        ? isDarkTheme
            ? Theme.of(context).colorScheme.secondary.darken(0.15)
            : Theme.of(context).colorScheme.primary.lighten(0.2)
        : transaction.status!.color;

    return Card(
      elevation: 1,
      color: color.lighten(0.625),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    showRecurrencyStatus
                        ? t.recurrent_transactions.details.title
                        : t.transaction.status
                            .tr_status(
                                status:
                                    transaction.status!.displayName(context))
                            .capitalize(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDarkTheme
                          ? Theme.of(context).colorScheme.background
                          : null,
                    )),
                Icon(
                  showRecurrencyStatus
                      ? Icons.repeat_rounded
                      : transaction.status?.icon,
                  size: 26,
                  color: color.darken(0.2),
                )
              ],
            ),
          ),
          Divider(color: color.lighten(0.25)),
          Padding(
            padding: EdgeInsets.all(showRecurrencyStatus ? 0 : 12),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(showRecurrencyStatus ? 12 : 0),
                  child: Text(
                    showRecurrencyStatus
                        ? t.recurrent_transactions.details.descr
                        : transaction.status!.description(context),
                    style: TextStyle(
                      color: isDarkTheme
                          ? Theme.of(context).colorScheme.background
                          : null,
                    ),
                  ),
                ),
                if (transaction.status == TransactionStatus.pending ||
                    transaction.recurrentInfo.isRecurrent) ...[
                  //const SizedBox(height: 12),
                  Builder(builder: (context) {
                    return Column(
                      children: transaction
                          .getNextDatesOfRecurrency(limit: 3)
                          .mapIndexed((index, e) => Column(
                                children: [
                                  if (index != 0)
                                    Divider(
                                        indent: 48, color: color.darken(0.2)),
                                  cardPay(
                                    date: e,
                                    transaction: transaction,
                                    isNext: index == 0,
                                  ),
                                ],
                              ))
                          .toList(),
                    );
                  })
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
        stream: TransactionService.instance
            .getTransactionById(widget.transaction.id),
        initialData: widget.transaction,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(t.transaction.details),
            ),
            body: Builder(builder: (context) {
              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }

              final transaction = snapshot.data!;

              final transactionDetailsActions = TransactionViewActionService()
                  .transactionDetailsActions(context,
                      transaction: transaction, navigateBackOnDelete: true);

              return Column(
                children: [
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CurrencyDisplayer(
                                      amountToConvert: transaction.value,
                                      currency: transaction.account.currency,
                                      textStyle: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w600,
                                        color: transaction.status ==
                                                TransactionStatus.voided
                                            ? Colors.grey.shade400
                                            : transaction.type ==
                                                    TransactionType.income
                                                ? CustomColors.of(context)
                                                    .success
                                                : transaction.type ==
                                                        TransactionType.expense
                                                    ? CustomColors.of(context)
                                                        .danger
                                                    : null,
                                        decoration: transaction.status ==
                                                TransactionStatus.voided
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      transaction.displayName(context),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (transaction.recurrentInfo.isNoRecurrent)
                                      Text(
                                        DateFormat.yMMMMd()
                                            .add_Hm()
                                            .format(transaction.date),
                                      )
                                    else
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.repeat_rounded,
                                            size: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            transaction.recurrentInfo
                                                .formText(context),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Hero(
                                tag: 'transaction-icon-${transaction.id}',
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: transaction
                                        .color(context)
                                        .lighten(0.82),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: transaction.color(context),
                                      width: 2,
                                    ),
                                  ),
                                  child: transaction.isIncomeOrExpense
                                      ? transaction.category!.icon.display(
                                          color: transaction.color(context),
                                          size: 42,
                                        )
                                      : Icon(
                                          color: transaction.color(context),
                                          TransactionType.transfer.icon,
                                          size: 42,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: Column(
                        children: [
                          if (transaction.status != null ||
                              transaction.recurrentInfo.isRecurrent)
                            statusDisplayer(transaction),
                          CardWithHeader(
                            title: 'Info',
                            body: SizedBox(
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      //contentPadding: const EdgeInsets.all(2),

                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          transaction.account.icon
                                              .displayFilled(
                                            padding: 2,
                                            borderRadius: 100,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? appColorScheme(context)
                                                        .primary
                                                    : appColorScheme(context)
                                                        .primaryContainer,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(transaction.account.name)
                                        ],
                                      ),
                                      title: Text(t.general.account),
                                    ),
                                    const Divider(indent: 12),
                                    ListTile(
                                      //contentPadding: const EdgeInsets.all(2),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          transaction.isIncomeOrExpense
                                              ? transaction.category!.icon
                                                  .displayFilled(
                                                  color: transaction
                                                      .color(context),
                                                  padding: 2,
                                                  borderRadius: 100,
                                                )
                                              : widget.transaction
                                                  .receivingAccount!.icon
                                                  .displayFilled(
                                                  color: transaction
                                                      .color(context),
                                                  padding: 2,
                                                  borderRadius: 100,
                                                ),
                                          const SizedBox(width: 6),
                                          Text(transaction.isIncomeOrExpense
                                              ? transaction.category!.name
                                              : transaction
                                                  .receivingAccount!.name),
                                        ],
                                      ),
                                      title: Text(transaction.isIncomeOrExpense
                                          ? t.general.category
                                          : t.transfer.form.to),
                                    ),
                                    if (transaction.tags.isNotEmpty) ...[
                                      const Divider(indent: 12),
                                      ListTile(
                                        title: Text("Tags"),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Wrap(
                                            spacing: 6,
                                            runSpacing: 0,
                                            children: List.generate(
                                                transaction.tags.length,
                                                (index) {
                                              final tag =
                                                  transaction.tags[index];

                                              return Chip(
                                                backgroundColor:
                                                    tag.colorData.lighten(0.75),
                                                elevation: 0,
                                                label: Text(
                                                  tag.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: tag.colorData),
                                                ),
                                                avatar: Icon(Icons.sell,
                                                    color: tag.colorData),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ],
                                    StreamBuilder(
                                        stream: CurrencyService.instance
                                            .getUserPreferredCurrency(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData ||
                                              snapshot.data!.code ==
                                                  transaction
                                                      .account.currencyId) {
                                            return Container();
                                          }

                                          final userCurrency = snapshot.data!;

                                          return Column(
                                            children: [
                                              const Divider(indent: 12),
                                              ListTile(
                                                title: Text(
                                                  t.transaction.form
                                                      .exchange_to_preferred_today(
                                                          currency: userCurrency
                                                              .code),
                                                ),
                                                trailing: StreamBuilder(
                                                    stream: ExchangeRateService
                                                        .instance
                                                        .calculateExchangeRateToPreferredCurrency(
                                                      fromCurrency: transaction
                                                          .account.currencyId,
                                                      amount: transaction.value,
                                                    ),
                                                    builder: (context,
                                                        exchangeRateSnapshot) {
                                                      if (!exchangeRateSnapshot
                                                          .hasData) {
                                                        return const Skeleton(
                                                            width: 16,
                                                            height: 14);
                                                      }

                                                      return CurrencyDisplayer(
                                                        currency: userCurrency,
                                                        textStyle:
                                                            const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        amountToConvert:
                                                            exchangeRateSnapshot
                                                                .data!,
                                                      );
                                                    }),
                                              ),
                                              const Divider(indent: 12),
                                              ListTile(
                                                title: Text(
                                                  t.transaction.form
                                                      .exchange_to_preferred_in_date(
                                                    currency: userCurrency.code,
                                                    date: DateFormat.yMd()
                                                        .format(
                                                            transaction.date),
                                                  ),
                                                ),
                                                trailing: StreamBuilder(
                                                    stream: ExchangeRateService
                                                        .instance
                                                        .calculateExchangeRateToPreferredCurrency(
                                                      fromCurrency: transaction
                                                          .account.currencyId,
                                                      amount: transaction.value,
                                                      date: transaction.date,
                                                    ),
                                                    builder: (context,
                                                        exchangeRateSnapshot) {
                                                      if (!exchangeRateSnapshot
                                                          .hasData) {
                                                        return const Skeleton(
                                                            width: 16,
                                                            height: 14);
                                                      }

                                                      return CurrencyDisplayer(
                                                        currency: userCurrency,
                                                        textStyle:
                                                            const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        amountToConvert:
                                                            exchangeRateSnapshot
                                                                .data!,
                                                      );
                                                    }),
                                              )
                                            ],
                                          );
                                        }),
                                    if (transaction.notes != null) ...[
                                      const Divider(indent: 12),
                                      ListTile(
                                        title: Text(
                                            t.transaction.form.description),
                                        subtitle: Text(transaction.notes!),
                                      )
                                    ]
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CardWithHeader(
                              title: t.general.quick_actions,
                              body: MonekinQuickActionsButton(
                                  actions: transactionDetailsActions)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }
}
