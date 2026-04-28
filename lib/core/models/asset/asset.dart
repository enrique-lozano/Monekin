import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/asset/asset_type.enum.dart';

class Asset extends AssetInDB {
  final CurrencyInDB currency;

  Asset({
    required super.id,
    required super.name,
    required super.initialValue,
    required super.creationDate,
    required this.currency,
    super.description,
    super.assetType,
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
