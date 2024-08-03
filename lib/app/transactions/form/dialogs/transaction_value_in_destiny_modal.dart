import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<num?> showTransactionValueInDestinyModal(
  BuildContext context, {
  required num initialValue,
  required CurrencyInDB currency,
}) {
  return showModalBottomSheet<num>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return TransactionValueInDestinyModal(
        initialValue: initialValue,
        currency: currency,
      );
    },
  );
}

class TransactionValueInDestinyModal extends StatefulWidget {
  const TransactionValueInDestinyModal(
      {super.key, required this.initialValue, required this.currency});

  final num initialValue;
  final CurrencyInDB currency;

  @override
  State<TransactionValueInDestinyModal> createState() =>
      _TransactionValueInDestinyModalState();
}

class _TransactionValueInDestinyModalState
    extends State<TransactionValueInDestinyModal> {
  FocusNode valueInputFocusNode = FocusNode();

  TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    super.initState();

    valueController.text = widget.initialValue.toString();
    valueInputFocusNode.requestFocus();
  }

  @override
  void dispose() {
    valueInputFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.transfer.form.value_in_destiny.title,
      bodyPadding:
          const EdgeInsets.only(bottom: 12, left: 16, right: 16, top: 8),
      body: TextFormField(
        controller: valueController,
        keyboardType: TextInputType.number,
        inputFormatters: decimalDigitFormatter,
        decoration: InputDecoration(
          label: Text(t.transfer.form.value_in_destiny.title),
          suffixText: widget.currency.symbol,
        ),
        focusNode: valueInputFocusNode,
        onChanged: (value) {
          setState(() {});
        },
      ),
      footer: BottomSheetFooter(
        onSaved: double.tryParse(valueController.text) == null
            ? null
            : () => Navigator.pop(context, double.parse(valueController.text)),
      ),
    );
  }
}
