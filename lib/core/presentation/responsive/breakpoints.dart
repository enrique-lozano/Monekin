import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/responsive/app_breakpoints.dart';

enum BreakpointID { xs, sm, md, lg, xl, xxl }

class BreakPoint extends Equatable {
  final BreakpointID id;

  /// Body maximum width
  final double width;

  const BreakPoint(this.id, {required this.width});

  /// Get the [BreakPoint] that corresponds to the given [width]. Useful to make
  /// decisions based on a locally available width (e.g. `LayoutBuilder`'s
  /// `constraints.maxWidth`) instead of the whole window.
  static BreakPoint fromWidth(double width, {Set<BreakPoint>? breakpoints}) {
    breakpoints ??= appBreakPoints;

    for (int i = breakpoints.length - 1; i >= 0; i--) {
      final breakpoint = breakpoints.elementAt(i);
      if (breakpoint.width <= width) return breakpoint;
    }

    return breakpoints.first;
  }

  /// Get the current BreakPoint based on the device width.
  ///
  /// Reads the cached value from an ancestor [BreakpointProvider] when
  /// present (so consumers rebuild only on breakpoint changes), otherwise
  /// falls back to the window width.
  static BreakPoint of(BuildContext context, {Set<BreakPoint>? breakpoints}) {
    if (breakpoints == null) {
      final inherited = context
          .dependOnInheritedWidgetOfExactType<_InheritedBreakpoint>();

      if (inherited != null) return inherited.breakpoint;
    }

    return fromWidth(
      MediaQuery.of(context).size.width,
      breakpoints: breakpoints,
    );
  }

  static BreakPoint getById(BreakpointID id) {
    return appBreakPoints.firstWhere((element) => element.id == id);
  }

  bool isSmallerThan(BreakpointID id) {
    return this < BreakPoint.getById(id);
  }

  bool isSmallerOrEqualTo(BreakpointID id) {
    return this <= BreakPoint.getById(id);
  }

  bool isLargerThan(BreakpointID id) {
    return this > BreakPoint.getById(id);
  }

  bool isLargerOrEqualTo(BreakpointID id) {
    return this >= BreakPoint.getById(id);
  }

  bool isBetween(BreakpointID id1, BreakpointID id2) {
    return this >= BreakPoint.getById(id1) && this <= BreakPoint.getById(id2);
  }

  @override
  List<Object?> get props => [id.index];

  bool operator >(BreakPoint other) {
    return id.index > other.id.index;
  }

  bool operator <(BreakPoint other) {
    return id.index < other.id.index;
  }

  bool operator >=(BreakPoint other) {
    return id.index >= other.id.index;
  }

  bool operator <=(BreakPoint other) {
    return id.index <= other.id.index;
  }
}

/// Exposes the current [BreakPoint] to descendants, notifying them only when
/// the breakpoint changes (not on every pixel of a resize).
///
/// Install it once, high in the tree and below `MediaQuery` (e.g. in the
/// `MaterialApp.builder`).
class BreakpointProvider extends StatelessWidget {
  const BreakpointProvider({super.key, required this.child, this.breakpoints});

  final Widget child;

  /// Optional custom breakpoints. Defaults to `appBreakPoints`.
  final Set<BreakPoint>? breakpoints;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return _InheritedBreakpoint(
      breakpoint: BreakPoint.fromWidth(width, breakpoints: breakpoints),
      child: child,
    );
  }
}

class _InheritedBreakpoint extends InheritedWidget {
  const _InheritedBreakpoint({required this.breakpoint, required super.child});

  final BreakPoint breakpoint;

  @override
  bool updateShouldNotify(_InheritedBreakpoint oldWidget) {
    return breakpoint != oldWidget.breakpoint;
  }
}
