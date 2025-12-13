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

class AnimatedFloatingButtonBasedOnScroll extends StatefulWidget {
  const AnimatedFloatingButtonBasedOnScroll({
    super.key,
    required this.scrollController,
    this.onPressed,
    required this.icon,
    required this.text,
  });

  final void Function()? onPressed;
  final Widget icon;
  final String text;

  final ScrollController scrollController;

  @override
  State<AnimatedFloatingButtonBasedOnScroll> createState() =>
      _AnimatedFloatingButtonBasedOnScrollState();
}

class _AnimatedFloatingButtonBasedOnScrollState
    extends State<AnimatedFloatingButtonBasedOnScroll> {
  bool isFloatingButtonExtended = true;

  void _setFloatingButtonState() {
    bool shouldExtendButton =
        BreakPoint.of(context).isLargerThan(BreakpointID.md) ||
        widget.scrollController.offset <= 10 ||
        widget.scrollController.position.userScrollDirection !=
            ScrollDirection.reverse;

    if (isFloatingButtonExtended != shouldExtendButton) {
      setState(() {
        isFloatingButtonExtended = shouldExtendButton;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_setFloatingButtonState);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_setFloatingButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingButton(
      onPressed: widget.onPressed,
      icon: widget.icon,
      text: widget.text,
      isExtended: isFloatingButtonExtended,
    );
  }
}
