import 'dart:math';

import 'package:monekin/core/presentation/animations/animation_controller.dart';
import 'package:flutter/material.dart';

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    required this.child,
    required this.duration,
    required this.shakeCount,
    required this.shakeOffset,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration duration;

  @override
  // ignore: no_logic_in_create_state
  State<ShakeWidget> createState() => ShakeWidgetState(duration);
}

class SineCurve extends Curve {
  const SineCurve({this.count = 3});
  final double count;

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t);
  }
}

class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(Duration duration) : super(duration);

  late final Animation<double> _sineAnimation =
      Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    parent: animationController,
    curve: SineCurve(count: widget.shakeCount.toDouble()),
  ));

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    // Reset animationController when the animation is complete
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sineAnimation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_sineAnimation.value * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }
}
