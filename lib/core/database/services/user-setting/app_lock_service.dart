import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/utils/logger.dart';

enum AppLockAuthResult { success, failed, noCredentials }

/// Locks the app behind the device authentication (biometrics, or the device
/// PIN / pattern / password as a fallback). It relies entirely on the OS: if the
/// device has no screen lock configured, the lock can't be enabled.
class AppLockService {
  AppLockService._();
  static final AppLockService instance = AppLockService._();

  /// How long the app can stay in background before asking to authenticate again
  static const relockAfter = Duration(seconds: 30);

  final _auth = LocalAuthentication();

  /// Whether the app is currently hidden behind the lock screen
  final ValueNotifier<bool> isLocked = ValueNotifier(false);

  bool get isEnabled => appStateSettings[SettingKey.appLock] == '1';

  /// Locks the app on startup if the lock is enabled
  void lockIfEnabled() => isLocked.value = isEnabled;

  /// Whether the device can authenticate the user (it has a biometric, PIN,
  /// pattern or password configured). Always false on unsupported platforms.
  Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (e) {
      Logger.printDebug('Device authentication not available: $e');
      return false;
    }
  }

  /// Prompts the device authentication.
  ///
  /// Only [AppLockAuthResult.noCredentials] means the device has no screen lock
  /// configured. Any other problem is a [AppLockAuthResult.failed], so callers
  /// never open the lock because of a transient error.
  Future<AppLockAuthResult> authenticate(String reason) async {
    try {
      final ok = await _auth.authenticate(localizedReason: reason);
      return ok ? AppLockAuthResult.success : AppLockAuthResult.failed;
    } on LocalAuthException catch (e) {
      Logger.printDebug('Authentication failed: ${e.code}');
      return e.code == LocalAuthExceptionCode.noCredentialsSet
          ? AppLockAuthResult.noCredentials
          : AppLockAuthResult.failed;
    } catch (e) {
      Logger.printDebug('Authentication failed: $e');
      return AppLockAuthResult.failed;
    }
  }

  Future<bool> setEnabled(bool value) {
    return UserSettingService.instance.setItem(
      SettingKey.appLock,
      value ? '1' : '0',
    );
  }
}
