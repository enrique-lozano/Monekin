import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<SecurityPriceInDB?> showSecurityPriceFormDialog(
  BuildContext context,
  SecurityPriceFormDialog dialog,
) {
  return RouteUtils.showResponsiveSheet<SecurityPriceInDB>(
    context: context,
    builder: (context) => dialog,
  );
}

/// A bottom sheet to create or edit a single price observation (date + price)
/// of a security.
///
/// It is reused across all the price-editing entry points:
///
/// * Adding/editing a point in the price-history list (date editable).
/// * The quick "Update price" action from a holding or the security detail
///   page ([dateEditable] `false`, prefilled with [initialPrice]).
class SecurityPriceFormDialog extends StatefulWidget {
  const SecurityPriceFormDialog({
    super.key,
    required this.securityId,
    this.currencySymbol,
    this.pointToEdit,
    this.initialPrice,
    this.dateEditable = true,
    this.title,
  });

  final String securityId;
  final String? currencySymbol;

  /// When set, the sheet edits this existing observation instead of creating a
  /// new one.
  final SecurityPriceInDB? pointToEdit;

  /// Price to prefill the field with when creating a new observation.
  final double? initialPrice;

  /// Whether the user can change the date. When `false` the date is locked to
  /// today (used by the quick "Update price" action).
  final bool dateEditable;

  /// Overrides the default add/edit title.
  final String? title;

  @override
  State<SecurityPriceFormDialog> createState() =>
      _SecurityPriceFormDialogState();
}

class _SecurityPriceFormDialogState extends State<SecurityPriceFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();

  late DateTime _date;

  /// Calendar days that already have a price observation for this security.
  Set<DateTime> _existingDays = {};

  bool get isEditMode => widget.pointToEdit != null;

  DateTime _dayOnly(DateTime date) => DateTime(date.year, date.month, date.day);

  /// Whether saving would replace an already-existing observation on the
  /// selected day. Not relevant when the date is locked (quick update on
  /// today's price intentionally overwrites today).
  bool get _willOverwrite {
    if (!widget.dateEditable) return false;

    final selectedDay = _dayOnly(_date);

    if (isEditMode && _dayOnly(widget.pointToEdit!.date) == selectedDay) {
      return false;
    }

    return _existingDays.contains(selectedDay);
  }

  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      final p = widget.pointToEdit!;
      _priceController.text = p.price.toString();
      _date = p.date;
    } else {
      _date = DateTime.now();

      if (widget.initialPrice != null) {
        _priceController.text = widget.initialPrice!.toString();
      }
    }

    unawaited(_loadExistingDays());
  }

  Future<void> _loadExistingDays() async {
    final history = await SecurityService.instance
        .getPriceHistory(widget.securityId)
        .first;

    if (!mounted) return;

    setState(() {
      _existingDays = history.map((p) => _dayOnly(p.date)).toSet();
    });
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
      SecurityPriceInDB(
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
      title:
          widget.title ??
          (isEditMode
              ? t.assets.securities.price_history.edit
              : t.assets.securities.price_history.add),
      footer: BottomSheetFooter(onSaved: _onSubmit),
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            DateTimeFormField(
              enabled: widget.dateEditable,
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
            if (_willOverwrite)
              InlineInfoCard(
                mode: InlineInfoCardMode.warn,
                text: t.assets.securities.price_history.overwrite_warning,
              ),
          ],
        ),
      ),
    );
  }
}
