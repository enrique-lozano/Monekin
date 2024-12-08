import 'dart:async';

import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:rxdart/rxdart.dart';

class PrivateModeService {
  final UserSettingService userSettingsService;

  PrivateModeService._(this.userSettingsService);
  static final PrivateModeService instance =
      PrivateModeService._(UserSettingService.instance);

  final _privateModeController = BehaviorSubject<bool>();
  Stream<bool> get privateModeStream => _privateModeController.stream;

  void dispose() {
    _privateModeController.close();
  }

  void setPrivateMode(bool value) {
    _privateModeController.add(value);
  }

  /// Set if the app should start in private mode
  Future<bool> setPrivateModeAtLaunch(bool value) async {
    final result = await userSettingsService.setSetting(
        SettingKey.privateModeAtLaunch, value ? '1' : '0');

    return result;
  }
}
