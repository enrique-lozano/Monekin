import 'package:flutter/material.dart';

/// Lays out [first] and [second] side-by-side (each in an [Expanded]) when the
/// available width is at least [breakpoint]; otherwise stacks them vertically.
///
/// Reacts to the *available* width (via [LayoutBuilder]), not the screen size,
/// so it adapts to the space the widget actually has (e.g. inside a card, a
/// split pane or a drawer).
class AdaptiveTwoColumn extends StatelessWidget {
  const AdaptiveTwoColumn({
    super.key,
    required this.first,
    required this.second,
    this.breakpoint = 560,
    this.spacing = 16,
    this.firstFlex = 1,
    this.secondFlex = 1,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
  });

  final Widget first;
  final Widget second;

  /// Minimum available width needed to switch to a two-column row.
  final double breakpoint;
  final double spacing;
  final int firstFlex;
  final int secondFlex;
  final CrossAxisAlignment rowCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              first,
              SizedBox(height: spacing),
              second,
            ],
          );
        }

        return Row(
          crossAxisAlignment: rowCrossAxisAlignment,
          children: [
            Expanded(flex: firstFlex, child: first),
            SizedBox(width: spacing),
            Expanded(flex: secondFlex, child: second),
          ],
        );
      },
    );
  }
}
