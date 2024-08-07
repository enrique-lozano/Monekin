import 'dart:async';

import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:rxdart/rxdart.dart';

class PrivateModeService {
  final UserSettingService userSettingsService;

  PrivateModeService._(this.userSettingsService);
  static final PrivateModeService instance =
      PrivateModeService._(UserSettingService.instance);

  /// Variable that track if the user is currently in the private mode.
  bool? inPrivateMode;

  final _privateModeController = BehaviorSubject<bool>();
  Stream<bool> get privateModeStream => _privateModeController.stream;

  void dispose() {
    _privateModeController.close();
  }

  Future<void> initializePrivateMode() async {
    setPrivateMode(await getPrivateModeAtLaunch().first);
  }

  void setPrivateMode(bool value) {
    inPrivateMode = value;
    _privateModeController.add(value);
  }

  /// Set if the app should start in private mode
  Future<int> setPrivateModeAtLaunch(bool value) async {
    final result = await userSettingsService.setSetting(
        SettingKey.privateModeAtLaunch, value ? '1' : '0');

    return result;
  }

  /// Get if the app should start in private mode:
  Stream<bool> getPrivateModeAtLaunch() {
    return userSettingsService
        .getSetting(SettingKey.privateModeAtLaunch)
        .map((x) => x == '1');
  }
}
