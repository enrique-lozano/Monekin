import 'package:flutter/material.dart';
import 'package:parsa/core/presentation/widgets/tappable.dart';

class OutlinedButtonStacked extends StatelessWidget {
  const OutlinedButtonStacked({
    super.key,
    required this.text,
    this.fontSize,
    required this.onTap,
    required this.iconData,
    this.afterWidget,
    this.alignLeft = false,
    this.padding,
    this.afterWidgetPadding,
    this.alignBeside,
    this.filled = false,
    this.transitionWhenFilled = true,
    this.infoButton,
    this.iconScale = 1,
    this.borderRadius = 15,
    this.color,
  });
  final String text;
  final double? fontSize;
  final void Function()? onTap;
  final IconData iconData;
  final Widget? afterWidget;
  final bool alignLeft;
  final EdgeInsets? padding;
  final EdgeInsets? afterWidgetPadding;
  final bool? alignBeside;
  final bool filled;
  final bool transitionWhenFilled;
  final Widget? infoButton;
  final double iconScale;
  final double borderRadius;

  // The color of the button and its icon (if defined)
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onTap,
      borderRadius: borderRadius,
      bgColor: Colors.transparent,
      child: _OutlinedContainer(
        filled: filled,
        borderRadius: borderRadius,
        borderColor: color,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              child: Column(
                crossAxisAlignment: alignLeft
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  alignBeside != true
                      ? Column(
                          crossAxisAlignment: alignLeft
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: iconScale,
                              child: Icon(
                                iconData,
                                size: 35,
                                color: color ??
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              text,
                              style: TextStyle(
                                fontSize: fontSize ?? 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                            infoButton ?? const SizedBox.shrink()
                          ],
                        )
                      : Row(
                          children: [
                            Transform.scale(
                              scale: iconScale,
                              child: Icon(
                                iconData,
                                size: 28,
                                color: color ??
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontSize: fontSize ?? 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            infoButton ?? const SizedBox.shrink(),
                          ],
                        ),
                  afterWidget == null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 8),
                  if (afterWidgetPadding == null)
                    afterWidget ?? const SizedBox.shrink()
                ],
              ),
            ),
            if (afterWidgetPadding != null)
              Padding(
                padding: afterWidgetPadding ?? EdgeInsets.zero,
                child: afterWidget ?? const SizedBox.shrink(),
              ),
          ],
        ),
      ),
    );
  }
}

class _OutlinedContainer extends StatelessWidget {
  const _OutlinedContainer({
    required this.child,
    this.filled = false,
    this.borderRadius = 15,
    this.borderColor,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final bool filled;
  final double borderRadius;
  final Color? borderColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (enabled == false) return child;

    final buttonColor = borderColor ?? Theme.of(context).colorScheme.secondary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        border: Border.all(
          color: buttonColor.withOpacity(filled ? 0.6 : 0.5),
          width: 2,
        ),
        color: filled ? buttonColor.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
