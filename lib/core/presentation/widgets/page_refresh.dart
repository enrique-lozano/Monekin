import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Wrap a vertical scrollable and recreate its queries in [onRefresh].
/// The refresh indicator stays visible until [onRefresh] completes.
class PageRefresh extends StatefulWidget {
  const PageRefresh({
    super.key,
    required this.onRefresh,
    required this.builder,
  });

  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext context, Widget? refreshButton) builder;

  @override
  PageRefreshState createState() => PageRefreshState();
}

class PageRefreshState extends State<PageRefresh> {
  final _indicatorKey = GlobalKey<RefreshIndicatorState>();
  final _busy = ValueNotifier(false);
  final _focusNode = FocusNode();

  void requestFocus() {
    if (mounted && AppUtils.hasPointerInput) _focusNode.requestFocus();
  }

  Future<void> _refresh() async {
    if (_busy.value) {
      return Future<void>.delayed(const Duration(seconds: 0));
    }

    _busy.value = true;

    try {
      await widget.onRefresh();
    } catch (error) {
      if (mounted) {
        MonekinSnackbar.error(SnackbarParams.fromError(error));
      }
    } finally {
      if (mounted) _busy.value = false;
    }
  }

  void _showRefresh() {
    if (_busy.value || ModalRoute.of(context)?.isCurrent == false) return;
    unawaited(_indicatorKey.currentState?.show());
  }

  @override
  void dispose() {
    _busy.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final desktop = AppUtils.hasPointerInput;
    final button = desktop
        ? ValueListenableBuilder(
            valueListenable: _busy,
            builder: (context, busy, _) => IconButton(
              tooltip: t.ui_actions.refresh,
              onPressed: busy ? null : _showRefresh,
              iconSize: 20,
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHigh,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                minimumSize: const Size(40, 40),
                padding: const EdgeInsets.all(10),
                shape: const CircleBorder(),
              ),
              icon: const Icon(Icons.refresh_rounded),
            ),
          )
        : null;

    return CallbackShortcuts(
      bindings: {
        if (desktop) const SingleActivator(LogicalKeyboardKey.f5): _showRefresh,
      },
      child: Focus(
        autofocus: desktop,
        focusNode: _focusNode,
        child: RefreshIndicator(
          key: _indicatorKey,
          onRefresh: _refresh,
          notificationPredicate: (notification) =>
              !desktop && notification.depth == 0,
          child: SizedBox.expand(
            child: Builder(
              builder: (context) => widget.builder(context, button),
            ),
          ),
        ),
      ),
    );
  }
}
