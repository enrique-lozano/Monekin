import 'package:monekin/core/database/app_db.dart';

class Asset extends AssetInDB {
  final CurrencyInDB currency;

  Asset({
    required super.id,
    required super.name,
    required super.initialValue,
    required super.creationDate,
    required super.includeInNetWorth,
    required this.currency,
    super.description,
  }) : super(currencyId: currency.code);

  static Asset fromDB(AssetInDB asset, CurrencyInDB currency) => Asset(
    id: asset.id,
    name: asset.name,
    initialValue: asset.initialValue,
    creationDate: asset.creationDate,
    includeInNetWorth: asset.includeInNetWorth,
    currency: currency,
    description: asset.description,
  );
}
