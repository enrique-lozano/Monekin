import 'package:flutter/material.dart';

ThemeMode getThemeFromString(String themeString) {
  Map<String, ThemeMode> themeSetting = {
    'system': ThemeMode.system,
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  return themeSetting[themeString] ?? ThemeMode.system;
}
