import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

List<ListTileActionItem> getPayActions(
  BuildContext context,
  MoneyTransaction transaction,
) {
  final t = Translations.of(context);

  return [
    ListTileActionItem(
      label: t.transaction.next_payments.accept_in_required_date(
        date: DateFormat.yMd().format(transaction.date),
      ),
      icon: Icons.today_rounded,
      onClick: transaction.date.compareTo(DateTime.now()) < 0
          ? () => _payTransaction(
              context,
              transaction,
              datetime: transaction.date,
            )
          : null,
    ),
    ListTileActionItem(
      label: t.transaction.next_payments.accept_today,
      icon: Icons.event_available_rounded,
      onClick: () =>
          _payTransaction(context, transaction, datetime: DateTime.now()),
    ),
  ];
}

/// Builds the transaction to post when paying [transaction] on [datetime].
///
/// For recurrent security trades the cash amount stays fixed and the quantity
/// is resized with [securityPrice] (in the security currency), converted to the
/// account currency with [securityToAccountRate].
TransactionInDB buildAcceptedTransaction(
  MoneyTransaction transaction, {
  required DateTime datetime,
  double? securityPrice,
  double securityToAccountRate = 1,
}) {
  const nullValue = drift.Value(null);

  final resizeTrade =
      transaction.recurrentInfo.isRecurrent &&
      transaction.securityID != null &&
      securityPrice != null &&
      securityPrice > 0;

  return transaction.copyWith(
    date: datetime,
    quantity: resizeTrade
        ? drift.Value(
            (transaction.quantity ?? 0).sign *
                transaction.value.abs() /
                (securityPrice * securityToAccountRate),
          )
        : const drift.Value.absent(),
    pricePerUnit: resizeTrade
        ? drift.Value(securityPrice)
        : const drift.Value.absent(),
    status: drift.Value(
      transaction.recurrentInfo.isRecurrent ? transaction.status : null,
    ),
    id: transaction.recurrentInfo.isRecurrent ? generateUUID() : transaction.id,

    // The new transaction will be no-recurrent always
    intervalEach: nullValue,
    intervalPeriod: nullValue,
    endDate: nullValue,
    remainingTransactions: nullValue,
  );
}

Future<void> _payTransaction(
  BuildContext context,
  MoneyTransaction transaction, {
  required DateTime datetime,
}) async {
  final security = transaction.securityID == null
      ? null
      : await SecurityService.instance
            .getSecurityById(transaction.securityID!)
            .first;

  double? securityPrice;
  double securityToAccountRate = 1;

  if (security != null && transaction.recurrentInfo.isRecurrent) {
    securityPrice = await SecurityService.instance.getPriceAtDate(
      security.id,
      datetime,
    );
    securityToAccountRate = await ExchangeRateService.instance
        .calculateExchangeRate(
          fromCurrency: security.currencyId,
          toCurrency: transaction.account.currencyId,
          date: datetime,
        )
        .first;
  }

  final transactionToPost = buildAcceptedTransaction(
    transaction,
    datetime: datetime,
    securityPrice: securityPrice,
    securityToAccountRate: securityToAccountRate,
  );

  if (!context.mounted) return;

  final payConfirmed = await confirmDialog(
    context,
    dialogTitle: t.transaction.next_payments.accept_dialog_title,
    contentParagraphs: [
      Text(
        transaction.recurrentInfo.isRecurrent
            ? t.transaction.next_payments.accept_dialog_msg(
                date: DateFormat.yMMMd().format(datetime),
              )
            : t.transaction.next_payments.accept_dialog_msg_single,
      ),
      if (securityPrice != null && securityPrice > 0)
        Text(
          t.transaction.next_payments.accept_dialog_trade(
            quantity: UINumberFormatter.decimal(
              amountToConvert: transactionToPost.quantity!.abs(),
              decimalDigits: 4,
            ).getFormattedAmount(),
            security: security!.name,
            price: UINumberFormatter.decimal(
              amountToConvert: transactionToPost.pricePerUnit!,
            ).getFormattedAmount(),
            currency: security.currencyId,
          ),
        ),
    ],
  );

  if (payConfirmed != true) {
    return;
  }

  final transactionService = TransactionService.instance;

  final transactionResult = transaction.recurrentInfo.isRecurrent
      ? await transactionService.insertTransaction(transactionToPost)
      : await transactionService.updateTransaction(transactionToPost);

  if (transactionResult <= 0) return;

  if (security != null &&
      transaction.account.trackingMode == AccountTrackingMode.transactions) {
    await HoldingService.instance.recomputeHolding(
      accountId: transaction.accountID,
      securityId: security.id,
    );
  }

  // Recurring occurrences preserve the rule status; one-offs become stateless.

  if (transaction.recurrentInfo.isRecurrent) {
    if (transaction.isOnLastPayment) {
      // NO MORE PAYMENTS NEEDED

      await transactionService.deleteTransaction(transaction.id);

      MonekinSnackbar.success(
        SnackbarParams(
          '${t.transaction.new_success}. ${t.transaction.next_payments.recurrent_rule_finished}',
        ),
      );

      RouteUtils.popRoute();

      return;
    }

    // Add new transaction tags
    await TagService.instance.linkTagsToTransaction(
      transactionId: transactionToPost.id,
      tagIds: transaction.tags.map((t) => t.id).toList(),
    );

    // Change the next payment date and the remaining iterations (if required)
    final nextPaymentResult = await transactionService
        .setTransactionNextPayment(transaction);

    if (nextPaymentResult > 0) {
      MonekinSnackbar.success(SnackbarParams(t.transaction.new_success));
    }
  } else {
    MonekinSnackbar.success(SnackbarParams(t.transaction.edit_success));
  }
}
