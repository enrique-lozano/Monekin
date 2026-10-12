import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';

/// A right-aligned trailing value for [ListTile]s whose primary figure is a
/// monetary amount, with an optional secondary line below it (e.g. a
/// `TrendingValue` delta or a small caption).
///
/// [ListTile] paints its `trailing` slot with the tiny `labelSmall` default,
/// so a bare [CurrencyDisplayer] there reads as secondary metadata instead of
/// the row's main value. This widget forces a prominent style (bold
/// `titleSmall` by default) so the amount stands out, and keeps the value +
/// secondary layout consistent across the app.
class TrailingValue extends StatelessWidget {
  const TrailingValue({
    super.key,
    required this.amount,
    this.currency,
    this.secondary,
    this.integerStyle,
    this.compactView = false,
  });

  final double amount;
  final CurrencyInDB? currency;

  /// Optional line rendered right below the amount, right-aligned.
  final Widget? secondary;

  /// Style for the amount. Defaults to a bold `titleSmall`.
  final TextStyle? integerStyle;

  final bool compactView;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CurrencyDisplayer(
          amountToConvert: amount,
          currency: currency,
          compactView: compactView,
          integerStyle:
              integerStyle ??
              Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        if (secondary != null) secondary!,
      ],
    );
  }
}
