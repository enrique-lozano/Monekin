import 'package:flutter/material.dart';

class Tappable extends StatelessWidget {
  const Tappable({
    super.key,
    this.bgColor,
    this.borderRadius,
    this.onTap,
    this.shape,
    required this.child,
    this.onLongPress,
    this.onDoubleTap,
    this.margin,
  });

  final Color? bgColor;
  final double? borderRadius;
  final ShapeBorder? shape;

  final EdgeInsets? margin;

  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onDoubleTap;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: bgColor,
        borderRadius:
            borderRadius == null ? null : BorderRadius.circular(borderRadius!),
        shape: shape,
        child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            onDoubleTap: onDoubleTap,
            customBorder: shape,
            borderRadius: borderRadius == null
                ? null
                : BorderRadius.circular(borderRadius!),
            child: child),
      ),
    );
  }
}
