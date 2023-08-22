import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:monekin/core/database/app_db.dart';

enum UINumberFormatterMode { currency, percentage, decimal }

class UINumberFormatter {
  const UINumberFormatter.decimal(
      {required this.amountToConvert,
      this.showDecimals = true,
      this.textStyle = const TextStyle(inherit: true),
      this.decimalsStyle})
      : mode = UINumberFormatterMode.decimal,
        currency = null;

  const UINumberFormatter.percentage(
      {required this.amountToConvert,
      this.showDecimals = true,
      this.textStyle = const TextStyle(inherit: true),
      this.decimalsStyle})
      : mode = UINumberFormatterMode.percentage,
        currency = null;

  const UINumberFormatter.currency(
      {required this.amountToConvert,
      required this.currency,
      this.showDecimals = true,
      this.textStyle = const TextStyle(inherit: true),
      this.decimalsStyle})
      : mode = UINumberFormatterMode.currency;

  final double amountToConvert;

  /// The currency of the amount, used to display the symbol.
  final CurrencyInDB? currency;

  final TextStyle textStyle;
  final TextStyle? decimalsStyle;

  final bool showDecimals;

  final UINumberFormatterMode mode;

  List<TextSpan> getTextSpanList(BuildContext context) {
    final String decimalSep =
        numberFormatSymbols[Intl.defaultLocale]?.DECIMAL_SEP;

    final valueFontSize =
        (textStyle.fontSize ?? DefaultTextStyle.of(context).style.fontSize) ??
            16;

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
      TextSpan(text: parts[0], style: textStyle),
      if (showDecimals && parts.length > 1)
        TextSpan(text: decimalSep, style: textStyle),
      if (showDecimals && parts.length > 1)
        TextSpan(
            text: parts[1],
            style: decimalsStyle ??
                textStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: max(valueFontSize * 0.75, 14),
                ))
    ];
  }

  Text getTextWidget(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: textStyle,
        children: getTextSpanList(context),
      ),
    );
  }
}
