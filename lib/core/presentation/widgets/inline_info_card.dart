import 'package:flutter/material.dart';
import 'package:parsa/core/presentation/responsive/responsive_row_column.dart';

import '../app_colors.dart';

enum InlineInfoCardMode { warn, info }

class InlineInfoCard extends StatelessWidget {
  const InlineInfoCard({
    super.key,
    required this.text,
    required this.mode,
    this.direction = Axis.horizontal,
    this.margin = const EdgeInsets.all(0),
  });

  final String text;
  final EdgeInsets margin;

  final InlineInfoCardMode mode;

  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final Color color = mode == InlineInfoCardMode.info
        ? AppColors.of(context).primary
        : Colors.amber;

    return Card(
      // color: color.withOpacity(0.1),
      elevation: 1,
      margin: margin,
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
              style: const TextStyle(
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
