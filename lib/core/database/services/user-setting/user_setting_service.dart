import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';

/// The keys of the avalaible settings of the app
enum SettingKey {
  preferredCurrency,
  userName,
  avatar,
  appLanguage,

  /// Key to storage if the user will enter in the "private mode" when the app launches.
  privateModeAtLaunch,

  /// Key to storage the app theme. Could be 'system', 'light' or 'dark'
  themeMode,

  /// Key to storage the app accentColor. It's a string representing the color in HEX format (without the `#`) or the string 'auto' to apply dynamic colors if possible (if not possible will default to the Monekin blue brand color)
  accentColor,

  /// Key to storage if the user have the AMOLED mode activated. Could be '1' (true) or '0' (false)
  amoledMode,
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
