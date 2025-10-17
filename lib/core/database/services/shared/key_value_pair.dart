import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';

class KeyValuePairInDB<T extends Enum> {
  final T key;
  final String? value;

  KeyValuePairInDB({required this.key, required this.value});

  static KeyValuePairInDB<SettingKey> fromUserSetting(UserSetting x) {
    return KeyValuePairInDB(key: x.settingKey, value: x.settingValue);
  }

  static KeyValuePairInDB<AppDataKey> fromAppData(AppDataData x) {
    return KeyValuePairInDB(key: x.appDataKey, value: x.appDataValue);
  }

  UserSetting toUserSetting() {
    return UserSetting(settingKey: key as SettingKey, settingValue: value);
  }

  AppDataData toAppDataItem() {
    return AppDataData(appDataKey: key as AppDataKey, appDataValue: value);
  }
}
