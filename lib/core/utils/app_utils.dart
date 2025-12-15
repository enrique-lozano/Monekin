import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';

abstract class AppUtils {
  static bool get isDesktop {
    return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  }

  static bool isMobileLayout(BuildContext context) {
    return BreakPoint.of(context).isSmallerThan(BreakpointID.md);
  }

  static bool isMobileSize(BuildContext context) {
    return MediaQuery.sizeOf(context).shortestSide < 580;
  }
}
