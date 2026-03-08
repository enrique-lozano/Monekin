import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/details/account_details.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../../core/models/transaction/transaction_type.enum.dart';

abstract class AccountDetailsActions {
  static Future<void> _navigateToTransferOrWarn(
    BuildContext context, {
    Account? fromAccount,
    Account? toAccount,
  }) async {
    final t = Translations.of(context);

    final numberOfAccounts =
        (await AccountService.instance
                .getAccounts(predicate: (acc, curr) => acc.closingDate.isNull())
                .first)
            .length;

    if (numberOfAccounts <= 1) {
      await confirmDialog(
        context,
        dialogTitle: t.transfer.need_two_accounts_warning_header,
        contentParagraphs: [Text(t.transfer.need_two_accounts_warning_message)],
      );
    } else {
      RouteUtils.pushRoute(
        TransactionFormPage(
          fromAccount: fromAccount,
          toAccount: toAccount,
          mode: TransactionType.transfer,
        ),
      );
    }
  }

  static ({List<ListTileActionItem> primary, List<ListTileActionItem> menu})
  getAccountDetailsActions(
    BuildContext context, {
    required Account account,
    bool navigateBackOnDelete = false,
  }) {
    final t = Translations.of(context);
    final isInvestment = account.type == AccountType.investment;

    final List<ListTileActionItem> primary = [];
    final List<ListTileActionItem> menu = [];

    // --- Primary actions (shown as chips) ---

    if (!isInvestment) {
      primary.add(
        ListTileActionItem(
          label: t.account.correct_balance,
          icon: Icons.balance_rounded,
          onClick: account.isClosed
              ? null
              : () => RouteUtils.pushRoute(AccountFormPage(account: account)),
        ),
      );

      primary.add(
        ListTileActionItem(
          label: t.transfer.create,
          icon: TransactionType.transfer.icon,
          onClick: account.isClosed
              ? null
              : () => _navigateToTransferOrWarn(context, fromAccount: account),
        ),
      );
    } else {
      primary.add(
        ListTileActionItem(
          label: t.account.add_money,
          icon: Icons.add_rounded,
          onClick: account.isClosed
              ? null
              : () => _navigateToTransferOrWarn(context, toAccount: account),
        ),
      );

      primary.add(
        ListTileActionItem(
          label: t.account.withdraw_money,
          icon: Icons.remove_rounded,
          onClick: account.isClosed
              ? null
              : () => _navigateToTransferOrWarn(context, fromAccount: account),
        ),
      );
    }

    // --- Menu actions (shown in three-dot popup) ---

    menu.add(
      ListTileActionItem(
        label: t.ui_actions.edit,
        icon: Icons.edit,
        onClick: () => RouteUtils.pushRoute(AccountFormPage(account: account)),
      ),
    );

    if (isInvestment) {
      menu.add(
        ListTileActionItem(
          label: t.account.correct_balance,
          icon: Icons.balance_rounded,
          onClick: account.isClosed
              ? null
              : () => RouteUtils.pushRoute(AccountFormPage(account: account)),
        ),
      );
    }

    menu.add(
      ListTileActionItem(
        label: account.isClosed
            ? t.account.reopen_short
            : t.account.close.title_short,
        icon: account.isClosed
            ? Icons.unarchive_rounded
            : Icons.archive_rounded,
        role: ListTileActionRole.warn,
        onClick: () async {
          if (account.isClosed) {
            showReopenAccountDialog(context, account);
            return;
          }

          final currentBalance = await AccountService.instance
              .getAccountMoney(account: account)
              .first;

          await showCloseAccountDialog(
            context,
            account: account,
            currentBalance: currentBalance,
          );
        },
      ),
    );

    menu.add(
      ListTileActionItem(
        label: t.ui_actions.delete,
        icon: Icons.delete,
        role: ListTileActionRole.delete,
        onClick: () {
          deleteAccountWithAlertAndSnackBar(
            context,
            accountId: account.id,
            navigateBack: navigateBackOnDelete,
          );
        },
      ),
    );

    return (primary: primary, menu: menu);
  }

  static void showReopenAccountDialog(BuildContext context, Account account) {
    confirmDialog(
      context,
      showCancelButton: true,
      dialogTitle: t.account.reopen,
      contentParagraphs: [Text(t.account.reopen_descr)],
      confirmationText: t.ui_actions.confirm,
    ).then((isConfirmed) {
      AccountService.instance
          .updateAccount(account.copyWith(closingDate: const drift.Value(null)))
          .then((value) {
            if (value) {
              MonekinSnackbar.success(
                SnackbarParams(t.account.close.unarchive_succes),
              );
            }
          })
          .catchError((err) {
            MonekinSnackbar.error(SnackbarParams.fromError(err));
          });
    });
  }

  static Future<bool?> showCloseAccountDialog(
    BuildContext context, {
    required Account account,
    required double currentBalance,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) =>
          ArchiveWarnDialog(currentBalance: currentBalance, account: account),
    );
  }

  static deleteAccountWithAlertAndSnackBar(
    BuildContext context, {
    required String accountId,
    required bool navigateBack,
  }) {
    confirmDialog(
      context,
      dialogTitle: t.account.delete.warning_header,
      contentParagraphs: [Text(t.account.delete.warning_text)],
      confirmationText: t.ui_actions.continue_text,
      showCancelButton: true,
      icon: Icons.delete,
    ).then((isConfirmed) {
      if (isConfirmed != true) return;

      AccountService.instance
          .deleteAccount(accountId)
          .then((value) {
            if (navigateBack) {
              RouteUtils.popRoute();
            }

            MonekinSnackbar.success(SnackbarParams(t.account.delete.success));
          })
          .catchError((err) {
            MonekinSnackbar.error(SnackbarParams.fromError(err));
          });
    });
  }
}
