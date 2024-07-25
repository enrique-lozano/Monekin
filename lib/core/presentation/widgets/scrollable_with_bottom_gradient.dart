import 'package:flutter/material.dart';

/// A Stack widget formed by a `SingleChildScrollView` and a gradient at the bottom of it
class ScrollableWithBottomGradient extends StatelessWidget {
  const ScrollableWithBottomGradient({
    super.key,
    required this.child,
    required this.gradientColor,
    this.controller,
    this.padding,
  });

  final Widget child;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;

  final Color gradientColor;

  /// Build the gradient to display at the end of the stack
  static Positioned buildPositionedGradient(Color color) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 18,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withOpacity(0), color],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: controller,
          padding: padding,
          scrollDirection: Axis.vertical,
          child: child,
        ),
        ScrollableWithBottomGradient.buildPositionedGradient(gradientColor),
      ],
    );
  }
}
