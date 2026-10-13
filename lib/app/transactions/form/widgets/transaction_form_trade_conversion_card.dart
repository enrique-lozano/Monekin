import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// The cash of a security trade quoted in another currency than the account.
///
/// Shows the trade in the security currency, the exchange rate and the total in
/// the account currency. That total is either converted with the stored rate
/// (auto) or typed by the user (custom), which also shows the difference with
/// the converted one (fees and exchange spread together).
class TransactionFormTradeConversionCard extends StatelessWidget {
  const TransactionFormTradeConversionCard({
    super.key,
    required this.controller,
    required this.accountCurrency,
    required this.securityCurrency,
  });

  final TransactionFormController controller;
  final CurrencyInDB accountCurrency;
  final CurrencyInDB securityCurrency;

  TransactionFormController get c => controller;

  String _rate(double rate) => UINumberFormatter.decimal(
    amountToConvert: rate,
    decimalDigits: 4,
  ).getFormattedAmount();

  static num _pow10(int n) {
    var r = 1;
    for (var i = 0; i < n; i++) {
      r *= 10;
    }
    return r;
  }

  Widget _detailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget value,
    String? tooltip,
  }) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(icon, size: 16, color: color),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium!.copyWith(color: color),
                ),
              ),
              if (tooltip != null)
                Tooltip(
                  message: tooltip,
                  triggerMode: TooltipTriggerMode.tap,
                  showDuration: const Duration(seconds: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: color,
                  ),
                ),
            ],
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
    final decimals = accountCurrency.decimalPlaces;

    // Anything under half of the smallest unit is rounding, not a cost
    final isZero = extra.abs() < 0.5 / _pow10(decimals);
    final color = isZero
        ? theme.colorScheme.onSurfaceVariant
        : extra > 0
        ? theme.colorScheme.error
        : Colors.green;

    return _detailRow(
      context,
      icon: Icons.receipt_long_outlined,
      label: t.assets.holdings.fees_and_exchange,
      tooltip: t.assets.holdings.fees_and_exchange_info,
      value: DefaultTextStyle.merge(
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            CurrencyDisplayer(
              amountToConvert: isZero ? 0 : extra,
              currency: accountCurrency,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final account = accountCurrency;
    final security = securityCurrency;
    final custom = c.isTradeTotalCustom;
    final converts = c.isTradeCurrencyMismatch;

    final stored = c.securityToAccountRate;
    final got = custom ? c.securityTradeEffectiveRate : null;
    final isEffective = got != null && (got - stored).abs() >= 0.00005;
    final rateColor = isEffective
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    final shownRate = isEffective ? got : stored;

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 2,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    t.assets.holdings.total,
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    child: CurrencyDisplayer(
                      amountToConvert: c.securityTradeTotal,
                      currency: security,
                    ),
                  ),
                ],
              ),
              if (converts)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6,
                        children: [
                          Icon(
                            Icons.swap_horiz_rounded,
                            size: 16,
                            color: rateColor,
                          ),
                          Flexible(
                            child: Text(
                              '${security.code} → ${account.code} × ${_rate(shownRate)}'
                              '${isEffective ? ' · ${t.assets.holdings.rate_effective}' : ''}',
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: rateColor,
                                fontWeight: isEffective
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultTextStyle.merge(
                      style: theme.textTheme.titleSmall!,
                      child: CurrencyDisplayer(
                        amountToConvert: c.securityTradeCashAmount,
                        currency: account,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (converts) ...[
            const Divider(height: 1),
            ExpandingSegmentedTabs<bool>(
              items: [
                SegmentedTabItem(
                  value: false,
                  icon: Icons.link_rounded,
                  label: t.assets.holdings.total_mode_auto,
                ),
                SegmentedTabItem(
                  value: true,
                  icon: Icons.link_off_rounded,
                  label: t.assets.holdings.total_mode_custom,
                ),
              ],
              selected: custom,
              onSelected: c.setTradeTotalCustom,
            ),
            // The field only exists while it is visible: a hidden field must not
            // block the save with its own validation.
            AnimatedExpanded(
              expand: custom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 6,
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
                  const SizedBox(height: 2),
                  _detailRow(
                    context,
                    icon: Icons.calculate_outlined,
                    label: t.assets.holdings.calculated,
                    value: DefaultTextStyle.merge(
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      child: CurrencyDisplayer(
                        amountToConvert: c.securityTradeConvertedValue,
                        currency: account,
                      ),
                    ),
                  ),
                  if (c.securityTradeCashAmount > 0)
                    _extraCost(context, c.securityTradeExtraCost),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
