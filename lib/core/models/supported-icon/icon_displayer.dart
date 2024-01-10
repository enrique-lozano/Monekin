import 'package:flutter/material.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/utils/color_utils.dart';

class IconDisplayer extends StatelessWidget {
  const IconDisplayer({
    super.key,
    required this.mainColor,
    this.icon,
    this.supportedIcon,
    this.size = 22,
    this.padding,
    this.borderRadius = 12,
    this.isOutline = false,
  }) : assert(
            (icon == null && supportedIcon != null) ||
                (icon != null && supportedIcon == null),
            'Only one of icon or supportedIcon should be defined');

  final IconData? icon;
  final SupportedIcon? supportedIcon;

  final Color mainColor;
  final double size;
  final double? padding;
  final double borderRadius;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    final calculatedPadding = padding ?? (size / (22 / 6));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size + calculatedPadding * 2,
      height: size + calculatedPadding * 2,
      padding: EdgeInsets.all(calculatedPadding),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: isOutline ? 3 : 0,
          style: !isOutline ? BorderStyle.none : BorderStyle.solid,
          color: mainColor.lighten(0.82),
        ),
        color: mainColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Builder(
        builder: (context) {
          if (supportedIcon != null) {
            return supportedIcon!
                .display(size: size, color: mainColor.lighten(0.82));
          }

          return FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
                height: size,
                width: size,
                child: Icon(
                  icon,
                  color: mainColor.lighten(0.82),
                  size: size,
                )),
          );
        },
      ),
    );
  }
}
