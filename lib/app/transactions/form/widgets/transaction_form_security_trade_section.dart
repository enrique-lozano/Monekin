import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

/// Buy/sell editor for a security trade (type N with a securityID): a buy/sell
/// toggle plus quantity and price-per-unit fields, with the computed total.
class TransactionFormSecurityTradeSection extends StatelessWidget {
  const TransactionFormSecurityTradeSection({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final t = Translations.of(context);
    final currency = c.fromAccount?.currency;
    final available = c.securityTradeIsBuy
        ? null
        : c.securityTradeAvailableUnits;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          ExpandingSegmentedTabs<bool>(
            items: [
              SegmentedTabItem(
                value: true,
                icon: Icons.add_rounded,
                label: t.assets.holdings.buy,
                color: TransactionType.income.color(context),
              ),
              SegmentedTabItem(
                value: false,
                icon: Icons.remove_rounded,
                label: t.assets.holdings.sell,
                color: TransactionType.expense.color(context),
              ),
            ],
            selected: c.securityTradeIsBuy,
            onSelected: (isBuy) => c.setSecurityTradeIsSell(!isBuy),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Expanded(
                child: TextFormField(
                  controller: c.quantityController,
                  focusNode: c.quantityFocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) {
                    final parsed = double.tryParse(
                      (v ?? '').trim().replaceAll(',', '.'),
                    );
                    if (parsed == null || parsed <= 0) {
                      return t.general.validations.required;
                    }
                    if (!c.securityTradeIsBuy &&
                        available != null &&
                        parsed > available + 1e-7) {
                      return t.assets.holdings.not_enough_units;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: '${t.assets.holdings.quantity} *',
                    helperText: available == null
                        ? null
                        : t.assets.holdings.units_available(
                            quantity: UINumberFormatter.decimal(
                              amountToConvert: available,
                            ).getFormattedAmount(),
                          ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: c.priceController,
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
                    labelText: '${t.assets.holdings.price_per_unit} *',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.assets.holdings.total,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              DefaultTextStyle.merge(
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                child: CurrencyDisplayer(
                  amountToConvert: c.securityTradeTotal,
                  currency: currency,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
