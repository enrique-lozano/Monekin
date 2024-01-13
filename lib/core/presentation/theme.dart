import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/utils/color_utils.dart';

import 'app_colors.dart';

bool isAppUsingDynamicColors = false;

/// Monekin brand color.
const brandBlue = Color(0xFF0F3375);

ThemeData getThemeData(
  BuildContext context, {
  required bool isDark,
  required bool amoledMode,
  required ColorScheme? lightDynamic,
  required ColorScheme? darkDynamic,
  required String accentColor,
}) {
  ThemeData theme;

  ColorScheme lightColorScheme;
  ColorScheme darkColorScheme;

  /// Fallback scheme for a not-dynamic mode in dark or light mode:
  ColorScheme fallbackScheme = ColorScheme.fromSeed(
      seedColor: accentColor == 'auto' ? brandBlue : ColorHex.get(accentColor),
      brightness: isDark ? Brightness.dark : Brightness.light,
      background: isDark && amoledMode ? Colors.black : null);

  if (lightDynamic != null && darkDynamic != null && accentColor == 'auto') {
    // On Android S+ devices, use the provided dynamic color scheme.
    // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
    lightColorScheme = lightDynamic.harmonized();

    // Repeat for the dark color scheme.
    darkColorScheme = darkDynamic.harmonized();

    if (amoledMode) {
      darkColorScheme = darkColorScheme.copyWith(background: Colors.black);
    }

    isAppUsingDynamicColors = true; // ignore, only for demo purposes
  } else {
    // Otherwise, use fallback schemes.
    lightColorScheme = fallbackScheme;
    darkColorScheme = fallbackScheme;
  }

  theme = ThemeData(
      colorScheme: isDark ? darkColorScheme : lightColorScheme,
      brightness: isDark ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      fontFamily: 'Nunito',
      extensions: [AppColors.fromColorScheme(fallbackScheme)]);

  final listTileSmallText = TextStyle(
      color: theme.textTheme.bodyMedium?.color,
      fontSize: 14,
      wordSpacing: 0,
      decorationThickness: 1,
      fontFamily: 'Nunito');

  return theme.copyWith(
    dividerTheme: const DividerThemeData(space: 0),
    cardColor: theme.colorScheme.surface,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
    ),
    bottomSheetTheme: theme.bottomSheetTheme.copyWith(
      elevation: 0,
      dragHandleSize: const Size(25, 4),
      surfaceTintColor: theme.colorScheme.background,
      dragHandleColor: Colors.grey[300],
      clipBehavior: Clip.hardEdge,
    ),
    listTileTheme: theme.listTileTheme.copyWith(
      minVerticalPadding: 8,
      subtitleTextStyle:
          listTileSmallText.copyWith(fontWeight: FontWeight.w300),
      leadingAndTrailingTextStyle: listTileSmallText,
    ),
  );
}
