import 'dart:async';

import 'package:flutter/material.dart';

/// A widget that tracks successive taps and triggers an action
/// when a specified number of taps are reached.
class SuccessiveTapDetector extends StatefulWidget {
  /// Creates a widget that tracks successive taps and triggers an action
  /// when a specified number of taps are reached.
  const SuccessiveTapDetector({
    super.key,
    this.numberOfClicks = 4,
    required this.child,
    required this.onClickGoalReached,
    this.delayTrackingAfterGoal = 0,
  });

  /// The number of successive taps required to trigger the [onClickGoalReached] callback.
  final int numberOfClicks;

  /// The widget to be displayed and monitored for taps.
  final Widget child;

  /// Callback function that is called when the specified number of taps is reached.
  final void Function() onClickGoalReached;

  /// Delay in ms until the widget will track again for clicks after reaching a goal
  final int delayTrackingAfterGoal;

  @override
  State<SuccessiveTapDetector> createState() => _SuccessiveTapDetectorState();
}

class _SuccessiveTapDetectorState extends State<SuccessiveTapDetector> {
  int _clickCount = 0;

  final int _clickInterval = 2000;
  Timer? _clickTimer;

  bool _tapEnabled = true;

  @override
  void dispose() {
    _clickTimer?.cancel();

    super.dispose();
  }

  void _handleTap() {
    if (_tapEnabled) {
      _clickCount += 1;
    } else {
      _clickCount = 0;
    }

    setState(() {});

    _clickTimer?.cancel();
    _clickTimer =
        Timer(Duration(milliseconds: _clickInterval), _resetClickCount);

    if (_clickCount == widget.numberOfClicks) {
      widget.onClickGoalReached();
      _resetClickCount();
      _tapEnabled = false;

      Future.delayed(Duration(milliseconds: widget.delayTrackingAfterGoal))
          .then((x) {
        _tapEnabled = true;
      });
    }
  }

  /// Resets the tap count to zero.
  ///
  /// This method is called either when the tap goal is reached or when the timer expires
  /// without the tap goal being reached, indicating a timeout.
  void _resetClickCount() {
    setState(() {
      _clickCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: widget.child,
    );
  }
}
