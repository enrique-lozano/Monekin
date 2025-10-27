import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/core/utils/uuid.dart';

import '../../../i18n/generated/translations.g.dart';

class TransactionViewActionService {
  final TransactionService transactionService = TransactionService.instance;

  TransactionViewActionService();

  List<ListTileActionItem> transactionDetailsActions(
    BuildContext context, {
    required MoneyTransaction transaction,
    bool navigateBackOnDelete = false,
  }) {
    final isRecurrent = transaction.recurrentInfo.isRecurrent;

    return [
      ListTileActionItem(
        label: t.ui_actions.edit,
        icon: Icons.edit,
        onClick: () => RouteUtils.pushRoute(
          context,
          TransactionFormPage(
            transactionToEdit: transaction,
            mode: transaction.type,
          ),
        ),
      ),
      if (transaction.recurrentInfo.isNoRecurrent)
        ListTileActionItem(
          label: t.transaction.duplicate_short,
          icon: Icons.control_point_duplicate_rounded,
          onClick: () => TransactionViewActionService()
              .cloneTransactionWithAlertAndSnackBar(
                context,
                transaction: transaction,
              ),
        ),
      ListTileActionItem(
        label: t.ui_actions.delete,
        icon: Icons.delete,
        role: ListTileActionRole.delete,
        onClick: () => TransactionViewActionService()
            .deleteTransactionWithAlertAndSnackBar(
              context,
              transactionId: transaction.id,
              isRecurrent: isRecurrent,
              navigateBack: navigateBackOnDelete,
            ),
      ),
    ];
  }

  void deleteTransactionWithAlertAndSnackBar(
    BuildContext context, {
    required String transactionId,
    bool isRecurrent = false,
    required bool navigateBack,
  }) {
    final t = Translations.of(context);

    confirmDialog(
      context,
      icon: Icons.delete,
      dialogTitle: !isRecurrent
          ? t.transaction.delete
          : t.recurrent_transactions.details.delete_header,
      contentParagraphs: [
        Text(
          !isRecurrent
              ? t.transaction.delete_warning_message
              : t.recurrent_transactions.details.delete_message,
        ),
      ],
      confirmationText: t.ui_actions.continue_text,
    ).then((isConfirmed) {
      if (isConfirmed != true) return;

      transactionService
          .deleteTransaction(transactionId)
          .then((value) {
            if (value == 0) {
              MonekinSnackbar.error(
                SnackbarParams('Error removing the transaction'),
              );

              return;
            }

            if (navigateBack && context.mounted) {
              Navigator.pop(context);
            }

            MonekinSnackbar.success(
              SnackbarParams(t.transaction.delete_success),
            );
          })
          .catchError((err) {
            MonekinSnackbar.error(SnackbarParams.fromError(err));
          });
    });
  }

  void cloneTransactionWithAlertAndSnackBar(
    BuildContext context, {
    required MoneyTransaction transaction,
  }) {
    final t = Translations.of(context);

    confirmDialog(
      context,
      icon: Icons.control_point_duplicate_rounded,
      dialogTitle: t.transaction.duplicate,
      contentParagraphs: [Text(t.transaction.duplicate_warning_message)],
      confirmationText: t.ui_actions.continue_text,
    ).then((isConfirmed) async {
      if (isConfirmed != true) return;

      final newTrId = generateUUID();

      try {
        await _duplicateTransaction(transaction, newTrId);

        MonekinSnackbar.success(
          SnackbarParams(t.transaction.duplicate_success),
        );
      } catch (error) {
        MonekinSnackbar.error(SnackbarParams.fromError(error));
      }
    });
  }

  Future<void> _duplicateTransaction(
    MoneyTransaction transaction,
    String newTrId,
  ) async {
    await transactionService.insertTransaction(
      transaction.copyWith(id: newTrId),
    );

    await TagService.instance.linkTagsToTransaction(
      transactionId: newTrId,
      tagIds: transaction.tags.map((t) => t.id).toList(),
    );
  }

  Future<int> updateTransactionStatus(
    String transactionId,
    TransactionStatus? statusCodeString,
  ) {
    final db = AppDB.instance;

    return (db.update(db.transactions)
          ..where((transaction) => transaction.id.equals(transactionId)))
        .write(TransactionsCompanion(status: Value(statusCodeString)));
  }
}
