import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:pausable_timer/pausable_timer.dart';

class SnackbarInstance extends SnackbarParams {
  final Color textColor;
  final Color backgroundColor;
  final IconData iconData;

  SnackbarInstance(
    super.title, {
    super.duration,
    super.actions,
    super.message,
    super.clearPrevious,
    required this.textColor,
    required this.backgroundColor,
    required this.iconData,
  });

  SnackbarInstance.fromParams(
    SnackbarParams params, {
    required this.textColor,
    required this.backgroundColor,
    required this.iconData,
  }) : super(
         params.title,
         duration: params.duration,
         actions: params.actions,
         message: params.message,
         clearPrevious: params.clearPrevious,
       );
}

class GlobalSnackbar extends StatefulWidget {
  const GlobalSnackbar({super.key});

  @override
  State<GlobalSnackbar> createState() => GlobalSnackbarState();
}

class GlobalSnackbarState extends State<GlobalSnackbar>
    with TickerProviderStateMixin {
  PausableTimer? currentTimeout;
  late AnimationController _animationControllerY;
  late AnimationController _animationControllerX;
  double totalMovedNegative = 0;
  List<SnackbarInstance> currentQueue = [];

  SnackbarInstance? snackbar;

  void post(SnackbarInstance snackbar, {bool postIfQueue = true}) {
    if (currentQueue.isNotEmpty && !postIfQueue) return;
    currentQueue.add(snackbar);
    if (currentQueue.length <= 1) animateIn(snackbar);
  }

  void animateIn(SnackbarParams message) {
    setState(() {
      snackbar = currentQueue[0];
    });
    _animationControllerX.animateTo(0.5, duration: Duration.zero);
    _animationControllerY.animateTo(
      0.5,
      curve: ElasticOutCurve(0.8),
      duration: Duration(
        milliseconds: ((_animationControllerY.value - 0.5).abs() * 800 + 900)
            .toInt(),
      ),
    );
    currentTimeout = PausableTimer(message.duration, () {
      animateOut();
    });
    currentTimeout!.start();
  }

  void animateOut() {
    currentTimeout?.cancel();
    _animationControllerY.animateTo(
      0,
      curve: Curves.elasticOut,
      duration: Duration(
        milliseconds: ((_animationControllerY.value - 0.5).abs() * 800 + 2000)
            .toInt(),
      ),
    );
    if (currentQueue.isNotEmpty) {
      currentQueue.removeAt(0);
    }
    if (currentQueue.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 150), () {
        if (currentQueue.isNotEmpty) animateIn(currentQueue[0]);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _animationControllerY = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animationControllerX = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  void _onPointerMove(PointerMoveEvent ptr) {
    if (ptr.delta.dy <= 0) {
      totalMovedNegative += ptr.delta.dy;
    }
    if (_animationControllerY.value <= 0.5) {
      _animationControllerY.value += ptr.delta.dy / 400;
    } else {
      _animationControllerY.value +=
          ptr.delta.dy / (2000 * _animationControllerY.value * 8);
    }
    _animationControllerX.value +=
        ptr.delta.dx / (1000 + (_animationControllerX.value - 0.5).abs() * 100);

    currentTimeout!.pause();
  }

  void _onPointerUp(PointerUpEvent event) {
    if (totalMovedNegative <= -200) {
      // if user drags it around but has a net negative, swipe up
      animateOut();
    } else if (_animationControllerY.value <= 0.4) {
      // it is swiped up
      animateOut();
    } else {
      _animationControllerY.animateTo(
        0.5,
        curve: Curves.elasticOut,
        duration: Duration(
          milliseconds: ((_animationControllerY.value - 0.5).abs() * 800 + 700)
              .toInt(),
        ),
      );

      currentTimeout!.start();
    }

    _animationControllerX.animateTo(
      0.5,
      curve: Curves.elasticOut,
      duration: Duration(
        milliseconds: ((_animationControllerX.value - 0.5).abs() * 800 + 700)
            .toInt(),
      ),
    );
    totalMovedNegative = 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationControllerX,
      builder: (context, child) {
        return child!;
      },
      child: AnimatedBuilder(
        animation: _animationControllerY,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              (_animationControllerX.value - 0.5) * 100,
              (_animationControllerY.value - 0.5) * 400 +
                  MediaQuery.viewPaddingOf(context).top +
                  10,
            ),
            child: child,
          );
        },
        child: Listener(
          onPointerMove: (ptr) => {_onPointerMove(ptr)},
          onPointerUp: (ptr) => {_onPointerUp(ptr)},
          child: Center(
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 15),
                width: double.infinity,
                padding: snackbar?.padding,
                decoration: BoxDecoration(
                  color: snackbar == null
                      ? Colors.transparent
                      : snackbar!.backgroundColor,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.surface,
                      blurRadius: 15,
                      offset: Offset(0, 0),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: snackbar == null
                    ? SizedBox.shrink()
                    : MonekinSnackbarContent(
                        title: snackbar!.title,
                        message: snackbar!.message,
                        color: snackbar!.textColor,
                        icon: snackbar!.iconData,
                        actions: snackbar!.actions
                            ?.map(
                              (action) => MonekinSnackbarAction(
                                label: action.label,
                                onPressed: () {
                                  action.onPressed?.call();
                                  animateOut();
                                },
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
