import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';

import 'ui_number_formatter.dart';

class CurrencyDisplayer extends StatelessWidget {
  /// Creates a widget that takes an amount and display it in a localized currency format with the decimals smaller that the rest of the text. This widget is not in charge of the conversion to any currency, that is, the amount will be remain as it is.
  const CurrencyDisplayer(
      {super.key,
      required this.amountToConvert,
      this.currency,
      this.showDecimals = true,
      this.textStyle = const TextStyle(inherit: true),
      this.decimalsStyle});

  final double amountToConvert;

  /// The currency of the amount, used to display the symbol. If not specified, will be the user preferred currency
  final CurrencyInDB? currency;

  final TextStyle textStyle;
  final TextStyle? decimalsStyle;

  final bool showDecimals;

  @override
  Widget build(BuildContext context) {
    final valueFontSize =
        (textStyle.fontSize ?? DefaultTextStyle.of(context).style.fontSize) ??
            16;

    if (currency != null) {
      return UINumberFormatter.currency(
        amountToConvert: amountToConvert,
        currency: currency,
        showDecimals: showDecimals,
        textStyle: textStyle,
        decimalsStyle: decimalsStyle,
      ).getTextWidget(context);
    }

    return StreamBuilder(
        stream: CurrencyService.instance.getUserPreferredCurrency(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Skeleton(width: 50, height: valueFontSize);
          }

          return UINumberFormatter.currency(
            amountToConvert: amountToConvert,
            currency: CurrencyInDB(
                code: snapshot.data!.code, symbol: snapshot.data!.symbol),
            showDecimals: showDecimals,
            textStyle: textStyle,
            decimalsStyle: decimalsStyle,
          ).getTextWidget(context);
        });
  }
}
