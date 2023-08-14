import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:monekin/core/database/app_db.dart';

enum UINumberFormatterMode { currency, percentage, decimal }

class UINumberFormatter {
  const UINumberFormatter(this.mode,
      {required this.amountToConvert,
      this.currency,
      this.showDecimals = true,
      this.textStyle = const TextStyle(inherit: true)});

  final double amountToConvert;

  /// The currency of the amount, used to display the symbol.
  final CurrencyInDB? currency;

  final TextStyle textStyle;

  final bool showDecimals;

  final UINumberFormatterMode mode;

  List<TextSpan> getTextSpanList() {
    final String decimalSep =
        numberFormatSymbols[Intl.defaultLocale]?.DECIMAL_SEP;
    final valueFontSize = textStyle.fontSize ?? 16;

    List<String> parts = [];

    if (mode == UINumberFormatterMode.currency) {
      if (currency == null) {
        throw Exception('A currency should be specified');
      }

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
            style: textStyle.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: max(valueFontSize * 0.75, 14),
            ))
    ];
  }

  Text getTextWidget() {
    return Text.rich(
      TextSpan(
        style: textStyle,
        children: getTextSpanList(),
      ),
    );
  }
}
