import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';

class TransactionAmountDisplay extends StatelessWidget {
  const TransactionAmountDisplay({
    super.key,
    required this.transactionType,
    required this.transactionValue,
    required this.fromAccount,
    required this.onTap,
    this.mainContainerRadius = 12.0,
    this.displayCurrencyOverride,
    this.accentColor,
    this.mathIconOverride,
  });

  final TransactionType transactionType;
  final double transactionValue;
  final Account? fromAccount;
  final VoidCallback onTap;
  final double mainContainerRadius;

  /// When set (e.g. asset trade in asset currency), overrides [fromAccount] currency for display.
  final CurrencyInDB? displayCurrencyOverride;

  /// When set, overrides [TransactionType.color] for the amount block (e.g. buy vs sell).
  final Color? accentColor;

  /// Optional icon instead of [transactionType.mathIcon] (e.g. add vs remove for asset trades).
  final IconData? mathIconOverride;

  @override
  Widget build(BuildContext context) {
    final baseColor = accentColor ?? transactionType.color(context);
    final fgColor = baseColor.getContrastColor();

    return Tappable(
      bgColor: baseColor.withOpacity(0.85),
      onTap: onTap,
      borderRadius: BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md)
          ? BorderRadius.only(
              topLeft: Radius.circular(mainContainerRadius),
              topRight: Radius.circular(mainContainerRadius),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: DefaultTextStyle(
          style: TextStyle(color: fgColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconDisplayer(
                    key: ValueKey<int>(
                      Object.hash(mathIconOverride, accentColor),
                    ),
                    mainColor: baseColor,
                    secondaryColor: fgColor,
                    padding: 2,
                    borderRadius: 4,
                    icon: mathIconOverride ?? transactionType.mathIcon,
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Builder(
                      builder: (context) {
                        final fontSize = transactionValue >= 1000
                            ? transactionValue >= 1000000
                                  ? 28.0
                                  : 34.0
                            : 38.0;
                        final bigTextStyle = TextStyle(
                          fontWeight: FontWeight.bold,
                          color: fgColor,
                          fontSize: fontSize,
                        );

                        return CurrencyDisplayer(
                          amountToConvert: transactionValue,
                          currency:
                              displayCurrencyOverride ?? fromAccount?.currency,
                          currencyStyle: bigTextStyle,
                          integerStyle: bigTextStyle,
                          followPrivateMode: false,
                        );
                      },
                    ),
                  ),
                ],
              ),
              if (fromAccount != null && displayCurrencyOverride == null)
                StreamBuilder(
                  stream: ExchangeRateService.instance
                      .calculateExchangeRateToPreferredCurrency(
                        fromCurrency: fromAccount!.currency.code,
                        amount: transactionValue,
                      ),
                  builder: (context, exchangeRateSnapshot) {
                    final shouldHide =
                        !exchangeRateSnapshot.hasData ||
                        exchangeRateSnapshot.data! == transactionValue;

                    final valueInPrefCurrencyIndicator = Column(
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.swap_horizontal_circle_rounded,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            CurrencyDisplayer(
                              amountToConvert: exchangeRateSnapshot.data ?? 0,
                              integerStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: fgColor,
                              ),
                              followPrivateMode: false,
                            ),
                          ],
                        ),
                      ],
                    );

                    return AnimatedSizeSwitcher(
                      duration: const Duration(milliseconds: 200),
                      enabled: false,
                      child: !shouldHide
                          ? valueInPrefCurrencyIndicator
                          : const SizedBox.shrink(),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
