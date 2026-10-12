import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// The cash of a security trade quoted in another currency than the account.
///
/// Collapsed it is only the total in the account currency. Opened, it shows the
/// exchange rate and what the trade is worth in the security currency, and lets
/// the user type the total that was really paid or received, which also shows
/// the difference with the converted one (fees and exchange spread together).
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

  String _rate(double rate) => UINumberFormatter.decimal(
    amountToConvert: rate,
    decimalDigits: 4,
  ).getFormattedAmount();

  Widget _label(BuildContext context, String text, {String? tooltip}) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        Flexible(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium!.copyWith(color: color),
          ),
        ),
        if (tooltip != null)
          Tooltip(
            message: tooltip,
            triggerMode: TooltipTriggerMode.tap,
            showDuration: const Duration(seconds: 8),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Icon(Icons.info_outline_rounded, size: 16, color: color),
          ),
      ],
    );
  }

  Widget _row(BuildContext context, Widget label, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Flexible(child: label),
        DefaultTextStyle.merge(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: value,
        ),
      ],
    );
  }

  /// The rate that is stored. Once the total is custom, the rate it implies is
  /// the main one and the stored one goes under it, to compare them.
  Widget _rateValue(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final stored = c.securityToAccountRate;
    final got = c.isTradeTotalCustom ? c.securityTradeEffectiveRate : null;

    if (got == null || (got - stored).abs() < 0.00005) {
      return Text('× ${_rate(stored)}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '× ${_rate(got)}',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          t.assets.holdings.rate_stored_caption(rate: '× ${_rate(stored)}'),
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Fees and exchange spread, as an amount and as a share of what the trade
  /// is worth.
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
      _label(
        context,
        t.assets.holdings.fees_and_exchange,
        tooltip: t.assets.holdings.fees_and_exchange_info,
      ),
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
    final custom = c.isTradeTotalCustom;

    // The field only exists while it is visible: a hidden field must not block
    // the save with its own validation.
    final showCustom = _expanded && custom;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.all(inputBorderRadius),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: BorderRadius.all(inputBorderRadius),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.assets.holdings.total),
                        CurrencyDisplayer(
                          amountToConvert: c.securityTradeCashAmount,
                          currency: account,
                        ),
                      ],
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
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  _row(
                    context,
                    _label(
                      context,
                      t.assets.holdings.rate_stored(
                        from: security.code,
                        to: account.code,
                      ),
                    ),
                    _rateValue(context),
                  ),
                  _row(
                    context,
                    _label(
                      context,
                      t.assets.holdings.equivalent_in(currency: security.code),
                    ),
                    CurrencyDisplayer(
                      amountToConvert: c.securityTradeTotal,
                      currency: security,
                    ),
                  ),
                  TextButton(
                    onPressed: () => c.setTradeTotalCustom(!custom),
                    child: Text(
                      custom
                          ? t.assets.holdings.custom_total_reset
                          : t.assets.holdings.custom_total_configure,
                    ),
                  ),
                  AnimatedExpanded(
                    expand: showCustom,
                    child: showCustom
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 12,
                            children: [
                              TextFormField(
                                controller: c.tradeTotalController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.,]'),
                                  ),
                                ],
                              ),
                              if (c.securityTradeCashAmount > 0)
                                _extraCost(context, c.securityTradeExtraCost),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
