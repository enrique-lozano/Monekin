import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/transactions/form/dialogs/amount_selector.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_dual_leg_amount_section.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:provider/provider.dart';

void main() {
  const currency = CurrencyInDB(
    code: 'EUR',
    symbol: 'EUR',
    name: 'Euro',
    decimalPlaces: 2,
    isDefault: true,
    type: 0,
  );

  Account account(String id) => Account(
    id: id,
    name: id,
    iniValue: 0,
    date: DateTime(2020),
    type: AccountType.money,
    displayOrder: 0,
    iconId: 'wallet',
    currency: currency,
  );

  late TransactionFormController controller;
  final formKey = GlobalKey();

  setUp(() {
    controller = TransactionFormController()
      ..transactionType = TransactionType.transfer;
  });

  tearDown(() {
    controller.dispose();
  });

  Future<void> pumpForm(WidgetTester tester, Widget body) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1400, 900);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final scheme = ColorScheme.fromSeed(seedColor: Colors.blue);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: controller,
        child: MaterialApp(
          navigatorKey: rootNavigatorKey,
          theme: ThemeData(
            colorScheme: scheme,
            extensions: [AppColors.fromColorScheme(scheme)],
          ),
          home: Scaffold(
            body: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(key: formKey, width: 450, child: body),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the transfer cards expose separate popover anchors', (
    tester,
  ) async {
    await pumpForm(tester, const TransactionFormDualLegAmountSection());

    final top = tester.getRect(find.byKey(controller.dualLegTopCardKey));
    final bottom = tester.getRect(find.byKey(controller.dualLegBottomCardKey));
    expect(top.width, greaterThan(0));
    expect(bottom.width, top.width);
    expect(top.bottom, lessThan(bottom.top));
  });

  for (final reversed in [false, true]) {
    testWidgets('calculator anchors follow accounts when reversed=$reversed', (
      tester,
    ) async {
      controller
        ..fromAccount = account('Top')
        ..transferAccount = account('Bottom');
      if (reversed) controller.toggleDualLegFlowDirection();

      await pumpForm(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              key: controller.dualLegTopCardKey,
              width: 450,
              height: 110,
            ),
            const SizedBox(height: 50),
            SizedBox(
              key: controller.dualLegBottomCardKey,
              width: 450,
              height: 110,
            ),
          ],
        ),
      );

      Future<void> expectAnchor(GlobalKey key) async {
        await tester.pumpAndSettle();
        final selector = find.byType(AmountSelector);
        expect(selector, findsOneWidget);
        final route = ModalRoute.of(tester.element(selector));
        expect(route, isA<SelectorPopoverRoute<void>>());
        expect(
          (route! as SelectorPopoverRoute<void>).anchorContext,
          same(key.currentContext),
        );
        final anchor = tester.getRect(find.byKey(key)).inflate(1);
        final highlight = find.byWidgetPredicate(
          (widget) =>
              widget is DecoratedBox &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).border != null,
        );
        expect(
          highlight.evaluate().any(
            (element) =>
                tester.getRect(find.byWidget(element.widget)) == anchor,
          ),
          isTrue,
        );
      }

      controller.openTransferSourceAmountSelector(formKey.currentContext!);
      await expectAnchor(
        reversed
            ? controller.dualLegBottomCardKey
            : controller.dualLegTopCardKey,
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.byType(AmountSelector), findsNothing);

      controller.openTransferDestinationAmountSelector(
        formKey.currentContext!,
        defaultDestinationAmount: 0,
      );
      await expectAnchor(
        reversed
            ? controller.dualLegTopCardKey
            : controller.dualLegBottomCardKey,
      );
      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();
      expect(find.byType(AmountSelector), findsNothing);

      controller.openDualLegTopAmountSelector(formKey.currentContext!);
      await expectAnchor(controller.dualLegTopCardKey);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(find.byType(AmountSelector), findsNothing);
    });
  }
}
