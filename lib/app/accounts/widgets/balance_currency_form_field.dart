import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/form_fields/read_only_form_field.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class AmountAndCurrencyFormField extends StatelessWidget {
  const AmountAndCurrencyFormField({
    super.key,
    required this.amountController,
    required this.onCurrencySelected,
    required this.amountLabel,
    this.currency,
    this.enabled = true,
    this.isRequired = true,
  });

  final TextEditingController amountController;
  final void Function(Currency) onCurrencySelected;
  final Currency? currency;

  /// When true, shows "Current balance" label; otherwise "Initial balance".
  final String amountLabel;

  final bool isRequired;

  /// Whether the balance input field is interactive.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      children: [
        TextFormField(
          controller: amountController,
          decoration: InputDecoration(
            labelText: amountLabel + (isRequired ? ' *' : ''),
            hintText: 'Ex.: 200',
            suffixText: currency?.symbol,
            border: appInputBorder.copyWith(
              borderRadius: BorderRadius.only(
                topLeft: inputBorderRadius,
                topRight: inputBorderRadius,
              ),
            ),
            // Disable the error text by setting empty error style
            errorStyle: const TextStyle(height: 0, fontSize: 0),
          ),
          keyboardType: TextInputType.number,
          enabled: enabled,
          inputFormatters: decimalDigitFormatter(currency?.decimalPlaces ?? 2),
          validator: (value) => fieldValidator(
            value,
            validator: ValidatorType.double,
            isRequired: isRequired,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
        ),
        const Divider(),
        ReadOnlyTextFormField(
          displayValue: currency != null
              ? currency!.name
              : t.general.unspecified,
          onTap: () {
            if (currency == null) return;

            showCurrencySelectorModal(
              context,
              CurrencySelectorModal(
                preselectedCurrency: currency!,
                onCurrencySelected: onCurrencySelected,
              ),
            );
          },
          decoration: InputDecoration(
            labelText: t.currencies.currency,
            suffixIcon: const Icon(Icons.arrow_drop_down),
            prefixIcon: currency != null
                ? Container(
                    margin: const EdgeInsets.all(10),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: SvgPicture.asset(
                      currency!.currencyIconPath,
                      height: 25,
                      width: 25,
                    ),
                  )
                : null,
            border: appInputBorder.copyWith(
              borderRadius: BorderRadius.only(
                bottomLeft: inputBorderRadius,
                bottomRight: inputBorderRadius,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
