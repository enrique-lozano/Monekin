import 'package:flutter/material.dart';
import 'package:parsa/core/presentation/responsive/breakpoints.dart';

class BreakpointContainer extends StatelessWidget {
  /// XS and up child widget
  final Widget child;

  /// SM and up child widget. If null will use child
  final Widget? smChild;

  /// MD and up child widget. If null will use smaller breakpoint child
  final Widget? mdChild;

  /// LG and up child widget. If null will use smaller breakpoint child
  final Widget? lgChild;

  /// XL and up child widget. If null will use smaller breakpoint child
  final Widget? xlChild;

  /// XXL and up child widget. If null will use smaller breakpoint child
  final Widget? xxlChild;

  const BreakpointContainer({
    super.key,
    required this.child,
    this.smChild,
    this.mdChild,
    this.lgChild,
    this.xlChild,
    this.xxlChild,
  });

  Widget getChild(BreakPoint breakpoint) {
    if (xxlChild != null &&
        breakpoint >= BreakPoint.getById(BreakpointID.xxl)) {
      return xxlChild!;
    }
    if (xlChild != null && breakpoint >= BreakPoint.getById(BreakpointID.xl)) {
      return xlChild!;
    }
    if (lgChild != null && breakpoint >= BreakPoint.getById(BreakpointID.lg)) {
      return lgChild!;
    }
    if (mdChild != null && breakpoint >= BreakPoint.getById(BreakpointID.md)) {
      return mdChild!;
    }
    if (smChild != null && breakpoint >= BreakPoint.getById(BreakpointID.sm)) {
      return smChild!;
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    return getChild(BreakPoint.of(context));
  }
}
