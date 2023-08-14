import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';

/// The keys of the avalaible settings of the app
enum AppDataKey { dbVersion, introSeen, lastExportDate }

class AppDataService {
  final AppDB db;

  AppDataService._(this.db);
  static final AppDataService instance = AppDataService._(AppDB.instance);

  Future<int> setAppDataItem(AppDataKey appDataKey, String? appDataValue) {
    return db.into(db.appData).insert(
        AppDataData(appDataKey: appDataKey, appDataValue: appDataValue),
        mode: InsertMode.insertOrReplace);
  }

  Stream<String?> getAppDataItem(AppDataKey appDataKey) {
    return (db.select(db.appData)
          ..where((tbl) => tbl.appDataKey.equalsValue(appDataKey)))
        .map((e) => e.appDataValue)
        .watchSingleOrNull();
  }

  Stream<List<AppDataData>> getAppDataItems(
      Expression<bool> Function(AppData) filter) {
    return (db.select(db.appData)..where(filter)).watch();
  }
}
