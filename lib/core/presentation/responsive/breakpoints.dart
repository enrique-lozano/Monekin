import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/responsive/app_breakpoints.dart';

enum BreakpointID { xs, sm, md, lg, xl, xxl }

class BreakPoint extends Equatable {
  final BreakpointID id;

  /// Body maximum width
  final double width;

  const BreakPoint(this.id, {required this.width});

  /// Get the current BreakPoint based on the device width
  static BreakPoint of(BuildContext context, {Set<BreakPoint>? breakpoints}) {
    breakpoints ??= appBreakPoints;

    final width = MediaQuery.of(context).size.width;

    for (int i = breakpoints.length - 1; i >= 0; i--) {
      final breakpoint = breakpoints.elementAt(i);
      if (breakpoint.width <= width) return breakpoint;
    }

    return breakpoints.first;
  }

  static getById(BreakpointID id) {
    return appBreakPoints.firstWhere((element) => element.id == id);
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
