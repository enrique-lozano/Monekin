import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';

String appDataInitialSeedSQL(int schemaVersion) {
  return """
    INSERT INTO appData VALUES 
      ('${AppDataKey.dbVersion.name}', '${schemaVersion.toStringAsFixed(0)}'), 
      ('${AppDataKey.introSeen.name}', '0'), 
      ('${AppDataKey.lastExportDate.name}', null)
    """;
}

/// Initial value of the user settings in a fresh install. Settings not listed
/// here start as `null`
const Map<SettingKey, String?> initialUserSettings = {
  SettingKey.avatar: 'man',
  SettingKey.userName: 'User',
  SettingKey.font: '0',
  SettingKey.appLanguage: null,
  SettingKey.privateModeAtLaunch: '0',
  SettingKey.accentColor: 'auto',
  SettingKey.amoledMode: '0',
  SettingKey.themeMode: 'system',
  SettingKey.defaultTransactionType: 'E',
  SettingKey.transactionSwipeLeftAction: null,
  SettingKey.transactionSwipeRightAction: null,
  SettingKey.showAllDecimals: '1',
  SettingKey.transactionTileShowTags: '1',
  SettingKey.transactionTileShowTime: '1',
};

// TODO: Pref currency missing, maybe we should initialise it too
String settingsInitialSeedSQL =
    """
  INSERT INTO userSettings VALUES 
  ${initialUserSettings.entries.map((e) => "('${e.key.name}', ${e.value == null ? 'null' : "'${e.value}'"})").join(',\n  ')}
""";
