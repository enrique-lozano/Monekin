import 'package:flutter/material.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_form_field.enum.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TransactionTitleField extends StatelessWidget {
  const TransactionTitleField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return ListTile(
          leading: const Icon(Icons.title_rounded),
          minVerticalPadding: 0,
          contentPadding: const EdgeInsets.only(left: 16, right: 12),
          title: TextFormField(
            controller: controller,
            maxLength: maxLabelLenghtForDisplayNames,
            decoration: InputDecoration(
              isDense: false,
              filled: false,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              counterText: '',
              border: InputBorder.none,
              hintText: t.transaction.form.title,
            ),
          ),
          trailing: value.text.isEmpty
              ? null
              : SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, size: 14),
                    iconSize: 14,
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      controller.clear();
                    },
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).deleteButtonTooltip,
                  ),
                ),
        );
      },
    );
  }
}

class TransactionDescriptionField extends StatelessWidget {
  const TransactionDescriptionField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ListTile(
      leading: Icon(TransactionFormField.note.icon),
      titleAlignment: ListTileTitleAlignment.titleHeight,
      minVerticalPadding: 0,
      contentPadding: const EdgeInsets.only(left: 16, right: 12),
      title: TextFormField(
        controller: controller,
        minLines: 2,
        maxLines: 10,
        maxLength: 300,
        buildCounter:
            (context, {required currentLength, required isFocused, maxLength}) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    '$currentLength/${maxLength ?? 300}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              );
            },
        decoration: InputDecoration(
          isDense: false,
          filled: false,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          hintText: t.transaction.form.description_info,
        ),
      ),
    );
  }
}

class TransactionValueInDestinyField extends StatelessWidget {
  const TransactionValueInDestinyField({
    super.key,
    required this.controller,
    required this.transferAccount,
    this.onChanged,
  });

  final TextEditingController controller;
  final Account? transferAccount;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ListTile(
      leading: const Icon(Icons.trending_flat_rounded),
      minVerticalPadding: 0,
      contentPadding: const EdgeInsets.only(left: 16, right: 12),
      title: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: t.transfer.form.value_in_destiny.title,
          suffixText: transferAccount?.currency.symbol,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          filled: false,
          isDense: false,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: twoDecimalDigitFormatter,
        validator: (value) {
          final defaultNumberValidatorResult = fieldValidator(
            value,
            isRequired: false,
            validator: ValidatorType.double,
          );

          if (defaultNumberValidatorResult != null) {
            return defaultNumberValidatorResult;
          }

          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          onChanged?.call();
        },
      ),
    );
  }
}
