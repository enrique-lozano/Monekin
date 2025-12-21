import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<ExchangeRate?> showExchangeRateFormDialog(
  BuildContext context,
  ExchangeRateFormDialog dialog,
) {
  return showModalBottomSheet<ExchangeRate>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => dialog,
  );
}

class ExchangeRateFormDialog extends StatefulWidget {
  const ExchangeRateFormDialog({
    super.key,
    this.currency,
    this.exchangeRateToEdit,
  }) : assert(
         currency == null || exchangeRateToEdit == null,
         'You cannot provide both a currency and an exchange rate to edit',
       );

  final Currency? currency;
  final ExchangeRate? exchangeRateToEdit;

  @override
  State<ExchangeRateFormDialog> createState() => _ExchangeRateFormDialogState();
}

class _ExchangeRateFormDialogState extends State<ExchangeRateFormDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController rateController = TextEditingController();

  DateTime date = DateTime.now();

  Currency? _currency;

  Currency? userPreferredCurrency;

  bool get isEditMode => widget.exchangeRateToEdit != null;

  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      final rate = widget.exchangeRateToEdit!;
      rateController.text = rate.exchangeRate.toString();
      _currency = Currency.fromDB(currencyInDB: rate.currency);
      date = rate.date;
    } else {
      rateController.text = '';
      _currency = widget.currency;
    }

    CurrencyService.instance.ensureAndGetPreferredCurrency().first.then((
      value,
    ) {
      setState(() {
        userPreferredCurrency = value;
      });
    });
  }

  void onSubmitted() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final newRate = ExchangeRate(
      id: widget.exchangeRateToEdit?.id ?? generateUUID(),
      currency: _currency!,
      date: date,
      exchangeRate: double.parse(rateController.text),
    );

    RouteUtils.popRoute(newRate);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: isEditMode
          ? t.currencies.exchange_rate_form.edit
          : t.currencies.exchange_rate_form.add,
      footer: BottomSheetFooter(onSaved: () => onSubmitted()),
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: TextEditingController(
                text: _currency != null
                    ? _currency?.name
                    : t.general.unspecified,
              ),
              readOnly: true,
              mouseCursor: isEditMode
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              validator: (value) {
                if (_currency == null) {
                  return t.currencies.exchange_rate_form.specify_a_currency;
                } else if (_currency!.code == userPreferredCurrency?.code) {
                  return t
                      .currencies
                      .exchange_rate_form
                      .equal_to_preferred_warn;
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
                      }),
                    },
                  ),
                );
              },
              decoration: InputDecoration(
                labelText: t.currencies.currency,
                enabled: !(isEditMode || widget.currency != null),
                suffixIcon: const Icon(Icons.arrow_drop_down),
                prefixIcon: _currency != null
                    ? Opacity(
                        opacity: isEditMode || widget.currency != null
                            ? 0.5
                            : 1.0,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: _currency!.displayFlagIcon(size: 25),
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.circle,
                          size: 25,
                          color: Theme.of(
                            context,
                          ).inputDecorationTheme.fillColor!.darken(0.2),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DateTimeFormField(
                    enabled: !isEditMode,
                    decoration: InputDecoration(
                      labelText: '${t.general.time.date} *',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    initialDate: date,
                    dateFormat: date.year == currentYear
                        ? DateFormat.MMMMd()
                        : DateFormat.yMMMd(),
                    validator: (e) =>
                        e == null ? t.general.validations.required : null,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        date = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: rateController,
                    validator: (value) => fieldValidator(
                      value,
                      validator: ValidatorType.double,
                      isRequired: true,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: decimalDigitFormatter(6),
                    decoration: InputDecoration(
                      labelText: '${t.currencies.exchange_rate} *',
                      hintText: 'Ex.: 2.14',
                      helperText:
                          (userPreferredCurrency != null &&
                              _currency != null &&
                              double.tryParse(rateController.text) != null)
                          ? '1 ${_currency?.code} = ${double.parse(rateController.text)} ${userPreferredCurrency?.code ?? ''}'
                          : null,
                    ),
                  ),
                ),
              ],
            ),

            if (_currency != null)
              StreamBuilder(
                stream: ExchangeRateService.instance
                    .getExchangeRateItem(_currency!.code, date)
                    .map((rate) => rate != null),
                initialData: false,
                builder: (context, snapshot) {
                  final hasAlreadyAnRate = snapshot.hasData && snapshot.data!;

                  return AnimatedExpanded(
                    expand: hasAlreadyAnRate && !isEditMode,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: InlineInfoCard(
                        text: t
                            .currencies
                            .exchange_rate_form
                            .override_existing_warn,
                        mode: InlineInfoCardMode.info,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
