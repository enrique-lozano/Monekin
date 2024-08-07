import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';

class PrivateModeService {
  final UserSettingService userSettingsService;

  PrivateModeService._(this.userSettingsService);
  static final PrivateModeService instance =
      PrivateModeService._(UserSettingService.instance);

  /// Variable that track if the user is currently in the private mode.
  bool? inPrivateMode;

  Future<bool> isInPrivateMode() async {
    if (inPrivateMode != null) {
      return inPrivateMode!;
    }

    final privateModeAtLaunch = await getPrivateModeAtLaunch().first;
    return privateModeAtLaunch;
  }

  Future<int> setPrivateModeAtLaunch(bool value) {
    return userSettingsService.setSetting(
        SettingKey.privateModeAtLaunch, value ? '1' : '0');
  }

  Stream<bool> getPrivateModeAtLaunch() {
    return userSettingsService
        .getSetting(SettingKey.privateModeAtLaunch)
        .map((x) => x == '1');
  }
}
