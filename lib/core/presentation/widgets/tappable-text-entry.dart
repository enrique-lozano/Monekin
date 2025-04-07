import 'dart:io';

import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';

class TappableTextEntry extends StatelessWidget {
  const TappableTextEntry({
    super.key,
    required this.title,
    required this.placeholder,
    required this.onTap,
    this.padding = const EdgeInsetsDirectional.symmetric(vertical: 0),
    this.internalPadding =
        const EdgeInsetsDirectional.symmetric(vertical: 6, horizontal: 12),
    this.showPlaceHolderWhenTextEquals,
    this.disabled = false,
    this.enableAnimatedSwitcher = true,
    this.addTappableBackground = false,
    this.textStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    this.showSelectArrow = false,
  });

  final String? title;
  final String placeholder;
  final VoidCallback onTap;
  final EdgeInsetsDirectional padding;
  final EdgeInsetsDirectional internalPadding;
  final String? showPlaceHolderWhenTextEquals;
  final bool disabled;
  final TextStyle textStyle;
  final bool enableAnimatedSwitcher;
  final bool showSelectArrow;
  final bool addTappableBackground;

  @override
  Widget build(BuildContext context) {
    Widget titleBuilder(String? titlePassed) {
      final showPlaceholder = titlePassed.isNullOrEmpty ||
          titlePassed == showPlaceHolderWhenTextEquals;

      return AnimatedDefaultTextStyle(
        style: textStyle.copyWith(
          color: showPlaceholder
              ? AppColors.of(context).textHint
              : (textStyle.color ?? Theme.of(context).colorScheme.onSurface),
        ),
        duration: const Duration(milliseconds: 200),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12 + (textStyle.fontSize ?? 14) * 0.2,
          children: [
            Text(
              showPlaceholder ? placeholder : titlePassed ?? '',
              maxLines: 2,
              textAlign: TextAlign.start,
            ),
            if (showSelectArrow)
              Icon(
                Icons.arrow_drop_down_rounded,
                size: (textStyle.fontSize ?? 16) * 1.25,
                color: textStyle.color,
              )
          ],
        ),
      );
    }

    return Stack(
      children: [
        if (addTappableBackground)
          PositionedDirectional(
            top: padding.top + 3,
            bottom: padding.bottom + 4,
            end: padding.end - 1,
            start: padding.start - 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(5),
                color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
              ),
            ),
          ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Tappable(
            key: ValueKey(title),
            onTap: disabled == true ? null : onTap,
            bgColor: Colors.transparent,
            borderRadius: BorderRadius.circular(
                textStyle.fontSize! * (Platform.isIOS ? 0.25 : 0.5)),
            child: Padding(
              padding: padding,
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 250),
                padding: internalPadding,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: borderSide(context),
                  ),
                ),
                child: IntrinsicWidth(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: titleBuilder(title),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  static BorderSide borderSide(BuildContext context, {bool disabled = false}) {
    return BorderSide(
        width: disabled ? 0 : 1.5,
        color: disabled ? Colors.transparent : Theme.of(context).dividerColor);
  }
}
