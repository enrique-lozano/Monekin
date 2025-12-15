import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';

class DisplayAppIcon extends StatelessWidget {
  const DisplayAppIcon({
    super.key,
    required this.height,

    this.padding = const EdgeInsets.all(8),
  });

  final double height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(min(height * 0.1, 8));

    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white.withOpacity(0.5)),
        borderRadius: borderRadius,
        color: ColorHex.get('0F3375'),
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadius),
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.asset('assets/resources/appIcon.png', fit: BoxFit.fill),
        ),
      ),
    );
  }
}
