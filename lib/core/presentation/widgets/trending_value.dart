import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';

import '../app_colors.dart';

class TrendingValue extends StatelessWidget {
  const TrendingValue({
    super.key,
    required this.percentage,
    this.decimalDigits = 2,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.filled = false,
    this.outlined = false,
    this.markNanAsZero = true,
  });

  final double percentage;
  final int decimalDigits;
  final double fontSize;
  final FontWeight fontWeight;
  final bool filled, outlined, markNanAsZero;

  Widget paintTrendValue(BuildContext context) {
    final textColor = _getColorBasedOnPercentage(
      context,
    ).lighten(filled && !outlined ? 0.85 : 0);

    double toDisplay = percentage;

    if (toDisplay.isNaN && markNanAsZero) {
      toDisplay = 0;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (toDisplay != 0)
          Icon(
            toDisplay > 0
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            size: fontSize * (9 / 7),
            color: textColor,
          ),
        if (toDisplay == 0)
          Text(
            '=',
            style: TextStyle(
              height: 1,
              fontWeight: FontWeight.bold,
              fontSize: fontSize * (9 / 7),
              color: textColor,
            ),
          ),
        const SizedBox(width: 6),
        UINumberFormatter.percentage(
          amountToConvert: toDisplay,
          integerStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ).getTextWidget(context),
      ],
    );
  }

  Color _getColorBasedOnPercentage(BuildContext context) {
    return (percentage == 0 || percentage.isNaN)
        ? AppColors.of(context).brand
              .lighten(
                filled
                    ? 0
                    : isAppInDarkBrightness(context)
                    ? 0.45
                    : 0.25,
              )
              .withBlue(225)
        : percentage > 0
        ? AppColors.of(context).success
        : AppColors.of(context).danger;
  }

  @override
  Widget build(BuildContext context) {
    final trendColor = _getColorBasedOnPercentage(context);
    final textColor = _getColorBasedOnPercentage(
      context,
    ).lighten(filled && !outlined ? 0.85 : 0);
    final backgroundColor = filled && outlined
        ? trendColor.lighten(0.85).withOpacity(0.95)
        : filled
        ? trendColor
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9999),
        border: outlined ? Border.all(color: textColor, width: 1) : null,
      ),
      child: paintTrendValue(context),
    );
  }
}
