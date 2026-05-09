import 'package:monekin/core/database/app_db.dart';

class Asset extends AssetInDB {
  final CurrencyInDB currency;

  Asset({
    required super.id,
    required super.name,
    required super.initialValue,
    required super.creationDate,
    required this.currency,
    required super.assetType,
    super.description,
    super.linkedAccountID,
  }) : super(currencyId: currency.code);

  static Asset fromDB(AssetInDB asset, CurrencyInDB currency) => Asset(
    id: asset.id,
    name: asset.name,
    initialValue: asset.initialValue,
    creationDate: asset.creationDate,
    currency: currency,
    description: asset.description,
    assetType: asset.assetType,
    linkedAccountID: asset.linkedAccountID,
  );
}
