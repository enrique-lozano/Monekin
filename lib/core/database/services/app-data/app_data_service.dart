import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/shared/key_value_pair.dart';
import 'package:monekin/core/database/services/shared/key_value_service.dart';

/// The keys of the avalaible settings of the app
enum AppDataKey {
  dbVersion,
  introSeen,
  lastExportDate,
  lastDashboardDatePeriod,
  firstTransactionGuideDismissed,
}

final Map<AppDataKey, String?> appStateData = {};

class AppDataService extends KeyValueService<AppDataKey, AppData, AppDataData> {
  AppDataService._(AppDB db)
    : super(
        db: db,
        table: db.appData,
        globalStateMap: appStateData,
        rowToKeyPairInstance: (row) => KeyValuePairInDB.fromAppData(row),
        toDbRow: (x) => x.toAppDataItem(),
      );

  static final AppDataService _instance = AppDataService._(AppDB.instance);
  static AppDataService get instance => _instance;

  /// Resets the app state to a fresh install (the onboarding will be shown
  /// again), keeping only the database version.
  Future<void> resetAppData() async {
    for (final key in AppDataKey.values) {
      if (key == AppDataKey.dbVersion || key == AppDataKey.introSeen) continue;

      await setItem(key, null);
    }

    await setItem(AppDataKey.introSeen, '0', updateGlobalState: true);
  }

  Stream<String?> getAppDataItem(AppDataKey appDataKey) {
    return (db.select(db.appData)
          ..where((tbl) => tbl.appDataKey.equalsValue(appDataKey)))
        .map((e) => e.appDataValue)
        .watchSingleOrNull();
  }
}
