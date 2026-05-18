import 'package:flutter/material.dart';

/// Default corner radius for buttons across the app.
const defaultButtonBorderRadius = 12.0;

/// Height for prominent call-to-action buttons (e.g. onboarding).
const bigButtonStyleHeight = 52.0;

/// Height for full-width persistent footer action buttons.
const mediumButtonStyleHeight = 42.0;

ButtonStyle _iconButtonStyle(BuildContext context, double height) {
  return ButtonStyle(
    textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.titleMedium!),
    iconSize: const WidgetStatePropertyAll(20),
    fixedSize: WidgetStatePropertyAll(Size.fromHeight(height)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultButtonBorderRadius),
      ),
    ),
  );
}

/// Prominent icon+label button style (e.g. onboarding).
ButtonStyle getBigButtonStyle(BuildContext context) {
  return _iconButtonStyle(context, bigButtonStyleHeight);
}

/// Full-width persistent footer icon+label button style.
ButtonStyle getMediumButtonStyle(BuildContext context) {
  return _iconButtonStyle(context, mediumButtonStyleHeight);
}

RoundedRectangleBorder get defaultButtonShape => RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(defaultButtonBorderRadius),
);

/// Base [ButtonStyle] applied via [ThemeData] for standard-sized buttons.
ButtonStyle defaultButtonStyle({required bool isDark}) {
  return FilledButton.styleFrom(
    shape: defaultButtonShape,
    disabledBackgroundColor: isDark ? null : Colors.grey[200],
    disabledForegroundColor: isDark ? null : Colors.grey,
  );
}
