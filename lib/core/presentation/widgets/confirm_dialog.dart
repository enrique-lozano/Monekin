import 'package:flutter/material.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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
  IconData? icon,
  bool canPop = true,
}) {
  final t = Translations.of(context);

  final useRootNavigator = true;

  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: canPop,
    barrierColor: Colors.black.withOpacity(0.4),
    barrierLabel: '',
    transitionBuilder: (_, anim, _, child) {
      Tween<double> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: 0.9, end: 1);
      } else {
        tween = Tween(begin: 0.95, end: 1);
      }
      return ScaleTransition(
        scale: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOutQuart),
        ),
        child: FadeTransition(opacity: anim, child: child),
      );
    },
    transitionDuration: Duration(milliseconds: 200),
    useRootNavigator: useRootNavigator,
    pageBuilder: (_, _, _) => PopScope(
      canPop: canPop,
      child: AlertDialog.adaptive(
        title: Text(dialogTitle),
        icon: icon != null ? Icon(icon, size: 36) : null,
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
              child: Text(t.ui_actions.cancel),
              onPressed: () {
                Navigator.of(
                  context,
                  rootNavigator: useRootNavigator,
                ).pop(false);

                // NOW EVERY TIME I PRESS THE PHYSICAL DEVICE BACK BUTTON, IT CLOSES THE APP
              },
            ),
          TextButton(
            child: Text(confirmationText ?? t.general.understood),
            onPressed: () {
              Navigator.of(
                context,
                rootNavigator: useRootNavigator,
              ).maybePop(true);
            },
          ),
        ],
      ),
    ),
  );
}
