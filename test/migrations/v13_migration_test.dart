import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

/// Mirrors [splitSQLStatements] in `app_db.dart`: the app splits a migration
/// file on `;` + whitespace, so a stray semicolon *inside a comment* would
/// break a statement in two. This test therefore also guards against that.
List<String> splitSQLStatements(String sqliteStr) {
  return sqliteStr
      .split(RegExp(r';\s'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
}

/// Applies `assets/sql/migrations/v13.sql` to a copy of the v12 sample DB the
/// same way the app does (statement split, FK pragmas stripped, FK off around
/// the batch) and returns the migrated, open database.
Database migrateSample() => migrateSampleMutated(null);

/// Same as [migrateSample], but runs [mutate] on the copied v12 database
/// *before* applying the migration. Lets a test inject legacy/dirty rows (e.g.
/// an asset stored with the old camelCase enum name) and assert the migration
/// still succeeds.
Database migrateSampleMutated(void Function(Database db)? mutate) {
  final sample = File('assets/sql/samples/v12_sample.db');
  expect(sample.existsSync(), isTrue, reason: 'v12 sample DB missing');

  final tmp = File(
    '${Directory.systemTemp.path}/v12_sample_migtest_'
    '${DateTime.now().microsecondsSinceEpoch}.db',
  );
  sample.copySync(tmp.path);
  addTearDown(() {
    if (tmp.existsSync()) tmp.deleteSync();
  });

  final db = sqlite3.open(tmp.path);
  addTearDown(db.dispose);

  if (mutate != null) mutate(db);

  final statements =
      splitSQLStatements(
        File('assets/sql/migrations/v13.sql').readAsStringSync(),
      ).where(
        (s) => !RegExp(
          r'^\s*PRAGMA\s+foreign_keys',
          caseSensitive: false,
        ).hasMatch(s),
      );

  db.execute('PRAGMA foreign_keys = OFF');
  db.execute('BEGIN');
  for (final s in statements) {
    db.execute(s);
  }
  final fkViolations = db.select('PRAGMA foreign_key_check');
  db.execute('COMMIT');
  db.execute('PRAGMA foreign_keys = ON');

  expect(fkViolations, isEmpty, reason: 'FK violations after migrating to v13');
  return db;
}

/// Inserts a physical asset carrying the given raw `assetType` string into the
/// copied v12 DB (reusing an existing currency), so tests can feed the migration
/// legacy enum encodings.
void insertLegacyAsset(Database db, String id, String assetType) {
  db.execute(
    '''
    INSERT INTO assets (id, name, description, currencyId, initialValue, creationDate, assetType, linkedAccountID)
    VALUES (?, ?, NULL, (SELECT code FROM currencies LIMIT 1), 1000, '2024-01-01', ?, NULL)
    ''',
    [id, 'Legacy $id', assetType],
  );
}

void main() {
  test('v12 sample migrates to v13 without errors or FK violations', () {
    // migrateSample itself asserts the batch runs and leaves no FK violations.
    migrateSample();
  });

  test('assets end up physical-only: no linkedAccountID, yes linkedDebtId', () {
    final db = migrateSample();

    final columns = db
        .select('PRAGMA table_info(assets)')
        .map((r) => r['name'] as String);

    expect(columns, isNot(contains('linkedAccountID')));
    expect(columns, contains('linkedDebtId'));
  });

  test('migrated holdings carry a non-phantom cost basis (P&L = 0)', () {
    final db = migrateSample();

    final holdings = db.select('''
      SELECT h.securityID, h.quantity, h.avgCostPrice, s.currentPrice
      FROM holdings h
      JOIN securities s ON s.id = h.securityID
    ''');

    expect(holdings, isNotEmpty, reason: 'sample has a linked financial asset');

    for (final h in holdings) {
      final avg = (h['avgCostPrice'] as num).toDouble();
      final price = (h['currentPrice'] as num?)?.toDouble() ?? 0;
      final qty = (h['quantity'] as num).toDouble();

      // The whole point of the fix: avg cost equals the current price, so a
      // freshly-migrated position shows no phantom gain/loss.
      expect(
        avg,
        closeTo(price, 0.0001),
        reason: 'avgCost of ${h['securityID']} should equal its current price',
      );
      expect((qty * price) - (qty * avg), closeTo(0, 0.0001));
    }
  });

  test('transactions-mode holdings each have a backing trade', () {
    final db = migrateSample();

    // In 'transactions' mode a holding is reconstructed by replaying its type-N
    // trades, so every such holding must have at least one backing trade in its
    // account (either a repointed real trade or the safety-net anchor buy).
    final orphan = db.select('''
      SELECT h.accountID, h.securityID
      FROM holdings h
      JOIN accounts a ON a.id = h.accountID
      WHERE a.trackingMode = 'transactions'
        AND NOT EXISTS (
          SELECT 1 FROM transactions t
          WHERE t.type = 'N'
            AND t.accountID = h.accountID
            AND t.securityID = h.securityID
        )
    ''');

    expect(
      orphan,
      isEmpty,
      reason: 'transactions-mode holdings must have a backing type-N trade',
    );
  });

  test('holdings-mode snapshots (if any) mirror the holdings cost basis', () {
    final db = migrateSample();

    // A 'holdings' mode account with securities is seeded exactly one portfolio
    // snapshot mirroring its holdings. Assert the invariant for whatever
    // holdings-mode positions the sample happens to contain (may be none).
    final positions = db.select('''
      SELECT hs.securityID, hs.quantity, hs.avgCostPrice, s.currentPrice
      FROM holdingSnapshots hs
      JOIN securities s ON s.id = hs.securityID
    ''');

    for (final p in positions) {
      final avg = (p['avgCostPrice'] as num).toDouble();
      final price = (p['currentPrice'] as num?)?.toDouble() ?? 0;
      expect(avg, closeTo(price, 0.0001));
    }

    // Every seeded snapshot must belong to a holdings-mode account.
    final wrongMode = db.select('''
      SELECT s.id
      FROM accountSnapshots s
      JOIN accounts a ON a.id = s.accountID
      WHERE a.trackingMode != 'holdings'
    ''');
    expect(wrongMode, isEmpty);
  });

  test('unlinked financial assets become securities without a holding', () {
    final db = migrateSample();

    // The sample's "My Stock 2 (unlinked)" asset has no linkedAccountID, so it
    // must convert to a security (with price history) but no holding.
    const securityId = 'sec_a2b7c9d0-1111-4222-8333-444455556666';

    final sec = db.select('SELECT currentPrice FROM securities WHERE id = ?', [
      securityId,
    ]);
    expect(sec, isNotEmpty, reason: 'unlinked stock should become a security');

    final holdings = db.select('SELECT 1 FROM holdings WHERE securityID = ?', [
      securityId,
    ]);
    expect(holdings, isEmpty, reason: 'unlinked security must have no holding');

    final priceHistory = db.select(
      'SELECT 1 FROM securityPrices WHERE securityID = ?',
      [securityId],
    );
    expect(
      priceHistory,
      isNotEmpty,
      reason: 'its valuations become price points',
    );
  });

  test('a financial asset without valuations gets one seed price point', () {
    final db = migrateSample();

    // "New Crypto" is a crypto asset with NO valuations, so the migration seeds
    // exactly one price point (creationDate/initialValue) and, being unlinked,
    // creates no holding.
    const securityId = 'sec_asset_newcrypto';

    final sec = db.select(
      'SELECT type, currentPrice FROM securities WHERE id = ?',
      [securityId],
    );
    expect(sec, isNotEmpty);
    expect(sec.first['type'], 'crypto');
    expect((sec.first['currentPrice'] as num).toDouble(), 500);

    final points = db.select(
      'SELECT price FROM securityPrices WHERE securityID = ?',
      [securityId],
    );
    expect(points.length, 1, reason: 'exactly one seed point');
    expect((points.first['price'] as num).toDouble(), 500);

    final holdings = db.select('SELECT 1 FROM holdings WHERE securityID = ?', [
      securityId,
    ]);
    expect(holdings, isEmpty);
  });

  test('an investment account with no trades migrates to a seeded snapshot', () {
    final db = migrateSample();

    // "Robo-Advisor" holds a financial asset ("World ETF") but has no type-N
    // trades, so it becomes a 'holdings'-mode account whose position is kept as
    // a single seeded portfolio snapshot mirroring the holding (no trades).
    const accountId = 'acc_robo';

    final acct = db.select('SELECT trackingMode FROM accounts WHERE id = ?', [
      accountId,
    ]);
    expect(acct.first['trackingMode'], 'holdings');

    final trades = db.select(
      "SELECT 1 FROM transactions WHERE accountID = ? AND type = 'N'",
      [accountId],
    );
    expect(trades, isEmpty, reason: 'holdings-mode accounts carry no trades');

    final snaps = db.select(
      'SELECT id FROM accountSnapshots WHERE accountID = ?',
      [accountId],
    );
    expect(snaps.length, 1, reason: 'one seeded portfolio snapshot');

    final positions = db.select(
      'SELECT securityID, quantity, avgCostPrice FROM holdingSnapshots WHERE snapshotID = ?',
      [snaps.first['id']],
    );
    final holdings = db.select(
      'SELECT securityID, quantity, avgCostPrice FROM holdings WHERE accountID = ?',
      [accountId],
    );
    expect(positions.length, holdings.length);
    expect(positions.length, 1);
    expect(positions.first['securityID'], holdings.first['securityID']);
    expect(
      (positions.first['quantity'] as num).toDouble(),
      (holdings.first['quantity'] as num).toDouble(),
    );
    expect(
      (positions.first['avgCostPrice'] as num).toDouble(),
      (holdings.first['avgCostPrice'] as num).toDouble(),
    );
  });

  test('synthetic anchor trades carry no hardcoded title', () {
    final db = migrateSample();

    // The safety-net anchor buy (value 0, created only when a formerly
    // valuation-tracked asset lands in a transactions-mode account) is left
    // untitled: a migration has no locale, and the app labels untitled 'N' rows
    // with a translated string. A hardcoded English title would leak into every
    // other language.
    final anchors = db.select('''
      SELECT title FROM transactions
      WHERE type = 'N' AND value = 0 AND id LIKE 'anchor_%'
    ''');

    expect(anchors, isNotEmpty, reason: 'sample produces at least one anchor');
    for (final a in anchors) {
      expect(a['title'], isNull);
    }
  });

  test('only investment accounts can end up in holdings mode', () {
    final db = migrateSample();

    // The heuristic looks at whether an account has trades to derive positions
    // from, which is meaningless for money/saving accounts: those must keep the
    // default 'transactions' instead of a stale value nobody would ever fix.
    final nonInvestment = db.select('''
      SELECT id FROM accounts
      WHERE type != 'investment' AND trackingMode != 'transactions'
    ''');

    expect(nonInvestment, isEmpty);
  });

  test('migration file has no semicolons inside comments', () {
    // A ';' in a comment would be split by the app's statement splitter and
    // corrupt the following statement (this regression bit us once already).
    final lines = File('assets/sql/migrations/v13.sql').readAsLinesSync();

    final offenders = <String>[];
    for (final line in lines) {
      if (RegExp(r'^\s*--').hasMatch(line) && line.contains(';')) {
        offenders.add(line.trim());
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'comment lines must not contain ";":\n${offenders.join('\n')}',
    );
  });

  test('legacy camelCase assetType values migrate to the snake_case enum', () {
    // v12 added `assets.assetType` WITHOUT a CHECK, so real databases carry the
    // old Dart enum name ('realEstate', ...) instead of its databaseValue
    // ('real_estate', ...). Copying it verbatim used to fail the CHECK on the
    // rebuilt `assets` table and roll the whole migration back to v12.
    final db = migrateSampleMutated((db) {
      insertLegacyAsset(db, 'legacy_re', 'realEstate');
      insertLegacyAsset(db, 'legacy_pm', 'preciousMetal');
      insertLegacyAsset(db, 'legacy_ja', 'jewelryArt');
      insertLegacyAsset(db, 'legacy_ve', 'vehicle');
    });

    String typeOf(String id) => db.select(
      'SELECT assetType FROM assets WHERE id = ?',
      [id],
    ).first['assetType'] as String;

    expect(typeOf('legacy_re'), 'real_estate');
    expect(typeOf('legacy_pm'), 'precious_metal');
    expect(typeOf('legacy_ja'), 'jewelry_art');
    expect(typeOf('legacy_ve'), 'vehicle');
  });

  test('an unrecognized assetType falls back to "other" instead of aborting', () {
    final db = migrateSampleMutated(
      (db) => insertLegacyAsset(db, 'legacy_unknown', 'someFutureType'),
    );

    final type = db.select(
      'SELECT assetType FROM assets WHERE id = ?',
      ['legacy_unknown'],
    ).first['assetType'] as String;

    expect(type, 'other');
  });

  test('two same-day valuations of a financial asset collapse to one price', () {
    // The app keeps one valuation per day in Dart, not via a DB constraint on
    // DATE(date), so a dirty DB can hold two valuations that collapse to the
    // same calendar day. Without dedup they'd violate the unique index on
    // securityPrices(securityID, date) and abort the migration.
    final db = migrateSampleMutated((db) {
      db.execute('''
        INSERT INTO assets (id, name, description, currencyId, initialValue, creationDate, assetType, linkedAccountID)
        VALUES ('dirty_fin', 'Dirty Fund', NULL, (SELECT code FROM currencies LIMIT 1), 100, '2024-01-01', 'funds', NULL)
      ''');
      db.execute(
        "INSERT INTO valuations (id, assetId, date, value) VALUES ('dv_early', 'dirty_fin', '2024-03-10T09:00:00.000', 110)",
      );
      db.execute(
        "INSERT INTO valuations (id, assetId, date, value) VALUES ('dv_late', 'dirty_fin', '2024-03-10T18:00:00.000', 120)",
      );
    });

    final prices = db.select(
      "SELECT date, price FROM securityPrices WHERE securityID = 'sec_dirty_fin'",
    );

    expect(prices.length, 1, reason: 'same-day valuations collapse to one row');
    expect(prices.first['date'], '2024-03-10');
    expect(
      (prices.first['price'] as num).toDouble(),
      120,
      reason: 'the latest value of the day wins',
    );
  });
}
