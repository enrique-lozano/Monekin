import 'package:flutter/material.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

/// A widget that handles the WillPopScope for the entire app
class HandleWillPopScope extends StatefulWidget {
  const HandleWillPopScope({required this.child, super.key});
  final Widget child;

  @override
  State<HandleWillPopScope> createState() => _HandleWillPopScopeState();
}

class _HandleWillPopScopeState extends State<HandleWillPopScope> {
  bool canExitApp = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // We need to add this cause otherwise after using
      // the root navigator (in the showDialog method for example)
      // the WillPopScope inside this widget stops working and the
      // back button closes the app directly.
      //
      // This may be a stateless widget otherwise
      canPop: canExitApp,
      child: WillPopScope(
        child: widget.child,
        onWillPop: () async {
          // This code is fired AFTER the PopScope onPopInvokedWithResult of any page
          // inside the navigatorKey navigator
          bool popResult = await RouteUtils.maybePopRoute(
            navigatorKey.currentContext,
          );

          if (popResult == true) {
            if (canExitApp == true) {
              canExitApp = false;
              setState(() {});
            }

            return false;
          }

          // If the nested navigator can not handle the pop usually that
          // means that we have just start the app, so we allow the pop
          // if we are in the dashboard.
          //
          // We don't allow popping if we are in other pages, but we could not
          // reach any case where this happens right now.

          if (tabsPageKey.currentState?.selectedDestination ==
              AppMenuDestinationsID.dashboard) {
            if (canExitApp == false) {
              canExitApp = true;
              setState(() {});
            }

            return true;
          }

          return false;
        },
      ),
    );
  }
}
