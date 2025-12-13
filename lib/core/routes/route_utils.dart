import 'package:flutter/material.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

abstract class RouteUtils {
  static Future<T?> pushRoute<T extends Object>(
    BuildContext context,
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

  static Route<T> getPageRouteBuilder<T>(Widget page) {
    return PageRouteBuilder<T>(
      opaque: false,
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
}
