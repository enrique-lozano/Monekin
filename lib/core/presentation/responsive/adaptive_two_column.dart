import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';

/// Lays out [first] and [second] side-by-side (each flexed) when the available
/// width is at least [breakpoint]; otherwise stacks them vertically.
///
/// Reacts to the *available* width (via [LayoutBuilder]), not the screen size,
/// so it adapts to the space the widget actually has (e.g. inside a card, a
/// split pane or a drawer). It only picks the direction from the available
/// width — the actual row/column rendering is delegated to [ResponsiveRowColumn].
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
        final isRow = constraints.maxWidth >= breakpoint;

        return ResponsiveRowColumn(
          direction: isRow ? Axis.horizontal : Axis.vertical,
          rowCrossAxisAlignment: rowCrossAxisAlignment,
          columnCrossAxisAlignment: CrossAxisAlignment.stretch,
          rowSpacing: spacing,
          columnSpacing: spacing,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: firstFlex,
              rowFit: FlexFit.tight,
              child: first,
            ),
            ResponsiveRowColumnItem(
              rowFlex: secondFlex,
              rowFit: FlexFit.tight,
              child: second,
            ),
          ],
        );
      },
    );
  }
}
