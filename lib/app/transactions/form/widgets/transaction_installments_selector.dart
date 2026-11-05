import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

/// Lets a credit card expense be paid in monthly installments by typing how
/// many. Empty (or fewer than 2) means paying at once.
class TransactionInstallmentsSelector extends StatelessWidget {
  const TransactionInstallmentsSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final c = context.watch<TransactionFormController>();
    final installments = c.installments;

    return ListTile(
      leading: const Icon(Icons.calendar_view_month_rounded),
      minVerticalPadding: 0,
      contentPadding: const EdgeInsets.only(left: 16, right: 12),
      title: TextFormField(
        controller: c.installmentsController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          isDense: false,
          filled: false,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: InputBorder.none,
          hintText: t.transaction.form.installments.title,
          suffixText: installments == null
              ? null
              : t.transaction.form.installments.months,
        ),
      ),
      subtitle: installments == null || c.transactionValue <= 0
          ? null
          : Row(
              children: [
                CurrencyDisplayer(
                  amountToConvert: c.transactionValue / installments,
                  currency: c.fromAccount?.currency,
                ),
                Text(' ${t.transaction.form.installments.per_month}'),
              ],
            ),
    );
  }
}
