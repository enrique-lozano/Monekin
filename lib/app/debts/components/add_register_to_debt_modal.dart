import 'package:flutter/material.dart';
import 'package:monekin/app/debts/components/transaction_selector.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class AddMoneyTransactionToDebtModal extends StatelessWidget {
  const AddMoneyTransactionToDebtModal({required this.debt});

  final Debt debt;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ModalContainer(
      title: t.debts.actions.add_register.modal_title,
      subtitle: t.debts.actions.add_register.modal_subtitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Column(
          children: [
            OutlinedButtonStacked(
              text: t.debts.actions.link_transaction.title,
              afterWidget: Text(t.debts.actions.link_transaction.description),
              iconData: Icons.link_rounded,
              alignLeft: true,
              alignBeside: true,
              padding: const EdgeInsets.all(16),
              onTap: () {
                // Show the selector on top; pop this modal inside the callback
                showTransactionSelectorModal(
                  context,
                  initialFilters: TransactionFilterSet(
                    minDate: debt.startDate,
                    transactionTypes: [
                      TransactionType.income,
                      TransactionType.expense,
                    ],
                    excludeDebtId: debt.id,
                  ),
                  onTransactionSelected: (transaction) async {
                    RouteUtils.popRoute(); // pop _AddRegisterToDebtModal
                    try {
                      await DebtService.instance.linkTransactionToDebt(
                        transactionId: transaction.id,
                        debtId: debt.id,
                      );
                      MonekinSnackbar.success(
                        SnackbarParams(
                          t.debts.actions.link_transaction.success,
                          showAtTop: true,
                        ),
                      );
                    } catch (e) {
                      MonekinSnackbar.error(
                        SnackbarParams.fromError(e, showAtTop: true),
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            OutlinedButtonStacked(
              text: t.debts.actions.new_transaction.title,
              afterWidget: Text(t.debts.actions.new_transaction.description),
              iconData: Icons.add_card_rounded,
              alignLeft: true,
              alignBeside: true,
              padding: const EdgeInsets.all(16),
              onTap: () {
                RouteUtils.popRoute();
                RouteUtils.pushRoute(TransactionFormPage(linkedDebt: debt));
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
