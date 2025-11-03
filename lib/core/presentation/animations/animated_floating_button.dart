import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';

class AnimatedFloatingButton extends StatelessWidget {
  const AnimatedFloatingButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.text,
    required this.isExtended,
  });

  final void Function()? onPressed;
  final Widget icon;
  final String text;

  final bool isExtended;

  static bool shouldExtendButton(
    BuildContext context,
    ScrollController scrollController,
  ) {
    return BreakPoint.of(context).isLargerThan(BreakpointID.md) ||
        scrollController.offset <= 10 ||
        scrollController.position.userScrollDirection !=
            ScrollDirection.reverse;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      onPressed: onPressed,
      icon: icon,
      extendedPadding: const EdgeInsetsDirectional.only(start: 16, end: 16),
      extendedIconLabelSpacing: isExtended ? 8 : 0,
      label: AnimatedExpanded(
        duration: const Duration(milliseconds: 250),
        expand: isExtended,
        axis: Axis.horizontal,
        child: Text(text),
      ),
    );
  }
}
