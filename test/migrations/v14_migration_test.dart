import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
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

/// A genuine investment account in `holdings` mode, carrying two snapshots.
/// The sample gives it no transactions at all, so tests that need the backfill
/// to actually compute something give it a ledger first ([injectLedger]).
const holdingsAccount = 'acc_crypto';

/// The first of that account's snapshots, and the earliest of the sample.
const firstSnapshot = 'asnap_crypto_1';

/// Applies `assets/sql/migrations/v14.sql` to a copy of the v13 sample DB the
/// same way the app does (statement split, FK pragmas stripped, FK off around
/// the batch) and returns the migrated, open database.
Database migrateSample() => migrateSampleMutated(null);

/// Same as [migrateSample], but runs [mutate] on the copied v13 database
/// *before* applying the migration, so a test can set up the rows whose
/// backfill it wants to check.
Database migrateSampleMutated(void Function(Database db)? mutate) {
  final sample = File('assets/sql/samples/v13_sample.db');
  expect(sample.existsSync(), isTrue, reason: 'v13 sample DB missing');

  final tmp = File(
    '${Directory.systemTemp.path}/v13_sample_migtest_'
    '${DateTime.now().microsecondsSinceEpoch}.db',
  );
  sample.copySync(tmp.path);
  addTearDown(() {
    if (tmp.existsSync()) tmp.deleteSync();
  });

  final db = sqlite3.open(tmp.path);
  addTearDown(db.close);

  if (mutate != null) mutate(db);

  final statements =
      splitSQLStatements(
        File('assets/sql/migrations/v14.sql').readAsStringSync(),
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

  expect(fkViolations, isEmpty, reason: 'FK violations after migrating to v14');
  return db;
}

void main() {
  test('v13 sample migrates to v14 without errors or FK violations', () {
    // migrateSample itself asserts the batch runs and leaves no FK violations.
    migrateSample();
  });

  test('accountSnapshots gains a non-null cash column', () {
    final db = migrateSample();

    final cash = db
        .select('PRAGMA table_info(accountSnapshots)')
        .firstWhere((r) => r['name'] == 'cash');

    expect(cash['type'], 'REAL');
    expect(cash['notnull'], 1);

    final nulls = db.select(
      'SELECT COUNT(*) c FROM accountSnapshots WHERE cash IS NULL',
    );
    expect(nulls.first['c'], 0);
  });

  test('nothing else is touched: snapshots and positions are all kept', () {
    final before = sqlite3.open('assets/sql/samples/v13_sample.db');
    addTearDown(before.close);

    int count(Database db, String table) =>
        db.select('SELECT COUNT(*) c FROM $table').first['c'] as int;

    final after = migrateSample();

    for (final table in [
      'accountSnapshots',
      'holdingSnapshots',
      'holdings',
      'transactions',
      'accounts',
      'securities',
    ]) {
      expect(
        count(after, table),
        count(before, table),
        reason: '$table row count changed',
      );
    }

    // The snapshot identities themselves are untouched.
    expect(
      after
          .select(
            'SELECT id, accountID, date FROM accountSnapshots ORDER BY id',
          )
          .map((r) => '${r['id']}|${r['accountID']}|${r['date']}')
          .toList(),
      before
          .select(
            'SELECT id, accountID, date FROM accountSnapshots ORDER BY id',
          )
          .map((r) => '${r['id']}|${r['accountID']}|${r['date']}')
          .toList(),
    );
  });

  /// Gives [holdingsAccount] a ledger its existing snapshots have to add up,
  /// spanning both of them: a transfer in and an income before the first one,
  /// an expense between the two. Plus two rows that must never reach a total.
  void injectLedger(Database db) {
    db.execute(
      '''
      INSERT INTO transactions (id, date, accountID, value, type, receivingAccountID, isHidden)
      VALUES ('tx-in', '2026-03-10T10:00:00.000 +01:00', 'acc2', 2000, 'T', ?, 0)
      ''',
      [holdingsAccount],
    );

    db.execute(
      '''
      INSERT INTO transactions (id, date, accountID, value, type, categoryID, isHidden)
      VALUES ('tx-dividend', '2026-06-20T10:00:00.000 +02:00', ?, 30, 'I',
              (SELECT id FROM categories WHERE type = 'I' LIMIT 1), 0),
             ('tx-fee', '2026-07-15T10:00:00.000 +02:00', ?, -12, 'E',
              (SELECT id FROM categories WHERE type = 'E' LIMIT 1), 0)
      ''',
      [holdingsAccount, holdingsAccount],
    );

    for (final status in ['V', 'P']) {
      db.execute(
        '''
        INSERT INTO transactions (id, date, accountID, value, type, status, categoryID, isHidden)
        VALUES (?, '2026-03-01', ?, 9999, 'I', ?,
                (SELECT id FROM categories LIMIT 1), 0)
        ''',
        ['tx-skip-$status', holdingsAccount, status],
      );
    }
  }

  test('the backfilled cash is the ledger cash at the snapshot date', () {
    final db = migrateSampleMutated(injectLedger);

    final busy = db.select('SELECT cash FROM accountSnapshots WHERE id = ?', [
      firstSnapshot,
    ]);
    expect(
      (busy.first['cash'] as num).toDouble(),
      isNot(closeTo(0, 0.01)),
      reason: 'a snapshot over a real ledger should carry its balance',
    );

    final snapshots = db.select('''
      SELECT acs.id, acs.date, acs.cash, a.id AS accountId, a.iniValue, a.date AS openedOn
      FROM accountSnapshots acs
      JOIN accounts a ON a.id = acs.accountID
    ''');

    expect(
      snapshots,
      isNotEmpty,
      reason: 'the sample should carry holdings-mode snapshots',
    );

    for (final snapshot in snapshots) {
      final snapshotDate = snapshot['date'] as String;
      final accountId = snapshot['accountId'] as String;

      // Expected cash is recomputed in Dart from the same rules as the
      // backfill (opening balance + counted transactions). Dates are compared
      // as the stored strings, exactly as SQLite compares these TEXT columns.
      var expected =
          (snapshot['openedOn'] as String).compareTo(snapshotDate) > 0
          ? 0.0
          : (snapshot['iniValue'] as num).toDouble();

      final rows = db.select(
        '''
        SELECT type, value, valueInDestiny, status, date, accountID, receivingAccountID
        FROM transactions
        WHERE accountID = ? OR receivingAccountID = ?
        ''',
        [accountId, accountId],
      );

      for (final row in rows) {
        final status = row['status'] as String?;
        if (status == 'V' || status == 'P') continue;
        if ((row['date'] as String).compareTo(snapshotDate) > 0) continue;

        final value = (row['value'] as num).toDouble();

        if (row['type'] != 'T') {
          if (row['accountID'] == accountId) expected += value;
        } else if (row['accountID'] == accountId) {
          expected -= value;
        } else if (row['receivingAccountID'] == accountId) {
          expected += (row['valueInDestiny'] as num?)?.toDouble() ?? value;
        }
      }

      expect(
        (snapshot['cash'] as num).toDouble(),
        closeTo(expected, 0.0001),
        reason: 'cash backfilled into snapshot ${snapshot['id']}',
      );
    }
  });

  test('balances are unchanged: every snapshot anchor nets to zero', () {
    final db = migrateSampleMutated(injectLedger);

    // Backfilling with the ledger cash means the runtime correction has
    // nothing to correct yet, so no balance, chart or net-worth point moves on
    // upgrade. Running the app's own query here also keeps the migration and
    // `AccountService` from drifting apart.
    final adjustment = db.select(AccountService.snapshotCashAdjustmentQuery(), [
      '9999-12-31T00:00:00.000Z',
    ]);

    expect(
      (adjustment.first['adjustment'] as num).toDouble(),
      closeTo(0, 0.0001),
    );
  });
}
