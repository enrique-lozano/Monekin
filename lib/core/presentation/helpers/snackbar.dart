import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/helpers/global_snackbar.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

class SnackbarParams {
  /// The amount of time the snack bar should be displayed.
  ///
  /// Defaults to 4.0s.
  final Duration duration;
  final String title;
  final String? message;
  final List<MonekinSnackbarAction>? actions;

  /// Whether to clear all previous snackbars before showing the new one.
  ///
  /// Defaults to true.
  final bool clearPrevious;

  /// Whether to show the snackbar at the top of the screen using global snackbar
  /// or at the bottom using ScaffoldMessenger.
  ///
  /// If null, uses the default defined in [MonekinSnackbar.showAtTopDefault].
  final bool? showAtTop;

  SnackbarParams(
    this.title, {
    this.duration = const Duration(seconds: 4),
    this.actions,
    this.message,
    this.showAtTop,
    this.clearPrevious = true,
  });

  SnackbarParams.fromError(
    dynamic errorMessage, {
    this.duration = const Duration(seconds: 6),
    this.actions,
    this.clearPrevious = true,
    this.showAtTop = false,
  }) : title = 'Error',
       message = '$errorMessage';

  EdgeInsetsGeometry get padding => EdgeInsets.only(
    top: actions != null && actions!.isNotEmpty ? 6 : 8,
    bottom: actions != null && actions!.isNotEmpty ? 4 : 8,
    left: 16,
    right: actions != null && actions!.isNotEmpty ? 8 : 16,
  );
}

/// Hosts an isolated [ScaffoldMessenger] for a subtree that is presented on top
/// of the page (a side drawer), and makes [MonekinSnackbar] target it while it
/// is on screen.
///
/// A [ScaffoldMessenger] lays its snackbars out in **every** [Scaffold]
/// registered under it, so without this scope a drawer would render its own
/// copy of each snackbar, measured for the whole window and squeezed into the
/// width of the panel.
class SnackbarScope extends StatefulWidget {
  const SnackbarScope({super.key, required this.child});

  final Widget child;

  /// Mounted scopes, outermost first.
  static final List<_SnackbarScopeState> _scopes = [];

  static _SnackbarScopeState? get _innermost {
    for (final scope in _scopes.reversed) {
      if (scope._messengerKey.currentState != null) return scope;
    }

    return null;
  }

  /// Messenger of the innermost scope on screen, or null when there is none.
  static ScaffoldMessengerState? get messenger =>
      _innermost?._messengerKey.currentState;

  /// Context of [messenger], to measure the area its snackbars live in.
  static BuildContext? get messengerContext =>
      _innermost?._messengerKey.currentContext;

  @override
  State<SnackbarScope> createState() => _SnackbarScopeState();
}

class _SnackbarScopeState extends State<SnackbarScope> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    SnackbarScope._scopes.add(this);
  }

  @override
  void dispose() {
    SnackbarScope._scopes.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(key: _messengerKey, child: widget.child);
  }
}

abstract class MonekinSnackbar {
  /// Whether to show snackbars at the top of the screen using global snackbar
  /// or at the bottom using ScaffoldMessenger.
  static bool get showAtTopDefault => false;

  /// Where the next snackbar goes: the drawer the user is working in, or the
  /// app itself when no drawer is open.
  static BuildContext? get _context =>
      SnackbarScope.messengerContext ?? snackbarKey.currentContext;

  /// Private method to get ScaffoldMessenger and optionally clear previous snackbars
  static ScaffoldMessengerState _getScaffoldMessenger(SnackbarParams options) {
    final scaffoldMessenger =
        SnackbarScope.messenger ?? snackbarKey.currentState;

    if (scaffoldMessenger == null || scaffoldMessenger.mounted == false) {
      Logger.printDebug(
        'ScaffoldMessengerState is null. Cannot show snackbar.',
      );
    }

    if (options.clearPrevious) {
      final globalSnackbarState = globalSnackbarKey.currentState;

      if (globalSnackbarState != null &&
          globalSnackbarState.mounted &&
          globalSnackbarState.currentQueue.isNotEmpty) {
        Future.delayed(Duration(milliseconds: 1), () {
          globalSnackbarState.animateOut();
        });
      }

      scaffoldMessenger!.clearSnackBars();
    }

    return scaffoldMessenger!;
  }

  static openSnackbar({
    required SnackbarParams options,
    required Color bgColor,
    required Color textColor,
    required IconData iconData,
  }) {
    final showAtTop = options.showAtTop ?? MonekinSnackbar.showAtTopDefault;

    if (showAtTop) {
      _getScaffoldMessenger(options);

      final snackbarResult = globalSnackbarKey.currentState!.post(
        SnackbarInstance.fromParams(
          options,
          textColor: textColor,
          backgroundColor: bgColor,
          iconData: iconData,
        ),
      );

      return snackbarResult;
    }

    final context = _context;
    final showAsToast = context != null && !AppUtils.isMobileLayout(context);

    // Snackbars are laid out by the page's Scaffold, which only spans the area
    // at the right of the navigation sidebar, so the margins have to be
    // measured against that area and not against the whole window. A drawer
    // lays them out inside its own panel, where the sidebar is not in the way.
    final sidebarWidth = SnackbarScope.messengerContext != null
        ? 0.0
        : (navigationSidebarKey.currentContext?.findRenderObject()
                      as RenderBox?)
                  ?.size
                  .width ??
              0;
    final availableWidth = context == null
        ? 0.0
        : MediaQuery.sizeOf(context).width - sidebarWidth;
    final toastWidth = min(380.0, availableWidth - 32);

    return _getScaffoldMessenger(options).showSnackBar(
      SnackBar(
        padding: options.padding,
        backgroundColor: bgColor,
        behavior: showAsToast ? SnackBarBehavior.floating : null,
        margin: showAsToast
            ? EdgeInsets.only(
                left: max(0, availableWidth - toastWidth - 16),
                right: 16,
                bottom: 16,
              )
            : null,
        duration: options.duration,
        content: MonekinSnackbarContent(
          title: options.title,
          message: options.message,
          color: textColor,
          icon: iconData,
          actions: options.actions,
        ),
      ),
    );
  }

  static success(SnackbarParams options) {
    return MonekinSnackbar.openSnackbar(
      options: options,
      bgColor: Colors.green[50]!,
      textColor: Colors.green,
      iconData: Icons.check_circle_outline,
    );
  }

  static error(SnackbarParams options) {
    final context = _context!;

    return MonekinSnackbar.openSnackbar(
      options: options,
      bgColor: isAppInLightBrightness(context)
          ? Theme.of(context).colorScheme.errorContainer
          : Theme.of(context).colorScheme.error,
      textColor: isAppInLightBrightness(context)
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.errorContainer,
      iconData: Icons.error_outline,
    );
  }

  static warning(SnackbarParams options) {
    return MonekinSnackbar.openSnackbar(
      options: options,
      bgColor: Colors.amber[50]!,
      textColor: Colors.amber,
      iconData: Icons.warning_amber_rounded,
    );
  }

  static info(SnackbarParams options) {
    return MonekinSnackbar.openSnackbar(
      options: options,
      bgColor: Colors.blue[50]!,
      textColor: Colors.blue,
      iconData: Icons.info_outline_rounded,
    );
  }
}

class MonekinSnackbarAction {
  final String label;
  final VoidCallback? onPressed;

  MonekinSnackbarAction({required this.label, required this.onPressed});
}

class MonekinSnackbarContent extends StatelessWidget {
  const MonekinSnackbarContent({
    super.key,
    required this.title,
    required this.color,
    this.message,
    this.icon,
    this.actions,
  });

  final Color color;

  /// title is the header String that will show on top
  final String title;

  /// message String is the body message which shows only 2 lines at max
  final String? message;

  /// `optional` color of the SnackBar/MaterialBanner body
  final IconData? icon;

  final List<MonekinSnackbarAction>? actions;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = isAppInDarkBrightness(context)
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.onSurface;

    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      textDirection: TextDirection.ltr,

      children: [
        Row(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, color: color),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyMedium!.copyWith(
                      color: textColor,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (message != null)
                    Text(
                      message!,
                      softWrap: true,
                      style: textTheme.bodyMedium!.copyWith(
                        color: textColor.withOpacity(0.9),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),

        if (actions != null && actions!.isNotEmpty)
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize:
                (message != null ||
                    actions!.length >= 2 ||
                    title.length > 30 ||
                    actions!.elementAt(0).label.length > 10)
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              ...actions!.map(
                (action) => TextButton(
                  onPressed: action.onPressed,
                  style: TextButton.styleFrom(
                    foregroundColor: color,
                    textStyle: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  child: Text(action.label),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
