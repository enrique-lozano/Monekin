import 'dart:ui';

import 'package:material_ui/material_ui.dart';

class ScrollBehaviorOverride extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.unknown,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.stylus,
  };
}
