import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<SecurityPriceHistoryInDB?> showSecurityPriceFormDialog(
  BuildContext context,
  SecurityPriceFormDialog dialog,
) {
  return showModalBottomSheet<SecurityPriceHistoryInDB>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => dialog,
  );
}

/// A bottom sheet to create or edit a single price observation (date + price)
/// of a security.
class SecurityPriceFormDialog extends StatefulWidget {
  const SecurityPriceFormDialog({
    super.key,
    required this.securityId,
    this.currencySymbol,
    this.pointToEdit,
  });

  final String securityId;
  final String? currencySymbol;
  final SecurityPriceHistoryInDB? pointToEdit;

  @override
  State<SecurityPriceFormDialog> createState() =>
      _SecurityPriceFormDialogState();
}

class _SecurityPriceFormDialogState extends State<SecurityPriceFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();

  DateTime _date = DateTime.now();

  bool get isEditMode => widget.pointToEdit != null;

  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      final p = widget.pointToEdit!;
      _priceController.text = p.price.toString();
      _date = p.date;
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final price = double.tryParse(_priceController.text);
    if (price == null) return;

    RouteUtils.popRoute(
      SecurityPriceHistoryInDB(
        id: widget.pointToEdit?.id ?? generateUUID(),
        securityID: widget.securityId,
        date: _date,
        price: price,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: isEditMode
          ? t.assets.securities.price_history.edit
          : t.assets.securities.price_history.add,
      footer: BottomSheetFooter(onSaved: _onSubmit),
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            DateTimeFormField(
              mode: DateTimeFieldPickerMode.date,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.event),
                labelText: '${t.general.time.date} *',
              ),
              initialDate: _date,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              dateFormat: DateFormat.yMMMMd(),
              validator: (e) =>
                  e == null ? t.general.validations.required : null,
              onDateSelected: (DateTime value) {
                setState(() => _date = value);
              },
            ),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: '${t.assets.securities.price_history.price} *',
                suffixText: widget.currencySymbol,
              ),
              validator: (value) => fieldValidator(
                value,
                isRequired: true,
                validator: ValidatorType.double,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ],
        ),
      ),
    );
  }
}
