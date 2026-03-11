import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<ValuationInDB?> showValuationFormDialog(
  BuildContext context,
  ValuationFormDialog dialog,
) {
  return showModalBottomSheet<ValuationInDB>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => dialog,
  );
}

class ValuationFormDialog extends StatefulWidget {
  const ValuationFormDialog({
    super.key,
    required this.accountId,
    this.currencySymbol,
    this.valuationToEdit,
  });

  final String accountId;
  final String? currencySymbol;
  final ValuationInDB? valuationToEdit;

  @override
  State<ValuationFormDialog> createState() => _ValuationFormDialogState();
}

class _ValuationFormDialogState extends State<ValuationFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  DateTime _date = DateTime.now();

  bool get isEditMode => widget.valuationToEdit != null;

  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      final v = widget.valuationToEdit!;
      _valueController.text = v.value.toString();
      _date = v.date;
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final value = double.tryParse(_valueController.text);
    if (value == null) return;

    final result = ValuationInDB(
      id: widget.valuationToEdit?.id ?? generateUUID(),
      accountId: widget.accountId,
      assetId: null,
      date: _date,
      value: value,
    );

    RouteUtils.popRoute(result);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: isEditMode
          ? t.account.investment.edit_valuation
          : t.account.investment.add_valuation,
      footer: BottomSheetFooter(onSaved: _onSubmit),
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _valueController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: '${t.account.investment.portfolio_value} *',
                suffixText: widget.currencySymbol,
              ),
              validator: (value) => fieldValidator(
                value,
                isRequired: true,
                validator: ValidatorType.double,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 22),
            DateTimeFormField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.event),
                labelText: '${t.general.time.date} *',
              ),
              initialDate: _date,
              lastDate: DateTime.now(),
              dateFormat: DateFormat.yMMMd().add_jm(),
              validator: (e) =>
                  e == null ? t.general.validations.required : null,
              onDateSelected: (DateTime value) {
                setState(() {
                  _date = value;
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
