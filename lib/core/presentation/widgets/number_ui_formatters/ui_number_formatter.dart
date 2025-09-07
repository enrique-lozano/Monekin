import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:monekin/core/database/app_db.dart';

enum UINumberFormatterMode { currency, percentage, decimal }

class UINumberFormatter {
  const UINumberFormatter.decimal({
    required this.amountToConvert,
    this.showDecimals = true,
    this.integerStyle = const TextStyle(inherit: true),
    this.decimalsStyle,
  })  : mode = UINumberFormatterMode.decimal,
        currency = null,
        currencyStyle = null;

  const UINumberFormatter.percentage({
    required this.amountToConvert,
    this.showDecimals = true,
    this.integerStyle = const TextStyle(inherit: true),
    this.decimalsStyle,
  })  : mode = UINumberFormatterMode.percentage,
        currency = null,
        currencyStyle = null;

  const UINumberFormatter.currency({
    required this.amountToConvert,
    required this.currency,
    this.showDecimals = true,
    this.integerStyle = const TextStyle(inherit: true),
    this.decimalsStyle,
    this.currencyStyle,
  }) : mode = UINumberFormatterMode.currency;

  /// The amount/number to display
  final double amountToConvert;

  /// The currency of the amount, used to display the currency symbol.
  /// Only defined and used if the `UINumberFormatterMode` of
  /// this Widget is set to `currency`.
  final CurrencyInDB? currency;

  /// Style of the text that corresponds to the integer part of the number to be displayed
  final TextStyle integerStyle;

  /// Style of the text that corresponds to the integer part of the number to be displayed.
  /// If not defined, we will try to use a less prominent style than the one used in the integer
  /// part of the number
  final TextStyle? decimalsStyle;

  /// Style of the text that corresponds to the currency symbol. By default will be
  /// the same as the `integerStyle`. This property is only defined and
  /// used if the `UINumberFormatterMode` of this Widget is set to `currency`.
  final TextStyle? currencyStyle;

  final bool showDecimals;

  final UINumberFormatterMode mode;

  List<TextSpan> getTextSpanList(BuildContext context) {
    final String decimalSep =
        numberFormatSymbols[Intl.defaultLocale]?.DECIMAL_SEP ?? '.';

    final valueFontSize = (integerStyle.fontSize ??
            DefaultTextStyle.of(context).style.fontSize) ??
        16;

    final computedDecimalStyles = decimalsStyle ??
        integerStyle.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: valueFontSize > 12.25
              ? max(valueFontSize * 0.75, 12.25)
              : valueFontSize,
        );

    List<String> parts = [];

    if (mode == UINumberFormatterMode.currency) {
      // Remove the decimal separator from the symbol, otherwise the parts won't be splitted correctly
      final String symbolWithoutDecSep =
          currency!.symbol.replaceAll(decimalSep, '');

      final String formattedAmount = NumberFormat.currency(
              decimalDigits: showDecimals ? 2 : 0, symbol: symbolWithoutDecSep)
          .format(amountToConvert);

      // Get the decimal and the integer part, and restore the original symbol
      parts = formattedAmount
          .split(decimalSep)
          .map((e) => e.replaceAll(symbolWithoutDecSep, currency!.symbol))
          .toList();
    } else if (mode == UINumberFormatterMode.percentage) {
      final String formattedAmount = NumberFormat.decimalPercentPattern(
              decimalDigits: showDecimals ? 2 : 0)
          .format(amountToConvert);

      parts = formattedAmount.split(decimalSep).toList();
    } else if (mode == UINumberFormatterMode.decimal) {
      final String formattedAmount =
          NumberFormat.decimalPatternDigits(decimalDigits: showDecimals ? 2 : 0)
              .format(amountToConvert);

      parts = formattedAmount.split(decimalSep).toList();
    }

    return [
      // Currency symbol (if is before the amount):
      if (mode == UINumberFormatterMode.currency &&
          parts[0].contains(currency!.symbol))
        TextSpan(
          text: currency!.symbol,
          style: currencyStyle ?? integerStyle,
        ),

      // Integer part (without the symbol in currency mode):
      TextSpan(
          text: parts[0].replaceAll(currency?.symbol ?? '', ''),
          style: integerStyle),

      // Decimal separator:
      if (showDecimals && parts.length > 1)
        TextSpan(text: decimalSep, style: integerStyle),

      // Decimal part (without the symbol in currency mode):
      if (showDecimals && parts.length > 1)
        TextSpan(
          text: parts[1].replaceAll(currency?.symbol ?? '', ''),
          style: computedDecimalStyles,
        ),

      // Currency symbol (if is after the amount):
      if (showDecimals &&
          parts.length > 1 &&
          mode == UINumberFormatterMode.currency &&
          parts[1].contains(currency!.symbol))
        TextSpan(
          text: currency!.symbol,
          style: currencyStyle ?? integerStyle,
        ),
    ];
  }

  Text getTextWidget(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: integerStyle,
        children: getTextSpanList(context),
      ),
    );
  }
}
