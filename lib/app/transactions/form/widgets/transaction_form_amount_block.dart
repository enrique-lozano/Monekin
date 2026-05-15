import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/transaction_form_controller.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
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
    final c = controller;
    if (c.isAssetTradeInvestment) {
      final t = Translations.of(context);
      final accent = c.investmentAccent(context);
      final onAccent = accent.getContrastColor();
      return Padding(
        padding: padding,
        child: SizedBox(
          width: double.infinity,
          child: SegmentedButton<bool>(
            segments: [
              ButtonSegment<bool>(
                value: true,
                label: Text(t.assets.details.buy),
              ),
              ButtonSegment<bool>(
                value: false,
                label: Text(t.assets.details.sell),
              ),
            ],
            selected: {c.investmentIsBuy},
            onSelectionChanged: (next) {
              final v = next.firstOrNull;
              if (v == null) return;
              final t = Translations.of(context);
              final buyL = t.assets.details.buy;
              final sellL = t.assets.details.sell;
              final cur = c.titleController.text.trim();
              if (cur.isEmpty || cur == buyL || cur == sellL) {
                c.titleController.text = v ? buyL : sellL;
              }
              c.setInvestmentIsBuy(v);
            },
            showSelectedIcon: false,
            style: ButtonStyle(
              animationDuration: const Duration(milliseconds: 250),
              side: WidgetStateProperty.resolveWith(
                (s) => const BorderSide(style: BorderStyle.none, width: 0),
              ),
              foregroundColor: WidgetStateProperty.resolveWith(
                (s) => s.contains(WidgetState.selected)
                    ? onAccent
                    : AppColors.of(context).textBody,
              ),
              backgroundColor: WidgetStateProperty.resolveWith(
                (s) => s.contains(WidgetState.selected)
                    ? accent
                    : Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
            ),
          ),
        ),
      );
    }
    final selectedColor = c.transactionType.color(context);
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
                  : AppColors.of(context).textBody,
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
              insufficientBalanceWarning(context, c),
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

  /// Shared with [TransactionFormDualLegAmountSection] for transfer / investment.
  static Widget insufficientBalanceWarning(
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
    final inv = c.isAssetTradeInvestment;
    final baseColor = inv
        ? c.investmentAccent(context)
        : c.transactionType.color(context);
    final ctrl = c.amountTextController;
    final cur = c.amountDisplayCurrency ?? c.fromAccount?.currency;
    final decimals = cur?.decimalPlaces ?? 2;
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
            child: Icon(
              inv
                  ? (c.investmentIsBuy
                        ? TransactionType.income.mathIcon
                        : TransactionType.expense.mathIcon)
                  : c.transactionType.mathIcon,
              color: baseColor,
              size: 24,
            ),
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
                      decimals,
                      allowNegative: true,
                    ),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
                      prefixText: cur?.symbol,
                      suffixText: ctrl.text.endsWith('.') ? '00' : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton.outlined(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            onPressed: () => c.openAmountSelectorSheet(context),
            icon: const Icon(Icons.calculate),
          ),
        ],
      ),
    );
  }
}
