import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/transaction_form_controller.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Segmented control for income / expense / transfer (hidden for locked asset trade flows).
class TransactionFormTypeSegmented extends StatelessWidget {
  const TransactionFormTypeSegmented({
    super.key,
    required this.controller,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 12),
  });

  final TransactionFormController controller;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    if (controller.isAssetTradeInvestment) {
      return const SizedBox.shrink();
    }
    final c = controller;
    final selectedColor = c.transactionType.color(context);
    final fg = c.foregroundColor(context);
    final types = [
      TransactionType.income,
      TransactionType.expense,
      TransactionType.transfer,
    ];

    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: SegmentedButton<TransactionType>(
          segments: types
              .map(
                (e) => ButtonSegment<TransactionType>(
                  value: e,
                  label: Text(
                    e.displayName(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          selected: {c.transactionType},
          onSelectionChanged: (next) {
            final v = next.firstOrNull;
            if (v != null) c.onTransactionTypeChanged(v);
          },
          showSelectedIcon: false,
          style: ButtonStyle(
            animationDuration: const Duration(milliseconds: 250),
            side: WidgetStateProperty.resolveWith(
              (s) => const BorderSide(style: BorderStyle.none, width: 0),
            ),
            foregroundColor: WidgetStateProperty.resolveWith(
              (s) => s.contains(WidgetState.selected)
                  ? selectedColor.getContrastColor()
                  : fg.withOpacity(0.85),
            ),
            backgroundColor: WidgetStateProperty.resolveWith(
              (s) => s.contains(WidgetState.selected)
                  ? selectedColor
                  : Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
          ),
        ),
      ),
    );
  }
}

/// Amount field, optional preferred-currency hint, and insufficient-balance warning.
class TransactionFormAmountBlock extends StatelessWidget {
  const TransactionFormAmountBlock({
    super.key,
    required this.controller,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 12),
  });

  final TransactionFormController controller;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Padding(
      padding: padding,
      child: ListenableBuilder(
        listenable: Listenable.merge([c, c.amountTextController]),
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _amountInputRow(context, c),
              _preferredCurrencyHint(context, c),
              _insufficientBalanceWarning(context, c),
            ],
          );
        },
      ),
    );
  }

  static Widget _preferredCurrencyHint(
    BuildContext context,
    TransactionFormController c,
  ) {
    final from = c.fromAccount;
    final displayCurrency = c.amountDisplayCurrency ?? from?.currency;

    if (from == null || displayCurrency == null) {
      return const SizedBox.shrink();
    }

    return StreamBuilder<double>(
      stream: ExchangeRateService.instance
          .calculateExchangeRateToPreferredCurrency(
            fromCurrency: displayCurrency.code,
            amount: c.transactionValue,
          ),
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox.shrink();

        final converted = snap.data!;
        final hintColor = c.foregroundColor(context).withOpacity(0.75);

        return AnimatedExpanded(
          expand: converted != c.transactionValue,
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.swap_horizontal_circle_rounded,
                  size: 16,
                  color: hintColor,
                ),
                const SizedBox(width: 6),
                CurrencyDisplayer(
                  amountToConvert: converted,
                  integerStyle:
                      Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: hintColor,
                        fontWeight: FontWeight.w500,
                      ) ??
                      TextStyle(color: hintColor, fontWeight: FontWeight.w500),
                  followPrivateMode: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _insufficientBalanceWarning(
    BuildContext context,
    TransactionFormController c,
  ) {
    final from = c.fromAccount;
    if (from == null || c.transactionValue <= 0) {
      return const SizedBox.shrink();
    }
    final newEffect = c.draftEffectOnFromAccountLedger();
    if (newEffect >= 0) return const SizedBox.shrink();

    return StreamBuilder<double>(
      initialData: 0,
      stream: AccountService.instance.getAccountMoney(account: from),
      builder: (context, snap) {
        final balance = snap.data ?? 0;
        final oldEffect = c.oldEffectOnFromAccountLedgerForEdit ?? 0;
        final projected = balance + newEffect - oldEffect;

        if (projected >= -1e-6) return const SizedBox.shrink();

        final t = Translations.of(context);
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InlineInfoCard(
            text: t.transaction.form.negative_balance_warning,
            mode: InlineInfoCardMode.warn,
            margin: EdgeInsets.zero,
          ),
        );
      },
    );
  }

  static Widget _amountInputRow(
    BuildContext context,
    TransactionFormController c,
  ) {
    if (c.isAssetTradeInvestment) {
      return _investmentAmountSurface(context, c);
    }
    final baseColor = c.transactionType.color(context);
    final ctrl = c.amountTextController;
    double fontSize = 48;
    switch (ctrl.text.length) {
      case > 8:
        fontSize = 24;
        break;
      case > 6:
        fontSize = 28;
        break;
      case > 4:
        fontSize = 36;
    }

    return AnimatedSizeSwitcher(
      duration: const Duration(milliseconds: 1250),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(left: 6, right: 2),
            decoration: BoxDecoration(
              color: c.foregroundColor(context),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(c.transactionType.mathIcon, color: baseColor, size: 24),
          ),
          Flexible(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Semantics(
                  label: Translations.of(context).transaction.form.value,
                  textField: true,
                  child: TextField(
                    controller: ctrl,
                    focusNode: c.amountFocusNode,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => c.titleFocusNode.requestFocus(),
                    textAlign: TextAlign.center,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: decimalDigitFormatter(
                      c.fromAccount?.currency.decimalPlaces ?? 2,
                      allowNegative: true,
                    ),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: c.foregroundColor(context),
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.transparent,
                      hoverColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh.withOpacity(0.05),
                      border: InputBorder.none,
                      hintText: '0',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixText: c.fromAccount?.currency.symbol,
                      suffixText: ctrl.text.endsWith('.') ? '00' : null,
                      hintStyle: TextStyle(
                        color: c.foregroundColor(context).withOpacity(0.35),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton.outlined(
            color: c.foregroundColor(context),
            onPressed: () => c.openAmountSelectorSheet(context),
            icon: const Icon(Icons.calculate),
          ),
        ],
      ),
    );
  }

  /// Tappable summary for asset buy/sell (amount is edited via sheet, not the text field).
  static Widget _investmentAmountSurface(
    BuildContext context,
    TransactionFormController c, {
    double mainContainerRadius = 12,
  }) {
    final baseColor = c.investmentAccent(context);
    final fgColor = baseColor.getContrastColor();
    final transactionValue = c.transactionValue;
    final fromAccount = c.fromAccount;
    final displayCurrencyOverride = c.asset?.currency;

    return Tappable(
      bgColor: baseColor.withOpacity(0.85),
      onTap: () => c.openAmountSelectorSheet(context),
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
                      Object.hash(c.investmentIsBuy, baseColor),
                    ),
                    mainColor: baseColor,
                    secondaryColor: fgColor,
                    padding: 2,
                    borderRadius: 4,
                    icon: c.investmentIsBuy
                        ? TransactionType.income.icon
                        : TransactionType.expense.icon,
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
                StreamBuilder<double>(
                  stream: ExchangeRateService.instance
                      .calculateExchangeRateToPreferredCurrency(
                        fromCurrency: fromAccount.currency.code,
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
