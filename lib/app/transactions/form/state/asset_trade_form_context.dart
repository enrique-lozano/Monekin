import 'package:monekin/core/models/asset/asset.dart';

/// Opens [TransactionFormPage] in locked investment mode for a concrete buy/sell.
class AssetTradeFormContext {
  const AssetTradeFormContext({
    required this.asset,
    required this.isBuy,
    this.prefillDate,
    this.prefillTradeAmountAbs,
    this.prefillUpdateValuations,
  });

  final Asset asset;
  final bool isBuy;

  /// When opening the full transaction form from a trade sheet, pre-fills the date.
  final DateTime? prefillDate;

  /// Positive trade amount; matches the full form’s amount magnitude for investments.
  final double? prefillTradeAmountAbs;

  /// Carries the “update valuations” switch from the sheet into the full form.
  final bool? prefillUpdateValuations;
}
