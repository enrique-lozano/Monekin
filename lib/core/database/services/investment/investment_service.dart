import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
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

  Stream<ValuationInDB?> getLatestValuationForAccount(String accountId) {
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
  /// Delegates to [TransactionService.getTransactionsValueBalance] filtered to
  /// transfers only, which already handles valueInDestiny vs value correctly.
  Stream<double> getInvestedCapital(Account account) {
    return TransactionService.instance
        .getTransactionsValueBalance(
          filters: TransactionFilterSet(
            accountsIDs: [account.id],
            transactionTypes: [TransactionType.transfer],
          ),
          convertToPreferredCurrency: false,
        )
        .map((netTransfers) => account.iniValue + netTransfers);
  }

  /// Returns the current portfolio value for an investment account.
  ///
  /// This is the value from the **latest valuation** for the account.
  /// If no valuation has been recorded yet, falls back to [getInvestedCapital].
  Stream<double> getPortfolioValue(Account account) {
    return getLatestValuationForAccount(account.id).switchMap((valuation) {
      if (valuation != null) {
        return Stream.value(valuation.value);
      }

      return getInvestedCapital(account);
    });
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
      getPortfolioValue(account),
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

  // ---------------------------------------------------------------------------
  // Net worth
  // ---------------------------------------------------------------------------

  /// Returns the total net worth in the user's preferred currency.
  ///
  /// Includes:
  ///   1. Balances of `normal` and `saving` accounts with [includeInNetWorth] = true
  ///   2. Portfolio values of `investment` accounts with [includeInNetWorth] = true
  ///   3. Values of assets with [includeInNetWorth] = true
  ///
  /// All amounts are converted to the preferred currency via the latest
  /// available exchange rates.
  Stream<double> getNetWorth() {
    // 1. Balances of cash/savings accounts (preferred currency)
    final cashStream = AccountService.instance.getAccountsMoney(
      convertToPreferredCurrency: true,
    );

    // 2. Portfolio values of investment accounts (preferred currency via SQL)
    final investmentStream = db
        .customSelect(
          '''
          SELECT COALESCE(SUM(
            COALESCE(
              -- Latest valuation for this account (in account currency * exchange rate)
              (SELECT v.value * COALESCE(excRate.exchangeRate, 1)
               FROM valuations v
               LEFT JOIN (
                 SELECT currencyCode, exchangeRate
                 FROM exchangeRates er
                 WHERE date = (
                   SELECT MAX(date) FROM exchangeRates
                   WHERE currencyCode = er.currencyCode
                     AND date <= DATE('now')
                 )
               ) excRate ON a.currencyId = excRate.currencyCode
               WHERE v.accountId = a.id
               ORDER BY v.date DESC
               LIMIT 1),
              -- Fallback: invested capital (iniValue + transfers in - transfers out)
              (
                a.iniValue +
                COALESCE((
                  SELECT SUM(COALESCE(t.valueInDestiny, t.value))
                  FROM transactions t
                  WHERE t.receivingAccountID = a.id
                    AND t.type = 'T'
                    AND (t.status IS NULL OR t.status NOT IN ('P', 'V'))
                ), 0) -
                COALESCE((
                  SELECT SUM(t.value)
                  FROM transactions t
                  WHERE t.accountID = a.id
                    AND t.type = 'T'
                    AND (t.status IS NULL OR t.status NOT IN ('P', 'V'))
                ), 0)
              ) * COALESCE(excRate2.exchangeRate, 1)
            )
          ), 0) AS totalInvestmentValue
          FROM accounts a
          LEFT JOIN (
            SELECT currencyCode, exchangeRate
            FROM exchangeRates er
            WHERE date = (
              SELECT MAX(date) FROM exchangeRates
              WHERE currencyCode = er.currencyCode
                AND date <= DATE('now')
            )
          ) excRate2 ON a.currencyId = excRate2.currencyCode
          WHERE a.type = 'investment'
            AND a.includeInNetWorth = 1
            AND a.closingDate IS NULL
          ''',
          readsFrom: {
            db.accounts,
            db.valuations,
            db.transactions,
            db.exchangeRates,
          },
        )
        .watchSingle()
        .map(
          (row) => (row.data['totalInvestmentValue'] as num? ?? 0).toDouble(),
        );

    // 3. Asset values (preferred currency via SQL)
    final assetStream = db
        .customSelect(
          '''
          SELECT COALESCE(SUM(
            COALESCE(
              (SELECT v.value FROM valuations v
               WHERE v.assetId = ast.id
               ORDER BY v.date DESC
               LIMIT 1),
              ast.initialValue
            ) * COALESCE(excRate.exchangeRate, 1)
          ), 0) AS totalAssetValue
          FROM assets ast
          LEFT JOIN (
            SELECT currencyCode, exchangeRate
            FROM exchangeRates er
            WHERE date = (
              SELECT MAX(date) FROM exchangeRates
              WHERE currencyCode = er.currencyCode
                AND date <= DATE('now')
            )
          ) excRate ON ast.currencyId = excRate.currencyCode
          WHERE ast.includeInNetWorth = 1
          ''',
          readsFrom: {db.assets, db.valuations, db.exchangeRates},
        )
        .watchSingle()
        .map((row) => (row.data['totalAssetValue'] as num? ?? 0).toDouble());

    return Rx.combineLatest3(
      cashStream,
      investmentStream,
      assetStream,
      (double cash, double investment, double assets) =>
          cash + investment + assets,
    );
  }

  /// Net worth broken down into its three components, all in preferred currency.
  Stream<({double cash, double investment, double assets, double total})>
  getNetWorthBreakdown() {
    final cashStream = AccountService.instance.getAccountsMoney(
      convertToPreferredCurrency: true,
    );

    final investmentStream = db
        .customSelect(
          '''
          SELECT COALESCE(SUM(
            COALESCE(
              (SELECT v.value * COALESCE(excRate.exchangeRate, 1)
               FROM valuations v
               LEFT JOIN (
                 SELECT currencyCode, exchangeRate
                 FROM exchangeRates er
                 WHERE date = (
                   SELECT MAX(date) FROM exchangeRates
                   WHERE currencyCode = er.currencyCode
                     AND date <= DATE('now')
                 )
               ) excRate ON a.currencyId = excRate.currencyCode
               WHERE v.accountId = a.id
               ORDER BY v.date DESC
               LIMIT 1),
              (
                a.iniValue +
                COALESCE((
                  SELECT SUM(COALESCE(t.valueInDestiny, t.value))
                  FROM transactions t
                  WHERE t.receivingAccountID = a.id
                    AND t.type = 'T'
                    AND (t.status IS NULL OR t.status NOT IN ('P', 'V'))
                ), 0) -
                COALESCE((
                  SELECT SUM(t.value)
                  FROM transactions t
                  WHERE t.accountID = a.id
                    AND t.type = 'T'
                    AND (t.status IS NULL OR t.status NOT IN ('P', 'V'))
                ), 0)
              ) * COALESCE(excRate2.exchangeRate, 1)
            )
          ), 0) AS total
          FROM accounts a
          LEFT JOIN (
            SELECT currencyCode, exchangeRate
            FROM exchangeRates er
            WHERE date = (
              SELECT MAX(date) FROM exchangeRates
              WHERE currencyCode = er.currencyCode
                AND date <= DATE('now')
            )
          ) excRate2 ON a.currencyId = excRate2.currencyCode
          WHERE a.type = 'investment'
            AND a.includeInNetWorth = 1
            AND a.closingDate IS NULL
          ''',
          readsFrom: {
            db.accounts,
            db.valuations,
            db.transactions,
            db.exchangeRates,
          },
        )
        .watchSingle()
        .map((row) => (row.data['total'] as num? ?? 0).toDouble());

    final assetStream = db
        .customSelect(
          '''
          SELECT COALESCE(SUM(
            COALESCE(
              (SELECT v.value FROM valuations v
               WHERE v.assetId = ast.id
               ORDER BY v.date DESC
               LIMIT 1),
              ast.initialValue
            ) * COALESCE(excRate.exchangeRate, 1)
          ), 0) AS total
          FROM assets ast
          LEFT JOIN (
            SELECT currencyCode, exchangeRate
            FROM exchangeRates er
            WHERE date = (
              SELECT MAX(date) FROM exchangeRates
              WHERE currencyCode = er.currencyCode
                AND date <= DATE('now')
            )
          ) excRate ON ast.currencyId = excRate.currencyCode
          WHERE ast.includeInNetWorth = 1
          ''',
          readsFrom: {db.assets, db.valuations, db.exchangeRates},
        )
        .watchSingle()
        .map((row) => (row.data['total'] as num? ?? 0).toDouble());

    return Rx.combineLatest3(
      cashStream,
      investmentStream,
      assetStream,
      (double cash, double investment, double assets) => (
        cash: cash,
        investment: investment,
        assets: assets,
        total: cash + investment + assets,
      ),
    );
  }
}
