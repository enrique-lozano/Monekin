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

class AddMoneyTransactionToDebtModal extends StatelessWidget {
  const AddMoneyTransactionToDebtModal({required this.debt});

  final Debt debt;

  @override
  Widget build(BuildContext context) {
    return ModalContainer(
      title: 'Add register to this debt',
      subtitle:
          "Elige una de las siguientes opciones para vincular una transacción a esta deuda",
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Column(
          children: [
            OutlinedButtonStacked(
              text: 'Link existing transaction',
              afterWidget: Text(
                "Elige un registro ya existente para vincularlo a esta deuda",
              ),
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
                      await DebtServive.instance.linkTransactionToDebt(
                        transactionId: transaction.id,
                        debtId: debt.id,
                      );
                      MonekinSnackbar.success(
                        SnackbarParams(
                          'Transaction linked to debt',
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
              text: 'Add new transaction',
              afterWidget: Text(
                "Añade o reduce la deuda manualmente creando una nueva transacción vinculada a esta deuda.",
              ),
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
