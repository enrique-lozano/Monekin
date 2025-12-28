import 'package:flutter/material.dart';
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
  });

  final TransactionType transactionType;
  final double transactionValue;
  final Account? fromAccount;
  final VoidCallback onTap;
  final double mainContainerRadius;

  @override
  Widget build(BuildContext context) {
    final fgColor = transactionType.color(context).getContrastColor();

    return Tappable(
      bgColor: transactionType.color(context).withOpacity(0.85),
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
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: IconDisplayer(
                      key: ValueKey(transactionType.mathIcon.toString()),
                      mainColor: transactionType.color(context),
                      secondaryColor: fgColor,
                      padding: 2,
                      borderRadius: 4,
                      icon: transactionType.mathIcon,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: AnimatedDefaultTextStyle(
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(
                            fontSize: transactionValue >= 1000
                                ? transactionValue >= 1000000
                                      ? 28
                                      : 34
                                : 38,
                          ),
                      duration: const Duration(milliseconds: 200),
                      child: Builder(
                        builder: (context) {
                          final bigTextStyle = TextStyle(
                            fontWeight: FontWeight.bold,
                            color: fgColor,
                          );

                          return CurrencyDisplayer(
                            amountToConvert: transactionValue,
                            currency: fromAccount?.currency,
                            currencyStyle: bigTextStyle,
                            integerStyle: bigTextStyle,
                            followPrivateMode: false,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if (fromAccount != null)
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
                      duration: const Duration(milliseconds: 400),
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
