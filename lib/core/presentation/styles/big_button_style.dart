import 'package:flutter/material.dart';

getBigButtonStyle(BuildContext context) {
  return ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
    iconSize: const WidgetStatePropertyAll(20),
    fixedSize: const WidgetStatePropertyAll(Size.fromHeight(56)),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    )),
  );
}
