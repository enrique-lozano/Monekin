import 'package:flutter/material.dart';

class ScaledAnimatedSwitcher extends StatelessWidget {
  const ScaledAnimatedSwitcher({
    required this.keyToWatch,
    required this.child,
    this.duration = const Duration(milliseconds: 450),
    super.key,
  });

  final String keyToWatch;
  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeInOutCubic,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1),
          ),
        );

        final scaleAnimation = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0, 1.0),
          ),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            alignment: Alignment.center,
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
      child: SizedBox(key: ValueKey(keyToWatch), child: child),
    );
  }
}
