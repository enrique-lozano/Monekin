import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// The cash of a security trade quoted in another currency than the account:
/// what it is worth, the exchange rate, the total really paid or received
/// (editable) and the difference between the two, which are the fees and the
/// exchange spread together.
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

  Widget _row(BuildContext context, String label, Widget value) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: [
        Flexible(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        DefaultTextStyle.merge(
          style: theme.textTheme.bodyMedium!,
          child: value,
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
          // The breakdown opens under the summary line
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
                          amountToConvert: c.securityTradeTotal,
                          currency: security,
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
          Align(
            alignment: Alignment.centerLeft,
            child: _CustomTotalChip(
              active: c.isTradeTotalCustom,
              onPressed: () => c.setTradeTotalCustom(!c.isTradeTotalCustom),
            ),
          ),
          // The field only exists while the total is custom: a hidden field
          // must not block the save with its own validation. Closing it skips
          // the collapse animation because of that.
          AnimatedExpanded(
            expand: c.isTradeTotalCustom,
            child: c.isTradeTotalCustom
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 12,
                    children: [
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
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
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
    );
  }
}

/// Turns on typing the total instead of using the converted one. Same style as
/// the "Custom amounts" chip of the transfer form.
class _CustomTotalChip extends StatelessWidget {
  const _CustomTotalChip({required this.active, required this.onPressed});

  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? scheme.primary : scheme.onSurfaceVariant;

    return Semantics(
      button: true,
      toggled: active,
      child: Material(
        color: active
            ? scheme.primary.withValues(alpha: 0.12)
            : Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(
            color: active ? scheme.primary : scheme.outlineVariant,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                Icon(
                  active ? Icons.link_off_rounded : Icons.link_rounded,
                  size: 16,
                  color: color,
                ),
                Text(
                  Translations.of(context).assets.holdings.total_custom,
                  maxLines: 1,
                  softWrap: false,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
