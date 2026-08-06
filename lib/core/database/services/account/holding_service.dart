import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:rxdart/rxdart.dart';

/// Manages [holdings] (positions of a [security] inside an account) using a
/// weighted-average cost basis, and records the matching cash trades.
class HoldingService {
  final AppDB db;

  HoldingService._(this.db);
  static final HoldingService instance = HoldingService._(AppDB.instance);

  /// Creates a service bound to a specific (test) database.
  @visibleForTesting
  HoldingService.forTesting(this.db);

  Stream<List<HoldingWithSecurity>> getHoldingsForAccount(String accountId) {
    final query = db.select(db.holdings).join([
      innerJoin(
        db.securities,
        db.securities.id.equalsExp(db.holdings.securityID),
      ),
    ])..where(db.holdings.accountID.equals(accountId));

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => HoldingWithSecurity(
              holding: row.readTable(db.holdings),
              security: row.readTable(db.securities),
            ),
          )
          .toList(),
    );
  }

  /// All holdings across every account, joined with their security.
  Stream<List<HoldingWithSecurity>> getAllHoldings() {
    final query = db.select(db.holdings).join([
      innerJoin(
        db.securities,
        db.securities.id.equalsExp(db.holdings.securityID),
      ),
    ]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => HoldingWithSecurity(
              holding: row.readTable(db.holdings),
              security: row.readTable(db.securities),
            ),
          )
          .toList(),
    );
  }

  /// Every position of a given [securityId] across accounts, each joined with
  /// its account (with currency, so its icon/color can be displayed via
  /// [Account.displayIcon]) and the security (so market value / P&L can be
  /// derived).
  Stream<List<({HoldingWithSecurity data, Account account})>>
  getHoldingsForSecurity(String securityId) {
    final query = db.select(db.holdings).join([
      innerJoin(
        db.securities,
        db.securities.id.equalsExp(db.holdings.securityID),
      ),
      innerJoin(db.accounts, db.accounts.id.equalsExp(db.holdings.accountID)),
      innerJoin(
        db.currencies,
        db.currencies.code.equalsExp(db.accounts.currencyId),
      ),
    ])..where(db.holdings.securityID.equals(securityId));

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => (
              data: HoldingWithSecurity(
                holding: row.readTable(db.holdings),
                security: row.readTable(db.securities),
              ),
              account: Account.fromDB(
                row.readTable(db.accounts),
                row.readTable(db.currencies),
              ),
            ),
          )
          .toList(),
    );
  }

  Stream<HoldingInDB?> getHolding(String accountId, String securityId) {
    return _selectHolding(accountId, securityId).watchSingleOrNull();
  }

  SimpleSelectStatement<Holdings, HoldingInDB> _selectHolding(
    String accountId,
    String securityId,
  ) {
    return db.select(db.holdings)..where(
      (tbl) =>
          tbl.accountID.equals(accountId) & tbl.securityID.equals(securityId),
    );
  }

  /// Total market value of holdings **as of [date]** (defaults to now),
  /// converted as requested.
  ///
  /// The value is time-aware and reflects the full position history, not just
  /// the securities currently held (see [_watchPositionValuations]). For each
  /// position the quantity held at [date] and the security's price at [date] are
  /// used, so historical charts reflect both the position size and the price at
  /// that point in time.
  ///
  /// Conversion:
  /// - [convertToPreferred] `true`: every position is converted to the user's
  ///   preferred currency.
  /// - else if [convertToCurrency] is set: converted to that currency.
  /// - else: summed raw (in each security's own currency).
  Stream<double> getHoldingsMarketValue({
    Iterable<String>? accountIds,
    String? convertToCurrency,
    bool convertToPreferred = false,
    DateTime? date,
  }) {
    if (accountIds != null && accountIds.isEmpty) return Stream.value(0.0);

    return _watchPositionValuations(
      date: date,
      accountIds: accountIds,
    ).switchMap((rows) {
      // Group the raw market value by currency, then convert per currency.
      final byCurrency = <String, double>{};
      for (final r in rows) {
        final market = r.quantity * r.price;
        if (market == 0) continue;
        byCurrency.update(
          r.currencyId,
          (v) => v + market,
          ifAbsent: () => market,
        );
      }

      if (byCurrency.isEmpty) return Stream.value(0.0);

      final streams = byCurrency.entries.map((e) {
        if (convertToPreferred) {
          return ExchangeRateService.instance
              .calculateExchangeRateToPreferredCurrency(
                amount: e.value,
                fromCurrency: e.key,
                date: date,
              );
        }

        if (convertToCurrency != null && e.key != convertToCurrency) {
          return ExchangeRateService.instance.calculateExchangeRate(
            fromCurrency: e.key,
            toCurrency: convertToCurrency,
            amount: e.value,
            date: date,
          );
        }

        return Stream.value(e.value);
      }).toList();

      return Rx.combineLatestList(
        streams,
      ).map((values) => values.fold<double>(0, (a, b) => a + b));
    });
  }

  /// Reconstructs the quantity, price and average cost of **every position that
  /// has ever existed** (per account/security) as of [date], branched by the
  /// account's [AccountTrackingMode]. This is the single source of truth for
  /// time-aware valuation and composition:
  ///
  /// - The universe of positions comes from the account's *activity*, not the
  ///   current `holdings` table, so a security sold before [date] still shows
  ///   its value on any earlier date:
  ///   - `transactions` mode: every security traded (type 'N') up to [date].
  ///   - `holdings` mode: every security appearing in any snapshot.
  /// - Quantity/avg-cost at [date]:
  ///   - `transactions`: the trades up to [date] replayed in order, exactly as
  ///     [recomputeHolding] does, so the average cost is the one of the
  ///     position still open (a position that is closed and bought again starts
  ///     its cost basis from scratch).
  ///   - `holdings`: the position taken from the most recent snapshot on or
  ///     before [date] (0 if the security is absent from that snapshot, i.e. it
  ///     was removed).
  /// - Price at [date]: latest `securityPriceHistory` observation on or before
  ///   [date], falling back to the security's current price.
  Stream<
    List<
      ({
        String accountId,
        String securityId,
        String securityName,
        SecurityType securityType,
        String currencyId,
        double quantity,
        double price,
        double avgCost,
      })
    >
  >
  _watchPositionValuations({DateTime? date, Iterable<String>? accountIds}) {
    final effectiveDate = date ?? DateTime.now();

    // ?1 is the date; ?2.. are the (optional) account ids. Numbered parameters
    // let the same value be referenced from several places in the query.
    final accountIdPlaceholders = accountIds == null
        ? ''
        : List.generate(accountIds.length, (i) => '?${i + 2}').join(', ');
    final tradesAccountFilter = accountIds == null
        ? ''
        : 'AND t.accountID IN ($accountIdPlaceholders)';
    final accountFilter = accountIds == null
        ? ''
        : 'WHERE u.accountID IN ($accountIdPlaceholders)';

    final sql =
        '''
      WITH RECURSIVE trades AS (
        SELECT
          t.accountID AS accountID,
          t.securityID AS securityID,
          COALESCE(t.quantity, 0) AS q,
          COALESCE(t.pricePerUnit, 0) AS p,
          ROW_NUMBER() OVER (
            PARTITION BY t.accountID, t.securityID ORDER BY t.date, t.id
          ) AS rn
        FROM transactions t
        JOIN accounts a ON a.id = t.accountID
        WHERE t.type = 'N' AND t.securityID IS NOT NULL
          AND a.trackingMode = 'transactions'
          AND t.date <= ?1
          $tradesAccountFilter
      ),
      -- Running weighted-average cost, mirroring `recomputeHolding`: buys move
      -- the average, sells only shrink the quantity, and a position that closes
      -- leaves a quantity of 0 so the next buy starts a fresh cost basis.
      replay(accountID, securityID, rn, qty, avgCost) AS (
        SELECT accountID, securityID, rn,
               CASE WHEN q > 0 THEN q ELSE 0 END,
               CASE WHEN q > 0 THEN p ELSE 0 END
        FROM trades WHERE rn = 1
        UNION ALL
        SELECT t.accountID, t.securityID, t.rn,
               CASE WHEN t.q > 0 OR r.qty + t.q > 0.0000001
                    THEN r.qty + t.q ELSE 0 END,
               CASE WHEN t.q > 0
                    THEN ((r.qty * r.avgCost) + (t.q * t.p)) / (r.qty + t.q)
                    ELSE r.avgCost END
        FROM replay r
        JOIN trades t ON t.accountID = r.accountID
                     AND t.securityID = r.securityID
                     AND t.rn = r.rn + 1
      ),
      tradedPosition AS (
        SELECT accountID, securityID, qty, avgCost FROM (
          SELECT accountID, securityID, qty, avgCost,
                 ROW_NUMBER() OVER (
                   PARTITION BY accountID, securityID ORDER BY rn DESC
                 ) AS isLast
          FROM replay
        ) WHERE isLast = 1
      ),
      universe AS (
        SELECT accountID, securityID FROM tradedPosition
        UNION
        SELECT acs.accountID AS accountID, hs.securityID AS securityID
        FROM accountSnapshots acs
        JOIN holdingSnapshots hs ON hs.snapshotID = acs.id
        JOIN accounts a ON a.id = acs.accountID
        WHERE a.trackingMode = 'holdings'
      )
      SELECT
        u.accountID AS accountId,
        u.securityID AS securityId,
        s.name AS securityName,
        s.type AS securityType,
        s.currencyId AS currencyId,
        (CASE a.trackingMode
           WHEN 'holdings' THEN COALESCE((
               SELECT hs.quantity FROM holdingSnapshots hs
               JOIN accountSnapshots acs ON acs.id = hs.snapshotID
               WHERE acs.accountID = u.accountID AND hs.securityID = u.securityID
                 AND acs.date = (SELECT MAX(acs2.date) FROM accountSnapshots acs2
                                 WHERE acs2.accountID = u.accountID AND acs2.date <= ?1)
           ), 0)
           ELSE COALESCE(tp.qty, 0)
         END) AS quantity,
        COALESCE(
          (SELECT sph.price FROM securityPriceHistory sph
            WHERE sph.securityID = u.securityID AND sph.date <= ?1
            ORDER BY sph.date DESC LIMIT 1),
          s.currentPrice, 0) AS price,
        (CASE a.trackingMode
           WHEN 'holdings' THEN COALESCE((
               SELECT hs.avgCostPrice FROM holdingSnapshots hs
               JOIN accountSnapshots acs ON acs.id = hs.snapshotID
               WHERE acs.accountID = u.accountID AND hs.securityID = u.securityID
                 AND acs.date = (SELECT MAX(acs2.date) FROM accountSnapshots acs2
                                 WHERE acs2.accountID = u.accountID AND acs2.date <= ?1)
           ), 0)
           ELSE COALESCE(tp.avgCost, 0)
         END) AS avgCost
      FROM universe u
      JOIN accounts a ON a.id = u.accountID
      JOIN securities s ON s.id = u.securityID
      LEFT JOIN tradedPosition tp ON tp.accountID = u.accountID
                                 AND tp.securityID = u.securityID
      $accountFilter
      ''';

    final variables = <Variable>[
      Variable.withDateTime(effectiveDate),
      if (accountIds != null)
        for (final id in accountIds) Variable.withString(id),
    ];

    return db
        .customSelect(
          sql,
          variables: variables,
          readsFrom: {
            db.holdings,
            db.securities,
            db.accounts,
            db.transactions,
            db.accountSnapshots,
            db.holdingSnapshots,
            db.securityPriceHistory,
          },
        )
        .watch()
        .map(
          (rows) => rows
              .map(
                (r) => (
                  accountId: r.read<String>('accountId'),
                  securityId: r.read<String>('securityId'),
                  securityName: r.read<String>('securityName'),
                  securityType: SecurityType.values.byName(
                    r.read<String>('securityType'),
                  ),
                  currencyId: r.read<String>('currencyId'),
                  quantity: (r.data['quantity'] as num?)?.toDouble() ?? 0.0,
                  price: (r.data['price'] as num?)?.toDouble() ?? 0.0,
                  avgCost: (r.data['avgCost'] as num?)?.toDouble() ?? 0.0,
                ),
              )
              .toList(),
        );
  }

  /// Buy [quantity] units at [pricePerUnit]: increases the position (recomputing
  /// the weighted-average cost) and records a cash-out investment transaction.
  ///
  /// The position and the trade are written in a single transaction, so the
  /// quantity and the ledger can never diverge.
  Future<void> buy({
    required String accountId,
    required String securityId,
    required double quantity,
    required double pricePerUnit,
    DateTime? date,
    String? title,
    String? notes,
  }) async {
    if (quantity <= 0) return;

    final tradeDate = date ?? DateTime.now();

    await db.transaction(() async {
      final existing = await _selectHolding(
        accountId,
        securityId,
      ).getSingleOrNull();

      if (existing == null) {
        await db
            .into(db.holdings)
            .insert(
              HoldingInDB(
                id: generateUUID(),
                accountID: accountId,
                securityID: securityId,
                quantity: quantity,
                avgCostPrice: pricePerUnit,
              ),
            );
      } else {
        final newQty = existing.quantity + quantity;
        final newAvg = newQty <= 0
            ? pricePerUnit
            : ((existing.quantity * existing.avgCostPrice) +
                      (quantity * pricePerUnit)) /
                  newQty;

        await (db.update(
          db.holdings,
        )..where((t) => t.id.equals(existing.id))).write(
          HoldingsCompanion(
            quantity: Value(newQty),
            avgCostPrice: Value(newAvg),
          ),
        );
      }

      await _recordTrade(
        accountId: accountId,
        securityId: securityId,
        quantity: quantity,
        pricePerUnit: pricePerUnit,
        cashDelta: -(quantity * pricePerUnit),
        date: tradeDate,
        title: title,
        notes: notes,
      );
    });
  }

  /// Sell [quantity] units at [pricePerUnit]: reduces the position (keeping the
  /// average cost) and records a cash-in investment transaction.
  ///
  /// Does nothing when the position does not exist or when [quantity] is larger
  /// than the units held: writing the trade anyway would leave the ledger and
  /// the position out of sync. Callers are expected to validate this first.
  ///
  /// The position and the trade are written in a single transaction, so the
  /// quantity and the ledger can never diverge.
  Future<void> sell({
    required String accountId,
    required String securityId,
    required double quantity,
    required double pricePerUnit,
    DateTime? date,
    String? title,
    String? notes,
  }) async {
    if (quantity <= 0) return;

    final tradeDate = date ?? DateTime.now();

    await db.transaction(() async {
      final existing = await _selectHolding(
        accountId,
        securityId,
      ).getSingleOrNull();

      if (existing == null) return;
      if (quantity > existing.quantity + 0.0000001) return;

      final newQty = existing.quantity - quantity;

      if (newQty <= 0.0000001) {
        await (db.delete(
          db.holdings,
        )..where((t) => t.id.equals(existing.id))).go();
      } else {
        await (db.update(db.holdings)..where((t) => t.id.equals(existing.id)))
            .write(HoldingsCompanion(quantity: Value(newQty)));
      }

      await _recordTrade(
        accountId: accountId,
        securityId: securityId,
        quantity: -quantity,
        pricePerUnit: pricePerUnit,
        cashDelta: quantity * pricePerUnit,
        date: tradeDate,
        title: title,
        notes: notes,
      );
    });
  }

  /// Directly sets a position's quantity and average cost without moving cash.
  Future<void> setHolding({
    required String accountId,
    required String securityId,
    required double quantity,
    required double avgCostPrice,
  }) async {
    final existing = await _selectHolding(
      accountId,
      securityId,
    ).getSingleOrNull();

    if (existing == null) {
      if (quantity <= 0) return;
      await db
          .into(db.holdings)
          .insert(
            HoldingInDB(
              id: generateUUID(),
              accountID: accountId,
              securityID: securityId,
              quantity: quantity,
              avgCostPrice: avgCostPrice,
            ),
          );
      return;
    }

    if (quantity <= 0.0000001) {
      await (db.delete(
        db.holdings,
      )..where((t) => t.id.equals(existing.id))).go();
      return;
    }

    await (db.update(
      db.holdings,
    )..where((t) => t.id.equals(existing.id))).write(
      HoldingsCompanion(
        quantity: Value(quantity),
        avgCostPrice: Value(avgCostPrice),
      ),
    );
  }

  /// Replays every security trade of the (account, security) pair in date order
  /// and returns the resulting position: buys move the weighted-average cost,
  /// sells only shrink the quantity, and a position that closes leaves a
  /// quantity of 0 so the next buy starts a fresh cost basis.
  Future<({double quantity, double avgCost})> _replayTrades(
    String accountId,
    String securityId,
  ) async {
    final trades =
        await (db.select(db.transactions)
              ..where(
                (t) =>
                    t.accountID.equals(accountId) &
                    t.securityID.equals(securityId),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.date)]))
            .get();

    double qty = 0;
    double avg = 0;

    for (final trade in trades) {
      final q = trade.quantity ?? 0;
      final price = trade.pricePerUnit ?? 0;

      if (q > 0) {
        final newQty = qty + q;
        avg = newQty <= 0 ? price : ((qty * avg) + (q * price)) / newQty;
        qty = newQty;
      } else if (q < 0) {
        qty += q;
        if (qty <= 0.0000001) qty = 0;
      }
    }

    return (quantity: qty, avgCost: avg);
  }

  /// Rebuilds a position's quantity and weighted-average cost by replaying every
  /// security trade (type N) for the (account, security) pair, in date order.
  ///
  /// Call this after editing or deleting a trade so the holding stays consistent.
  /// Deletes the holding if the net quantity ends at (or below) zero.
  Future<void> recomputeHolding({
    required String accountId,
    required String securityId,
  }) async {
    final (quantity: qty, avgCost: avg) = await _replayTrades(
      accountId,
      securityId,
    );

    final existing = await _selectHolding(
      accountId,
      securityId,
    ).getSingleOrNull();

    if (qty <= 0.0000001) {
      if (existing != null) {
        await (db.delete(
          db.holdings,
        )..where((h) => h.id.equals(existing.id))).go();
      }
      return;
    }

    if (existing == null) {
      await db
          .into(db.holdings)
          .insert(
            HoldingInDB(
              id: generateUUID(),
              accountID: accountId,
              securityID: securityId,
              quantity: qty,
              avgCostPrice: avg,
            ),
          );
    } else {
      await (db.update(
        db.holdings,
      )..where((h) => h.id.equals(existing.id))).write(
        HoldingsCompanion(quantity: Value(qty), avgCostPrice: Value(avg)),
      );
    }
  }

  /// Per-holding valuation **as of [date]** (defaults to now), for date-aware
  /// breakdowns like the portfolio composition chart. Reflects the full position
  /// history (see [_watchPositionValuations]); [HoldingValuationAtDate.market]
  /// and `cost` are in the security currency (convert to the preferred currency
  /// at the call site).
  Stream<List<HoldingValuationAtDate>> getHoldingValuationsAtDate([
    DateTime? date,
  ]) {
    return _watchPositionValuations(date: date).map(
      (rows) => rows
          .map(
            (r) => HoldingValuationAtDate(
              accountId: r.accountId,
              securityId: r.securityId,
              securityName: r.securityName,
              securityType: r.securityType,
              currencyId: r.currencyId,
              market: r.quantity * r.price,
              cost: r.quantity * r.avgCost,
            ),
          )
          .toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // Holdings-mode portfolio snapshots
  //
  // A snapshot is the complete portfolio photo for a date (accountSnapshots),
  // grouping zero or more position rows (holdingSnapshots). The most recent
  // snapshot on or before "now" is mirrored into the `holdings` table so the
  // rest of the app keeps reading the current positions.
  // ---------------------------------------------------------------------------

  /// All portfolio snapshots for an account, newest first, each joined with its
  /// positions and their securities.
  Stream<List<AccountSnapshotWithPositions>> getAccountSnapshots(
    String accountId,
  ) {
    final headersStream =
        (db.select(db.accountSnapshots)
              ..where((tbl) => tbl.accountID.equals(accountId))
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
            .watch();

    final positionsQuery = db.select(db.holdingSnapshots).join([
      innerJoin(
        db.securities,
        db.securities.id.equalsExp(db.holdingSnapshots.securityID),
      ),
      innerJoin(
        db.accountSnapshots,
        db.accountSnapshots.id.equalsExp(db.holdingSnapshots.snapshotID),
      ),
    ])..where(db.accountSnapshots.accountID.equals(accountId));

    return Rx.combineLatest2(headersStream, positionsQuery.watch(), (
      List<AccountSnapshotInDB> headers,
      List<TypedResult> positionRows,
    ) {
      final bySnapshot = <String, List<SnapshotPosition>>{};

      for (final row in positionRows) {
        final position = SnapshotPosition(
          row: row.readTable(db.holdingSnapshots),
          security: row.readTable(db.securities),
        );
        bySnapshot.putIfAbsent(position.row.snapshotID, () => []).add(position);
      }

      return headers
          .map(
            (h) => AccountSnapshotWithPositions(
              snapshot: h,
              positions: bySnapshot[h.id] ?? [],
            ),
          )
          .toList();
    });
  }

  /// The snapshot in effect at [date] (the most recent on or before it, defaults
  /// to now) with its positions, or `null` if the account has no snapshot yet.
  Stream<AccountSnapshotWithPositions?> getEffectiveSnapshot(
    String accountId, [
    DateTime? date,
  ]) {
    final effectiveDate = date ?? DateTime.now();

    return getAccountSnapshots(accountId).map((all) {
      for (final snapshot in all) {
        if (!snapshot.date.isAfter(effectiveDate)) return snapshot;
      }
      return null;
    });
  }

  /// Creates or replaces the portfolio snapshot for ([accountId], [date]) with
  /// [positions] (rows with quantity <= 0 are dropped), then rebuilds the
  /// account's current `holdings` from its latest snapshot.
  ///
  /// When editing an existing snapshot, pass its id as [replaceSnapshotId]; it
  /// is removed first so its date can change freely (and any snapshot already on
  /// the target date is overwritten).
  Future<void> saveAccountSnapshot({
    required String accountId,
    required DateTime date,
    required List<({String securityId, double quantity, double avgCostPrice})>
    positions,
    String? replaceSnapshotId,
  }) async {
    await db.transaction(() async {
      if (replaceSnapshotId != null) {
        await (db.delete(
          db.accountSnapshots,
        )..where((tbl) => tbl.id.equals(replaceSnapshotId))).go();
      }

      await (db.delete(db.accountSnapshots)..where(
            (tbl) => tbl.accountID.equals(accountId) & tbl.date.equals(date),
          ))
          .go();

      final snapshotId = generateUUID();
      await db
          .into(db.accountSnapshots)
          .insert(
            AccountSnapshotInDB(
              id: snapshotId,
              accountID: accountId,
              date: date,
            ),
          );

      for (final p in positions) {
        if (p.quantity <= 0) continue;
        await db
            .into(db.holdingSnapshots)
            .insert(
              HoldingSnapshotInDB(
                id: generateUUID(),
                snapshotID: snapshotId,
                securityID: p.securityId,
                quantity: p.quantity,
                avgCostPrice: p.avgCostPrice,
              ),
            );
      }
    });

    await syncHoldingsFromLatestSnapshot(accountId);
  }

  /// Removes a portfolio snapshot (its positions cascade) and rebuilds the
  /// account's current holdings from the remaining latest snapshot.
  Future<void> deleteAccountSnapshot(
    String snapshotId,
    String accountId,
  ) async {
    await (db.delete(
      db.accountSnapshots,
    )..where((tbl) => tbl.id.equals(snapshotId))).go();
    await syncHoldingsFromLatestSnapshot(accountId);
  }

  /// Rebuilds the `holdings` rows of [accountId] from its most recent snapshot:
  /// upserts a holding per position and removes holdings for securities absent
  /// from that snapshot (or clears them all when there is no snapshot left).
  Future<void> syncHoldingsFromLatestSnapshot(String accountId) async {
    final latest =
        await (db.select(db.accountSnapshots)
              ..where((tbl) => tbl.accountID.equals(accountId))
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
              ..limit(1))
            .getSingleOrNull();

    if (latest == null) {
      await (db.delete(
        db.holdings,
      )..where((h) => h.accountID.equals(accountId))).go();
      return;
    }

    final positions = await (db.select(
      db.holdingSnapshots,
    )..where((tbl) => tbl.snapshotID.equals(latest.id))).get();

    if (positions.isEmpty) {
      await (db.delete(
        db.holdings,
      )..where((h) => h.accountID.equals(accountId))).go();
      return;
    }

    final keepSecurityIds = positions.map((p) => p.securityID).toList();

    await (db.delete(db.holdings)..where(
          (h) =>
              h.accountID.equals(accountId) &
              h.securityID.isNotIn(keepSecurityIds),
        ))
        .go();

    for (final p in positions) {
      await setHolding(
        accountId: accountId,
        securityId: p.securityID,
        quantity: p.quantity,
        avgCostPrice: p.avgCostPrice,
      );
    }
  }

  /// Carries the current positions of [accountId] over to the data source that
  /// the [to] tracking mode reads from, so switching modes does not make the
  /// account's securities disappear from balances and charts.
  ///
  /// - to `holdings`: the positions become a portfolio snapshot dated [date]
  ///   (defaults to now), which is what holdings mode values them from.
  /// - to `transactions`: every position that has no trade history in this
  ///   account gets an anchor buy of the units held at their average cost. The
  ///   trade moves no cash (the money already left the account when the
  ///   position was funded), so only the position is reconstructed. Positions
  ///   that do have trades are realigned with them, since that is what
  ///   transactions mode considers the truth.
  ///
  /// Only the *current* positions are converted: valuations before [date] keep
  /// coming from whatever history the new source already holds.
  ///
  /// This does not change the account row itself; save the account with its new
  /// [AccountTrackingMode] as usual.
  Future<void> convertTrackingMode({
    required String accountId,
    required AccountTrackingMode to,
    DateTime? date,
    String? anchorTradeTitle,
  }) async {
    final positions = await (db.select(
      db.holdings,
    )..where((h) => h.accountID.equals(accountId))).get();

    if (positions.isEmpty) return;

    final effectiveDate = date ?? DateTime.now();

    if (to == AccountTrackingMode.holdings) {
      await saveAccountSnapshot(
        accountId: accountId,
        date: effectiveDate,
        positions: [
          for (final p in positions)
            (
              securityId: p.securityID,
              quantity: p.quantity,
              avgCostPrice: p.avgCostPrice,
            ),
        ],
      );

      return;
    }

    for (final p in positions) {
      final replayed = await _replayTrades(accountId, p.securityID);

      if (replayed.quantity <= 0.0000001) {
        await _recordTrade(
          accountId: accountId,
          securityId: p.securityID,
          quantity: p.quantity,
          pricePerUnit: p.avgCostPrice,
          cashDelta: 0,
          date: effectiveDate,
          title: anchorTradeTitle,
        );
      }

      await recomputeHolding(accountId: accountId, securityId: p.securityID);
    }
  }

  /// Inserts the cash leg of a trade. Goes through [db] (and not
  /// [TransactionService]) so it takes part in the caller's transaction.
  Future<void> _recordTrade({
    required String accountId,
    required String securityId,
    required double quantity,
    required double pricePerUnit,
    required double cashDelta,
    required DateTime date,
    String? title,
    String? notes,
  }) async {
    await db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: generateUUID(),
            date: date,
            accountID: accountId,
            value: cashDelta,
            type: TransactionType.investment,
            securityID: securityId,
            quantity: quantity,
            pricePerUnit: pricePerUnit,
            isHidden: false,
            title: title,
            notes: notes,
          ),
        );

    db.markTablesUpdated([db.accounts]);
  }
}
