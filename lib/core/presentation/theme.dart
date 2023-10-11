import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/utils/color_utils.dart';

bool isAppUsingDynamicColors = false;

// Fictitious brand color.
const _brandBlue = Color(0xFF0F3375);

CustomColors lightCustomColors = const CustomColors(
    danger: Colors.red, success: Colors.green, brand: _brandBlue);
CustomColors darkCustomColors = const CustomColors(
    danger: Colors.redAccent, success: Colors.lightGreen, brand: _brandBlue);

ColorScheme appColorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
    required this.success,
    required this.brand,
  });

  final Color danger;
  final Color success;
  final Color brand;

  static CustomColors of(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? darkCustomColors
        : lightCustomColors;
  }

  @override
  CustomColors copyWith({Color? danger, Color? success, Color? brand}) {
    return CustomColors(
      danger: danger ?? this.danger,
      success: success ?? this.success,
      brand: brand ?? this.brand,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t) ?? danger,
      success: Color.lerp(success, other.success, t) ?? success,
      brand: Color.lerp(brand, other.brand, t) ?? brand,
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      danger: danger.harmonizeWith(dynamic.primary),
      brand: brand.harmonizeWith(dynamic.primary),
      success: success.harmonizeWith(dynamic.primary),
    );
  }
}

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

  if (lightDynamic != null && darkDynamic != null && accentColor == 'auto') {
    // On Android S+ devices, use the provided dynamic color scheme.
    // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
    lightColorScheme = lightDynamic.harmonized();

    // (Optional) Customize the scheme as desired. For example, one might
    // want to use a brand color to override the dynamic [ColorScheme.secondary].
    // lightColorScheme = lightColorScheme.copyWith(secondary: _brandBlue);

    // (Optional) If applicable, harmonize custom colors.
    lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

    // Repeat for the dark color scheme.
    darkColorScheme = darkDynamic.harmonized();

    if (amoledMode) {
      darkColorScheme = darkColorScheme.copyWith(background: Colors.black);
    }

    darkCustomColors = darkCustomColors.harmonized(darkColorScheme);

    isAppUsingDynamicColors = true; // ignore, only for demo purposes
  } else {
    // Otherwise, use fallback schemes.
    lightColorScheme = ColorScheme.fromSeed(
      seedColor: accentColor == 'auto' ? _brandBlue : ColorHex.get(accentColor),
    );
    darkColorScheme = ColorScheme.fromSeed(
        seedColor:
            accentColor == 'auto' ? _brandBlue : ColorHex.get(accentColor),
        brightness: Brightness.dark,
        background: amoledMode ? Colors.black : null);
  }

  theme = ThemeData(
    colorScheme: isDark ? darkColorScheme : lightColorScheme,
    brightness: isDark ? Brightness.dark : Brightness.light,
    useMaterial3: true,
    fontFamily: 'Nunito',
  );

  final listTileSmallText = TextStyle(
      color: theme.textTheme.bodyMedium?.color,
      fontSize: 14,
      wordSpacing: 0,
      decorationThickness: 1,
      fontFamily: 'Nunito');

  return theme.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: isDark
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.primary,
      foregroundColor: isDark
          ? theme.colorScheme.onPrimaryContainer
          : theme.colorScheme.onPrimary,
      shadowColor: theme.primaryColorDark,
    ),
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
    tabBarTheme: TabBarTheme(
        unselectedLabelColor: isDark
            ? theme.colorScheme.onPrimaryContainer
            : theme.colorScheme.onPrimary,
        labelColor: isDark
            ? theme.colorScheme.primary
            : theme.colorScheme.primaryContainer,
        indicatorColor: isDark
            ? theme.colorScheme.primary
            : theme.colorScheme.primaryContainer),
  );
}
