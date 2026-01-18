import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/decimal_separator.dart';

enum UINumberFormatterMode { currency, percentage, decimal }

class UINumberFormatter {
  const UINumberFormatter.decimal({
    required this.amountToConvert,
    this.showDecimals = true,
    this.compactView = false,
    this.integerStyle = const TextStyle(inherit: true),
    this.decimalsStyle,
  }) : mode = UINumberFormatterMode.decimal,
       currency = null,
       currencyStyle = null;

  const UINumberFormatter.percentage({
    required this.amountToConvert,
    this.showDecimals = true,
    this.integerStyle = const TextStyle(inherit: true),
    this.decimalsStyle,
  }) : mode = UINumberFormatterMode.percentage,
       currency = null,
       currencyStyle = null,
       compactView = false;

  const UINumberFormatter.currency({
    required this.amountToConvert,
    required this.currency,
    this.showDecimals = true,
    this.compactView = false,
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
  final bool compactView;

  final UINumberFormatterMode mode;

  int get _compactLimit => 1000;
  int get _fractionsDigits => amountToConvert >= 10000000
      ? 3
      : amountToConvert >= 100000
      ? 2
      : 1;

  bool get _shouldCompact =>
      compactView == true && amountToConvert.abs() >= _compactLimit;

  String get _currencySymbolWithoutDecimalSep =>
      currency!.symbol.replaceAll(currentDecimalSep, '');

  String getFormattedAmount() {
    String formattedAmount;

    switch (mode) {
      case UINumberFormatterMode.currency:
        formattedAmount = _getFormattedCurrencyAmount(currentDecimalSep);
        break;
      case UINumberFormatterMode.percentage:
        formattedAmount = NumberFormat.decimalPercentPattern(
          decimalDigits: showDecimals ? 2 : 0,
        ).format(amountToConvert);
        break;
      case UINumberFormatterMode.decimal:
        formattedAmount = _getFormattedDecimalAmount();
        break;
    }

    return formattedAmount;
  }

  String _getFormattedCurrencyAmount(String decimalSep) {
    if (_shouldCompact) {
      final formatter = NumberFormat.compactCurrency(
        decimalDigits: 3,
        symbol: _currencySymbolWithoutDecimalSep,
      );
      formatter.minimumFractionDigits = _fractionsDigits;
      formatter.maximumFractionDigits = _fractionsDigits;

      return formatter.format(amountToConvert);
    } else {
      final forceHideAllDecimals =
          appStateSettings[SettingKey.showAllDecimals] != '1' &&
          amountToConvert % 1 == 0;

      return NumberFormat.currency(
        decimalDigits: showDecimals && !forceHideAllDecimals
            ? currency?.decimalPlaces
            : 0,
        symbol: _currencySymbolWithoutDecimalSep,
      ).format(amountToConvert);
    }
  }

  String _getFormattedDecimalAmount() {
    if (_shouldCompact) {
      final formatter = NumberFormat.compact();
      formatter.minimumFractionDigits = _fractionsDigits;
      formatter.maximumFractionDigits = _fractionsDigits;
      return formatter.format(amountToConvert);
    } else {
      return NumberFormat.decimalPatternDigits(
        decimalDigits: showDecimals ? 2 : 0,
      ).format(amountToConvert);
    }
  }

  List<String> _splitAndKeepDelimiter(String input, String delimiter) {
    if (delimiter.isEmpty) {
      throw ArgumentError('Delimiter cannot be an empty string.');
    }

    final regex = RegExp('(${RegExp.escape(delimiter)})');

    // Use a set of chars that do not collide with the formatted amount (and its currency)
    const splitSep = '**';

    return input
        .splitMapJoin(
          regex,
          onMatch: (match) => '$splitSep${match.group(0)}$splitSep',
          onNonMatch: (nonMatch) => nonMatch,
        )
        .split(splitSep)
        .where((element) => element.isNotEmpty)
        .toList();
  }

  List<TextSpan> _getTextSpanListForAFormattedNumber(
    String number, {
    required double fontSize,
  }) {
    final decimalSep = currentDecimalSep;

    List<String> parts = number.split(decimalSep);

    final computedDecimalStyles =
        decimalsStyle ??
        integerStyle.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: fontSize > 12.25 ? max(fontSize * 0.75, 12.25) : fontSize,
        );

    return [
      // Integer part
      TextSpan(text: parts[0], style: integerStyle),

      // Decimal separator:
      if (parts.length > 1) TextSpan(text: decimalSep, style: integerStyle),

      // Decimal part
      if (parts.length > 1)
        TextSpan(
          text: parts[1],
          style: _shouldCompact ? integerStyle : computedDecimalStyles,
        ),
    ];
  }

  List<TextSpan> getTextSpanList(BuildContext context) {
    final valueFontSize =
        (integerStyle.fontSize ??
            DefaultTextStyle.of(context).style.fontSize) ??
        16;

    final String formattedAmount = getFormattedAmount();

    if (mode != UINumberFormatterMode.currency) {
      return _getTextSpanListForAFormattedNumber(
        formattedAmount,
        fontSize: valueFontSize,
      );
    }

    final List<TextSpan> toReturn = [];

    for (final elementToDisplay in _splitAndKeepDelimiter(
      formattedAmount,
      _currencySymbolWithoutDecimalSep,
    )) {
      if (elementToDisplay == _currencySymbolWithoutDecimalSep) {
        toReturn.add(
          TextSpan(
            text: currency!.symbol,
            style: currencyStyle ?? integerStyle,
          ),
        );
      } else {
        toReturn.addAll(
          _getTextSpanListForAFormattedNumber(
            elementToDisplay,
            fontSize: valueFontSize,
          ),
        );
      }
    }

    return toReturn;
  }

  Text getTextWidget(BuildContext context) {
    return Text.rich(
      TextSpan(style: integerStyle, children: getTextSpanList(context)),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
