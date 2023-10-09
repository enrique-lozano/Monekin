import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          percentage >= 0 ? Icons.trending_up : Icons.trending_down,
          size: fontSize * (9 / 7),
          color: _getColorBasedOnPercentage(context),
        ),
        const SizedBox(width: 6),
        UINumberFormatter.percentage(
          amountToConvert: percentage,
          textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: _getColorBasedOnPercentage(context)),
        ).getTextWidget(context)
      ],
    );
  }

  Color _getColorBasedOnPercentage(BuildContext context) {
    return percentage >= 0
        ? CustomColors.of(context).success
        : CustomColors.of(context).danger;
  }

  @override
  Widget build(BuildContext context) {
    if (filled || outlined) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: !filled
              ? null
              : (percentage >= 0
                  ? const Color.fromARGB(255, 220, 255, 220)
                  : const Color.fromARGB(255, 255, 220, 220)),
          borderRadius: BorderRadius.circular(fontSize / 3.5),
          border: outlined
              ? Border.all(color: _getColorBasedOnPercentage(context), width: 1)
              : null,
        ),
        child: paintTrendValue(context),
      );
    } else {
      return paintTrendValue(context);
    }
  }
}
