import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/assets/asset_trade_valuation.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
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
    final hasAmount = amount != null && amount > 0;

    return AnimatedExpanded(
      expand: hasAmount,
      child: StreamBuilder<double>(
        stream: InvestmentService.instance.getAssetValueAtDate(
          asset,
          date: tradeDate,
        ),
        builder: (context, snapshot) {
          final originalValue = snapshot.data ?? asset.initialValue;
          final transactionValue = isBuy ? -amount! : amount!;
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
                margin: const EdgeInsets.only(bottom: 12),
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
                      InlineInfoCard(
                        mode: InlineInfoCardMode.warn,
                        text: warningText,
                        margin: const EdgeInsets.only(bottom: 12),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          t.assets.details.trade_sheet_update_following_valuations,
                        ),
                        subtitle: Text(
                          t
                              .assets
                              .details
                              .trade_sheet_update_following_valuations_description,
                        ),
                        value: updateLaterValuations,
                        onChanged: onUpdateLaterValuationsChanged,
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
