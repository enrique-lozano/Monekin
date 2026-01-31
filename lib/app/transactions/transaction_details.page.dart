import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/label_value_info_table.dart';
import 'package:monekin/app/transactions/utils/show_pay_modal.dart';
import 'package:monekin/app/transactions/widgets/translucent_transaction_status_card.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/monekin_quick_actions_buttons.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/view-actions/transaction_view_actions_service.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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
    required this.heroTag,
  });

  final MoneyTransaction transaction;

  final Object? heroTag;

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  void showSkipTransactionModal(
    BuildContext context,
    MoneyTransaction transaction,
  ) {
    final nextPaymentDate = transaction.followingDateToNext;

    confirmDialog(
      context,
      dialogTitle: t.transaction.next_payments.skip_dialog_title,
      confirmationText: t.ui_actions.confirm,
      contentParagraphs: [
        Text(
          nextPaymentDate != null
              ? t.transaction.next_payments.skip_dialog_msg(
                  date: DateFormat.yMMMd().format(nextPaymentDate),
                )
              : t.recurrent_transactions.details.last_payment_info,
        ),
      ],
    ).then((isConfirmed) {
      if (isConfirmed != true) return;

      if (nextPaymentDate == null) {
        TransactionService.instance.deleteTransaction(transaction.id).then((
          value,
        ) {
          MonekinSnackbar.success(
            SnackbarParams(
              '${t.transaction.next_payments.skip_success}. ${t.transaction.next_payments.recurrent_rule_finished}',
            ),
          );

          RouteUtils.popRoute();
        });

        return;
      }

      // Change the next payment date and the remaining iterations (if required)
      TransactionService.instance.setTransactionNextPayment(transaction).then((
        inserted,
      ) {
        if (inserted == 0) return;

        MonekinSnackbar.success(
          SnackbarParams(t.transaction.next_payments.skip_success),
        );
      });
    });
  }

  Widget cardPay({
    required MoneyTransaction transaction,
    required DateTime date,
    bool isNext = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: ListTile(
        enabled: isNext,
        contentPadding: const EdgeInsets.only(left: 16, right: 6),
        tileColor: transaction.nextPayStatus!.color(context).withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            width: 1,
            color: transaction.nextPayStatus!.color(context),
          ),
        ),
        leading: Icon(
          isNext ? transaction.nextPayStatus!.icon : Icons.access_time,
          color: transaction.nextPayStatus!.color(context),
        ),
        title: Text(DateFormat.yMMMd().format(date)),
        subtitle: !isNext
            ? null
            : Text(
                transaction.nextPayStatus!.displayDaysToPay(
                  context,
                  transaction.daysToPay(),
                ),
              ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            IconButton(
              color: AppColors.of(context).danger,
              disabledColor: AppColors.of(context).danger.withOpacity(0.7),
              icon: const Icon(Icons.cancel_rounded),
              tooltip: t.transaction.next_payments.skip,
              onPressed: !isNext
                  ? null
                  : () => showSkipTransactionModal(context, transaction),
            ),
            IconButton(
              onPressed: !isNext
                  ? null
                  : () => showPayModal(context, transaction),
              color: AppColors.of(context).success,
              tooltip: !isNext ? null : t.transaction.next_payments.accept,
              disabledColor: AppColors.of(context).success.withOpacity(0.7),
              icon: const Icon(Icons.price_check_rounded),
            ),
          ],
        ),
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
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.lighten(0.2)
        : transaction.status!.color;

    return TranslucentTransactionStatusCard(
      color: color,
      body: Padding(
        padding: EdgeInsets.all(showRecurrencyStatus ? 0 : 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(showRecurrencyStatus ? 12 : 0),
              child: Text(
                showRecurrencyStatus
                    ? t.recurrent_transactions.details.descr
                    : transaction.status!.description(context),
              ),
            ),
            if (showRecurrencyStatus) ...[
              //const SizedBox(height: 12),
              Column(
                children: transaction
                    .getNextDatesOfRecurrency(limit: 3)
                    .mapIndexed(
                      (index, e) => Column(
                        children: [
                          cardPay(
                            date: e,
                            transaction: transaction,
                            isNext: index == 0,
                          ),
                          if (index == 2) const SizedBox(height: 8),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
            if (transaction.status == TransactionStatus.pending &&
                !showRecurrencyStatus) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: color.darken(0.2),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => showPayModal(context, transaction),
                  child: Text(t.transaction.next_payments.accept_dialog_title),
                ),
              ),
            ],
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
                .capitalize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
      stream: TransactionService.instance.getTransactionById(
        widget.transaction.id,
      ),
      initialData: widget.transaction,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }

        final transaction = snapshot.data!;

        final transactionDetailsActions = TransactionViewActionService()
            .transactionDetailsActions(
              context,
              transaction: transaction,
              navigateBackOnDelete: true,
            );

        return PageFramework(
          title: t.transaction.details,
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
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        16,
                        16,
                        24,
                      ).withSafeBottom(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (transaction.status != null ||
                              transaction.recurrentInfo.isRecurrent)
                            statusDisplayer(transaction),
                          if (transaction.isReversed)
                            TranslucentTransactionStatusCard(
                              color: AppColors.of(context).brand,
                              body: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  transaction.type == TransactionType.expense
                                      ? t
                                            .transaction
                                            .reversed
                                            .description_for_expenses
                                      : t
                                            .transaction
                                            .reversed
                                            .description_for_incomes,
                                ),
                              ),
                              icon: MoneyTransaction.reversedIcon,
                              title: t.transaction.reversed.title,
                            ),
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
                                              : 0,
                                        ),
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
                                      color:
                                          ColorHex.get(
                                            transaction.category!.color,
                                          ).lighten(
                                            isAppInDarkBrightness(context)
                                                ? 0.5
                                                : 0,
                                          ),
                                      data: transaction.category!.name,
                                    ),
                                    label: t.general.category,
                                  ),
                                if (transaction.isTransfer)
                                  LabelValueInfoItem(
                                    value: buildInfoTileWithIconAndColor(
                                      icon: transaction.receivingAccount!.icon,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      data: transaction.receivingAccount!.name,
                                    ),
                                    label: t.transfer.form.to,
                                  ),
                                LabelValueInfoItem(
                                  value: Text(
                                    DateFormat.yMMMMd().format(
                                      transaction.date,
                                    ),
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
                                  transaction.tags.length,
                                  (index) {
                                    final tag = transaction.tags[index];

                                    return TransactionTagChip(tag: tag);
                                  },
                                ),
                              ),
                            ),
                          ],
                          if (transaction.notes != null) ...[
                            const SizedBox(height: 16),
                            CardWithHeader(
                              title: t.transaction.form.description,
                              bodyPadding: const EdgeInsets.all(16),
                              body: Text(transaction.notes!),
                            ),
                          ],
                          StreamBuilder(
                            stream: CurrencyService.instance
                                .ensureAndGetPreferredCurrency(),
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
                                        currency: userCurrency.code,
                                      ),
                                  body: Column(
                                    children: [
                                      StreamBuilder(
                                        stream: ExchangeRateService.instance
                                            .getLastExchangeRateOf(
                                              currencyCode: transaction
                                                  .account
                                                  .currency
                                                  .code,
                                              date: DateTime.now(),
                                            )
                                            .map(
                                              (event) =>
                                                  event?.exchangeRate ?? 1,
                                            ),
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
                                                  '1 ${transaction.account.currency.code} = ${snapshot.data} ${userCurrency.code}',
                                                ),
                                              ],
                                            ),
                                            trailing: CurrencyDisplayer(
                                              currency: userCurrency,
                                              integerStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              amountToConvert:
                                                  snapshot.data! *
                                                  transaction.value,
                                            ),
                                          );
                                        },
                                      ),
                                      StreamBuilder(
                                        stream: ExchangeRateService.instance
                                            .getLastExchangeRateOf(
                                              currencyCode: transaction
                                                  .account
                                                  .currency
                                                  .code,
                                              date: transaction.date,
                                            )
                                            .map(
                                              (event) =>
                                                  event?.exchangeRate ?? 1,
                                            ),
                                        initialData: 1,
                                        builder: (context, snapshot) {
                                          return buildInfoListTile(
                                            title: t
                                                .transaction
                                                .form
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
                                                  '1 ${transaction.account.currency.code} = ${snapshot.data} ${userCurrency.code}',
                                                ),
                                              ],
                                            ),
                                            trailing: CurrencyDisplayer(
                                              currency: userCurrency,
                                              integerStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              amountToConvert:
                                                  snapshot.data! *
                                                  transaction.value,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          CardWithHeader(
                            title: t.general.quick_actions,
                            body: MonekinQuickActionsButton(
                              actions: transactionDetailsActions,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.85),
        ),
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
        icon.display(color: color),
        const SizedBox(width: 8),
        Text(data, style: TextStyle(color: color)),
      ],
    );
  }
}

class TransactionTagChip extends StatelessWidget {
  const TransactionTagChip({
    super.key,
    required this.tag,
    this.visualDensity = VisualDensity.standard,
  });

  final Tag tag;
  final VisualDensity visualDensity;

  @override
  Widget build(BuildContext context) {
    if (visualDensity == VisualDensity.compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: tag.colorData.lighten(0.8),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          spacing: 2,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Tag.icon, color: tag.colorData, size: 14),
            Text(
              tag.name,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: tag.colorData),
            ),
          ],
        ),
      );
    }

    return Chip(
      backgroundColor: tag.colorData.lighten(0.8),
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
        style: Theme.of(
          context,
        ).textTheme.labelMedium!.copyWith(color: tag.colorData),
      ),
      visualDensity: visualDensity,
      avatar: Icon(Tag.icon, color: tag.colorData),
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
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 12, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 24,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 100),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 34 - (1 - pow(1 - shrinkPercent, 4)) * 16,
                    fontWeight: FontWeight.bold,
                    color: transaction.status == TransactionStatus.voided
                        ? Colors.grey.shade400
                        : transaction.type == TransactionType.transfer
                        ? null
                        : transaction.type.color(context),
                    decoration: transaction.status == TransactionStatus.voided
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (transaction.recurrentInfo.isNoRecurrent)
                  AnimatedExpanded(
                    duration: const Duration(milliseconds: 200),
                    expand: shrinkPercent < 0.3,
                    child: Text(
                      transaction.date.year == currentYear
                          ? DateFormat.MMMMEEEEd().format(transaction.date)
                          : DateFormat.yMMMEd().format(transaction.date),
                    ),
                  )
                else
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.repeat_rounded,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        transaction.recurrentInfo.formText(context),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Hero(
            tag: heroTag ?? UniqueKey(),
            child: transaction.getDisplayIcon(
              context,
              size: 44 - (1 - pow(1 - shrinkPercent, 4)) * 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => transaction.recurrentInfo.isNoRecurrent ? 72 : 100;

  @override
  bool shouldRebuild(covariant _TransactionDetailHeader oldDelegate) =>
      oldDelegate.transaction != transaction || oldDelegate.heroTag != heroTag;
}
