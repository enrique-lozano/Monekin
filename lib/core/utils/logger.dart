import 'package:flutter/foundation.dart';

class Logger {
  static void printDebug(Object message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
