import 'package:flutter/material.dart';

const bigButtonStyleHeight = 52.0;

getBigButtonStyle(BuildContext context) {
  return ButtonStyle(
    textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.titleMedium!),
    iconSize: const WidgetStatePropertyAll(20),
    fixedSize: const WidgetStatePropertyAll(
      Size.fromHeight(bigButtonStyleHeight),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
