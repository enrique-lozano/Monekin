import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

abstract class RouteUtils {
  static Future<T?> pushRoute<T extends Object>(
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

  static Future<T?> showResponsiveForm<T extends Object>(
    Widget form, {
    double? desktopWidth,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) return Future.value(null);

    // Wide: root-nav drawer so the scrim covers the sidebar too.
    if (!AppUtils.isMobileLayout(context)) {
      return rootNavigatorKey.currentState!.push(
        SideDrawerRoute<T>(
          child: form,
          desktopWidth: desktopWidth,
          barrierLabel: MaterialLocalizations.of(
            context,
          ).modalBarrierDismissLabel,
        ),
      );
    }

    return navigatorKey.currentState!.push(_fullscreenDialogRoute<T>(form));
  }

  static Future<T?> showResponsiveSheet<T extends Object>({
    required BuildContext context,
    required WidgetBuilder builder,
    double? desktopWidth,
  }) {
    if (AppUtils.isMobileLayout(context)) {
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => ModalPageScope(child: builder(context)),
      );
    }

    return rootNavigatorKey.currentState!.push(
      SideDrawerRoute<T>(
        child: Builder(builder: builder),
        desktopWidth: desktopWidth,
        barrierLabel: MaterialLocalizations.of(
          context,
        ).modalBarrierDismissLabel,
      ),
    );
  }

  /// Presents a selector/picker responsively.
  ///
  /// On mobile it is a full-width bottom sheet on the local navigator (as
  /// before). On wide layouts it is a floating popover anchored to the widget
  /// that triggered it (the [context]'s render box) and pushed on the ROOT
  /// navigator — so it stacks *above* any open side drawer (a nested sheet would
  /// be hidden behind it) and its scrim covers the whole window.
  ///
  /// The wide/narrow decision is taken from the *root* context (the whole
  /// window), not [context], because a selector opened from inside a side drawer
  /// has a width-constrained MediaQuery that would otherwise look "mobile".
  static Future<T?> showResponsiveModal<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    // Minimum popover width. Wider trigger fields expand the popover to match.
    double desktopWidth = 400,
    double desktopMaxHeight = 600,
  }) {
    final wideContext = rootNavigatorKey.currentContext ?? context;

    if (AppUtils.isMobileLayout(wideContext)) {
      return showModalBottomSheet<T>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: builder,
      );
    }

    return rootNavigatorKey.currentState!.push(
      SelectorPopoverRoute<T>(
        builder: builder,
        width: desktopWidth,
        maxHeight: desktopMaxHeight,
        anchorContext: context,
        barrierLabel: MaterialLocalizations.of(
          wideContext,
        ).modalBarrierDismissLabel,
      ),
    );
  }

  /// Current bounds of [anchorContext]'s render box, expressed in the ROOT
  /// overlay's coordinate space (where popover routes are painted).
  ///
  /// Recomputed on demand (not cached) so the popover card, its highlight
  /// border and its arrow all keep tracking the trigger widget when the window
  /// is resized or moved. Returns null if the anchor is gone or not yet laid
  /// out, in which case the popover falls back to a centered position.
  static Rect? anchorRectFor(BuildContext anchorContext) {
    if (!anchorContext.mounted) return null;

    final renderObject = anchorContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return null;

    // The popover route is pushed on the root navigator overlay, whose origin
    // sits below the desktop window bar. Screen-global coordinates from
    // [localToGlobal] must be converted into that overlay space or the field
    // highlight (and arrow) render too low.
    final overlayBox = rootNavigatorKey.currentState?.overlay?.context
        .findRenderObject();
    if (overlayBox is RenderBox) {
      final topLeft = renderObject.localToGlobal(
        Offset.zero,
        ancestor: overlayBox,
      );
      final bottomRight = renderObject.localToGlobal(
        renderObject.size.bottomRight(Offset.zero),
        ancestor: overlayBox,
      );
      return Rect.fromPoints(topLeft, bottomRight);
    }

    return renderObject.localToGlobal(Offset.zero) & renderObject.size;
  }

  static Route<T> _fullscreenDialogRoute<T extends Object>(Widget page) {
    return PageRouteBuilder<T>(
      fullscreenDialog: true,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) =>
          ModalPageScope(child: page),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            ),
          ),
          child: child,
        );
      },
    );
  }

  static Route<T> getPageRouteBuilder<T>(Widget page) {
    return PageRouteBuilder<T>(
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

  static Future<bool> maybePopRoute<T extends Object?>(
    BuildContext? context, [
    T? result,
  ]) async {
    BuildContext? contextToPop = context;
    if (context == null) contextToPop = navigatorKey.currentContext;
    if (contextToPop == null) return false;
    return Navigator.of(contextToPop, rootNavigator: false).maybePop(result);
  }

  static void popRoute<T extends Object?>([T? result]) {
    // Side drawers / dialogs live on the root navigator; when one is open it is
    // the top-most route the user is interacting with, so close that first.
    final rootNav = rootNavigatorKey.currentState;
    if (rootNav != null && rootNav.canPop()) {
      return rootNav.pop(result);
    }

    return navigatorKey.currentState!.pop(result);
  }
}

/// A right-anchored overlay panel used to present forms on wide layouts.
///
/// It extends [PopupRoute] (not [PageRoute]) so it is guaranteed non-opaque:
/// the page underneath keeps painting behind the scrim instead of going black.
class SideDrawerRoute<T> extends PopupRoute<T> {
  SideDrawerRoute({required this.child, this.desktopWidth, this.barrierLabel});

  final Widget child;
  final double? desktopWidth;

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final width = min(
      desktopWidth ?? 480,
      MediaQuery.sizeOf(context).width * 0.9,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(16),
          ),
          child: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(size: Size(width, MediaQuery.sizeOf(context).height)),
            child: BreakpointProvider(child: SideDrawerScope(child: child)),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        ),
      ),
      child: child,
    );
  }
}

/// Marks the subtree as being presented inside a [SideDrawerRoute], so shared
/// shells (e.g. `PageFramework`) can show a close affordance instead of a back
/// arrow.
class SideDrawerScope extends InheritedWidget {
  const SideDrawerScope({super.key, required super.child});

  static bool of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SideDrawerScope>() !=
        null;
  }

  @override
  bool updateShouldNotify(SideDrawerScope oldWidget) => false;
}

class ModalPageScope extends InheritedWidget {
  const ModalPageScope({super.key, required super.child});

  static bool of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ModalPageScope>() != null;
  }

  @override
  bool updateShouldNotify(ModalPageScope oldWidget) => false;
}

/// A floating, anchored popover used to present selectors/pickers on wide
/// layouts (see [RouteUtils.showResponsiveModal]).
///
/// Extends [PopupRoute] so it is non-opaque (the page underneath keeps painting
/// behind the scrim) and covers the whole window when pushed on the root
/// navigator.
class SelectorPopoverRoute<T> extends PopupRoute<T> {
  SelectorPopoverRoute({
    required this.builder,
    required this.width,
    required this.maxHeight,
    this.anchorContext,
    this.barrierLabel,
  });

  final WidgetBuilder builder;
  final double width;
  final double maxHeight;

  /// Context of the widget that triggered the popover. The anchor rect is
  /// derived from it live (see [RouteUtils.anchorRectFor]) on every rebuild so
  /// it survives window resizes/moves instead of being pinned to stale coords.
  final BuildContext? anchorContext;

  // A popover reads as attached to its trigger field, not as a modal takeover,
  // so it does not dim the content behind it. Its elevation/shadow provides the
  // separation instead. The (transparent) barrier still captures the outside
  // tap that dismisses it.
  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 120);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final anchorRect = anchorContext == null
        ? null
        : RouteUtils.anchorRectFor(anchorContext!);

    final geo = _PopoverGeometry.compute(
      screen: MediaQuery.sizeOf(context),
      anchor: anchorRect,
      width: width,
      maxHeight: maxHeight,
    );

    final card = Material(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16),
      color: AppColors.of(context).modalBackground,
      child: ModalPresentation(
        isPopoverPresentation: true,
        child: Builder(builder: builder),
      ),
    );

    // Trap focus inside the popover (so keystrokes don't leak to the page
    // behind it and Esc is caught here). With no search field, [autofocus]
    // lands on the first focusable item so it is keyboard-ready on open.
    final content = FocusScope(
      autofocus: true,
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            DismissIntent: CallbackAction<DismissIntent>(
              onInvoke: (intent) {
                Navigator.of(context).maybePop();
                return null;
              },
            ),
          },
          child: card,
        ),
      ),
    );

    final popoverColor = AppColors.of(context).modalBackground;
    final contentAlignment = switch (geo.side) {
      _PopoverSide.left || _PopoverSide.right => Alignment.center,
      _PopoverSide.below => Alignment.topCenter,
      _PopoverSide.above => Alignment.bottomCenter,
    };

    return Stack(
      children: [
        // Highlight the trigger field with a thin, primary-colored border so it
        // reads as the popover's origin.
        if (anchorRect != null)
          Positioned.fromRect(
            rect: anchorRect.inflate(1),
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(inputBorderRadius),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

        // Little triangle connecting the popover to its field. Painted before
        // the card so the card edge covers the ~1px seam.
        if (geo.arrowCenter != null)
          _PopoverArrow(
            side: geo.side,
            center: geo.arrowCenter!,
            color: popoverColor,
          ),

        Positioned.fromRect(
          rect: geo.rect,
          child: Align(
            alignment: contentAlignment,
            child: SizedBox(width: geo.rect.width, child: content),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    );

    // Grow the popover out of its trigger field: scaling around the anchor keeps
    // the field highlight and arrow visually pinned while the panel expands.
    final anchorRect = anchorContext == null
        ? null
        : RouteUtils.anchorRectFor(anchorContext!);

    final screen = MediaQuery.sizeOf(context);
    final alignment = anchorRect == null
        ? Alignment.center
        : Alignment(
            (anchorRect.center.dx / screen.width) * 2 - 1,
            (anchorRect.center.dy / screen.height) * 2 - 1,
          );

    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1).animate(curved),
        alignment: alignment,
        child: child,
      ),
    );
  }
}

/// The side of the trigger field the popover is placed on.
enum _PopoverSide { left, right, below, above }

/// Deterministic geometry for [SelectorPopoverRoute]: where the popover sits
/// and where its little pointer arrow connects to the field.
///
/// The popover prefers the *left* of the field (the filter panel lives on the
/// right, so there's more room there and it can grow taller), then the right,
/// and only stacks below/above when neither side fits.
class _PopoverGeometry {
  _PopoverGeometry({required this.rect, required this.side, this.arrowCenter});

  final Rect rect;
  final _PopoverSide side;
  final Offset? arrowCenter;

  static const double _margin = 20;
  static const double _gap = 10;

  static _PopoverGeometry compute({
    required Size screen,
    required Rect? anchor,
    required double width,
    required double maxHeight,
  }) {
    final desiredWidth = anchor == null ? width : max(width, anchor.width);
    final w = min(desiredWidth, screen.width - _margin * 2);

    if (anchor == null) {
      final h = maxHeight.clamp(160.0, screen.height - _margin * 2);
      return _PopoverGeometry(
        rect: Rect.fromLTWH(
          (screen.width - w) / 2,
          (screen.height - h) / 2,
          w,
          h,
        ),
        side: _PopoverSide.below,
      );
    }

    final spaceLeft = anchor.left - _gap - _margin;
    final spaceRight = screen.width - anchor.right - _gap - _margin;

    final side = spaceLeft >= w
        ? _PopoverSide.left
        : spaceRight >= w
        ? _PopoverSide.right
        : (screen.height - anchor.bottom) >= anchor.top
        ? _PopoverSide.below
        : _PopoverSide.above;

    final double h = switch (side) {
      _PopoverSide.left ||
      _PopoverSide.right => maxHeight.clamp(160.0, screen.height - _margin * 2),
      _PopoverSide.below => min(
        maxHeight,
        screen.height - anchor.bottom - _gap - _margin,
      ).clamp(160.0, screen.height - _margin * 2),
      _PopoverSide.above => min(
        maxHeight,
        anchor.top - _gap - _margin,
      ).clamp(160.0, screen.height - _margin * 2),
    };

    final double left = switch (side) {
      _PopoverSide.left => anchor.left - _gap - w,
      _PopoverSide.right => anchor.right + _gap,
      _PopoverSide.below || _PopoverSide.above =>
        (anchor.center.dx - w / 2).clamp(_margin, screen.width - w - _margin),
    };

    final double top = switch (side) {
      _PopoverSide.left || _PopoverSide.right =>
        (anchor.center.dy - h / 2).clamp(_margin, screen.height - h - _margin),
      _PopoverSide.below => anchor.bottom + _gap,
      _PopoverSide.above => anchor.top - _gap - h,
    };

    final rect = Rect.fromLTWH(left, top, w, h);

    final arrowCenter = switch (side) {
      _PopoverSide.left => Offset(
        rect.right,
        anchor.center.dy.clamp(rect.top + 14, rect.bottom - 14),
      ),
      _PopoverSide.right => Offset(
        rect.left,
        anchor.center.dy.clamp(rect.top + 14, rect.bottom - 14),
      ),
      _PopoverSide.below => Offset(
        anchor.center.dx.clamp(rect.left + 14, rect.right - 14),
        rect.top,
      ),
      _PopoverSide.above => Offset(
        anchor.center.dx.clamp(rect.left + 14, rect.right - 14),
        rect.bottom,
      ),
    };

    return _PopoverGeometry(rect: rect, side: side, arrowCenter: arrowCenter);
  }
}

class _PopoverArrow extends StatelessWidget {
  const _PopoverArrow({
    required this.side,
    required this.center,
    required this.color,
  });

  final _PopoverSide side;

  /// The point on the popover edge the arrow grows out of.
  final Offset center;
  final Color color;

  static const double _len = 7;
  static const double _half = 8;

  @override
  Widget build(BuildContext context) {
    final horizontal = side == _PopoverSide.left || side == _PopoverSide.right;
    final w = horizontal ? _len : _half * 2;
    final h = horizontal ? _half * 2 : _len;

    final left = switch (side) {
      _PopoverSide.left => center.dx - 0.5,
      _PopoverSide.right => center.dx - _len + 0.5,
      _PopoverSide.below || _PopoverSide.above => center.dx - _half,
    };

    final top = switch (side) {
      _PopoverSide.left || _PopoverSide.right => center.dy - _half,
      _PopoverSide.below => center.dy - _len + 0.5,
      _PopoverSide.above => center.dy - 0.5,
    };

    return Positioned(
      left: left,
      top: top,
      width: w,
      height: h,
      child: CustomPaint(
        painter: _ArrowPainter(side: side, color: color),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.side, required this.color});

  final _PopoverSide side;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    switch (side) {
      case _PopoverSide.left: // points right
        path.moveTo(0, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height / 2);
      case _PopoverSide.right: // points left
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height / 2);
      case _PopoverSide.below: // points up
        path.moveTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width / 2, 0);
      case _PopoverSide.above: // points down
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width / 2, size.height);
    }
    path.close();

    // A soft shadow lets the notch read as part of the elevated card even when
    // it sits against a same-colored background.
    canvas.drawShadow(path, Colors.black, 3, false);
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) =>
      oldDelegate.side != side || oldDelegate.color != color;
}

/// Tells descendants whether they are being presented inside a
/// [SelectorPopoverRoute] (a bounded, fixed-size popover) instead of a draggable
/// bottom sheet. Sheet content can use it to skip the [DraggableScrollableSheet]
/// (which would float with an empty gap inside a fixed box) and simply fill the
/// popover instead.
class ModalPresentation extends InheritedWidget {
  const ModalPresentation({
    super.key,
    required this.isPopoverPresentation,
    required super.child,
  });

  final bool isPopoverPresentation;

  static bool isPopover(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<ModalPresentation>()
            ?.isPopoverPresentation ??
        false;
  }

  @override
  bool updateShouldNotify(ModalPresentation oldWidget) =>
      isPopoverPresentation != oldWidget.isPopoverPresentation;
}

/// Focus node for a popover search field. Arrow Up/Down move focus into (and
/// through) the list below instead of moving the text cursor, so the results
/// stay keyboard-navigable while the search keeps input focus. Enter/Space then
/// activate the focused item natively.
FocusNode createPopoverSearchFocusNode() {
  return FocusNode(
    onKeyEvent: (node, event) {
      if (event is KeyUpEvent) return KeyEventResult.ignored;

      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        node.focusInDirection(TraversalDirection.down);
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        node.focusInDirection(TraversalDirection.up);
        return KeyEventResult.handled;
      }

      return KeyEventResult.ignored;
    },
  );
}

/// Commits the current selection when a popover is dismissed (barrier tap, back
/// or Esc). Popovers have no save button, so multi-step / multi-select pickers
/// apply their state on close instead. Outside a popover it is a passthrough.
///
/// [onCommit] is expected to close the popover itself (e.g. via
/// `RouteUtils.popRoute(result)`); it runs only when the dismissal was blocked
/// by this widget, so it never double-pops.
class PopoverCommitOnDismiss extends StatelessWidget {
  const PopoverCommitOnDismiss({
    super.key,
    required this.onCommit,
    required this.child,
  });

  final VoidCallback onCommit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!ModalPresentation.isPopover(context)) return child;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        onCommit();
      },
      child: child,
    );
  }
}
