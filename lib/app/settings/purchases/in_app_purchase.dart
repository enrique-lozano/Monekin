// Gives the option to override in tests.
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';

class IAPConnection {
  static InAppPurchase? _instance;

  /// Overwrite the deafult method to check if the platform is supported
  static Future<bool> isAvailable() async {
    final instanceAv = await _instance?.isAvailable();

    return instanceAv != null &&
        instanceAv == true &&
        (Platform.isIOS || Platform.isAndroid);
  }

  static set instance(InAppPurchase value) {
    _instance = value;
  }

  static InAppPurchase get instance {
    _instance ??= InAppPurchase.instance;
    return _instance!;
  }
}
