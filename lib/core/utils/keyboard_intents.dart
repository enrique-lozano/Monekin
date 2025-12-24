import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

/// Handle when the user presses a back button key on the keyboard/mouse
void _handleKeyBackButton() {
  if (rootNavigatorKey.currentState != null &&
      rootNavigatorKey.currentState!.canPop()) {
    rootNavigatorKey.currentState!.maybePop();
    return;
  }

  RouteUtils.maybePopRoute(navigatorKey.currentContext);
}

Map<Type, Action<Intent>> keyboardIntents = {
  GoBackIntent: CallbackAction<GoBackIntent>(
    onInvoke: (GoBackIntent intent) => _handleKeyBackButton(),
  ),
};

Map<ShortcutActivator, Intent> shortcuts = {
  LogicalKeySet(LogicalKeyboardKey.goBack): const GoBackIntent(),
  LogicalKeySet(LogicalKeyboardKey.browserBack): const GoBackIntent(),
};

class GoBackIntent extends Intent {
  const GoBackIntent();
}
