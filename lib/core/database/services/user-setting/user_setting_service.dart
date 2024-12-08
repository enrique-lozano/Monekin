import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/main.dart';

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

final Map<SettingKey, String?> appStateSettings = {};

class UserSettingService {
  final AppDB db;

  UserSettingService._(this.db);
  static final UserSettingService instance =
      UserSettingService._(AppDB.instance);

  initializeSettings() async {
    final savedSettings = await db.select(db.userSettings).watch().first;

    for (final savedSetting in savedSettings) {
      appStateSettings[savedSetting.settingKey] = savedSetting.settingValue;
    }
  }

  Future<bool> setSetting(
    SettingKey settingKey,
    String? settingValue, {
    bool updateGlobalState = false,
  }) async {
    final previousValue = appStateSettings[settingKey];

    if (previousValue == settingValue) {
      return false;
    }

    appStateSettings[settingKey] = settingValue;

    try {
      await db.into(db.userSettings).insert(
            UserSetting(settingKey: settingKey, settingValue: settingValue),
            mode: InsertMode.insertOrReplace,
          );

      if (updateGlobalState == true) {
        appStateKey.currentState?.refreshAppState();
      }
    } catch (e) {
      // Restore the previous value if an error occurs
      appStateSettings[settingKey] = previousValue;
      // Rethrow the error to allow the caller to handle it
      rethrow;
    }

    return true;
  }

  Stream<String?> getSettingFromDB(SettingKey settingKey) {
    return (db.select(db.userSettings)
          ..where((tbl) => tbl.settingKey.equalsValue(settingKey)))
        .map((e) => e.settingValue)
        .watchSingleOrNull();
  }

  Stream<List<UserSetting>> getSettingsFromDB(
      Expression<bool> Function(UserSettings) filter) {
    return (db.select(db.userSettings)..where(filter)).watch();
  }
}
