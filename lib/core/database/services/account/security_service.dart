import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/utils/uuid.dart';

/// CRUD and manual price updates for [securities] (shared financial instruments).
class SecurityService {
  final AppDB db;

  SecurityService._(this.db);
  static final SecurityService instance = SecurityService._(AppDB.instance);

  /// Creates a service bound to a specific (test) database.
  @visibleForTesting
  SecurityService.forTesting(this.db);

  Future<int> insertSecurity(SecurityInDB security) async {
    final res = await db.into(db.securities).insert(security);

    final price = security.currentPrice;
    if (price != null && price > 0) {
      await addPricePoint(
        security.id,
        price,
        security.priceDate ?? DateTime.now(),
      );
    }

    return res;
  }

  Future<bool> updateSecurity(SecurityInDB security) {
    return db.update(db.securities).replace(security);
  }

  Future<int> deleteSecurity(String securityId) {
    return (db.delete(
      db.securities,
    )..where((tbl) => tbl.id.equals(securityId))).go();
  }

  Stream<List<SecurityInDB>> getSecurities() {
    return (db.select(
      db.securities,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  Stream<SecurityInDB?> getSecurityById(String id) {
    return (db.select(
      db.securities,
    )..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  /// The buy/sell transactions linked to a security, ordered by date.
  ///
  /// Used to derive a price series (`pricePerUnit` over time) since prices are
  /// tracked manually and we keep no dedicated price-history table.
  Stream<List<TransactionInDB>> getSecurityTrades(String securityId) {
    return (db.select(db.transactions)
          ..where((tbl) => tbl.securityID.equals(securityId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.date)]))
        .watch();
  }

  /// Historical price observations for a security, oldest first.
  Stream<List<SecurityPriceHistoryInDB>> getPriceHistory(String securityId) {
    return (db.select(db.securityPriceHistory)
          ..where((tbl) => tbl.securityID.equals(securityId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.date)]))
        .watch();
  }

  /// The security's price as of [date]: the most recent price-history
  /// observation with `date <= [date]`, falling back to the current price when
  /// there is no earlier observation. Returns 0 when nothing is known.
  Future<double> getPriceAtDate(String securityId, DateTime date) async {
    final point =
        await (db.select(db.securityPriceHistory)
              ..where(
                (tbl) =>
                    tbl.securityID.equals(securityId) &
                    tbl.date.isSmallerOrEqualValue(date),
              )
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
              ..limit(1))
            .getSingleOrNull();

    if (point != null) return point.price;

    final security = await getSecurityById(securityId).first;
    return security?.currentPrice ?? 0;
  }

  /// Records a single price observation in the history (does not touch the
  /// security's current price).
  Future<void> addPricePoint(String securityId, double price, DateTime date) {
    return db
        .into(db.securityPriceHistory)
        .insert(
          SecurityPriceHistoryInDB(
            id: generateUUID(),
            securityID: securityId,
            date: date,
            price: price,
          ),
        );
  }

  /// Inserts or updates a price-history observation and keeps the security's
  /// current price/date aligned with the most recent point.
  Future<void> upsertPricePoint(SecurityPriceHistoryInDB point) async {
    await db.into(db.securityPriceHistory).insertOnConflictUpdate(point);
    await syncCurrentPriceFromHistory(point.securityID);
  }

  /// Bulk-inserts price-history observations (e.g. from a pasted/imported
  /// CSV) and realigns the security's current price with the most recent
  /// point. Any existing observation sharing the same calendar date as an
  /// imported point is replaced, so re-importing overlapping data overwrites
  /// it instead of creating duplicates. Returns the number of points
  /// inserted.
  Future<int> importPricePoints(
    String securityId,
    List<({DateTime date, double price})> points,
  ) async {
    if (points.isEmpty) return 0;

    await db.batch((batch) {
      for (final point in points) {
        final dayRange = _dayRange(point.date);

        batch.deleteWhere(
          db.securityPriceHistory,
          (tbl) =>
              tbl.securityID.equals(securityId) &
              tbl.date.isBiggerOrEqualValue(dayRange.$1) &
              tbl.date.isSmallerThanValue(dayRange.$2),
        );
      }

      batch.insertAll(
        db.securityPriceHistory,
        points.map(
          (p) => SecurityPriceHistoryInDB(
            id: generateUUID(),
            securityID: securityId,
            date: p.date,
            price: p.price,
          ),
        ),
      );
    });

    await syncCurrentPriceFromHistory(securityId);

    return points.length;
  }

  /// Among the given calendar [dates], returns the ones that already have a
  /// price observation recorded for [securityId]. Used to warn the user
  /// before an import would overwrite existing data.
  Future<Set<DateTime>> getDatesWithExistingPrice(
    String securityId,
    Iterable<DateTime> dates,
  ) async {
    final days = dates.map(_dayOnly).toSet();
    if (days.isEmpty) return {};

    final existingDates =
        await (db.selectOnly(db.securityPriceHistory)
              ..addColumns([db.securityPriceHistory.date])
              ..where(db.securityPriceHistory.securityID.equals(securityId)))
            .map((row) => row.read(db.securityPriceHistory.date)!)
            .get();

    return existingDates.map(_dayOnly).where(days.contains).toSet();
  }

  DateTime _dayOnly(DateTime date) => DateTime(date.year, date.month, date.day);

  (DateTime, DateTime) _dayRange(DateTime date) {
    final start = _dayOnly(date);
    return (start, start.add(const Duration(days: 1)));
  }

  /// Removes a price-history observation and realigns the security's current
  /// price with the remaining most recent point.
  Future<void> deletePricePoint(String pointId, String securityId) async {
    await (db.delete(
      db.securityPriceHistory,
    )..where((tbl) => tbl.id.equals(pointId))).go();
    await syncCurrentPriceFromHistory(securityId);
  }

  /// Sets the security's [currentPrice]/[priceDate] to its most recent
  /// price-history observation. No-op when there is no history.
  Future<void> syncCurrentPriceFromHistory(String securityId) async {
    final latest =
        await (db.select(db.securityPriceHistory)
              ..where((tbl) => tbl.securityID.equals(securityId))
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
              ..limit(1))
            .getSingleOrNull();

    if (latest == null) return;

    await (db.update(
      db.securities,
    )..where((tbl) => tbl.id.equals(securityId))).write(
      SecuritiesCompanion(
        currentPrice: Value(latest.price),
        priceDate: Value(latest.date),
      ),
    );
  }

  /// Updates the manually-tracked price of a security (offline-first) and stores
  /// the observation in the price history so the chart reflects it.
  ///
  /// A day holds a single observation: correcting the price again on the same
  /// calendar day replaces it instead of adding a second, ambiguous point.
  Future<int> updatePrice(
    String securityId,
    double price, {
    DateTime? date,
  }) async {
    final effectiveDate = date ?? DateTime.now();
    final dayRange = _dayRange(effectiveDate);

    return db.transaction(() async {
      final res =
          await (db.update(
            db.securities,
          )..where((tbl) => tbl.id.equals(securityId))).write(
            SecuritiesCompanion(
              currentPrice: Value(price),
              priceDate: Value(effectiveDate),
            ),
          );

      await (db.delete(db.securityPriceHistory)..where(
            (tbl) =>
                tbl.securityID.equals(securityId) &
                tbl.date.isBiggerOrEqualValue(dayRange.$1) &
                tbl.date.isSmallerThanValue(dayRange.$2),
          ))
          .go();

      await addPricePoint(securityId, price, effectiveDate);

      return res;
    });
  }
}
