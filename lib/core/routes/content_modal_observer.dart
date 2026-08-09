import 'package:flutter/material.dart';

/// Number of "modal barrier" routes (e.g. bottom sheets) currently open on the
/// content (nested) navigator.
///
/// The persistent side navigation lives *beside* the content navigator, so a
/// modal pushed on it only dims the content pane — the sidebar would stay
/// interactive. Widgets can listen to this to block the sidebar while such a
/// modal is open. Modals presented on the root navigator don't count here (they
/// already cover the whole window, sidebar included).
final ValueNotifier<int> contentModalRoutesCount = ValueNotifier<int>(0);

/// Shared instance attached to the content navigator (see `main.dart`).
final ContentModalObserver contentModalObserver = ContentModalObserver();

class ContentModalObserver extends NavigatorObserver {
  bool _isBlockingModal(Route<dynamic>? route) {
    return route is ModalBottomSheetRoute || route is PopupRoute;
  }

  void _decrement() {
    contentModalRoutesCount.value = (contentModalRoutesCount.value - 1).clamp(
      0,
      1 << 30,
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (_isBlockingModal(route)) contentModalRoutesCount.value++;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (_isBlockingModal(route)) _decrement();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    if (_isBlockingModal(route)) _decrement();
  }
}
