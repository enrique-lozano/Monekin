import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/assets/asset_trade_valuation.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Explains how a buy/sell trade affects recorded asset value and later valuations.
class AssetValuationImpactSection extends StatelessWidget {
  const AssetValuationImpactSection({
    super.key,
    required this.asset,
    required this.isBuy,
    required this.tradeDate,
    required this.tradeAmountAbs,
    required this.isEditingExistingTransaction,
    required this.updateLaterValuations,
    required this.onUpdateLaterValuationsChanged,
  });

  final Asset asset;
  final bool isBuy;
  final DateTime tradeDate;
  final double? tradeAmountAbs;

  /// When true, copy uses [trade_sheet_update_linked_asset_value_info].
  final bool isEditingExistingTransaction;

  final bool updateLaterValuations;
  final ValueChanged<bool> onUpdateLaterValuationsChanged;

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

    final absAmount = amount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: StreamBuilder<double>(
        stream: InvestmentService.instance.getAssetValueAtDate(
          asset,
          date: tradeDate,
        ),
        builder: (context, snapshot) {
          final originalValue = snapshot.data ?? asset.initialValue;
          final transactionValue = isBuy ? -absAmount : absAmount;
          final updatedValue = originalValue - transactionValue;
          final formattedDate = DateFormat.yMMMd(
            Localizations.localeOf(context).toString(),
          ).format(tradeDate);

          final infoText = isEditingExistingTransaction
              ? t.assets.details.trade_sheet_update_linked_asset_value_info(
                  value: _formatCurrency(updatedValue),
                )
              : t.assets.details.trade_sheet_update_value_info(
                  value: _formatCurrency(updatedValue),
                );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InlineInfoCard(
                mode: InlineInfoCardMode.info,
                text: infoText,
                margin: const EdgeInsets.only(bottom: 16),
              ),
              StreamBuilder(
                stream: InvestmentService.instance.getValuationsForAsset(
                  asset.id,
                ),
                builder: (context, valuationsSnap) {
                  final laterValuations = (valuationsSnap.data ?? [])
                      .where(
                        (valuation) => isTradeDateAfterCalendarDay(
                          valuation.date,
                          tradeDate,
                        ),
                      )
                      .toList();
                  if (laterValuations.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  final warningText = t.assets.details
                      .trade_sheet_following_valuations_warning(
                    date: formattedDate,
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SwitchListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        title: Text(
                          t.assets.details
                              .trade_sheet_update_following_valuations,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            t.assets.details
                                .trade_sheet_update_following_valuations_description,
                          ),
                        ),
                        value: updateLaterValuations,
                        onChanged: onUpdateLaterValuationsChanged,
                      ),
                      const SizedBox(height: 12),
                      InlineInfoCard(
                        mode: InlineInfoCardMode.warn,
                        text: warningText,
                        margin: const EdgeInsets.only(top: 4, bottom: 8),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
