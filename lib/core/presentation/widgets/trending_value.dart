import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';

import '../app_colors.dart';

class TrendingValue extends StatelessWidget {
  const TrendingValue(
      {super.key,
      required this.percentage,
      this.decimalDigits = 2,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.filled = false,
      this.outlined = false});

  final double percentage;
  final int decimalDigits;

  final double fontSize;

  final FontWeight fontWeight;

  final bool filled, outlined;

  Widget paintTrendValue(BuildContext context) {
    final textColor =
        _getColorBasedOnPercentage(context).lighten(filled ? 0.85 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (percentage != 0)
          Icon(
            percentage > 0
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            size: fontSize * (9 / 7),
            color: textColor,
          ),
        if (percentage == 0)
          Text(
            '=',
            style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w700,
              fontSize: fontSize * (9 / 7),
              color: textColor,
            ),
          ),
        const SizedBox(width: 6),
        UINumberFormatter.percentage(
          amountToConvert: percentage,
          integerStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ).getTextWidget(context)
      ],
    );
  }

  Color _getColorBasedOnPercentage(BuildContext context) {
    return percentage == 0
        ? AppColors.of(context)
            .brand
            .lighten(isAppInDarkBrightness(context) ? 0.45 : 0.25)
            .withBlue(225)
        : percentage > 0
            ? AppColors.of(context).success
            : AppColors.of(context).danger;
  }

  @override
  Widget build(BuildContext context) {
    if (filled) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: !filled ? null : (_getColorBasedOnPercentage(context)),
          borderRadius: BorderRadius.circular(9999),
          border: outlined
              ? Border.all(
                  color: _getColorBasedOnPercentage(context).lighten(0.85),
                  width: 1)
              : null,
        ),
        child: paintTrendValue(context),
      );
    } else {
      return paintTrendValue(context);
    }
  }
}
