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

/// Applies `assets/sql/migrations/v15.sql` to a copy of the v14 sample DB the
/// same way the app does (statement split, FK pragmas stripped, FK off around
/// the batch) and returns the migrated, open database.
Database migrateSample() {
  final sample = File('assets/sql/samples/v14_sample.db');
  expect(sample.existsSync(), isTrue, reason: 'v14 sample DB missing');

  final tmp = File(
    '${Directory.systemTemp.path}/v14_sample_migtest_'
    '${DateTime.now().microsecondsSinceEpoch}.db',
  );
  sample.copySync(tmp.path);
  addTearDown(() {
    if (tmp.existsSync()) tmp.deleteSync();
  });

  final db = sqlite3.open(tmp.path);
  addTearDown(db.close);

  final statements =
      splitSQLStatements(
        File('assets/sql/migrations/v15.sql').readAsStringSync(),
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

  expect(fkViolations, isEmpty, reason: 'FK violations after migrating to v15');
  return db;
}

void main() {
  test('v14 sample migrates to v15 without errors or FK violations', () {
    migrateSample();
  });

  test('existing accounts are kept as they were, with no credit data', () {
    final before = sqlite3.open('assets/sql/samples/v14_sample.db');
    addTearDown(before.close);

    final after = migrateSample();

    const columns =
        'id, name, groupName, iniValue, date, description, type, isSaving, '
        'trackingMode, iconId, displayOrder, color, closingDate, currencyId, '
        'iban, swift';

    List<String> rows(Database db) => db
        .select('SELECT $columns FROM accounts ORDER BY id')
        .map((r) => r.values.join('|'))
        .toList();

    expect(rows(after), rows(before));

    final withCreditData = after.select(
      'SELECT COUNT(*) c FROM accounts WHERE cutoffDay IS NOT NULL '
      'OR dueDay IS NOT NULL OR creditLimit IS NOT NULL '
      'OR minPaymentPct IS NOT NULL',
    );
    expect(withCreditData.first['c'], 0);
  });

  test('child tables still reference the rebuilt accounts table', () {
    final db = migrateSample();

    final fks = db.select('PRAGMA foreign_key_list(transactions)');
    expect(fks.where((r) => r['table'] == 'accounts'), isNotEmpty);
  });

  test('credit accounts can be stored and days are range-checked', () {
    final db = migrateSample();

    final currency = db
        .select('SELECT code FROM currencies LIMIT 1')
        .first['code'];

    void insert(String id, int cutoffDay) => db.execute(
      '''
      INSERT INTO accounts (id, name, iniValue, date, type, iconId, displayOrder, currencyId, cutoffDay, dueDay, creditLimit, minPaymentPct)
      VALUES (?, ?, -1500, '2026-01-01', 'credit', 'credit_card', 99, ?, ?, 20, 30000, 0.05)
      ''',
      [id, 'Card $id', currency, cutoffDay],
    );

    insert('card-ok', 31);
    expect(
      db.select("SELECT type FROM accounts WHERE id = 'card-ok'").first['type'],
      'credit',
    );

    expect(() => insert('card-bad', 32), throwsA(isA<SqliteException>()));
  });
}
