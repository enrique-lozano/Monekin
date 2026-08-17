import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';

import '../app_colors.dart';

enum TrendingValueDataType {
  /// Renders [TrendingValue.percentage] as a `%`.
  percentage,

  /// Renders [TrendingValue.value] as a plain decimal (or as money if
  /// [TrendingValue.valueCurrency] is set).
  value,
}

enum TrendingValueStyle {
  /// Icon and values inline, without a tinted background.
  plain,

  /// Pill-shaped chip with a semi-transparent tint of the trend color.
  chip,
}

class TrendingValue extends StatelessWidget {
  const TrendingValue({
    super.key,
    this.percentage,
    this.value,
    this.valueCurrency,
    this.dataTypes = const [TrendingValueDataType.percentage],
    this.separator = ' · ',
    this.decimalDigits = 2,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.showValueDecimals = false,
    this.showPercentageDecimals = true,
    this.compactValue = false,
    this.style = TrendingValueStyle.plain,
    this.inverse = false,
    this.markNanAsZero = true,
    this.afterText,
    this.padding,
  });

  /// The trend as a fraction, e.g. `0.12` for +12%. Only rendered if
  /// [dataTypes] contains [TrendingValueDataType.percentage], but it is also
  /// the default source used to pick the arrow direction and color (see
  /// [dataTypes]). Treated as `0` when null.
  final double? percentage;

  /// The raw amount of the change (not a fraction), e.g. the money
  /// difference between two periods. Only rendered if [dataTypes] contains
  /// [TrendingValueDataType.value]. Always displayed as an absolute value:
  /// the sign is already conveyed by the arrow icon and color. Treated as
  /// `0` when null.
  final double? value;

  /// Currency used to format [value] as money. If null, [value] is
  /// rendered as a plain decimal number instead.
  final CurrencyInDB? valueCurrency;

  /// Which piece(s) of data to render, and in which order. If it contains
  /// [TrendingValueDataType.percentage], [percentage] (not [value]) is used
  /// to decide the arrow direction and color, regardless of position in the
  /// list. An empty list falls back to `[TrendingValueDataType.percentage]`.
  final List<TrendingValueDataType> dataTypes;

  /// Text painted between entries when [dataTypes] has more than one item.
  /// Ignored when only one data type is shown.
  final String separator;

  /// How many decimals [value] is shown with when [showValueDecimals] is set
  /// and no [valueCurrency] is given (money always follows the currency's own
  /// precision). Useful for figures that need more precision than money, such
  /// as an exchange rate.
  final int decimalDigits;

  final double fontSize;
  final FontWeight fontWeight;

  /// Whether [value] is shown with decimals. Defaults to `false` (rounded).
  final bool showValueDecimals;

  /// Whether [percentage] is shown with decimals. Defaults to `true`,
  /// unlike [showValueDecimals].
  final bool showPercentageDecimals;

  /// Whether [value] is abbreviated (e.g. `1.2K`) once it is large enough.
  /// Only applies to the [TrendingValueDataType.value] entry.
  final bool compactValue;

  /// Visual presentation of the trend indicator.
  final TrendingValueStyle style;

  /// Whether a positive trend should be treated as a bad thing (and painted
  /// as such) and vice versa. Useful for metrics where "less is better",
  /// e.g. expenses: a drop in spending is a good trend and should be green.
  final bool inverse;

  /// Whether a `NaN` trend source (e.g. the previous period was 0, making
  /// the percentage undefined) is treated as `0` — i.e. a neutral trend,
  /// painted in the neutral brand color with a "–" icon — instead of
  /// propagating the `NaN` (which would otherwise render as `NaN%` and fall
  /// back to a neutral-looking icon too, since `NaN` comparisons are always
  /// `false`). Defaults to `true`.
  final bool markNanAsZero;

  /// Optional trailing label rendered right after the value(s), e.g.
  /// `vs previous`. Inherits the trend color (dimmed).
  final String? afterText;

  /// Padding around the content. If null, defaults to a small inline
  /// padding, or a larger pill-shaped padding when [style] is
  /// [TrendingValueStyle.chip] (see `build()`).
  final EdgeInsets? padding;

  List<TrendingValueDataType> get _effectiveDataTypes =>
      dataTypes.isEmpty ? const [TrendingValueDataType.percentage] : dataTypes;

  double _trendSourceValue() {
    if (_effectiveDataTypes.contains(TrendingValueDataType.percentage)) {
      return percentage ?? 0;
    }

    return value ?? 0;
  }

  /// The raw (non-inverted) trend, used to pick the arrow direction: it
  /// should always reflect the real direction of the change.
  double _rawTrend() {
    final raw = _trendSourceValue();
    return raw.isNaN ? (markNanAsZero ? 0 : raw) : raw;
  }

  /// The trend used to pick the color, taking [inverse] into account.
  double _signedTrend() {
    final raw = _rawTrend();
    return inverse ? -raw : raw;
  }

  double _displayPercentage() {
    final raw = percentage ?? 0;
    if (raw.isNaN) return markNanAsZero ? 0 : raw;

    // The sign is already conveyed by the arrow icon and the color, so it
    // would be redundant (and visually noisy) to also show it here.
    return raw.abs();
  }

  Color _getColorBasedOnPercentage(BuildContext context) {
    final trend = _signedTrend();

    if (trend == 0 || trend.isNaN) {
      return AppColors.of(context).brand
          .lighten(isAppInDarkBrightness(context) ? 0.45 : 0.25)
          .withBlue(225);
    }

    return trend > 0
        ? AppColors.of(context).success
        : AppColors.of(context).danger;
  }

  Widget _paintTrendValue(BuildContext context, Color textColor) {
    final toDisplay = _rawTrend();
    final iconSize = fontSize * (11 / 7);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          toDisplay > 0
              ? Icons.arrow_drop_up_rounded
              : toDisplay < 0
              ? Icons.arrow_drop_down_rounded
              : Icons.remove_rounded,
          size: iconSize,
          color: textColor,
        ),
        for (var i = 0; i < _effectiveDataTypes.length; i++) ...[
          if (i > 0)
            Text(
              separator,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
            ),
          if (_effectiveDataTypes[i] == TrendingValueDataType.value)
            Builder(
              builder: (context) {
                final valueToDisplay = value?.abs() ?? 0;

                if (valueCurrency != null) {
                  return CurrencyDisplayer(
                    amountToConvert: valueToDisplay,
                    currency: valueCurrency,
                    compactView: compactValue,
                    showDecimals: showValueDecimals,
                    integerStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                    currencyStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                  );
                }

                return UINumberFormatter.decimal(
                  amountToConvert: valueToDisplay,
                  compactView: compactValue,
                  showDecimals: showValueDecimals,
                  decimalDigits: decimalDigits,
                  integerStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor,
                  ),
                ).getTextWidget(context);
              },
            ),
          if (_effectiveDataTypes[i] == TrendingValueDataType.percentage)
            UINumberFormatter.percentage(
              amountToConvert: _displayPercentage(),
              showDecimals: showPercentageDecimals,
              integerStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
            ).getTextWidget(context),
        ],
        if (afterText != null) ...[
          SizedBox(width: fontSize * 0.3),
          Text(
            afterText!,
            style: TextStyle(
              fontSize: fontSize * 0.85,
              fontWeight: FontWeight.w600,
              color: textColor.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final trendColor = _getColorBasedOnPercentage(context);
    final isChip = style == TrendingValueStyle.chip;

    return Container(
      padding:
          padding ??
          (isChip
              ? const EdgeInsets.fromLTRB(4, 4, 10, 4)
              : const EdgeInsets.symmetric(horizontal: 6, vertical: 1)),
      decoration: isChip
          ? BoxDecoration(
              color: trendColor.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(9999),
            )
          : null,
      child: _paintTrendValue(context, trendColor),
    );
  }
}
