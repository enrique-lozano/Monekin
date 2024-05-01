import 'package:flutter/material.dart';

class ReadOnlyTextFormField extends StatelessWidget {
  const ReadOnlyTextFormField({
    super.key,
    this.onTap,
    this.decoration,
    required this.displayValue,
    this.textAlign = TextAlign.start,
  });

  final void Function()? onTap;

  final InputDecoration? decoration;

  final String? displayValue;

  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      readOnly: true,
      mouseCursor: SystemMouseCursors.click,
      onTap: onTap,
      decoration: decoration,
      textAlign: textAlign,
      controller: TextEditingController(text: displayValue),
    );
  }
}
