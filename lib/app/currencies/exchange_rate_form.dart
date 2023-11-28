import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_field.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:uuid/uuid.dart';

showExchangeRateFormDialog(
  BuildContext context,
  ExchangeRateFormDialog dialog,
) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => dialog);
}

class ExchangeRateFormDialog extends StatefulWidget {
  const ExchangeRateFormDialog(
      {super.key,
      this.preSelectedCurrency,
      this.preSelectedDate,
      this.preSelectedRate,
      this.idToEdit});

  final Currency? preSelectedCurrency;
  final DateTime? preSelectedDate;
  final double? preSelectedRate;

  final String? idToEdit;

  @override
  State<ExchangeRateFormDialog> createState() => _ExchangeRateFormDialogState();
}

class _ExchangeRateFormDialogState extends State<ExchangeRateFormDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController rateController = TextEditingController();

  DateTime date = DateTime.now();

  Currency? _currency;

  Currency? userPreferredCurrency;

  bool get isEditMode => widget.idToEdit != null;

  @override
  void initState() {
    super.initState();

    rateController.text =
        widget.preSelectedRate == null ? '' : widget.preSelectedRate.toString();

    setState(() {
      _currency = widget.preSelectedCurrency;

      if (widget.preSelectedDate != null) {
        date = widget.preSelectedDate!;
      }
    });

    CurrencyService.instance.getUserPreferredCurrency().first.then((value) {
      setState(() {
        userPreferredCurrency = value;
      });
    });
  }

  onSubmitted() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final t = Translations.of(context);

    ExchangeRateService.instance
        .insertOrUpdateExchangeRate(ExchangeRate(
            id: widget.idToEdit ?? const Uuid().v4(),
            currency: _currency!,
            date: date,
            exchangeRate: double.parse(rateController.text)))
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isEditMode
              ? t.currencies.form.edit_success
              : t.currencies.form.add_success)));
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    }).whenComplete(() => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditMode ? t.currencies.form.edit : t.currencies.form.add,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: TextEditingController(
                                text: _currency != null
                                    ? _currency?.name
                                    : t.general.unspecified),
                            readOnly: true,
                            validator: (value) {
                              if (_currency == null) {
                                return t.currencies.form.specify_a_currency;
                              } else if (_currency!.code ==
                                  userPreferredCurrency?.code) {
                                return t
                                    .currencies.form.equal_to_preferred_warn;
                              }

                              return null;
                            },
                            onTap: () {
                              showCurrencySelectorModal(
                                  context,
                                  CurrencySelectorModal(
                                      preselectedCurrency: _currency,
                                      onCurrencySelected: (newCurrency) => {
                                            setState(() {
                                              _currency = newCurrency;
                                            })
                                          }));
                            },
                            decoration: InputDecoration(
                                labelText: t.currencies.currency,
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                prefixIcon: Container(
                                  margin: const EdgeInsets.all(10),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: _currency != null
                                      ? SvgPicture.asset(
                                          'assets/icons/currency_flags/${_currency!.code.toLowerCase()}.svg',
                                          height: 25,
                                          width: 25,
                                        )
                                      : const Skeleton(width: 28, height: 28),
                                ))),
                        const SizedBox(height: 22),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DateTimeFormField(
                                decoration: InputDecoration(
                                  labelText: '${t.general.time.date} *',
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                initialDate: date,
                                dateFormat: DateFormat.yMMMd(),
                                validator: (e) => e == null
                                    ? t.general.validations.required
                                    : null,
                                onDateSelected: (DateTime value) {
                                  setState(() {
                                    date = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                                child: TextFormField(
                              controller: rateController,
                              validator: (value) => fieldValidator(value,
                                  validator: ValidatorType.double,
                                  isRequired: true),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: '${t.currencies.exchange_rate} *',
                                hintText: 'Ex.: 2.14',
                                helperText: (userPreferredCurrency != null &&
                                        _currency != null &&
                                        double.tryParse(rateController.text) !=
                                            null)
                                    ? '1 ${_currency?.code} = ${double.parse(rateController.text)} ${userPreferredCurrency?.code ?? ''}'
                                    : null,
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            BottomSheetFooter(onSaved: () => onSubmitted())
          ]),
    );
  }
}
