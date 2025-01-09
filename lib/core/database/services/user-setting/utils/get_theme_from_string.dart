import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/i18n/translations.g.dart';

ThemeMode getThemeFromString(String? themeString) {
  if (themeString == null) return ThemeMode.system;

  Map<String, ThemeMode> themeSetting = {
    'system': ThemeMode.system,
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  return themeSetting[themeString] ?? ThemeMode.system;
}

extension ThemeModeExt on ThemeMode {
  String displayName(BuildContext context) {
    final t = Translations.of(context);

    switch (this) {
      case ThemeMode.system:
        return t.settings.theme_auto;
      case ThemeMode.light:
        return t.settings.theme_light;
      case ThemeMode.dark:
        return t.settings.theme_dark;
    }
  }

  IconData icon(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return isAppInDarkBrightness(context)
            ? Icons.dark_mode
            : Icons.light_mode_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }
}
