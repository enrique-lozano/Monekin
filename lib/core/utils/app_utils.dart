import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';

abstract class AppUtils {
  static bool get isDesktop {
    return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  }

  /// Whether the primary input is a pointer (mouse/trackpad). Used to decide
  /// pointer-first affordances such as selection checkboxes. Touch platforms
  /// (Android/iOS) return false and should rely on touch gestures (long press)
  /// instead.
  static bool get hasPointerInput => kIsWeb || isDesktop;

  /// Returns true if the current layout is in mobile mode. That means that
  /// we will display a bottom navigation bar instead of a sidebar
  static bool isMobileLayout(BuildContext context) {
    return BreakPoint.of(context).isSmallerThan(BreakpointID.md);
  }

  static bool isMobileSize(BuildContext context) {
    return MediaQuery.sizeOf(context).shortestSide < 580;
  }
}
