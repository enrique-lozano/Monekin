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

// TODO: Pref currency missing, maybe we should initialise it too
String settingsInitialSeedSQL = """
  INSERT INTO userSettings VALUES 
  ('${SettingKey.avatar.name}', 'man'), 
  ('${SettingKey.userName.name}', 'User'), 
  ('${SettingKey.appLanguage.name}', null), 
  ('${SettingKey.privateModeAtLaunch.name}', '0'), 
  ('${SettingKey.accentColor.name}', 'auto'), 
  ('${SettingKey.amoledMode.name}', '0'), 
  ('${SettingKey.themeMode.name}', 'system');
""";
