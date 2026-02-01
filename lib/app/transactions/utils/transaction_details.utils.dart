import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
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

Future<void> _payTransaction(
  BuildContext context,
  MoneyTransaction transaction, {
  required DateTime datetime,
}) async {
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
    ],
  );

  if (payConfirmed != true) {
    return;
  }

  const nullValue = drift.Value(null);

  final transactionToPost = transaction.copyWith(
    date: datetime,
    status: nullValue,
    id: transaction.recurrentInfo.isRecurrent ? generateUUID() : transaction.id,

    // The new transaction will be no-recurrent always
    intervalEach: nullValue,
    intervalPeriod: nullValue,
    endDate: nullValue,
    remainingTransactions: nullValue,
  );

  final transactionService = TransactionService.instance;

  final transactionResult = transaction.recurrentInfo.isRecurrent
      ? await transactionService.insertTransaction(transactionToPost)
      : await transactionService.updateTransaction(transactionToPost);

  if (transactionResult <= 0) return;

  // Transaction created/updated successfully with a new empty status

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
