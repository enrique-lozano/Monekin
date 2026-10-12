import 'package:flutter/material.dart';

/// Faint circle that shades the innermost part of a donut chart ring.
///
/// Stack it right above the chart (and below any content painted in the hole).
/// Its diameter is derived from [centerSpaceRadius] so it always bleeds a
/// little into the ring.
class PieChartCenterShade extends StatelessWidget {
  const PieChartCenterShade({super.key, required this.centerSpaceRadius});

  final double centerSpaceRadius;

  @override
  Widget build(BuildContext context) {
    final diameter = centerSpaceRadius * 2.25;

    return IgnorePointer(
      child: Center(
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
          ),
        ),
      ),
    );
  }
}
