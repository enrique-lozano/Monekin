import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
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
    this.cardMargin = const EdgeInsets.all(0),
  });

  final Asset asset;
  final bool isBuy;
  final DateTime tradeDate;
  final double? tradeAmountAbs;
  final double? previousSignedValue;
  final DateTime? previousTradeDate;

  final EdgeInsets cardMargin;

  final bool updateValuations;
  final ValueChanged<bool> onUpdateValuationsChanged;

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      symbol: asset.currency.symbol,
      decimalDigits: asset.currency.decimalPlaces,
    ).format(amount);
  }

  static bool _hasValuationsStrictlyAfterDate(
    List<ValuationInDB> valuations,
    DateTime tradeDate,
  ) {
    final tradeDay = DateUtils.dateOnly(tradeDate);
    return valuations.any((v) => DateUtils.dateOnly(v.date).isAfter(tradeDay));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final amount = tradeAmountAbs;

    if (amount == null || amount <= 0) {
      return const SizedBox.shrink();
    }

    final signedValue = isBuy ? -amount : amount;

    return StreamBuilder<List<ValuationInDB>>(
      stream: InvestmentService.instance.getValuationsForAsset(asset.id),
      builder: (context, valuationsSnap) {
        // Until valuations load, assume future rows may exist (copy matches insert logic).
        final hasFutureValuations = valuationsSnap.data == null
            ? true
            : _hasValuationsStrictlyAfterDate(valuationsSnap.data!, tradeDate);

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
                !DateUtils.dateOnly(
                  previousTradeDate!,
                ).isAfter(DateUtils.dateOnly(tradeDate));

            final nextValue = hasPreviousImpactAtSelectedDate
                ? currentValue - (signedValue - previousSignedValue!)
                : currentValue - signedValue;

            /// Section translations abbreviation
            final sectionTr = t.assets.details;

            final switchTitle = hasFutureValuations
                ? sectionTr.trade_sheet_update_following_valuations
                : sectionTr.trade_sheet_valuation_create_new_title;

            final switchSubtitle = hasFutureValuations
                ? sectionTr.trade_sheet_update_following_valuations_description
                : sectionTr.trade_sheet_valuation_adjust_current_description;

            return Card(
              margin: cardMargin,
              clipBehavior: Clip.antiAlias,
              color: InputDecorationTheme.of(context).filled
                  ? InputDecorationTheme.of(context).fillColor
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(inputBorderRadius),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(switchTitle),
                    subtitle: Text(switchSubtitle),
                    value: nextValue == currentValue ? false : updateValuations,

                    onChanged: nextValue == currentValue
                        ? null
                        : (value) {
                            onUpdateValuationsChanged(value);
                          },
                  ),
                  AnimatedExpanded(
                    expand: updateValuations,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12,
                      children: [
                        const Divider(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              _ValuePreviewColumn(
                                title: t
                                    .assets
                                    .details
                                    .trade_sheet_valuation_current_value_label,
                                value: _formatCurrency(currentValue),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                child: Icon(Icons.arrow_forward_rounded),
                              ),
                              Expanded(
                                child: _ValuePreviewColumn(
                                  title: t
                                      .assets
                                      .details
                                      .trade_sheet_valuation_new_value_label,
                                  value: _formatCurrency(nextValue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 0),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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
