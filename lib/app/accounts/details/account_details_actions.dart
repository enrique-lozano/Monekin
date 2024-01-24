import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/details/account_details.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/translations.g.dart';

abstract class AccountDetailsActions {
  static List<ListTileActionItem> getAccountDetailsActions(
    BuildContext context, {
    required Account account,
    bool navigateBackOnDelete = false,
  }) {
    final t = Translations.of(context);

    return [
      ListTileActionItem(
        label: t.general.edit,
        icon: Icons.edit,
        onClick: () => context.pushRoute(AccountFormRoute(account: account)),
      ),
      ListTileActionItem(
          label: t.transfer.create,
          icon: TransactionType.transfer.icon,
          onClick: account.isClosed
              ? null
              : () async {
                  showAccountsWarn() async =>
                      await confirmDialog(context,
                          dialogTitle:
                              t.transfer.need_two_accounts_warning_header,
                          contentParagraphs: [
                            Text(t.transfer.need_two_accounts_warning_message)
                          ]);

                  navigateToTransferForm() => context.pushRoute(
                        TransactionFormRoute(
                          fromAccount: account,
                          mode: TransactionFormMode.transfer,
                        ),
                      );

                  final numberOfAccounts = (await AccountService.instance
                          .getAccounts(
                            predicate: (acc, curr) => acc.closingDate.isNull(),
                          )
                          .first)
                      .length;

                  if (numberOfAccounts <= 1) {
                    await showAccountsWarn();
                  } else {
                    await navigateToTransferForm();
                  }
                }),
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

            await showCloseAccountDialog(context,
                account: account, currentBalance: currentBalance);
          }),
      ListTileActionItem(
          label: t.general.delete,
          icon: Icons.delete,
          role: ListTileActionRole.delete,
          onClick: () {
            deleteAccountWithAlertAndSnackBar(
              context,
              accountId: account.id,
              navigateBack: navigateBackOnDelete,
            );
          }),
    ];
  }

  static showReopenAccountDialog(BuildContext context, Account account) {
    confirmDialog(
      context,
      showCancelButton: true,
      dialogTitle: t.account.reopen,
      contentParagraphs: [
        Text(t.account.reopen_descr),
      ],
      confirmationText: t.general.confirm,
    ).then((isConfirmed) {
      AccountService.instance
          .updateAccount(
        account.copyWith(
          closingDate: const drift.Value(null),
        ),
      )
          .then((value) {
        if (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.account.close.unarchive_succes)),
          );
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$err')));
      });
    });
  }

  static Future<bool?> showCloseAccountDialog(BuildContext context,
      {required Account account, required double currentBalance}) {
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
    final scaffold = ScaffoldMessenger.of(context);

    confirmDialog(
      context,
      dialogTitle: t.account.delete.warning_header,
      contentParagraphs: [Text(t.account.delete.warning_text)],
      confirmationText: t.general.continue_text,
      showCancelButton: true,
    ).then((isConfirmed) {
      if (isConfirmed != true) return;

      AccountService.instance.deleteAccount(accountId).then((value) {
        if (navigateBack) {
          Navigator.pop(context);
        }

        scaffold
            .showSnackBar(SnackBar(content: Text(t.account.delete.success)));
      }).catchError((err) {
        scaffold.showSnackBar(SnackBar(content: Text('$err')));
      });
    });
  }
}
