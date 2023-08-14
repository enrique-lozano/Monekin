import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';

/// The keys of the avalaible settings of the app
enum SettingKey {
  preferredCurrency,
  userName,
  avatar,
  appLanguage,
  themeMode,
  transactionMobileMode
}

class UserSettingService {
  final AppDB db;

  UserSettingService._(this.db);
  static final UserSettingService instance =
      UserSettingService._(AppDB.instance);

  Future<int> setSetting(SettingKey settingKey, String? settingValue) async {
    return db.into(db.userSettings).insert(
        UserSetting(settingKey: settingKey, settingValue: settingValue),
        mode: InsertMode.insertOrReplace);
  }

  Stream<String?> getSetting(SettingKey settingKey) {
    return (db.select(db.userSettings)
          ..where((tbl) => tbl.settingKey.equalsValue(settingKey)))
        .map((e) => e.settingValue)
        .watchSingleOrNull();
  }

  Stream<List<UserSetting>> getSettings(
      Expression<bool> Function(UserSettings) filter) {
    return (db.select(db.userSettings)..where(filter)).watch();
  }
}
