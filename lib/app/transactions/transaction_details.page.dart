import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
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
      BuildContext context, MoneyTransaction transaction) {
    final t = Translations.of(context);

    payTransaction(DateTime datetime) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
                      if (transaction
                          .getNextDatesOfRecurrency(limit: 2)
                          .isEmpty) {
                        // NO MORE PAYMENTS NEEDED

                        TransactionService.instance
                            .deleteTransaction(newId)
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

                      final db = TransactionService.instance.db;

                      (db.select(db.transactions)
                            ..where((tbl) => tbl.id.isValue(transaction.id)))
                          .getSingle()
                          .then((value) {
                        // Change the next payment date and the remaining iterations (if required)
                        int? remainingIterations = transaction.recurrentInfo
                            .ruleRecurrentLimit!.remainingIterations;

                        TransactionService.instance
                            .insertOrUpdateTransaction(
                          value.copyWith(
                              date: transaction.getNextDatesOfRecurrency(
                                  limit: 2)[0],
                              remainingTransactions: remainingIterations != null
                                  ? drift.Value(remainingIterations - 1)
                                  : const drift.Value(null)),
                        )
                            .then((inserted) {
                          if (inserted <= 0) return;

                          TransactionService.instance
                              .getTransactionById(transaction.id)
                              .first
                              .then((value) {
                            if (value == null) return;

                            setState(() {
                              transaction = value;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(t.transaction.new_success),
                            ));

                            Navigator.pop(context);
                          });
                        });
                      });
                    } else {
                      TransactionService.instance
                          .getTransactionById(newId)
                          .first
                          .then((value) {
                        if (value == null) return;

                        setState(() {
                          transaction = value;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(t.transaction.edit_success),
                        ));

                        Navigator.pop(context);
                      });
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
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(t.transaction.next_payments.skip_dialog_title),
            content: SingleChildScrollView(
              child: Text(
                t.transaction.next_payments.skip_dialog_msg(
                  date: DateFormat.yMMMd().format(
                      transaction.getNextDatesOfRecurrency(limit: 2)[0]),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final db = TransactionService.instance.db;

                  (db.select(db.transactions)
                        ..where((tbl) => tbl.id.isValue(transaction.id)))
                      .getSingle()
                      .then((value) {
                    TransactionService.instance
                        .insertOrUpdateTransaction(value.copyWith(
                      date: transaction.getNextDatesOfRecurrency(limit: 2)[0],
                    ))
                        .then((inserted) {
                      TransactionService.instance
                          .getTransactionById(transaction.id)
                          .first
                          .then((value) {
                        if (value == null) return;

                        setState(() {
                          transaction = value;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(t.transaction.next_payments.skip_success),
                        ));

                        Navigator.pop(context);
                      });
                    });
                  });
                },
                child: Text(t.general.continue_text),
              ),
            ],
          );
        });
  }

  showPayModal(BuildContext context, MoneyTransaction transaction) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Column(
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
            ],
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
      color: color.lighten(0.385),
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
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Builder(builder: (context) {
                  return Text(
                      showRecurrencyStatus
                          ? transaction
                                  .getNextDatesOfRecurrency(limit: 2)
                                  .isNotEmpty
                              ? t.recurrent_transactions.details
                                  .next_payment_info(
                                      date: DateFormat.yMMMMd()
                                          .format(transaction.date))
                              : t.recurrent_transactions.details
                                  .last_payment_info(
                                      date: DateFormat.yMMMMd()
                                          .format(transaction.date))
                          : transaction.status!.description(context),
                      style: TextStyle(
                        color: isDarkTheme
                            ? Theme.of(context).colorScheme.background
                            : null,
                      ));
                }),
                if (transaction.status == TransactionStatus.pending ||
                    transaction.recurrentInfo.isRecurrent) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (transaction.recurrentInfo.isRecurrent &&
                          transaction
                              .getNextDatesOfRecurrency(limit: 2)
                              .isNotEmpty) ...[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                showSkipTransactionModal(context, transaction),
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: color.darken(0.2)),
                                backgroundColor: Colors.white.withOpacity(0.6),
                                foregroundColor: color.darken(0.2)),
                            child: Text(t.transaction.next_payments.skip),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: FilledButton(
                          onPressed: () => showPayModal(context, transaction),
                          style: FilledButton.styleFrom(
                              backgroundColor: color.darken(0.2)),
                          child: Text(
                            t.transaction.next_payments.accept,
                            style: TextStyle(
                              color: isDarkTheme
                                  ? Theme.of(context).colorScheme.onBackground
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                              Column(
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
                                      )),
                                  Text(
                                    transaction.displayName(context),
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
                                      : const Icon(Icons.swap_vert, size: 42),
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
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
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
