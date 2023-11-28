import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';

enum InlineInfoCardMode { warn, info }

class InlineInfoCard extends StatelessWidget {
  const InlineInfoCard(
      {super.key,
      required this.text,
      required this.mode,
      this.direction = Axis.horizontal});

  final String text;

  final InlineInfoCardMode mode;

  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final Color color = mode == InlineInfoCardMode.info
        ? Theme.of(context).colorScheme.primary
        : Colors.amber;

    return Card(
      // color: color.withOpacity(0.1),
      elevation: 1,
      margin: const EdgeInsets.all(0),
      child: ResponsiveRowColumn.withSymetricSpacing(
        spacing: 10,
        padding: const EdgeInsets.all(8),
        direction: direction,
        children: [
          ResponsiveRowColumnItem(
            child: Icon(
              mode == InlineInfoCardMode.info
                  ? Icons.info_rounded
                  : Icons.warning_rounded,
              color: color,
              size: 28,
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Text(
              text,
              textAlign: direction == Axis.vertical
                  ? TextAlign.center
                  : TextAlign.left,
              style: TextStyle(
                fontSize: 12.25,
                fontWeight: FontWeight.w400,
                //color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
