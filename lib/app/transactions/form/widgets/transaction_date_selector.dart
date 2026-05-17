import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/transaction_form_controller.dart';
import 'package:monekin/core/models/transaction/transaction_form_field.enum.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

class TransactionDateSelector extends StatelessWidget {
  const TransactionDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final date = c.date;
    final fromAccount = c.fromAccount;
    final t = Translations.of(context);
    final dateFormat = getMMMdDateFormatBasedOnYear(date).dateFormat;

    return Column(
      children: [
        ListTile(
          leading: Icon(TransactionFormField.date.icon),
          title: Text(dateFormat.format(date)),
          onTap: () async {
            unfocusCurrentFocusedItem(context);

            final datePickerRes = await openDateTimePicker(
              context,
              initialDate: date,
              showTimePickerAfterDate: true,
            );

            if (datePickerRes != null) {
              c.setDate(datePickerRes);
            }
          },
        ),
        if (date.compareTo(DateTime.now()) > 0)
          InlineInfoCard(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            text: t.transaction.form.validators.date_max,
            mode: InlineInfoCardMode.info,
          ),
        if (fromAccount != null &&
            fromAccount.date.compareTo(date) > 0 &&
            !(date.compareTo(DateTime.now()) > 0))
          InlineInfoCard(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            text: t.transaction.form.validators.date_after_account_creation,
            mode: InlineInfoCardMode.warn,
          ),
      ],
    );
  }
}
