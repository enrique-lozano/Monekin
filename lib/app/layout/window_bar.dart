import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

Color getWindowBackgroundColor(BuildContext context) {
  // return Colors.red;
  return Theme.of(context).colorScheme.surfaceContainerLow;
}

class WindowBar extends StatefulWidget {
  const WindowBar({super.key});

  @override
  State<WindowBar> createState() => WindowBarState();
}

class WindowBarState extends State<WindowBar> {
  bool canGoBack = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateCanGoBack();
  }

  void updateCanGoBack() {
    final newCanGoBack = navigatorKey.currentState?.canPop() ?? false;
    if (canGoBack != newCanGoBack) {
      setState(() {
        canGoBack = newCanGoBack;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // macOS draws its own window controls (the traffic lights) on the left, so
    // we leave room for them there and don't paint our own buttons. Windows and
    // Linux keep the app-drawn buttons on the right.
    final isApple = AppUtils.isApple;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: getWindowBackgroundColor(context),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: isApple ? 74 : 12, right: 12),
              height: 31,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                spacing: 12,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 3),
                    child: DisplayAppIcon(
                      height: 20,
                      withBorder: false,
                      padding: EdgeInsets.all(2),
                    ),
                  ),
                  Expanded(
                    child: MoveWindow(
                      child: Container(
                        padding: const EdgeInsets.only(top: 3),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Monekin',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isApple)
            WindowTitleBarBox(
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: WindowButtons(),
              ),
            ),
        ],
      ),
    );
  }
}

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons>
    with WidgetsBindingObserver {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    _isMaximized = appWindow.isMaximized;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _syncMaximizedState();
  }

  void _syncMaximizedState() {
    final isMaximized = appWindow.isMaximized;
    if (!mounted || isMaximized == _isMaximized) return;
    setState(() => _isMaximized = isMaximized);
  }

  void maximizeOrRestore() {
    appWindow.maximizeOrRestore();
    // Native maximize/restore is posted asynchronously; flip the icon now and
    // let [didChangeMetrics] confirm once the window size actually changes.
    setState(() => _isMaximized = !_isMaximized);
  }

  @override
  Widget build(BuildContext context) {
    final Color iconNormalColor = Theme.of(context).iconTheme.color!;

    final buttonColors = WindowButtonColors(
      normal: Theme.of(context).colorScheme.surfaceContainerLow,
      iconNormal: iconNormalColor,
      mouseOver: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      mouseDown: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
      iconMouseOver: Theme.of(context).colorScheme.primary,
      iconMouseDown: Theme.of(context).colorScheme.primary,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        if (_isMaximized)
          RestoreWindowButton(
            colors: buttonColors,
            onPressed: maximizeOrRestore,
          )
        else
          MaximizeWindowButton(
            colors: buttonColors,
            onPressed: maximizeOrRestore,
          ),
        CloseWindowButton(
          colors: WindowButtonColors(
            normal: Theme.of(context).colorScheme.surfaceContainerLow,
            mouseOver: Colors.red,
            mouseDown: Colors.redAccent,
            iconNormal: iconNormalColor,
            iconMouseOver: Colors.white,
          ),
        ),
      ],
    );
  }
}
