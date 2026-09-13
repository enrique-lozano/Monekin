import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:sqlite3/sqlite3.dart';

/// `assets/sql/samples/v<schemaVersion>_sample.db` is a hand-maintained fixture
/// the maintainer imports to test the app with realistic data. It is always the
/// sample for the *current* schema version, so importing it runs no migration:
/// any drift from the real schema only shows up as a crash at import time.
/// These tests catch it here instead.
///
/// The path is derived from `AppDB.schemaVersion` on purpose: bumping the
/// version without shipping a matching sample fails right here, instead of
/// silently leaving the old fixture untested.
void main() {
  late Database sample;
  late AppDB app;

  setUp(() {
    app = AppDB.forTesting(NativeDatabase.memory());
    addTearDown(app.close);

    final path = 'assets/sql/samples/v${app.schemaVersion}_sample.db';

    expect(
      File(path).existsSync(),
      isTrue,
      reason:
          'Missing $path. The schema version was bumped to '
          '${app.schemaVersion}, so the import sample has to be regenerated '
          'for it (migrate the previous one and update its dbVersion).',
    );

    sample = sqlite3.open(path);
    addTearDown(sample.close);
  });

  test(
    'declares the current schema version, so no migration runs on import',
    () {
      final version = sample.select(
        "SELECT appDataValue FROM appData WHERE appDataKey = 'dbVersion'",
      );

      expect(version, isNotEmpty);
      expect(
        int.parse(version.first['appDataValue'] as String),
        app.schemaVersion,
      );
    },
  );

  test('has exactly the tables and columns the app expects', () {
    final expected = {
      for (final table in app.allTables)
        table.actualTableName: table.$columns.map((c) => c.name).toSet(),
    };

    final actualTables = sample
        .select(
          "SELECT name FROM sqlite_master WHERE type = 'table' "
          "AND name NOT LIKE 'sqlite_%'",
        )
        .map((r) => r['name'] as String)
        .toSet();

    expect(actualTables, expected.keys.toSet());

    for (final entry in expected.entries) {
      final columns = sample
          .select('PRAGMA table_info(${entry.key})')
          .map((r) => r['name'] as String)
          .toSet();

      expect(columns, entry.value, reason: 'columns of ${entry.key}');
    }
  });

  test('is referentially sound', () {
    expect(sample.select('PRAGMA foreign_key_check'), isEmpty);
  });
}
