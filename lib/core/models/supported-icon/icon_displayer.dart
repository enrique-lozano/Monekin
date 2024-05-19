import 'dart:math';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';

part 'icon_displayer.g.dart';

enum IconDisplayMode {
  decoratedBox,
  polygon,
}

@CopyWith()
class IconDisplayer extends StatelessWidget {
  const IconDisplayer({
    super.key,
    required this.mainColor,
    this.icon,
    this.supportedIcon,
    this.size = 22,
    this.padding,
    this.borderRadius = 12,
    this.outlineWidth = 4,
    this.isOutline = false,
    this.onDoubleTap,
    this.onTap,
    this.onLongPress,
    this.secondaryColor,
    this.displayMode = IconDisplayMode.decoratedBox,
  }) : assert(
            (icon == null && supportedIcon != null) ||
                (icon != null && supportedIcon == null),
            'Only one of icon or supportedIcon should be defined');

  factory IconDisplayer.fromCategory(
    BuildContext context, {
    required Category category,
    double size = 22,
    double? padding,
    double borderRadius = 99999,
    bool isOutline = false,
    IconDisplayMode displayMode = IconDisplayMode.decoratedBox,
    void Function()? onDoubleTap,
    void Function()? onTap,
    void Function()? onLongPress,
  }) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color categoryColor = ColorHex.get(category.color);

    return IconDisplayer(
      mainColor: isDark ? categoryColor.lighten(0.82) : categoryColor,
      secondaryColor: isDark ? categoryColor : categoryColor.lighten(0.82),
      supportedIcon: category.icon,
      isOutline: isOutline,
      borderRadius: borderRadius,
      displayMode: displayMode,
      size: size,
      padding: padding,
      onDoubleTap: onDoubleTap,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  final IconData? icon;
  final SupportedIcon? supportedIcon;

  final Color mainColor;
  final Color? secondaryColor;
  final double size;
  final double? padding;
  final double borderRadius;

  final double outlineWidth;
  final bool isOutline;

  final IconDisplayMode displayMode;

  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final calculatedPadding = padding ?? (size / (22 / 6));
    final secondaryColorInBuild = secondaryColor ?? mainColor.lighten(0.82);

    final borderSide = BorderSide(
      width: isOutline ? outlineWidth : 0,
      style: !isOutline ? BorderStyle.none : BorderStyle.solid,
      color: mainColor,
    );

    final polygonBorder = StarBorder.polygon(
      sides: 6,
      rotation: 0,
      pointRounding: min(1, borderRadius * 2.5 / 100),
      side: borderSide,
      squash: 0,
    );

    return Material(
      color: secondaryColorInBuild,
      borderRadius: displayMode == IconDisplayMode.polygon
          ? null
          : BorderRadius.circular(borderRadius),
      shape: displayMode == IconDisplayMode.polygon ? polygonBorder : null,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        customBorder:
            displayMode == IconDisplayMode.polygon ? polygonBorder : null,
        borderRadius: displayMode == IconDisplayMode.polygon
            ? null
            : BorderRadius.circular(borderRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: size + calculatedPadding * 2,
          height: size + calculatedPadding * 2,
          padding: EdgeInsets.all(calculatedPadding),
          alignment: Alignment.center,
          decoration: displayMode == IconDisplayMode.polygon
              ? ShapeDecoration(
                  shape: polygonBorder,
                )
              : BoxDecoration(
                  border: Border.fromBorderSide(borderSide),
                  borderRadius: BorderRadius.circular(borderRadius),
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
