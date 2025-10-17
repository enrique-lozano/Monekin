import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/theme.dart';

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
    final isDarkBrightness = isAppInDarkBrightness(context);

    final Color bgColor = mode == InlineInfoCardMode.warn
        ? Colors.amber.darken(isDarkBrightness ? 0.6 : -0.7)
        : Theme.of(context).colorScheme.primaryContainer;
    final Color iconColor = mode == InlineInfoCardMode.warn
        ? Colors.amber.lighten(isDarkBrightness ? 0.5 : -0.4)
        : Theme.of(context).colorScheme.onPrimaryContainer;

    //   final iconColor = baseColor.lighten(isDarkBrightness ? 0.5 : -0.4);

    return Card(
      color: bgColor,
      elevation: 0,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 2, color: iconColor),
      ),
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
              color: iconColor,
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
              style: TextStyle(fontSize: 12.25, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
