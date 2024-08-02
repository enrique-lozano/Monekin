import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/transactions/label_value_info_table.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/monekin_quick_actions_buttons.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/services/view-actions/transaction_view_actions_service.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/models/transaction/transaction_type.enum.dart';
import '../../core/presentation/app_colors.dart';

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
    required this.heroTag,
  });

  final MoneyTransaction transaction;

  final Object? heroTag;

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
                      ? generateUUID()
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

    confirmDialog(
      context,
      dialogTitle: t.transaction.next_payments.skip_dialog_title,
      confirmationText: t.general.confirm,
      contentParagraphs: [
        Text(nextPaymentDate != null
            ? t.transaction.next_payments.skip_dialog_msg(
                date: DateFormat.yMMMd().format(nextPaymentDate),
              )
            : t.recurrent_transactions.details.last_payment_info),
      ],
    ).then((isConfirmed) {
      if (isConfirmed != true) return;

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
        });

        return;
      }

      // Change the next payment date and the remaining iterations (if required)
      int? remainingIterations =
          transaction.recurrentInfo.ruleRecurrentLimit!.remainingIterations;

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
      });
    });
  }

  Widget cardPay({
    required MoneyTransaction transaction,
    required DateTime date,
    bool isNext = false,
  }) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            width: 1,
            color: transaction.nextPayStatus!
                .color(context)
                .withOpacity(isNext ? 1 : 0.3),
          )),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 6),
        subtitleTextStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: isNext
                  ? transaction.nextPayStatus!.color(context).darken(0.6)
                  : AppColors.of(context).primaryContainer,
            ),
        leading: Icon(
          isNext ? transaction.nextPayStatus!.icon : Icons.access_time,
          color: transaction.nextPayStatus!
              .color(context)
              .withOpacity(isNext ? 1 : 0.3),
        ),
        title: Text(DateFormat.yMMMd().format(date)),
        subtitle: !isNext
            ? null
            : Text(
                transaction.nextPayStatus!
                    .displayDaysToPay(context, transaction.daysToPay()),
                style: TextStyle(
                  color: AppColors.of(context).onSurface,
                ),
              ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            color: AppColors.of(context).danger,
            disabledColor: AppColors.of(context).danger.withOpacity(0.3),
            icon: const Icon(Icons.cancel_rounded),
            tooltip: t.transaction.next_payments.skip,
            onPressed: !isNext
                ? null
                : () => showSkipTransactionModal(context, transaction),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed:
                !isNext ? null : () => showPayModal(context, transaction),
            color: AppColors.of(context).success.darken(0.4),
            tooltip: !isNext ? null : t.transaction.next_payments.accept,
            disabledColor:
                AppColors.of(context).success.darken(0.4).withOpacity(0.3),
            icon: const Icon(Icons.price_check_rounded),
          ),
        ]),
      ),
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
                )),
                if (transaction.recurrentInfo.isRecurrent &&
                    transaction.isOnLastPayment)
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

  Widget translucentCard({
    required Color color,
    required Widget body,
    required IconData? icon,
    required String title,
  }) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.15),
        border: Border.all(
          width: 1,
          color: color,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).shadowColorLight,
            blurRadius: 12,
            offset: const Offset(0, 0),
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: color,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          body
        ],
      ),
    );
  }

  Widget statusDisplayer(MoneyTransaction transaction) {
    if (transaction.status == null && transaction.recurrentInfo.isNoRecurrent) {
      throw Exception('Error');
    }

    final bool showRecurrencyStatus = (transaction.recurrentInfo.isRecurrent);
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    final color = showRecurrencyStatus
        ? isDarkTheme
            ? AppColors.of(context).primary
            : AppColors.of(context).primary.lighten(0.2)
        : transaction.status!.color;

    return translucentCard(
        color: color,
        body: Padding(
          padding: EdgeInsets.all(showRecurrencyStatus ? 0 : 12),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(showRecurrencyStatus ? 12 : 0),
                child: Text(
                  showRecurrencyStatus
                      ? t.recurrent_transactions.details.descr
                      : transaction.status!.description(context),
                ),
              ),
              if (transaction.recurrentInfo.isRecurrent) ...[
                //const SizedBox(height: 12),
                Column(
                  children: transaction
                      .getNextDatesOfRecurrency(limit: 3)
                      .mapIndexed((index, e) => Column(
                            children: [
                              cardPay(
                                date: e,
                                transaction: transaction,
                                isNext: index == 0,
                              ),
                              if (index == 2) const SizedBox(height: 8),
                            ],
                          ))
                      .toList(),
                )
              ],
              if (transaction.status == TransactionStatus.pending) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: color.darken(0.2),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => showPayModal(context, transaction),
                    child:
                        Text(t.transaction.next_payments.accept_dialog_title),
                  ),
                )
              ]
            ],
          ),
        ),
        icon: showRecurrencyStatus
            ? Icons.repeat_rounded
            : transaction.status?.icon,
        title: showRecurrencyStatus
            ? t.recurrent_transactions.details.title
            : t.transaction.status
                .tr_status(status: transaction.status!.displayName(context))
                .capitalize());
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
        stream: TransactionService.instance
            .getTransactionById(widget.transaction.id),
        initialData: widget.transaction,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          }

          final transaction = snapshot.data!;

          final transactionDetailsActions = TransactionViewActionService()
              .transactionDetailsActions(context,
                  transaction: transaction, navigateBackOnDelete: true);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(t.transaction.details),
            ),
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TransactionDetailHeader(
                    heroTag: widget.heroTag,
                    transaction: transaction,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (transaction.status != null ||
                                transaction.recurrentInfo.isRecurrent)
                              statusDisplayer(transaction),
                            if (transaction.isReversed)
                              translucentCard(
                                  color: AppColors.of(context).brand,
                                  body: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                        transaction.type == TransactionType.E
                                            ? t.transaction.reversed
                                                .description_for_expenses
                                            : t.transaction.reversed
                                                .description_for_incomes),
                                  ),
                                  icon: MoneyTransaction.reversedIcon,
                                  title: t.transaction.reversed.title),
                            CardWithHeader(
                              title: 'Info',
                              body: LabelValueInfoTable(
                                items: [
                                  LabelValueInfoItem(
                                    value: buildInfoTileWithIconAndColor(
                                      icon: transaction.account.icon,
                                      color: transaction.account
                                          .getComputedColor(context)
                                          .lighten(
                                              isAppInDarkBrightness(context)
                                                  ? 0.5
                                                  : 0),
                                      data: transaction.account.name,
                                    ),
                                    label: transaction.isTransfer
                                        ? t.transfer.form.from
                                        : t.general.account,
                                  ),
                                  if (transaction.isIncomeOrExpense)
                                    LabelValueInfoItem(
                                      value: buildInfoTileWithIconAndColor(
                                        icon: transaction.category!.icon,
                                        color: ColorHex.get(
                                                transaction.category!.color)
                                            .lighten(
                                                isAppInDarkBrightness(context)
                                                    ? 0.5
                                                    : 0),
                                        data: transaction.category!.name,
                                      ),
                                      label: t.general.category,
                                    ),
                                  if (transaction.isTransfer)
                                    LabelValueInfoItem(
                                        value: buildInfoTileWithIconAndColor(
                                          icon: transaction
                                              .receivingAccount!.icon,
                                          color: AppColors.of(context).primary,
                                          data: transaction
                                              .receivingAccount!.name,
                                        ),
                                        label: t.transfer.form.to),
                                  LabelValueInfoItem(
                                    value: Text(
                                      DateFormat.yMMMMd()
                                          .format(transaction.date),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                    label: t.general.time.date,
                                  ),
                                  LabelValueInfoItem(
                                    value: Text(
                                      DateFormat.Hm().format(transaction.date),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                    label: t.general.time.time,
                                  ),
                                ],
                              ),
                            ),
                            if (transaction.tags.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              CardWithHeader(
                                title: t.tags.display(n: 2),
                                bodyPadding: const EdgeInsets.all(12),
                                body: Wrap(
                                  spacing: 6,
                                  runSpacing: 0,
                                  children: List.generate(
                                      transaction.tags.length, (index) {
                                    final tag = transaction.tags[index];

                                    return Chip(
                                      backgroundColor:
                                          tag.colorData.lighten(0.8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: const BorderSide(
                                          width: 0,
                                          color: Colors.transparent,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      elevation: 0,
                                      label: Text(
                                        tag.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: tag.colorData),
                                      ),
                                      avatar:
                                          Icon(Tag.icon, color: tag.colorData),
                                    );
                                  }),
                                ),
                              ),
                            ],
                            if (transaction.notes != null) ...[
                              const SizedBox(height: 16),
                              CardWithHeader(
                                title: t.transaction.form.description,
                                bodyPadding: const EdgeInsets.all(16),
                                body: Text(transaction.notes!),
                              )
                            ],
                            StreamBuilder(
                                stream: CurrencyService.instance
                                    .getUserPreferredCurrency(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data!.code ==
                                          transaction.account.currencyId) {
                                    return Container();
                                  }

                                  final userCurrency = snapshot.data!;

                                  return Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: CardWithHeader(
                                      title: t.transaction.form
                                          .exchange_to_preferred_title(
                                              currency: userCurrency.code),
                                      body: Column(
                                        children: [
                                          StreamBuilder(
                                              stream: ExchangeRateService
                                                  .instance
                                                  .getLastExchangeRateOf(
                                                    currencyCode: transaction
                                                        .account.currency.code,
                                                    date: DateTime.now(),
                                                  )
                                                  .map((event) =>
                                                      event?.exchangeRate ?? 1),
                                              initialData: 1,
                                              builder: (context, snapshot) {
                                                return buildInfoListTile(
                                                  title: t.general.today,
                                                  subtitle: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .currency_exchange_rounded,
                                                        size: 12,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                          '1 ${transaction.account.currency.code} = ${snapshot.data} ${userCurrency.code}')
                                                    ],
                                                  ),
                                                  trailing: CurrencyDisplayer(
                                                    currency: userCurrency,
                                                    integerStyle:
                                                        const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    amountToConvert:
                                                        snapshot.data! *
                                                            transaction.value,
                                                  ),
                                                );
                                              }),
                                          StreamBuilder(
                                              stream: ExchangeRateService
                                                  .instance
                                                  .getLastExchangeRateOf(
                                                    currencyCode: transaction
                                                        .account.currency.code,
                                                    date: transaction.date,
                                                  )
                                                  .map((event) =>
                                                      event?.exchangeRate ?? 1),
                                              initialData: 1,
                                              builder: (context, snapshot) {
                                                return buildInfoListTile(
                                                  title: t.transaction.form
                                                      .exchange_to_preferred_in_date,
                                                  subtitle: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .currency_exchange_rounded,
                                                        size: 12,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                          '1 ${transaction.account.currency.code} = ${snapshot.data} ${userCurrency.code}')
                                                    ],
                                                  ),
                                                  trailing: CurrencyDisplayer(
                                                    currency: userCurrency,
                                                    integerStyle:
                                                        const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    amountToConvert:
                                                        snapshot.data! *
                                                            transaction.value,
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            const SizedBox(height: 16),
                            CardWithHeader(
                              title: t.general.quick_actions,
                              body: MonekinQuickActionsButton(
                                  actions: transactionDetailsActions),
                            ),
                          ],
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

  ListTile buildInfoListTile({
    required String title,
    required Widget trailing,
    Widget? subtitle,
  }) {
    return ListTile(
      minVerticalPadding: 4,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      trailing: trailing,
      subtitle: subtitle,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.of(context).onSurface.withOpacity(0.85)),
      ),
    );
  }

  Row buildInfoTileWithIconAndColor({
    required SupportedIcon icon,
    required String data,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon.display(
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          data,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        )
      ],
    );
  }
}

class _TransactionDetailHeader extends SliverPersistentHeaderDelegate {
  const _TransactionDetailHeader({
    required this.transaction,
    required this.heroTag,
  });

  final MoneyTransaction transaction;
  final Object? heroTag;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlap) {
    final shrinkPercent = shrinkOffset / maxExtent;

    return Container(
      color: AppColors.of(context).surface,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 100),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 34 - shrinkPercent * 16,
                        fontWeight: FontWeight.w600,
                        color: transaction.status == TransactionStatus.voided
                            ? Colors.grey.shade400
                            : transaction.type == TransactionType.T
                                ? null
                                : transaction.type.color(context),
                        decoration:
                            transaction.status == TransactionStatus.voided
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                  child: CurrencyDisplayer(
                    amountToConvert: transaction.value,
                    currency: transaction.account.currency,
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
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        child: ScaleTransition(
                          scale: animation,
                          alignment: Alignment.centerLeft,
                          child: child,
                        ),
                      );
                    },
                    child: shrinkPercent > 0.3
                        ? const SizedBox.shrink()
                        : Text(
                            transaction.date.year == currentYear
                                ? DateFormat.MMMMEEEEd()
                                    .format(transaction.date)
                                : DateFormat.yMMMEd().format(transaction.date),
                          ),
                  )
                else
                  Row(
                    children: [
                      Icon(
                        Icons.repeat_rounded,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        transaction.recurrentInfo.formText(context),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Hero(
            tag: heroTag ?? UniqueKey(),
            child: transaction.getDisplayIcon(
              context,
              size: 42 - shrinkPercent * 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
