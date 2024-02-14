import 'package:flutter/material.dart';
import 'package:monekin/main.dart';

abstract class RouteUtils {
  static Future<T?> pushRoute<T extends Object>(
    BuildContext context,
    Widget page, {
    bool withReplacement = false,
  }) {
    if (navigatorKey.currentState == null) return Future.value(null);

    var pageRouteBuilder = PageRouteBuilder<T>(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 125),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: const Offset(0, 0.05),
          end: Offset.zero,
        ).chain(
          CurveTween(curve: Curves.easeOut),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
    );

    if (withReplacement) {
      return navigatorKey.currentState!.pushReplacement(pageRouteBuilder);
    }

    return navigatorKey.currentState!.push(pageRouteBuilder);
  }
}
