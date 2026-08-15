import 'package:flutter/material.dart';
import 'package:monekin/core/utils/app_utils.dart';

/// Default corner radius for buttons across the app.
final defaultButtonBorderRadius = AppUtils.isDesktop ? 10.0 : 12.0;

/// Height for prominent call-to-action buttons (e.g. onboarding).
const bigButtonStyleHeight = 52.0;

/// Height for full-width persistent footer action buttons.
final mediumButtonStyleHeight = AppUtils.isDesktop ? 34.0 : 42.0;

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
///
/// Disabled colors are set explicitly (instead of relying on Material's
/// default opacity-based overlay) so disabled buttons render as a solid,
/// opaque grey instead of a translucent one.
ButtonStyle defaultButtonStyle({required bool isDark}) {
  return FilledButton.styleFrom(
    shape: defaultButtonShape,
    disabledBackgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
    disabledForegroundColor: isDark ? Colors.grey[500] : Colors.grey,
  );
}
