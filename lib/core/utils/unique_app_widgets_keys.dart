import 'package:flutter/material.dart';
import 'package:monekin/app/layout/navigation_sidebar.dart';
import 'package:monekin/app/layout/tabs.dart';
import 'package:monekin/app/layout/window_bar.dart';
import 'package:monekin/core/presentation/helpers/global_snackbar.dart';

final GlobalKey<TabsPageState> tabsPageKey = GlobalKey();
final GlobalKey<NavigationSidebarState> navigationSidebarKey = GlobalKey();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<WindowBarState> windowBarKey = GlobalKey<WindowBarState>();
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<GlobalSnackbarState> globalSnackbarKey = GlobalKey();
