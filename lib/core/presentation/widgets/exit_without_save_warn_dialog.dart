import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<Null> showExitWithoutSaveWarnDialog(BuildContext context) {
  final t = Translations.of(context);

  return confirmDialog(
    context,
    canPop: false,
    icon: Icons.warning_rounded,
    confirmationText: t.ui_actions.continue_text,
    showCancelButton: true,
    dialogTitle: t.general.leave_without_saving.title,
    contentParagraphs: [Text(t.general.leave_without_saving.message)],
  ).then((isConfirmed) {
    if (isConfirmed == true) RouteUtils.popRoute();
  });
}
