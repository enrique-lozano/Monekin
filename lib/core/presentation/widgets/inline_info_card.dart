import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';

abstract class InlineInfoCardMode {
  const InlineInfoCardMode();

  Color resolveBgColor(BuildContext context);
  Color resolveIconColor(BuildContext context);
  IconData get icon;

  static const InlineInfoCardMode warn = _WarnInlineInfoCardMode();
  static const InlineInfoCardMode info = _InfoInlineInfoCardMode();

  /// Creates a fully custom mode with explicit colors and icon.
  factory InlineInfoCardMode.custom({
    required Color bgColor,
    required Color iconColor,
    IconData icon,
  }) = _CustomInlineInfoCardMode;
}

class _WarnInlineInfoCardMode extends InlineInfoCardMode {
  const _WarnInlineInfoCardMode();

  @override
  Color resolveBgColor(BuildContext context) {
    final isDark = isAppInDarkBrightness(context);
    return Colors.amber.darken(isDark ? 0.6 : -0.7);
  }

  @override
  Color resolveIconColor(BuildContext context) {
    final isDark = isAppInDarkBrightness(context);
    return Colors.amber.lighten(isDark ? 0.5 : -0.4);
  }

  @override
  IconData get icon => Icons.warning_rounded;
}

class _InfoInlineInfoCardMode extends InlineInfoCardMode {
  const _InfoInlineInfoCardMode();

  @override
  Color resolveBgColor(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;

  @override
  Color resolveIconColor(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryContainer;

  @override
  IconData get icon => Icons.info_rounded;
}

class _CustomInlineInfoCardMode extends InlineInfoCardMode {
  const _CustomInlineInfoCardMode({
    required this.bgColor,
    required this.iconColor,
    this.icon = Icons.info_rounded,
  });

  final Color bgColor;
  final Color iconColor;

  @override
  Color resolveBgColor(BuildContext context) => bgColor;

  @override
  Color resolveIconColor(BuildContext context) => iconColor;

  @override
  final IconData icon;
}

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
    final bgColor = mode.resolveBgColor(context);
    final iconColor = mode.resolveIconColor(context);

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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        direction: direction,
        children: [
          ResponsiveRowColumnItem(
            child: Icon(mode.icon, color: iconColor, size: 28),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: HTMLText(
              htmlString: text,
              textAlign: direction == Axis.vertical
                  ? TextAlign.center
                  : TextAlign.left,
              tags: {"b": TextStyle(fontWeight: FontWeight.bold)},
              defaultTextStyle: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
