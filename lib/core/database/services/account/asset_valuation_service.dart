import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/asset_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
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

  /// Market value of **linked portfolio assets**.
  ///
  /// When [convertToPreferredCurrency] is false, amounts are summed in each
  /// asset's currency (caller should only use when assets match the account).
  Stream<double> getLinkedPortfolioMarketValue(
    Account account, {
    DateTime? date,
    bool convertToPreferredCurrency = false,
  }) {
    return AssetService.instance
        .getAssets(
          predicate: (a, c) =>
              a.linkedAccountID.isNotNull() &
              a.linkedAccountID.equals(account.id),
        )
        .switchMap((linked) {
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

  /// Returns the current value for an asset.
  ///
  /// Uses the latest valuation if one exists; otherwise returns the asset's
  /// [initialValue].
  Stream<double> getCurrentAssetValue(
    AssetInDB asset, {
    bool convertToPreferredCurrency = false,
  }) {
    return getAssetValueAtDate(
      asset,
      convertToPreferredCurrency: convertToPreferredCurrency,
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
  /// With [considerLinkedAccounts] `true` (default), every asset row is included.
  /// With `false`, assets linked to an account are omitted.
  Stream<double> getTotalAssetsValueAtDate({
    DateTime? date,
    bool considerLinkedAccounts = true,
  }) {
    return AssetService.instance
        .getAssets(
          predicate: (a, currency) => buildDriftExpr([
            if (!considerLinkedAccounts) a.linkedAccountID.isNull(),
          ]),
        )
        .switchMap((assets) {
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
  Stream<double> getStandaloneAssetsValueAtDate({DateTime? date}) {
    return getTotalAssetsValueAtDate(date: date, considerLinkedAccounts: false);
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
      ValuationInDB(
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

  /// Gain vs the asset’s creation-time initial value.
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
