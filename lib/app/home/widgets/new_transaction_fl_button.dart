import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/animations/animated_floating_button.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void _showShouldCreateAccountWarn(BuildContext context) {
  final t = Translations.of(context);

  if (!context.mounted) return;

  confirmDialog(
    context,
    dialogTitle: t.home.should_create_account_header,
    contentParagraphs: [Text(t.home.should_create_account_message)],
    confirmationText: t.ui_actions.continue_text,
  ).then((value) {
    if (value != true || !context.mounted) return;

    RouteUtils.pushRoute(const AccountFormPage());
  });
}

void onNewTransactionButtonPressed(BuildContext context) {
  TransactionService.instance.checkIfCreateTransactionIsPossible().first.then((
    value,
  ) {
    if (!context.mounted) return;

    if (!value) {
      _showShouldCreateAccountWarn(context);
    } else {
      RouteUtils.pushRoute(const TransactionFormPage());
    }
  });
}

class NewTransactionButton extends StatelessWidget {
  const NewTransactionButton({
    super.key,
    this.isExtended = true,
    this.scrollController,
  });

  final bool isExtended;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    if (scrollController != null) {
      return AnimatedFloatingButtonBasedOnScroll(
        onPressed: () => onNewTransactionButtonPressed(context),
        icon: const Icon(Icons.add_rounded),
        text: t.transaction.create,
        scrollController: scrollController!,
      );
    }

    return AnimatedFloatingButton(
      onPressed: () => onNewTransactionButtonPressed(context),
      icon: const Icon(Icons.add_rounded),
      isExtended: isExtended,
      text: t.transaction.create,
    );
  }
}
