import 'package:monekin/core/models/asset/asset.dart';

/// Opens [TransactionFormPage] in locked investment mode for a concrete buy/sell.
class AssetTradeFormContext {
  const AssetTradeFormContext({required this.asset, required this.isBuy});

  final Asset asset;
  final bool isBuy;
}
