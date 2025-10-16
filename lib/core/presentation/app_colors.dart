import 'package:flutter/material.dart';

/// Monekin brand color.
const brandBlue = Color(0xFF0F3375);

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({required this.colors});

  final Map<String, Color> colors;

  // Getters for type-safe access with autocompletion
  Color get link => colors['link']!;
  Color get danger => colors['danger']!;
  Color get success => colors['success']!;
  Color get brand => colors['brand']!;
  Color get shadowColor => colors['shadowColor']!;
  Color get shadowColorLight => colors['shadowColorLight']!;
  Color get textBody => colors['textBody']!;
  Color get textHint => colors['textHint']!;
  Color get modalBackground => colors['modalBackground']!;
  Color get consistentPrimary => colors['consistentPrimary']!;
  Color get onConsistentPrimary => colors['onConsistentPrimary']!;

  static AppColors fromColorScheme(ColorScheme colorScheme) {
    final isDark = colorScheme.brightness == Brightness.dark;

    return AppColors(
      colors: {
        'link': isDark ? Colors.blue.shade200 : Colors.blue.shade700,
        'danger': isDark ? Colors.redAccent : Colors.red,
        'success': isDark
            ? Colors.lightGreen
            : const Color.fromARGB(255, 55, 161, 59),
        'brand': isDark ? const Color.fromARGB(255, 128, 134, 177) : brandBlue,
        'shadowColor': isDark
            ? const Color.fromARGB(105, 189, 189, 189)
            : const Color.fromARGB(100, 90, 90, 90),
        'shadowColorLight': isDark
            ? const Color.fromARGB(40, 116, 116, 116)
            : const Color.fromARGB(44, 90, 90, 90),
        'textBody': isDark
            ? const Color.fromARGB(245, 211, 211, 211)
            : const Color.fromARGB(255, 67, 67, 67),
        'textHint': isDark
            ? const Color.fromARGB(255, 153, 153, 153)
            : const Color.fromARGB(255, 123, 123, 123),
        'modalBackground': colorScheme.surfaceContainer,
        'consistentPrimary': isDark
            ? colorScheme.primaryContainer
            : colorScheme.primary,
        'onConsistentPrimary': isDark
            ? colorScheme.onPrimaryContainer
            : colorScheme.onPrimary,
      },
    );
  }

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  AppColors copyWith({Map<String, Color>? colors}) {
    return AppColors(colors: colors ?? this.colors);
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    final lerpedColors = <String, Color>{};
    colors.forEach((key, value) {
      lerpedColors[key] = Color.lerp(value, other.colors[key], t)!;
    });

    return AppColors(colors: lerpedColors);
  }
}
