import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData getThemeData(bool dark) {
  ThemeData theme;

  const FlexSchemeData appColorScheme = FlexSchemeData(
    name: 'App color scheme',
    description: 'The app color scheme',
    light: FlexSchemeColor(
      primary: Color(0xFF005DB7),
      primaryContainer: Color(0xFFD6E3FF),
      secondary: Color(0xFF555F71),
      secondaryContainer: Color(0xFFDAE2F9),
      tertiary: Color(0xFF6F5575),
      tertiaryContainer: Color(0xFFF9D8FD),
    ),
    dark: FlexSchemeColor(
      primary: Color(0xFFA9C7FF),
      primaryContainer: Color(0xFF00468C),
      secondary: Color(0xFFBDC7DC),
      secondaryContainer: Color(0xFF3E4758),
      tertiary: Color(0xFFDCBCE1),
      tertiaryContainer: Color(0xFF563E5C),
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
    dividerTheme: const DividerThemeData(space: 0),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
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
    useMaterial3: true,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
  );
}
