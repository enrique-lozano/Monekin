import 'package:flutter/material.dart';

/// Lays out a stats tab's cards in a single column, or in two balanced columns
/// (a light masonry) once there's enough horizontal room — which typically
/// happens on large screens with the filter pane collapsed.
class StatsCardsLayout extends StatelessWidget {
  const StatsCardsLayout({
    super.key,
    required this.cards,
    this.twoColumnBreakpoint = 1140,
    this.spacing = 16,
  });

  final List<Widget> cards;

  /// Minimum available width at which the cards split into two columns.
  final double twoColumnBreakpoint;

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (cards.length < 2 || constraints.maxWidth < twoColumnBreakpoint) {
          return _column(cards);
        }

        final left = <Widget>[];
        final right = <Widget>[];
        for (var i = 0; i < cards.length; i++) {
          (i.isEven ? left : right).add(cards[i]);
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _column(left)),
            SizedBox(width: spacing),
            Expanded(child: _column(right)),
          ],
        );
      },
    );
  }

  Widget _column(List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: items,
    );
  }
}
