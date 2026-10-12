import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// The cash of a security trade whose security is quoted in another currency
/// than the account: what it is worth, at which rate, what was really paid and
/// the difference (fees and exchange spread together).
class TransactionFormTradeConversionCard extends StatefulWidget {
  const TransactionFormTradeConversionCard({
    super.key,
    required this.controller,
    required this.accountCurrency,
    required this.securityCurrency,
  });

  final TransactionFormController controller;
  final CurrencyInDB accountCurrency;
  final CurrencyInDB securityCurrency;

  @override
  State<TransactionFormTradeConversionCard> createState() =>
      _TransactionFormTradeConversionCardState();
}

class _TransactionFormTradeConversionCardState
    extends State<TransactionFormTradeConversionCard> {
  bool _expanded = false;

  TransactionFormController get c => widget.controller;

  String _rate(double? rate) => rate == null
      ? '—'
      : UINumberFormatter.decimal(
          amountToConvert: rate,
          decimalDigits: 4,
        ).getFormattedAmount();

  Widget _row(
    BuildContext context,
    String label,
    Widget value, {
    bool emphasized = false,
  }) {
    final theme = Theme.of(context);
    final style = emphasized
        ? theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700)
        : theme.textTheme.bodyMedium!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: [
        Flexible(
          child: Text(
            label,
            style: style.copyWith(
              color: emphasized ? null : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        DefaultTextStyle.merge(style: style, child: value),
      ],
    );
  }

  /// Fees and spread, as an amount and as a share of what the trade is worth.
  Widget _extraCost(BuildContext context, double extra) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final worth = c.securityTradeConvertedValue;
    final decimals = widget.accountCurrency.decimalPlaces;

    // Anything under half of the smallest unit is rounding, not a cost
    final isZero = extra.abs() < 0.5 / _pow10(decimals);
    final color = isZero
        ? theme.colorScheme.onSurfaceVariant
        : extra > 0
        ? theme.colorScheme.error
        : Colors.green;

    return _row(
      context,
      t.assets.holdings.fees_and_exchange,
      DefaultTextStyle.merge(
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            CurrencyDisplayer(
              amountToConvert: isZero ? 0 : extra,
              currency: widget.accountCurrency,
              followPrivateMode: false,
            ),
            if (!isZero && worth > 0)
              Text(
                '(${UINumberFormatter.percentage(amountToConvert: extra / worth).getFormattedAmount()})',
              ),
          ],
        ),
      ),
    );
  }

  static num _pow10(int n) {
    var r = 1;
    for (var i = 0; i < n; i++) {
      r *= 10;
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final account = widget.accountCurrency;
    final security = widget.securityCurrency;
    final effectiveRate = c.securityTradeEffectiveRate;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.all(inputBorderRadius),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          // The summary line always shows; the breakdown opens under it
          InkWell(
            borderRadius: BorderRadius.all(inputBorderRadius),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: _row(
                    context,
                    t.assets.holdings.total,
                    CurrencyDisplayer(
                      amountToConvert: c.securityTradeTotal,
                      currency: security,
                    ),
                  ),
                ),
                Icon(
                  _expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          AnimatedExpanded(
            expand: _expanded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                _row(
                  context,
                  t.assets.holdings.rate_stored(
                    from: security.code,
                    to: account.code,
                  ),
                  Text('× ${_rate(c.securityToAccountRate)}'),
                ),
                _row(
                  context,
                  t.assets.holdings.equivalent_in(currency: account.code),
                  CurrencyDisplayer(
                    amountToConvert: c.securityTradeConvertedValue,
                    currency: account,
                  ),
                ),
                if (effectiveRate != null)
                  _row(
                    context,
                    t.assets.holdings.rate_applied,
                    Text('× ${_rate(effectiveRate)}'),
                  ),
                const Divider(height: 8),
              ],
            ),
          ),
          TextFormField(
            controller: c.tradeTotalController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (v) {
              final parsed = double.tryParse(
                (v ?? '').trim().replaceAll(',', '.'),
              );
              return parsed == null || parsed <= 0
                  ? t.general.validations.required
                  : null;
            },
            decoration: InputDecoration(
              labelText:
                  '${t.assets.holdings.total_in_account_currency(currency: account.code)} *',
              suffixText: account.symbol,
              suffixIcon: c.isTradeTotalCustom
                  ? IconButton(
                      icon: const Icon(Icons.restart_alt_rounded),
                      tooltip: t.ui_actions.reset,
                      onPressed: c.resetTradeTotal,
                    )
                  : null,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
          ),
          if (c.securityTradeCashAmount > 0)
            _extraCost(context, c.securityTradeExtraCost),
        ],
      ),
    );
  }
}
