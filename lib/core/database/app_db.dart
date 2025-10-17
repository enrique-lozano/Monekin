import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/sql/initial/seed.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart';

@DriftDatabase(
  include: {'sql/initial/tables.drift', 'sql/queries/select-full-data.drift'},
)
class AppDB extends _$AppDB {
  AppDB._({
    required this.dbName,
    required this.inMemory,
    required this.logStatements,
  }) : super(openConnection(dbName, logStatements: logStatements));

  static final AppDB instance = AppDB._(
    dbName: 'database.db',
    inMemory: false,
    logStatements: false,
  );

  final String dbName;
  final bool inMemory;
  final bool logStatements;

  /// Get the path to the DB, that is `xxxx/xxxx/.../filename.db`
  Future<String> get databasePath async =>
      join((await getApplicationDocumentsDirectory()).path, dbName);

  Future<void> migrateDB(int from, int to) async {
    Logger.printDebug('Executing migrations from previous version...');

    await UserSettingService.instance.initializeGlobalStateMap();
    await AppDataService.instance.initializeGlobalStateMap();

    for (var i = from + 1; i <= to; i++) {
      Logger.printDebug('Migrating database from v$from to v$i...');

      String initialSQL = await rootBundle.loadString(
        'assets/sql/migrations/v$i.sql',
      );

      for (final sqlStatement in splitSQLStatements(initialSQL)) {
        Logger.printDebug(
            'Running custom statement: ${sqlStatement.substring(0, sqlStatement.length > 30 ? 30 : sqlStatement.length)}...');
        await customStatement(sqlStatement);
      }

      await AppDataService.instance.setItem(
        AppDataKey.dbVersion,
        i.toStringAsFixed(0),
      );
    }

    Logger.printDebug('Migration completed!');
  }

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        Logger.printDebug(
          'DB found! Version ${details.versionNow} (previous was ${details.versionBefore}). Path to DB -> ${await databasePath}',
        );

        if (details.wasCreated) {
          Logger.printDebug('Executing seeders... Populating the database...');

          try {
            final initialDbSeedersStatements = [
              settingsInitialSeedSQL,
              appDataInitialSeedSQL(schemaVersion),
            ];

            for (final sqlStatement in initialDbSeedersStatements) {
              await customStatement(sqlStatement);
            }

            await CategoryService.instance.initializeCategories();
            await CurrencyService.instance.initializeCurrencies();

            Logger.printDebug('Initial data correctly inserted!');
          } catch (e) {
            Logger.printDebug('ERROR: $e');
            throw Exception(e);
          }
        }

        await customStatement('PRAGMA foreign_keys = ON');

        final dbVersion = int.parse(
          (await AppDataService.instance
              .getAppDataItem(AppDataKey.dbVersion)
              .first)!,
        );

        if (dbVersion < schemaVersion) {
          await migrateDB(dbVersion, schemaVersion);
        }

        Logger.printDebug('DB Opened!');
      },
      onCreate: (m) async {
        Logger.printDebug('Creating database tables...');

        // Create all tables from `sql/initial/tables.drift`. We have also the schema in SQLite format in the assets folder
        await m.createAll();

        Logger.printDebug('Database tables created!');
      },
      onUpgrade: (m, from, to) {
        // The migration (if applied) is already done when the DB is opened. For instance, we have nothing to do here.
        return Future(() => null);
      },
    );
  }

  /// Return a WHERE clause expression that is the equivalent to the conjunction of some expressions. If no expressions are passed, the WHERE clause will have no effect.
  Expression<bool> buildExpr(List<Expression<bool>> expressions) {
    if (expressions.isEmpty) return const CustomExpression('(TRUE)');

    Expression<bool> toReturn = expressions.first;

    for (var i = 1; i < expressions.length; i++) {
      final exprToPush = expressions[i];

      toReturn = toReturn & exprToPush;
    }

    return toReturn;
  }
}

LazyDatabase openConnection(String dbName, {bool logStatements = false}) {
  return LazyDatabase(() async {
    // Should be in the same route as the indicated in the databasePath getter of the AppDB class
    final file = File(
      join((await getApplicationDocumentsDirectory()).path, dbName),
    );

    return NativeDatabase.createBackgroundConnection(
      file,
      logStatements: logStatements,
    );
  });
}

/// Splits a string containing multiple SQL statements into a list of individual statements.
///
/// This function takes a string of SQL commands separated by semicolons and
/// splits them into individual statements.
///
/// Example:
/// ```dart
/// String sql = "CREATE TABLE users (id INT); INSERT INTO users (id) VALUES (1);";
/// List<String> statements = splitSQLStatements(sql);
/// Logger.printDebug(statements); // Output: ["CREATE TABLE users (id INT)", "INSERT INTO users (id) VALUES (1)"]
/// ```
///
/// [sqliteStr] - The input string containing multiple SQL statements.
///
/// Returns a list of individual SQL statements.
List<String> splitSQLStatements(String sqliteStr) {
  return sqliteStr
      .split(RegExp(r';\s'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
}
