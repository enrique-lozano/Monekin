import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/asset_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:rxdart/rxdart.dart';

/// Service for valuation rows, derived asset values, and valuation sync from transactions.
class AssetValuationService {
  final AppDB db;

  AssetValuationService._(this.db);
  static final AssetValuationService instance = AssetValuationService._(
    AppDB.instance,
  );

  /// Inserts a valuation, or replaces an existing one if there is already
  /// a valuation for the same asset on the same day.
  Future<int> insertOrUpdateValuation(AssetValuationInDB valuation) async {
    final existing = await getValuationsForAsset(valuation.assetId).first;

    final sameDay = existing.where(
      (v) =>
          v.id != valuation.id && DateUtils.isSameDay(v.date, valuation.date),
    );

    if (sameDay.isNotEmpty) {
      valuation = valuation.copyWith(id: sameDay.first.id);
    }

    return db
        .into(db.assetValuations)
        .insert(valuation, mode: InsertMode.insertOrReplace);
  }

  Future<int> deleteValuation(String valuationId) {
    return (db.delete(
      db.assetValuations,
    )..where((tbl) => tbl.id.equals(valuationId))).go();
  }

  Stream<List<AssetValuationInDB>> getValuationsForAsset(String assetId) {
    return db.getValuationsForAsset(assetId: assetId).watch();
  }

  Stream<AssetValuationInDB?> getLatestValuationForAsset(
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

  /// Returns the current value for an asset.
  ///
  /// Uses the latest valuation if one exists; otherwise falls back to the
  /// asset's [getEffectivePurchaseValue].
  Stream<double> getCurrentAssetValue(
    AssetInDB asset, {
    bool convertToPreferredCurrency = false,
  }) {
    return getAssetValueAtDate(
      asset,
      convertToPreferredCurrency: convertToPreferredCurrency,
    );
  }

  /// The effective **purchase value** of the asset, used as the baseline for
  /// performance and as the value shown for the window between the acquisition
  /// date and the first recorded valuation.
  ///
  /// Resolved, in priority order, from:
  /// 1. the linked **acquisition transaction** amount (its magnitude),
  /// 2. the legacy stored [AssetInDB.initialValue] when non-zero,
  /// 3. the earliest recorded valuation (i.e. "as if the purchase price
  ///    equalled the first existing valuation"),
  /// 4. `0` when there is no information at all.
  ///
  /// A manually entered purchase value is persisted as a valuation on the
  /// acquisition date, so it is picked up through the normal valuation lookups
  /// (and short-circuits this resolver via case 3 / the latest-valuation path).
  Stream<double> getEffectivePurchaseValue(AssetInDB asset) {
    final acquisitionStream = TransactionService.instance
        .getTransactions(filters: TransactionFilterSet(assetIds: [asset.id]))
        .map(
          (txs) => txs.firstWhereOrNull(
            (tx) =>
                statusAffectsValuation(tx) &&
                isAcquisitionTransaction(tx, asset),
          ),
        );

    return Rx.combineLatest2(
      acquisitionStream,
      getValuationsForAsset(asset.id),
      (acquisition, valuations) {
        if (acquisition != null) return -acquisition.value;
        if (asset.initialValue != 0) return asset.initialValue;
        if (valuations.isNotEmpty) {
          return valuations
              .reduce((a, b) => a.date.isBefore(b.date) ? a : b)
              .value;
        }
        return 0.0;
      },
    );
  }

  Stream<double> getAssetValueAtDate(
    AssetInDB asset, {
    DateTime? date,
    bool convertToPreferredCurrency = false,
  }) {
    if (date != null && date.isBefore(asset.creationDate)) {
      return Stream.value(0.0);
    }

    return getLatestValuationForAsset(asset.id, date: date).switchMap((
      valuation,
    ) {
      final Stream<double> valueStream = valuation != null
          ? Stream.value(valuation.value)
          : getEffectivePurchaseValue(asset);

      return valueStream.switchMap((value) {
        if (!convertToPreferredCurrency) return Stream.value(value);

        return ExchangeRateService.instance
            .calculateExchangeRateToPreferredCurrency(
              amount: value,
              fromCurrency: asset.currencyId,
              date: date,
            );
      });
    });
  }

  /// Total market value of every asset at [date], in the user's preferred
  /// currency.
  Stream<double> getTotalAssetsValueAtDate({DateTime? date}) {
    return AssetService.instance.getAssets().switchMap((assets) {
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

  /// Valuation snapshot delta from the asset leg amount and buy/sell direction.
  static double valuationDeltaForAssetLeg({
    required double assetLegAmountAbs,
    required bool isBuy,
  }) {
    return isBuy ? assetLegAmountAbs : -assetLegAmountAbs;
  }

  /// Default delta when cash and asset legs match: `-transaction.value`.
  static double valuationDeltaForTransaction(TransactionInDB transaction) {
    if (transaction.assetID == null) return 0;
    if (transaction.type == TransactionType.transfer) return 0;
    return -transaction.value;
  }

  /// A transaction is the asset's **acquisition** record when it's linked to
  /// that asset and dated on the same calendar day as (or before) the asset's
  /// creation date. There is no dedicated DB column for this: it's purely
  /// derived from the dates so that old data (and the "link existing
  /// transaction" flow) keep working.
  ///
  /// The comparison is day-level on purpose: the asset's [AssetInDB.creationDate]
  /// carries a time-of-day (the "acquisition date"), while the purchase
  /// transaction can be logged later that same day. A full-timestamp comparison
  /// would then miss the purchase and double-count it as an extra contribution.
  ///
  /// Its amount already makes up [AssetInDB.initialValue], so it must be
  /// excluded from valuation-delta sums (e.g. net-contribution calculations)
  /// to avoid double counting.
  static bool isAcquisitionTransaction(
    TransactionInDB transaction,
    AssetInDB asset,
  ) {
    return transaction.assetID == asset.id &&
        !DateUtils.dateOnly(
          transaction.date,
        ).isAfter(DateUtils.dateOnly(asset.creationDate));
  }

  static bool statusAffectsValuation(TransactionInDB t) {
    final s = t.status;
    if (s == TransactionStatus.pending || s == TransactionStatus.voided) {
      return false;
    }
    return true;
  }

  /// Reverts any prior impact, then optionally applies [valuationDelta] for [current].
  ///
  /// When [valuationDelta] is null, the current row's impact is derived from
  /// [valuationDeltaForTransaction] (cash leg equals asset leg).
  Future<void> syncValuationOnTransactionSave({
    TransactionInDB? previous,
    required TransactionInDB current,
    double? valuationDelta,
    bool applyCurrent = true,
    bool shiftFutureValuations = false,
  }) async {
    if (previous != null &&
        previous.assetID != null &&
        statusAffectsValuation(previous)) {
      final revertDelta = -valuationDeltaForTransaction(previous);
      await _applyValuationDelta(
        assetId: previous.assetID!,
        date: previous.date,
        delta: revertDelta,
      );
      if (shiftFutureValuations) {
        await _shiftFutureValuations(
          assetId: previous.assetID!,
          date: previous.date,
          delta: revertDelta,
        );
      }
    }

    if (!applyCurrent ||
        !statusAffectsValuation(current) ||
        current.assetID == null) {
      return;
    }

    final delta = valuationDelta ?? valuationDeltaForTransaction(current);
    if (delta == 0) return;

    await _applyValuationDelta(
      assetId: current.assetID!,
      date: current.date,
      delta: delta,
    );
    if (shiftFutureValuations) {
      await _shiftFutureValuations(
        assetId: current.assetID!,
        date: current.date,
        delta: delta,
      );
    }
  }

  /// `newSnapshot = latestValuationAtOrBefore(date) + delta` (same calendar day row updated in place).
  ///
  /// When there is no prior valuation snapshot, transaction-driven updates start
  /// from the asset's initial value so the first auto-valuation becomes
  /// `initialValue ± transactionAmount`.
  Future<void> _applyValuationDelta({
    required String assetId,
    required DateTime date,
    required double delta,
  }) async {
    if (delta == 0) return;

    final latest = await getLatestValuationForAsset(assetId, date: date).first;

    final base = latest?.value ?? await _getAssetInitialValue(assetId);
    final newVal = base + delta;

    await insertOrUpdateValuation(
      AssetValuationInDB(
        id: generateUUID(),
        assetId: assetId,
        date: date,
        value: newVal,
      ),
    );
  }

  Future<double> _getAssetInitialValue(String assetId) async {
    final asset = await (db.select(
      db.assets,
    )..where((tbl) => tbl.id.equals(assetId))).getSingleOrNull();
    return asset?.initialValue ?? 0.0;
  }

  Future<void> _shiftFutureValuations({
    required String assetId,
    required DateTime date,
    required double delta,
  }) async {
    if (delta == 0) return;

    final valuations = await getValuationsForAsset(assetId).first;

    final toShift = valuations.where((valuation) {
      final valuationDay = DateUtils.dateOnly(valuation.date);
      final tradeDay = DateUtils.dateOnly(date);
      return valuationDay.isAfter(tradeDay);
    }).toList();

    if (toShift.isEmpty) return;

    await Future.wait(
      toShift.map(
        (valuation) => insertOrUpdateValuation(
          valuation.copyWith(value: valuation.value + delta),
        ),
      ),
    );
  }

  /// Gain vs the asset's effective purchase value (see
  /// [getEffectivePurchaseValue]).
  Stream<({double value, double percent})> getAssetProfit(Asset asset) {
    return Rx.combineLatest2(
      getCurrentAssetValue(asset),
      getEffectivePurchaseValue(asset),
      (currentValue, purchaseValue) {
        final profit = currentValue - purchaseValue;
        final percent = purchaseValue != 0
            ? profit / purchaseValue
            : currentValue.isNegative
            ? double.negativeInfinity
            : double.infinity;
        return (value: profit, percent: percent);
      },
    );
  }
}
