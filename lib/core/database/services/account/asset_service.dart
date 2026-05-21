import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/asset/asset.dart';

/// Service for asset CRUD and asset/transaction linking operations.
class AssetService {
  final AppDB db;

  AssetService._(this.db);
  static final AssetService instance = AssetService._(AppDB.instance);

  Future<int> insertAsset(AssetInDB asset) {
    return db.into(db.assets).insert(asset);
  }

  Future<bool> updateAsset(AssetInDB asset) {
    return db.update(db.assets).replace(asset);
  }

  Future<int> deleteAsset(String assetId) {
    return (db.delete(db.assets)..where((tbl) => tbl.id.equals(assetId))).go();
  }

  Stream<List<Asset>> getAssets({
    Expression<bool> Function(Assets a, Currencies curr)? predicate,
    int? limit,
  }) {
    return db
        .getAssetsWithFullData(
          predicate: predicate,
          orderBy: (a, curr) => OrderBy([OrderingTerm.asc(a.name)]),
          limit: (a, curr) => Limit(limit ?? -1, null),
        )
        .watch();
  }

  Stream<Asset?> getAssetById(String id) {
    return getAssets(
      predicate: (a, curr) => a.id.equals(id),
      limit: 1,
    ).map((res) => res.firstOrNull);
  }

  /// Only the [assetId] column is written; all other transaction data is preserved.
  Future<int> linkTransactionToAsset({
    required String transactionId,
    required String assetId,
  }) {
    return (db.update(db.transactions)
          ..where((tbl) => tbl.id.equals(transactionId)))
        .write(TransactionsCompanion(assetID: Value(assetId)));
  }

  /// Removes the asset link from a transaction by setting its [assetId] to null.
  Future<int> unlinkTransactionFromAsset(String transactionId) {
    return (db.update(db.transactions)
          ..where((tbl) => tbl.id.equals(transactionId)))
        .write(TransactionsCompanion(assetID: Value<String?>(null)));
  }
}
