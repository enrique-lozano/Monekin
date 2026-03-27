import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/numbers.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
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

  // ---------------------------------------------------------------------------
  // Valuation CRUD
  // ---------------------------------------------------------------------------

  Future<int> insertValuation(ValuationInDB valuation) {
    return db.into(db.valuations).insert(valuation);
  }

  Future<bool> updateValuation(ValuationInDB valuation) {
    return db.update(db.valuations).replace(valuation);
  }

  /// Inserts a valuation, or replaces an existing one if there is already
  /// a valuation for the same account/asset on the same day.
  Future<int> insertOrUpdateValuation(ValuationInDB valuation) async {
    final existing = await getValuationsForAccount(valuation.accountId!).first;

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

  Stream<List<ValuationInDB>> getValuationsForAccount(String accountId) {
    return db.getValuationsForAccount(accountId: accountId).watch();
  }

  Stream<ValuationInDB?> getLatestValuationForAccount(
    String accountId, {
    DateTime? date,
  }) {
    if (date != null) {
      return db
          .getLatestValuationForAccountAtDate(accountId: accountId, date: date)
          .watchSingleOrNull();
    }

    return db
        .getLatestValuationForAccount(accountId: accountId)
        .watchSingleOrNull();
  }

  Stream<List<ValuationInDB>> getValuationsForAsset(String assetId) {
    return db.getValuationsForAsset(assetId: assetId).watch();
  }

  Stream<ValuationInDB?> getLatestValuationForAsset(String assetId) {
    return db.getLatestValuationForAsset(assetId: assetId).watchSingleOrNull();
  }

  // ---------------------------------------------------------------------------
  // Investment account metrics
  // ---------------------------------------------------------------------------

  /// Returns the total capital invested into the given investment account.
  ///
  /// This is calculated as:
  ///   iniValue + net transfers (transfersIn - transfersOut) in account currency.
  ///
  /// If [date] is provided, only transfers up to that date are included.
  ///
  /// Delegates to [TransactionService.getTransactionsValueBalance] filtered to
  /// transfers only, which already handles valueInDestiny vs value correctly.
  Stream<double> getInvestedCapital(Account account, {DateTime? date}) {
    return TransactionService.instance
        .getTransactionsValueBalance(
          filters: TransactionFilterSet(
            accountsIDs: [account.id],
            transactionTypes: [TransactionType.transfer],
            maxDate: date,
          ),
          convertToPreferredCurrency: false,
        )
        .map((netTransfers) => account.iniValue + netTransfers);
  }

  /// Returns the portfolio money/value for an investment account.
  ///
  /// If [date] is provided, returns the value from the **latest valuation
  /// at or before** that date. Otherwise, returns the latest valuation.
  ///
  /// If no valuation has been recorded (for the given date), falls back to
  /// [getInvestedCapital].
  ///
  /// If [convertToPreferredCurrency] is not set or `false`, the returned value
  /// is in the account currency. If `true`, the value is converted to the preferred
  /// currency using the exchange rate at the given date (or latest if date is null).
  Stream<double> getInvestmentAccountValue(
    Account account, {
    DateTime? date,
    bool convertToPreferredCurrency = false,
  }) {
    return getLatestValuationForAccount(account.id, date: date)
        .switchMap((valuation) {
          if (valuation != null) {
            return Stream.value(valuation.value);
          }

          return getInvestedCapital(account, date: date);
        })
        .switchMap((value) {
          if (!convertToPreferredCurrency) return Stream.value(value);

          // Convert to preferred currency via exchange rate
          return ExchangeRateService.instance
              .calculateExchangeRateToPreferredCurrency(
                amount: value,
                fromCurrency: account.currency.code,
                date: date,
              );
        })
        .map(
          (converted) =>
              converted.roundWithDecimals(account.currency.decimalPlaces),
        );
  }

  /// Returns the profit (in the account currency) and the profit percentage
  /// for an investment account.
  ///
  /// Profit = portfolioValue - investedCapital
  /// Percent = profit / investedCapital  (0 when investedCapital == 0)
  Stream<({double value, double percent})> getInvestmentProfit(
    Account account,
  ) {
    return Rx.combineLatest2(
      getInvestmentAccountValue(account),
      getInvestedCapital(account),
      (double portfolioValue, double investedCapital) {
        final profit = portfolioValue - investedCapital;
        final percent = investedCapital != 0 ? profit / investedCapital : 0.0;
        return (value: profit, percent: percent);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Asset value
  // ---------------------------------------------------------------------------

  /// Returns the current value for an asset.
  ///
  /// Uses the latest valuation if one exists; otherwise returns the asset's
  /// [initialValue].
  Stream<double> getAssetValue(AssetInDB asset) {
    return getLatestValuationForAsset(
      asset.id,
    ).map((valuation) => valuation?.value ?? asset.initialValue);
  }
}
