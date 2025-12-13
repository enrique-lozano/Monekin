// ignore_for_file: unnecessary_string_interpolations, prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

abstract mixin class PageWithScaffold {
  ScaffoldConfiguration get scaffoldConfiguration;

  set scaffoldConfiguration(ScaffoldConfiguration? config) {
    tabsPageKey.currentState?.updateScaffoldConfiguration();
  }
}

class ScaffoldConfiguration {
  final Widget? floatingActionButton;
  final List<Widget>? persistentFooterButtons;

  final String title;
  final TabBar? tabBar;
  final List<Widget>? appBarActions;

  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;

  final bool enableAppBar;

  final PreferredSizeWidget Function(
    String title,
    TabBar? tabBar,
    List<Widget>? appBarActions,
  )?
  appBarBuilder;

  ScaffoldConfiguration({
    required this.title,
    this.floatingActionButton,
    this.persistentFooterButtons,
    this.tabBar,
    this.appBarActions,
    this.appBarBuilder,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.enableAppBar = true,
  });

  PreferredSizeWidget buildDefaultAppBar() {
    return appBarBuilder != null
        ? appBarBuilder!(title, tabBar, appBarActions)
        : AppBar(
            key: ValueKey('AppBar_$title'),
            title: Text(title),
            bottom: tabBar,
            backgroundColor: appBarBackgroundColor,
            foregroundColor: appBarForegroundColor,
            actions: appBarActions,

            //automaticallyImplyLeading: !AppUtils.isDesktop,
          );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScaffoldConfiguration &&
        other.title == title &&
        other.appBarBackgroundColor == appBarBackgroundColor &&
        other.appBarForegroundColor == appBarForegroundColor &&
        other.enableAppBar == enableAppBar &&
        other.tabBar == tabBar &&
        other.floatingActionButton == floatingActionButton &&
        other.appBarBuilder == appBarBuilder;
  }

  @override
  int get hashCode {
    return Object.hash(
      title,
      appBarBackgroundColor,
      appBarForegroundColor,
      enableAppBar,
      tabBar,
      floatingActionButton,
      appBarBuilder,
    );
  }
}
