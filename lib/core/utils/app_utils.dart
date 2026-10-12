import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';

abstract class AppUtils {
  /// The platform the UI should adapt to. Mirrors [defaultTargetPlatform], so
  /// it honours [debugDefaultTargetPlatformOverride] (set from the Debug page)
  /// to preview platform-specific UI, and falls back to the real platform when
  /// no override is active.
  static TargetPlatform get platform => defaultTargetPlatform;

  static bool get isDesktop {
    return platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.linux;
  }

  /// Apple platforms (macOS/iOS), which follow their own conventions (e.g. the
  /// window traffic-light controls live on the left, larger corner radii...).
  static bool get isApple {
    return platform == TargetPlatform.macOS || platform == TargetPlatform.iOS;
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
