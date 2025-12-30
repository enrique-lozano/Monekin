import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_form_field.enum.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TransactionDateSelector extends StatelessWidget {
  const TransactionDateSelector({
    super.key,
    required this.date,
    required this.fromAccount,
    required this.onDateChanged,
  });

  final DateTime date;
  final Account? fromAccount;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final dateFormat = date.year == currentYear
        ? DateFormat.MMMMd().add_jm()
        : DateFormat.yMMMd().add_jm();

    return Column(
      children: [
        ListTile(
          leading: Icon(TransactionFormField.date.icon),
          minTileHeight: 64,
          title: Text(dateFormat.format(date)),
          onTap: () async {
            unfocusCurrentFocusedItem(context);

            final datePickerRes = await openDateTimePicker(
              context,
              initialDate: date,
              showTimePickerAfterDate: true,
            );

            if (datePickerRes != null) {
              onDateChanged(datePickerRes);
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
            fromAccount!.date.compareTo(date) > 0 &&
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
