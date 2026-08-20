import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';

void main() {
  Widget buildModal({bool inSideDrawer = false}) {
    final modal = ModalContainer(
      title: 'Modal title',
      subtitle: 'Modal subtitle',
      body: const Text('Modal body'),
    );

    return MaterialApp(
      home: Scaffold(
        body: inSideDrawer ? SideDrawerScope(child: modal) : modal,
      ),
    );
  }

  testWidgets('side drawer modals wear an app bar with a close action', (
    tester,
  ) async {
    await tester.pumpWidget(buildModal(inSideDrawer: true));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(CloseButton), findsOneWidget);
    expect(find.text('Modal title'), findsOneWidget);
    expect(find.text('Modal subtitle'), findsOneWidget);
  });

  testWidgets('bottom sheets keep the headline title, with no extra chrome', (
    tester,
  ) async {
    await tester.pumpWidget(buildModal());

    expect(find.byType(AppBar), findsNothing);
    expect(find.byType(CloseButton), findsNothing);
    expect(find.text('Modal title'), findsOneWidget);
  });
}
