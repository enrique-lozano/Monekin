import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/i18n/translations.g.dart';

class NewTransactionButton extends StatelessWidget {
  const NewTransactionButton({super.key, this.isExtended = false});

  final bool isExtended;

  _showShouldCreateAccountWarn(BuildContext context) {
    final t = Translations.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(t.home.should_create_account_header),
          content: SingleChildScrollView(
              child: Text(t.home.should_create_account_message)),
          actions: [
            TextButton(
              child: Text(t.general.continue_text),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountFormPage()));
              },
            ),
          ],
        );
      },
    );
  }

  _onPressed(BuildContext context) {
    TransactionService.instance
        .checkIfCreateTransactionIsPossible()
        .first
        .then((value) {
      if (!value) {
        _showShouldCreateAccountWarn(context);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TransactionFormPage()));
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
