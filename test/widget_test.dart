// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/main.dart';

void main() {
  testWidgets('MonekinAppEntryPoint builds correctly',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const MonekinAppEntryPoint());

      expect(find.byType(MonekinAppEntryPoint), findsOneWidget);
    });
  });
}
