import 'package:flutter/material.dart';
import 'package:monekin/i18n/translations.g.dart';

/// Display a dialog with a title, a description and confirm/cancel buttons.
///
/// When the confirm dialogs is closed, it will return `true` or `false` when one of the actions
/// button is pressed, and null if closed without tapping on any icon
Future<bool?> confirmDialog(
  BuildContext context, {
  required String dialogTitle,
  required List<Widget> contentParagraphs,
  bool showCancelButton = false,
  String? confirmationText,
}) {
  final t = Translations.of(context);

  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: Text(dialogTitle),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: contentParagraphs
              .expand((element) => [element, const SizedBox(height: 6)])
              .toList(),
        ),
      ),
      actions: [
        if (showCancelButton)
          TextButton(
            child: Text(t.general.cancel),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
          ),
        TextButton(
          child: Text(confirmationText ?? t.general.understood),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(true);
          },
        ),
      ],
    ),
  );
}
