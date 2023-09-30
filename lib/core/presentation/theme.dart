import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData getThemeData(bool dark) {
  ThemeData theme;

  const FlexSchemeData appColorScheme = FlexSchemeData(
    name: 'App color scheme',
    description: 'The app color scheme',
    light: FlexSchemeColor(
      primary: Color.fromARGB(255, 15, 51, 117),
      primaryContainer: Color(0xFFDAE2FF),
      secondary: Color(0xFF555F71),
      secondaryContainer: Color(0xFFDAE2F9),
      tertiary: Color(0xFF735572),
      tertiaryContainer: Color(0xFFFED7F9),
    ),
    dark: FlexSchemeColor(
      primary: Color(0xFF8FCDFF),
      primaryContainer: Color(0xFF004B71),
      secondary: Color(0xFFB8C8D9),
      secondaryContainer: Color(0xFF394956),
      tertiary: Color(0xFF735572),
      tertiaryContainer: Color(0xFFFED7F9),
    ),
  );

  if (dark) {
    theme = FlexThemeData.dark(
      colors: appColorScheme.dark,
      useMaterial3: true,
      fontFamily: 'Nunito',
      appBarElevation: 3,
    );
  } else {
    theme = FlexThemeData.light(
      colors: appColorScheme.light,
      useMaterial3: true,
      fontFamily: 'Nunito',
      appBarElevation: 2,
    );
  }

  final listTileSmallText = TextStyle(
      color: theme.textTheme.bodyMedium?.color,
      fontSize: 14,
      wordSpacing: 0,
      decorationThickness: 1,
      fontFamily: 'Nunito');

  return theme.copyWith(
    appBarTheme: AppBarTheme(
      color: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
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
        unselectedLabelColor: theme.colorScheme.onPrimary,
        labelColor: theme.colorScheme.primaryContainer,
        indicatorColor: theme.colorScheme.primaryContainer),
    useMaterial3: true,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
  );
}
