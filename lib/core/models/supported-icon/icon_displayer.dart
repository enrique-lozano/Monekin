import 'package:flutter/material.dart';
import 'package:monekin/core/models/category/category.dart';
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
    this.onDoubleTap,
    this.onTap,
    this.onLongPress,
    this.secondaryColor,
  }) : assert(
            (icon == null && supportedIcon != null) ||
                (icon != null && supportedIcon == null),
            'Only one of icon or supportedIcon should be defined');

  factory IconDisplayer.fromCategory({
    required Category category,
    double size = 22,
    double? padding,
    double borderRadius = 12,
    bool isOutline = false,
    void Function()? onDoubleTap,
    void Function()? onTap,
    void Function()? onLongPress,
  }) =>
      IconDisplayer(
        mainColor: ColorHex.get(category.color),
        supportedIcon: category.icon,
        isOutline: isOutline,
        borderRadius: borderRadius,
        size: size,
        padding: padding,
        onDoubleTap: onDoubleTap,
        onTap: onTap,
        onLongPress: onLongPress,
      );

  final IconData? icon;
  final SupportedIcon? supportedIcon;

  final Color mainColor;
  final Color? secondaryColor;
  final double size;
  final double? padding;
  final double borderRadius;
  final bool isOutline;

  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final calculatedPadding = padding ?? (size / (22 / 6));
    final secondaryColorInBuild = secondaryColor ?? mainColor.lighten(0.82);

    return Material(
      color: secondaryColorInBuild,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: size + calculatedPadding * 2,
          height: size + calculatedPadding * 2,
          padding: EdgeInsets.all(calculatedPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: isOutline ? 3.3 : 0,
              style: !isOutline ? BorderStyle.none : BorderStyle.solid,
              color: mainColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            /* --- 
              The bgColor of the container is specified in the top Material Widget to achieve the splash effect
            --- */
            // color: mainColor,
          ),
          child: Builder(
            builder: (context) {
              if (supportedIcon != null) {
                return supportedIcon!.display(
                  size: size,
                  color: mainColor,
                );
              }

              return FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                    height: size,
                    width: size,
                    child: Icon(
                      icon,
                      color: mainColor,
                      size: size,
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
