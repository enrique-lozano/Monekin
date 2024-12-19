import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

class NewTransactionButton extends StatelessWidget {
  const NewTransactionButton({super.key, this.isExtended = true});

  final bool isExtended;

  _showShouldCreateAccountWarn(BuildContext context) {
    final t = Translations.of(context);

    confirmDialog(
      context,
      dialogTitle: t.home.should_create_account_header,
      contentParagraphs: [Text(t.home.should_create_account_message)],
      confirmationText: t.general.continue_text,
    ).then((value) {
      if (value != true) return;

      RouteUtils.pushRoute(context, AccountFormPage());
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
        RouteUtils.pushRoute(context, const TransactionFormPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Material(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
        child: FloatingActionButton.extended(
          heroTag: 'new-transaction-floating-button',
          onPressed: () => _onPressed(context),
          isExtended: !isExtended,
          icon: const Icon(Icons.add_rounded),
          extendedIconLabelSpacing: 8.0,
          label: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            child: !isExtended
                ? Text(t.transaction.create)
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
