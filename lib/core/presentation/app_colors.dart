import 'package:flutter/material.dart';

/// Monekin brand color.
const brandBlue = Color(0xFF0F3375);

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.danger,
    required this.success,
    required this.brand,
    required this.light,
    required this.dark,
    required this.shadowColor,
    required this.shadowColorLight,
  });

  final Color danger;
  final Color success;
  final Color brand;
  final Color light;
  final Color dark;
  final Color shadowColor;
  final Color shadowColorLight;

  static AppColors fromColorScheme(ColorScheme colorScheme) {
    final isDark = colorScheme.brightness == Brightness.dark;

    return AppColors(
      danger: isDark ? Colors.redAccent : Colors.red,
      success:
          isDark ? Colors.lightGreen : const Color.fromARGB(255, 55, 161, 59),
      brand: isDark ? const Color.fromARGB(255, 128, 134, 177) : brandBlue,
      light: colorScheme.surfaceContainerLow,
      dark: colorScheme.inverseSurface,
      shadowColor: isDark
          ? const Color.fromARGB(105, 189, 189, 189)
          : const Color.fromARGB(100, 90, 90, 90),
      shadowColorLight: isDark
          ? const Color.fromARGB(40, 116, 116, 116)
          : const Color.fromARGB(44, 90, 90, 90),
    );
  }

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  AppColors copyWith({
    Color? danger,
    Color? success,
    Color? brand,
    Color? inputFill,
    Color? dark,
    Color? light,
    Color? shadowColor,
    Color? shadowColorLight,
    Color? modalBackground,
  }) {
    return AppColors(
      danger: danger ?? this.danger,
      success: success ?? this.success,
      light: light ?? this.light,
      dark: dark ?? this.dark,
      brand: brand ?? this.brand,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowColorLight: shadowColorLight ?? this.shadowColorLight,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      danger: Color.lerp(danger, other.danger, t) ?? danger,
      success: Color.lerp(success, other.success, t) ?? success,
      light: Color.lerp(light, other.light, t) ?? light,
      dark: Color.lerp(dark, other.dark, t) ?? dark,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      shadowColorLight:
          Color.lerp(shadowColorLight, other.shadowColorLight, t) ??
              shadowColorLight,
      brand: Color.lerp(brand, other.brand, t) ?? brand,
    );
  }
}

extension CustomThemeDataExt on ThemeData {
  CustomColorSchemeExtended get colorSchemeExtended {
    return CustomColorSchemeExtended(colorScheme);
  }
}

class CustomColorSchemeExtended {
  final ColorScheme colorScheme;

  CustomColorSchemeExtended(this.colorScheme);

  Color get modalBackground => colorScheme.surfaceContainer;
  Color get inputFill => colorScheme.surfaceContainerHighest;
  Color get cardColor => colorScheme.surfaceContainer;
  Color get dashboardHeader => colorScheme.primaryContainer;
  Color get onDashboardHeader => colorScheme.onPrimaryContainer;
}
