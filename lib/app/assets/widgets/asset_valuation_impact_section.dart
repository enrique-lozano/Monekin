import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Toggle and preview card for valuation updates caused by an asset trade.
class AssetValuationImpactSection extends StatelessWidget {
  const AssetValuationImpactSection({
    super.key,
    required this.asset,
    required this.isBuy,
    required this.tradeDate,
    required this.tradeAmountAbs,
    required this.updateValuations,
    required this.onUpdateValuationsChanged,
    this.previousSignedValue,
    this.previousTradeDate,
  });

  final Asset asset;
  final bool isBuy;
  final DateTime tradeDate;
  final double? tradeAmountAbs;
  final double? previousSignedValue;
  final DateTime? previousTradeDate;

  final bool updateValuations;
  final ValueChanged<bool> onUpdateValuationsChanged;

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      symbol: asset.currency.symbol,
      decimalDigits: asset.currency.decimalPlaces,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final amount = tradeAmountAbs;

    if (amount == null || amount <= 0) {
      return const SizedBox.shrink();
    }

    final signedValue = isBuy ? -amount : amount;

    return StreamBuilder<double>(
      stream: InvestmentService.instance.getAssetValueAtDate(
        asset,
        date: tradeDate,
      ),
      builder: (context, snapshot) {
        final currentValue = snapshot.data ?? asset.initialValue;
        final hasPreviousImpactAtSelectedDate =
            previousSignedValue != null &&
            previousTradeDate != null &&
            !DateUtils.dateOnly(previousTradeDate!).isAfter(
              DateUtils.dateOnly(tradeDate),
            );
        final nextValue = hasPreviousImpactAtSelectedDate
            ? currentValue - (signedValue - previousSignedValue!)
            : currentValue - signedValue;
        final dateLabel = DateFormat.yMMMd(
          Localizations.localeOf(context).toString(),
        ).format(tradeDate);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    t.assets.details.trade_sheet_update_following_valuations,
                  ),
                  subtitle: Text(
                    '${t.assets.details.trade_sheet_update_following_valuations_description}\n$dateLabel',
                  ),
                  value: updateValuations,
                  onChanged: onUpdateValuationsChanged,
                ),
                const Divider(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _ValuePreviewColumn(
                        title: t.general.balance,
                        value: _formatCurrency(currentValue),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.arrow_forward_rounded),
                    ),
                    Expanded(
                      child: _ValuePreviewColumn(
                        title: t.assets.details.update_value,
                        value: _formatCurrency(nextValue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ValuePreviewColumn extends StatelessWidget {
  const _ValuePreviewColumn({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
