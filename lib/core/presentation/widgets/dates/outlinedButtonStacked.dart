import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';

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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Tappable(
            onTap: onTap,
            borderRadius: borderRadius,
            bgColor: Colors.transparent,
            child: OutlinedContainer(
              filled: filled,
              borderRadius: borderRadius,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
          ),
        ),
      ],
    );
  }
}

class OutlinedContainer extends StatelessWidget {
  const OutlinedContainer(
      {required this.child,
      this.filled = false,
      this.borderRadius = 15,
      this.borderColor,
      this.enabled = true,
      super.key});
  final Widget child;
  final bool filled;
  final double borderRadius;
  final Color? borderColor;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    if (enabled == false) return child;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ??
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          width: 2,
        ),
        color: filled == true
            ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
