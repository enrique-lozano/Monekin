import 'package:flutter/material.dart';

class AnimateFAB extends StatelessWidget {
  const AnimateFAB({this.condition = true, required this.fab, super.key});

  final bool condition;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    final showFAB = fab != null && condition;

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOutCubicEmphasized,
      switchOutCurve: Curves.ease,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeScaleTransitionButton(
          animation: animation,
          alignment: Alignment(0.7, 0.7),
          child: child,
        );
      },
      child: showFAB ? fab : SizedBox(key: ValueKey(1), width: 50, height: 50),
    );
  }
}

class FadeScaleTransitionButton extends StatelessWidget {
  const FadeScaleTransitionButton({
    super.key,
    required this.animation,
    required this.alignment,
    this.child,
  });

  final Animation<double> animation;
  final Widget? child;
  final Alignment alignment;

  static final Animatable<double> _fadeInTransition = CurveTween(
    curve: const Interval(0.0, 0.7),
  );
  static final Animatable<double> _scaleInTransition = Tween<double>(
    begin: 0.30,
    end: 1.00,
  );
  static final Animatable<double> _fadeOutTransition = Tween<double>(
    begin: 1.0,
    end: 0,
  );
  static final Animatable<double> _scaleOutTransition = Tween<double>(
    begin: 1.0,
    end: 0.1,
  );

  @override
  Widget build(BuildContext context) {
    return DualTransitionBuilder(
      animation: animation,
      forwardBuilder:
          (BuildContext context, Animation<double> animation, Widget? child) {
            return FadeTransition(
              opacity: _fadeInTransition.animate(animation),
              child: ScaleTransition(
                scale: _scaleInTransition.animate(animation),
                alignment: alignment,
                child: child,
              ),
            );
          },
      reverseBuilder:
          (BuildContext context, Animation<double> animation, Widget? child) {
            return FadeTransition(
              opacity: _fadeOutTransition.animate(animation),
              child: ScaleTransition(
                scale: _scaleOutTransition.animate(animation),
                alignment: alignment,
                child: child,
              ),
            );
          },
      child: child,
    );
  }
}

class AnimateFABDelayed extends StatefulWidget {
  const AnimateFABDelayed({
    super.key,
    required this.fab,
    this.delay = const Duration(milliseconds: 250),
    this.enabled,
  });

  final Widget? fab;
  final Duration delay;
  final bool? enabled;

  @override
  State<AnimateFABDelayed> createState() => _AnimateFABDelayedState();
}

class _AnimateFABDelayedState extends State<AnimateFABDelayed> {
  bool scaleIn = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      setState(() {
        scaleIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (appStateSettings["appAnimations"] != AppAnimations.all.index)
    //   return widget.fab;

    return AnimateFAB(condition: widget.enabled ?? scaleIn, fab: widget.fab);
  }
}
