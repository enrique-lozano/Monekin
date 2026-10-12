import 'package:flutter/material.dart';

/// Two-column row where [info] sets the height and [chart] fills it.
///
/// Uses a [Stack] instead of [IntrinsicHeight] because chart, skeleton, and
/// chip widgets rely on [LayoutBuilder] and break intrinsic sizing.
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
