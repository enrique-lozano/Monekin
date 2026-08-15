import 'package:flutter/material.dart';

/// A two-column desktop layout where [info] (left) drives the row height from
/// its own content, and [chart] (right) is stretched to that exact same height.
///
/// It is implemented with a [Stack] + [Positioned] rather than [IntrinsicHeight]
/// on purpose: the chart side (and, on the info side, the skeleton `Bone`s and
/// the date-range chips) rely on widgets that use a [LayoutBuilder] internally
/// (`fl_chart`, `skeletonizer`, `DateRangeChips`). Those do not support the
/// intrinsic-sizing protocol and would throw under [IntrinsicHeight]. Here
/// everything is measured through normal layout: [info] is the only
/// size-determining (non-positioned) child, and [chart] is a positioned child
/// that simply fills the resulting height.
class EqualHeightChartRow extends StatelessWidget {
  const EqualHeightChartRow({
    super.key,
    required this.info,
    required this.chart,
    this.infoFraction = 0.44,
    this.gap = 16,
    this.trailingInset = 16,
    this.minHeight = 260,
  });

  /// Left column. Its natural height (clamped to at least [minHeight]) sets the
  /// height both columns share.
  final Widget info;

  /// Right column, stretched to match [info]'s height.
  final Widget chart;

  /// Fraction of the available width taken by [info].
  final double infoFraction;

  /// Horizontal space between the two columns.
  final double gap;

  /// Inset kept between [chart] and the trailing edge.
  final double trailingInset;

  /// Lower bound for the shared height, so a short [info] column doesn't squash
  /// the chart down to nothing.
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final infoWidth = totalWidth * infoFraction;

        return Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: SizedBox(width: infoWidth, child: info),
            ),
            Positioned(
              left: infoWidth + gap,
              right: trailingInset,
              top: 0,
              bottom: 0,
              child: chart,
            ),
          ],
        );
      },
    );
  }
}
