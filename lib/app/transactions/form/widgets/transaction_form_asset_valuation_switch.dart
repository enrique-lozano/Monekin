import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/asset_valuation_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

/// Valuation update toggle for asset investment rows in the transaction form.
class TransactionFormAssetValuationSwitch extends StatelessWidget {
  const TransactionFormAssetValuationSwitch({super.key});

  static bool _hasValuationsStrictlyAfterDate(
    List<ValuationInDB> valuations,
    DateTime tradeDate,
  ) {
    final tradeDay = DateUtils.dateOnly(tradeDate);
    return valuations.any((v) => DateUtils.dateOnly(v.date).isAfter(tradeDay));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final asset = c.asset;
    final amount = c.investmentValuationAmount;

    if (!c.isAssetTradeInvestment || asset == null || amount <= 0) {
      return const SizedBox.shrink();
    }

    final signedValue = c.investmentIsBuy ? -amount : amount;
    final tradeDate = c.date;
    final previousSignedValue = c.isEditMode
        ? c.transactionToEdit?.value
        : null;
    final previousTradeDate = c.isEditMode ? c.transactionToEdit?.date : null;

    return StreamBuilder<List<ValuationInDB>>(
      stream: AssetValuationService.instance.getValuationsForAsset(asset.id),
      builder: (context, valuationsSnap) {
        final hasFutureValuations = valuationsSnap.data == null
            ? true
            : _hasValuationsStrictlyAfterDate(valuationsSnap.data!, tradeDate);

        return StreamBuilder<double>(
          stream: AssetValuationService.instance.getAssetValueAtDate(
            asset,
            date: tradeDate,
          ),
          builder: (context, snapshot) {
            final currentValue = snapshot.data ?? asset.initialValue;
            final hasPreviousImpactAtSelectedDate =
                previousSignedValue != null &&
                previousTradeDate != null &&
                !DateUtils.dateOnly(
                  previousTradeDate,
                ).isAfter(DateUtils.dateOnly(tradeDate));

            final nextValue = hasPreviousImpactAtSelectedDate
                ? currentValue - (signedValue - previousSignedValue)
                : currentValue - signedValue;

            final t = Translations.of(context);
            final sectionTr = t.assets.details;

            final switchTitle = hasFutureValuations
                ? sectionTr.trade_sheet_update_following_valuations
                : sectionTr.trade_sheet_valuation_create_new_title;

            final switchSubtitle = hasFutureValuations
                ? sectionTr.trade_sheet_update_following_valuations_description
                : sectionTr.trade_sheet_valuation_adjust_current_description;

            final noImpact =
                (!c.isEditMode && nextValue == currentValue) ||
                (c.isEditMode && c.investmentValuationDraftUnchangedOnEdit);

            return SwitchListTile(
              title: Text(switchTitle),
              subtitle: Text(switchSubtitle),
              value: noImpact ? false : c.updateValuations,
              onChanged: noImpact
                  ? null
                  : (value) {
                      c.updateValuations = value;
                    },
            );
          },
        );
      },
    );
  }
}
