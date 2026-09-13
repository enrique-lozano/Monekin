import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';

void main() {
  void setSurfaceSize(WidgetTester tester, Size size) {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(() {
      tester.view.resetDevicePixelRatio();
      tester.view.resetPhysicalSize();
    });
  }

  Widget buildApp() {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      navigatorKey: rootNavigatorKey,
      home: const Scaffold(body: SizedBox.expand()),
    );
  }

  Future<void> openDrawer(WidgetTester tester) async {
    unawaited(
      rootNavigatorKey.currentState!.push(
        SideDrawerRoute<void>(
          barrierLabel: 'Dismiss',
          child: Scaffold(
            persistentFooterButtons: [
              FilledButton(onPressed: () {}, child: const Text('Save')),
            ],
            body: const SizedBox.expand(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
  }

  /// Lets the snackbar time out, so no timer outlives the test.
  Future<void> waitForDismissal(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  }

  testWidgets('a snackbar raised from a side drawer is shown inside it', (
    tester,
  ) async {
    setSurfaceSize(tester, const Size(1400, 900));
    await tester.pumpWidget(buildApp());
    await openDrawer(tester);

    // A long message: squeezed into a fraction of the panel it grows tall
    // enough to be pushed off screen by the footer buttons.
    MonekinSnackbar.info(
      SnackbarParams(
        'This account can no longer change its type, since it already has '
        'holdings, trades or snapshots.',
      ),
    );
    await tester.pumpAndSettle();

    // The app messenger would lay one out in every Scaffold it knows about,
    // the drawer's included, with margins measured for the whole window.
    expect(find.byType(SnackBar), findsOneWidget);

    final drawer = tester.getRect(find.byType(SideDrawerScope));
    final content = tester.getRect(find.byType(MonekinSnackbarContent));

    // Window-sized margins would squeeze the content out of the panel.
    expect(content.left, greaterThanOrEqualTo(drawer.left));
    expect(content.right, lessThanOrEqualTo(drawer.right));
    expect(content.width, greaterThan(0));

    await waitForDismissal(tester);
  });

  testWidgets('without a drawer it is a toast at the bottom right', (
    tester,
  ) async {
    setSurfaceSize(tester, const Size(1400, 900));
    await tester.pumpWidget(buildApp());

    MonekinSnackbar.info(SnackbarParams('Account saved'));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);

    final content = tester.getRect(find.byType(MonekinSnackbarContent));
    expect(content.right, lessThanOrEqualTo(1400 - 16));
    expect(content.left, greaterThan(1400 / 2));

    await waitForDismissal(tester);
  });
}
