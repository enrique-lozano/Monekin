import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

abstract class RouteUtils {
  static Future<T?> pushRoute<T extends Object>(
    Widget page, {
    bool withReplacement = false,
  }) {
    if (navigatorKey.currentState == null) return Future.value(null);

    var pageRouteBuilder = getPageRouteBuilder<T>(page);

    if (withReplacement) {
      return navigatorKey.currentState!.pushReplacement(pageRouteBuilder);
    }

    return navigatorKey.currentState!.push(pageRouteBuilder);
  }

  static Future<T?> showResponsiveForm<T extends Object>(
    Widget form, {
    double? desktopWidth,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) return Future.value(null);

    // On wide layouts the form is a right-side drawer pushed on the ROOT
    // navigator, so its scrim covers the whole window (including the side
    // navigation), not just the content pane.
    if (!AppUtils.isMobileLayout(context)) {
      return rootNavigatorKey.currentState!.push(
        SideDrawerRoute<T>(
          child: form,
          desktopWidth: desktopWidth,
          barrierLabel: MaterialLocalizations.of(
            context,
          ).modalBarrierDismissLabel,
        ),
      );
    }

    return navigatorKey.currentState!.push(_fullscreenDialogRoute<T>(form));
  }

  static Future<T?> showResponsiveSheet<T extends Object>({
    required BuildContext context,
    required WidgetBuilder builder,
    double? desktopWidth,
  }) {
    if (AppUtils.isMobileLayout(context)) {
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: builder,
      );
    }

    return rootNavigatorKey.currentState!.push(
      SideDrawerRoute<T>(
        child: Builder(builder: builder),
        desktopWidth: desktopWidth,
        barrierLabel: MaterialLocalizations.of(
          context,
        ).modalBarrierDismissLabel,
      ),
    );
  }

  /// Presents a selector/picker bottom sheet responsively.
  ///
  /// On mobile it is a full-width bottom sheet on the local navigator (as
  /// before). On wide layouts it is pushed on the ROOT navigator and constrained
  /// to [desktopWidth] (a centered, narrower sheet). Presenting on the root is
  /// required so the sheet stacks *above* any open side drawer — a nested sheet
  /// would be hidden behind it — and so its scrim covers the whole window.
  static Future<T?> showResponsiveModal<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    double desktopWidth = 520,
  }) {
    final isMobile = AppUtils.isMobileLayout(context);

    return showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useRootNavigator: !isMobile,
      constraints: isMobile ? null : BoxConstraints(maxWidth: desktopWidth),
      builder: builder,
    );
  }

  static Route<T> _fullscreenDialogRoute<T extends Object>(Widget page) {
    return PageRouteBuilder<T>(
      fullscreenDialog: true,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            ),
          ),
          child: child,
        );
      },
    );
  }

  static Route<T> getPageRouteBuilder<T>(Widget page) {
    return PageRouteBuilder<T>(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const transitionBuilder = FadeForwardsPageTransitionsBuilder();
        return transitionBuilder.buildTransitions(
          null, // route parameter is not used by FadeForwardsPageTransitionsBuilder
          context,
          animation,
          secondaryAnimation,
          child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
    );
  }

  /// Pop all the routes in the stack except the first one without any animation
  static void popAllRoutesExceptFirst() {
    // This function can be useful when we want to return to the main layout page
    navigatorKey.currentState!.pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const SizedBox(),
        transitionDuration: const Duration(seconds: 0),
      ),
      (route) => route.isFirst,
    );

    navigatorKey.currentState!.pop();
  }

  static Future<bool> maybePopRoute<T extends Object?>(
    BuildContext? context, [
    T? result,
  ]) async {
    BuildContext? contextToPop = context;
    if (context == null) contextToPop = navigatorKey.currentContext;
    if (contextToPop == null) return false;
    return Navigator.of(contextToPop, rootNavigator: false).maybePop(result);
  }

  static void popRoute<T extends Object?>([T? result]) {
    // Side drawers / dialogs live on the root navigator; when one is open it is
    // the top-most route the user is interacting with, so close that first.
    final rootNav = rootNavigatorKey.currentState;
    if (rootNav != null && rootNav.canPop()) {
      return rootNav.pop(result);
    }

    return navigatorKey.currentState!.pop(result);
  }
}

/// A right-anchored overlay panel used to present forms on wide layouts.
///
/// It extends [PopupRoute] (not [PageRoute]) so it is guaranteed non-opaque:
/// the page underneath keeps painting behind the scrim instead of going black.
class SideDrawerRoute<T> extends PopupRoute<T> {
  SideDrawerRoute({required this.child, this.desktopWidth, this.barrierLabel});

  final Widget child;
  final double? desktopWidth;

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final width = min(
      desktopWidth ?? 480,
      MediaQuery.sizeOf(context).width * 0.9,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(16),
          ),
          child: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(size: Size(width, MediaQuery.sizeOf(context).height)),
            child: BreakpointProvider(child: SideDrawerScope(child: child)),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        ),
      ),
      child: child,
    );
  }
}

/// Marks the subtree as being presented inside a [SideDrawerRoute], so shared
/// shells (e.g. `PageFramework`) can show a close affordance instead of a back
/// arrow.
class SideDrawerScope extends InheritedWidget {
  const SideDrawerScope({super.key, required super.child});

  static bool of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SideDrawerScope>() !=
        null;
  }

  @override
  bool updateShouldNotify(SideDrawerScope oldWidget) => false;
}
