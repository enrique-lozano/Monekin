import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/transaction_form_field.enum.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TransactionTitleField extends StatelessWidget {
  const TransactionTitleField({
    super.key,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String value)? onFieldSubmitted;

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
            focusNode: focusNode,
            textInputAction: textInputAction ?? TextInputAction.next,
            onFieldSubmitted: onFieldSubmitted,
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
  const TransactionDescriptionField({
    super.key,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String value)? onFieldSubmitted;

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
        focusNode: focusNode,
        textInputAction: textInputAction ?? TextInputAction.newline,
        onFieldSubmitted: onFieldSubmitted,
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
