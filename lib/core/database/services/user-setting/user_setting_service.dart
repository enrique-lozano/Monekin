import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/shared/key_value_pair.dart';
import 'package:monekin/core/database/services/shared/key_value_service.dart';

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

  transactionSwipeLeftAction,
  transactionSwipeRightAction
}

final Map<SettingKey, String?> appStateSettings = {};

class UserSettingService
    extends KeyValueService<SettingKey, UserSettings, UserSetting> {
  UserSettingService._(AppDB db)
      : super(
          db: db,
          table: db.userSettings,
          globalStateMap: appStateSettings,
          rowToKeyPairInstance: (row) => KeyValuePairInDB.fromUserSetting(row),
          toDbRow: (x) => x.toUserSetting(),
        );

  static final UserSettingService _instance =
      UserSettingService._(AppDB.instance);
  static UserSettingService get instance => _instance;

  Stream<String?> getSettingFromDB(SettingKey settingKey) {
    return (db.select(db.userSettings)
          ..where((tbl) => tbl.settingKey.equalsValue(settingKey)))
        .map((e) => e.settingValue)
        .watchSingleOrNull();
  }
}
