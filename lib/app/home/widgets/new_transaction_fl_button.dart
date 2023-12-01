import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/i18n/translations.g.dart';

class NewTransactionButton extends StatelessWidget {
  const NewTransactionButton({super.key, this.isExtended = false});

  final bool isExtended;

  _showShouldCreateAccountWarn(BuildContext context) {
    final t = Translations.of(context);

    showConfirmDialog(
      context,
      dialogTitle: t.home.should_create_account_header,
      contentParagraphs: [Text(t.home.should_create_account_message)],
      confirmationText: t.general.continue_text,
    ).then((value) {
      if (value != true) return;

      context.pushRoute(AccountFormRoute());
    });
  }

  _onPressed(BuildContext context) {
    TransactionService.instance
        .checkIfCreateTransactionIsPossible()
        .first
        .then((value) {
      if (!value) {
        _showShouldCreateAccountWarn(context);
      } else {
        context.pushRoute(TransactionFormRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isExtended) {
      return FloatingActionButton.extended(
        onPressed: () => _onPressed(context),
        label: Text(t.transaction.create),
        icon: const Icon(Icons.add_rounded),
      );
    }

    return FloatingActionButton(
      tooltip: t.transaction.create,
      onPressed: () => _onPressed(context),
      child: const Icon(Icons.add_rounded),
    );
  }
}
