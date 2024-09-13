import 'package:flutter/material.dart';
import 'app_colors.dart';

bool isAppInDarkBrightness(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;
bool isAppInLightBrightness(BuildContext context) =>
    !isAppInDarkBrightness(context);

ThemeData getThemeData({
  required ColorScheme lightColorScheme,
  required String accentColor,
}) {
  AppColors customAppColors = AppColors.fromColorScheme(lightColorScheme);

  ThemeData theme = ThemeData(
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Nunito',
    extensions: [customAppColors],
  );

  final listTileSmallText = TextStyle(
    color: theme.textTheme.bodyMedium?.color,
    fontSize: 14,
    wordSpacing: 0,
    decorationThickness: 1,
    fontFamily: 'Nunito',
  );

  return theme.copyWith(
    scaffoldBackgroundColor: theme.colorScheme.surface,
    dividerTheme: const DividerThemeData(space: 0),
    cardColor: theme.colorScheme.surface,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHighest,
      isDense: true,
      floatingLabelStyle: TextStyle(
        backgroundColor: theme.colorScheme.surface.withOpacity(0.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
    ),
    bottomSheetTheme: theme.bottomSheetTheme.copyWith(
      elevation: 0,
      dragHandleSize: const Size(25, 4),
      modalBackgroundColor: customAppColors.modalBackground,
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
