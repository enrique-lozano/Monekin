import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
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
    return ColoredBox(
      color: getWindowBackgroundColor(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 36,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                spacing: 12,
                children: [
                  // IconButton(
                  //   icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  //   onPressed: canGoBack
                  //       ? () {
                  //           navigatorKey.currentState?.pop();
                  //         }
                  //       : null,
                  // ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 3),
                    child: DisplayAppIcon(
                      height: 24,
                      padding: EdgeInsets.all(2),
                    ),
                  ),
                  Expanded(
                    child: MoveWindow(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Monekin",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final Color iconNormalColor = Theme.of(context).iconTheme.color!;

    final buttonColors = WindowButtonColors(
      normal: Theme.of(context).colorScheme.surfaceContainerLow,
      iconNormal: iconNormalColor,
      mouseOver: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      mouseDown: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      iconMouseOver: Theme.of(context).colorScheme.primary,
      iconMouseDown: Theme.of(context).colorScheme.primary,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
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
