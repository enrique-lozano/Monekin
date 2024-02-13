import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

final mainLayoutRouterKey = GlobalKey<AutoRouterState>();
final tabsLayoutKey = GlobalKey<AutoTabsRouterState>();

StreamController<String?> layoutInsideRouteName = BehaviorSubject();

class MainLayoutNavObserver extends RouteObserver<ModalRoute<dynamic>> {
  StackRouter? get _router => mainLayoutRouterKey.currentState?.controller;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // print('Main layout nav observer: Did push');
    layoutInsideRouteName.add(_router?.current.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    //print('Main layout nav observer: Did replace');
    layoutInsideRouteName.add(_router?.current.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // print('Main layout nav observer: Did pop');
    layoutInsideRouteName.add(_router?.current.name);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // print('Main layout nav observer: Did remove');
    layoutInsideRouteName.add(_router?.current.name);
  }

  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didStopUserGesture() {}
}
