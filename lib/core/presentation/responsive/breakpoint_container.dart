import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';

enum _BreakpointSlot { xs, sm, md, lg, xl, xxl }

/// Picks a builder based on the current [BreakPoint]. Rebuilds only when the
/// breakpoint changes (see [BreakpointProvider]).
class BreakpointContainer extends StatelessWidget {
  /// XS and up builder
  final WidgetBuilder builder;

  /// SM and up builder. If null will use [builder]
  final WidgetBuilder? smBuilder;

  /// MD and up builder. If null will use smaller breakpoint's builder
  final WidgetBuilder? mdBuilder;

  /// LG and up builder. If null will use smaller breakpoint's builder
  final WidgetBuilder? lgBuilder;

  /// XL and up builder. If null will use smaller breakpoint's builder
  final WidgetBuilder? xlBuilder;

  /// XXL and up builder. If null will use smaller breakpoint's builder
  final WidgetBuilder? xxlBuilder;

  const BreakpointContainer({
    super.key,
    required this.builder,
    this.smBuilder,
    this.mdBuilder,
    this.lgBuilder,
    this.xlBuilder,
    this.xxlBuilder,
  });

  (WidgetBuilder, _BreakpointSlot) _resolveBuilder(BreakPoint breakpoint) {
    if (xxlBuilder != null &&
        breakpoint >= BreakPoint.getById(BreakpointID.xxl)) {
      return (xxlBuilder!, _BreakpointSlot.xxl);
    }
    if (xlBuilder != null &&
        breakpoint >= BreakPoint.getById(BreakpointID.xl)) {
      return (xlBuilder!, _BreakpointSlot.xl);
    }
    if (lgBuilder != null &&
        breakpoint >= BreakPoint.getById(BreakpointID.lg)) {
      return (lgBuilder!, _BreakpointSlot.lg);
    }
    if (mdBuilder != null &&
        breakpoint >= BreakPoint.getById(BreakpointID.md)) {
      return (mdBuilder!, _BreakpointSlot.md);
    }
    if (smBuilder != null &&
        breakpoint >= BreakPoint.getById(BreakpointID.sm)) {
      return (smBuilder!, _BreakpointSlot.sm);
    }

    return (builder, _BreakpointSlot.xs);
  }

  @override
  Widget build(BuildContext context) {
    final (selectedBuilder, slot) = _resolveBuilder(BreakPoint.of(context));

    // Keyed by slot so crossing a breakpoint tears down the old subtree
    // instead of reusing its State (and any streams it captured) in the new
    // one. The builder runs only for the active slot, always fresh.
    return KeyedSubtree(key: ValueKey(slot), child: selectedBuilder(context));
  }
}
