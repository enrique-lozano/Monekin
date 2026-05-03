import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:rxdart/rxdart.dart';

/// Service for investment accounts, assets, valuations and net worth.
class InvestmentService {
  final AppDB db;

  InvestmentService._(this.db);
  static final InvestmentService instance = InvestmentService._(AppDB.instance);

  // ---------------------------------------------------------------------------
  // Asset CRUD
  // ---------------------------------------------------------------------------

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

  /// Removes the debt link from a transaction by setting its [assetId] to null.
  Future<int> unlinkTransactionFromAsset(String transactionId) {
    return (db.update(db.transactions)
          ..where((tbl) => tbl.id.equals(transactionId)))
        .write(TransactionsCompanion(assetID: Value<String?>(null)));
  }

  // ---------------------------------------------------------------------------
  // Valuation CRUD
  // ---------------------------------------------------------------------------

  /// Inserts a valuation, or replaces an existing one if there is already
  /// a valuation for the same asset on the same day.
  Future<int> insertOrUpdateValuation(ValuationInDB valuation) async {
    final existing = await getValuationsForAsset(valuation.assetId).first;

    final sameDay = existing.where(
      (v) =>
          v.id != valuation.id && DateUtils.isSameDay(v.date, valuation.date),
    );

    if (sameDay.isNotEmpty) {
      valuation = valuation.copyWith(id: sameDay.first.id);
    }

    return db
        .into(db.valuations)
        .insert(valuation, mode: InsertMode.insertOrReplace);
  }

  Future<int> deleteValuation(String valuationId) {
    return (db.delete(
      db.valuations,
    )..where((tbl) => tbl.id.equals(valuationId))).go();
  }

  // ---------------------------------------------------------------------------
  // Valuation queries
  // ---------------------------------------------------------------------------

  Stream<List<ValuationInDB>> getValuationsForAsset(String assetId) {
    return db.getValuationsForAsset(assetId: assetId).watch();
  }

  Stream<ValuationInDB?> getLatestValuationForAsset(
    String assetId, {
    DateTime? date,
  }) {
    if (date != null) {
      return db
          .getLatestValuationForAssetAtDate(assetId: assetId, date: date)
          .watchSingleOrNull();
    }

    return db.getLatestValuationForAsset(assetId: assetId).watchSingleOrNull();
  }

  // ---------------------------------------------------------------------------
  // Investment account metrics
  // ---------------------------------------------------------------------------

  /// Market value of **linked portfolio assets** (migrated from account valuations).
  ///
  /// When [convertToPreferredCurrency] is false, amounts are summed in each
  /// asset's currency (caller should only use when assets match the account).
  Stream<double> getLinkedPortfolioMarketValue(
    Account account, {
    DateTime? date,
    bool convertToPreferredCurrency = false,
  }) {
    return getAssets(
      predicate: (a, c) =>
          a.linkedAccountID.isNotNull() & a.linkedAccountID.equals(account.id),
    ).switchMap((linked) {
      if (linked.isEmpty) return Stream.value(0.0);
      final streams = linked
          .map(
            (asset) => getAssetValueAtDate(
              asset,
              date: date,
              convertToPreferredCurrency: convertToPreferredCurrency,
            ),
          )
          .toList();
      return Rx.combineLatestList(
        streams,
      ).map((values) => values.fold<double>(0, (sum, v) => sum + v));
    });
  }

  // ---------------------------------------------------------------------------
  // Asset value
  // ---------------------------------------------------------------------------

  /// Returns the current value for an asset
  ///
  /// Uses the latest valuation if one exists; otherwise returns the asset's
  /// [initialValue].
  Stream<double> getCurrentAssetValue(
    AssetInDB asset, {
    convertToPreferredCurrency = false,
  }) {
    return getAssetValueAtDate(
      asset,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );
  }

  Stream<double> getAssetValueAtDate(
    AssetInDB asset, {
    DateTime? date,
    convertToPreferredCurrency = false,
  }) {
    if (date != null && date.isBefore(asset.creationDate)) {
      return Stream.value(0.0);
    }

    return getLatestValuationForAsset(asset.id, date: date).switchMap((
      valuation,
    ) {
      final value = valuation?.value ?? asset.initialValue;

      if (!convertToPreferredCurrency) return Stream.value(value);

      return ExchangeRateService.instance
          .calculateExchangeRateToPreferredCurrency(
            amount: value,
            fromCurrency: asset.currencyId,
            date: date,
          );
    });
  }

  /// Total market value of assets at [date] in the user's preferred currency.
  ///
  /// With [considerLinkedAccounts] `true` (default), every asset row is included
  /// (e.g. useful for an “all rows in the assets table” total).
  ///
  /// With `false`, assets linked to an account ([Assets.linkedAccountID] set) are
  /// omitted — use that next to combined account balances so linked holdings are not
  /// double-counted. Prefer [getStandaloneAssetsValueAtDate] at call sites that always
  /// want the latter.
  Stream<double> getTotalAssetsValueAtDate({
    DateTime? date,
    bool considerLinkedAccounts = true,
  }) {
    return getAssets(
      predicate: (a, currency) => buildDriftExpr([
        if (!considerLinkedAccounts) a.linkedAccountID.isNull(),
      ]),
    ).switchMap((assets) {
      if (assets.isEmpty) {
        return Stream.value(0.0);
      }

      final streams = assets
          .map(
            (asset) => getAssetValueAtDate(
              asset,
              date: date,
              convertToPreferredCurrency: true,
            ),
          )
          .toList();

      return CombineLatestStream.list(
        streams,
      ).map((values) => values.fold(0.0, (sum, value) => sum + value));
    });
  }

  /// Same as [getTotalAssetsValueAtDate] with linked-account assets excluded.
  ///
  /// Linked portfolio assets are already counted inside the parent account’s balance;
  /// summing them again would overstate net worth (see `NetWorthService.getGrossAssetsAtDate`).
  Stream<double> getStandaloneAssetsValueAtDate({DateTime? date}) {
    return getTotalAssetsValueAtDate(
      date: date,
      considerLinkedAccounts: false,
    );
  }

  /// Sum of linked asset market values for an account (0 if none).
  Stream<double> streamLinkedAssetsTotalForAccount(
    String accountId, {
    DateTime? date,
    bool convertToPreferredCurrency = false,
  }) {
    return db
        .getAccountsWithFullData(
          predicate: (a, c) => a.id.equals(accountId),
          limit: (a, c) => Limit(1, 0),
        )
        .watch()
        .switchMap((accounts) {
          if (accounts.isEmpty) return Stream.value(0.0);
          final account = accounts.first;
          return getLinkedPortfolioMarketValue(
            account,
            date: date,
            convertToPreferredCurrency: convertToPreferredCurrency,
          );
        });
  }

  // ---------------------------------------------------------------------------
  // Valuation adjustments from transactions (cash leg vs holdings snapshot)
  // ---------------------------------------------------------------------------

  /// How [transaction] should move the asset valuation snapshot (accounting currency).
  ///
  /// Uses the same signed `value` stored for cash (expenses negative on outflow, etc.):
  /// snapshot moves by `-value` so typical buys (negative `value`) increase the asset.
  static double valuationDeltaForTransaction(TransactionInDB transaction) {
    if (transaction.assetID == null) return 0;
    if (transaction.type == TransactionType.transfer) return 0;
    return -transaction.value;
  }

  static bool _statusAffectsValuation(TransactionInDB t) {
    final s = t.status;
    if (s == TransactionStatus.pending || s == TransactionStatus.voided) {
      return false;
    }
    return true;
  }

  Future<void> onTransactionSaved(TransactionInDB inserted) async {
    if (!_statusAffectsValuation(inserted) || inserted.assetID == null) {
      return;
    }
    await _applyValuationDelta(
      assetId: inserted.assetID!,
      date: inserted.date,
      delta: valuationDeltaForTransaction(inserted),
    );
  }

  Future<void> onTransactionUpdated(
    TransactionInDB? previous,
    TransactionInDB current,
  ) async {
    if (previous != null &&
        previous.assetID != null &&
        _statusAffectsValuation(previous)) {
      await _applyValuationDelta(
        assetId: previous.assetID!,
        date: previous.date,
        delta: -valuationDeltaForTransaction(previous),
      );
    }
    if (_statusAffectsValuation(current) && current.assetID != null) {
      await _applyValuationDelta(
        assetId: current.assetID!,
        date: current.date,
        delta: valuationDeltaForTransaction(current),
      );
    }
  }

  Future<void> onTransactionDeleted(TransactionInDB removed) async {
    if (!_statusAffectsValuation(removed) || removed.assetID == null) return;
    await _applyValuationDelta(
      assetId: removed.assetID!,
      date: removed.date,
      delta: -valuationDeltaForTransaction(removed),
    );
  }

  /// `newSnapshot = latestValuationAtOrBefore(date) + delta` (same calendar day row updated in place).
  ///
  /// Transaction-driven base uses **0** when there is no prior snapshot (manual
  /// valuations still “win” for display until a tx touches that day).
  Future<void> _applyValuationDelta({
    required String assetId,
    required DateTime date,
    required double delta,
  }) async {
    if (delta == 0) return;

    final latest = await db
        .getLatestValuationForAssetAtDate(assetId: assetId, date: date)
        .getSingleOrNull();

    final base = latest?.value ?? 0.0;
    final newVal = base + delta;

    await insertOrUpdateValuation(
      ValuationInDB(
        id: generateUUID(),
        assetId: assetId,
        date: date,
        value: newVal,
      ),
    );
  }

  /// Gain vs the asset’s **creation-time initial value** ([AssetInDB.initialValue]),
  /// not a full cost basis rebuilt from every trade.
  ///
  /// Emits `(value, percent)` where `value` is current market value minus initial,
  /// and `percent` is `value / initial` when initial ≠ 0; otherwise signed infinities
  /// for display edge cases.
  Stream<({double value, double percent})> getAssetProfit(Asset asset) {
    return getCurrentAssetValue(asset).map((currentValue) {
      final profit = currentValue - asset.initialValue;
      final percent = asset.initialValue != 0
          ? profit / asset.initialValue
          : currentValue.isNegative
          ? double.negativeInfinity
          : double.infinity;
      return (value: profit, percent: percent);
    });
  }
}
