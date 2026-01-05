import 'package:flutter/material.dart';

Widget createListSeparator(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
    child: Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

ListTileThemeData getSettingListTileStyle(BuildContext context) {
  return ListTileTheme.of(context).copyWith(
    titleTextStyle: TextTheme.of(context).bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onSurface,
    ),
    leadingAndTrailingTextStyle: TextTheme.of(context).bodySmall?.copyWith(),
  );
}
