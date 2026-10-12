import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/routes/route_utils.dart';

void main() {
  void setSurfaceSize(WidgetTester tester, Size size) {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(() {
      tester.view.resetDevicePixelRatio();
      tester.view.resetPhysicalSize();
    });
  }

  Widget buildPage({TabBar? tabBar, Widget? body}) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: PageFramework(
          title: 'Account title',
          subtitle: const Text('Account subtitle'),
          icon: const Icon(Icons.account_balance_wallet_outlined),
          tabBar: tabBar,
          body:
              body ??
              ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) =>
                    SizedBox(height: 64, child: Text('Item $index')),
              ),
        ),
      ),
    );
  }

  testWidgets('mobile identity header collapses into toolbar title', (
    tester,
  ) async {
    setSurfaceSize(tester, const Size(400, 800));
    await tester.pumpWidget(buildPage());
    await tester.pump(const Duration(milliseconds: 300));

    var appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height, 124);
    expect(find.text('Account title'), findsOneWidget);
    expect(
      tester
          .widget<Transform>(
            find.byKey(const ValueKey('page_framework_collapsing_title')),
          )
          .transform
          .getMaxScaleOnAxis(),
      closeTo(24 / 22, 0.05),
    );

    await tester.drag(find.byType(ListView), const Offset(0, -100));
    await tester.pump();

    appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height, 56);
    expect(find.text('Account title'), findsOneWidget);
    expect(
      tester
          .widget<Transform>(
            find.byKey(const ValueKey('page_framework_collapsing_title')),
          )
          .transform
          .getMaxScaleOnAxis(),
      closeTo(1.0, 0.01),
    );
  });

  testWidgets('horizontal scrolling does not collapse the mobile header', (
    tester,
  ) async {
    setSurfaceSize(tester, const Size(400, 800));
    await tester.pumpWidget(
      buildPage(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: const SizedBox(width: 1200, height: 200),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(-200, 0),
    );
    await tester.pump();

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height, 124);
    expect(find.text('Account title'), findsOneWidget);
  });

  testWidgets('mobile tab bar remains pinned after identity collapse', (
    tester,
  ) async {
    setSurfaceSize(tester, const Size(400, 800));
    await tester.pumpWidget(
      buildPage(
        tabBar: const TabBar(
          tabs: [
            Tab(text: 'One'),
            Tab(text: 'Two'),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    var appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height, 172);

    await tester.drag(find.byType(ListView), const Offset(0, -100));
    await tester.pump();

    appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height, 104);
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.text('Account title'), findsOneWidget);
  });

  testWidgets('omitting a title keeps a compact actions-only app bar', (
    tester,
  ) async {
    setSurfaceSize(tester, const Size(400, 800));
    await tester.pumpWidget(
      const MaterialApp(
        home: PageFramework(
          appBarActions: [
            IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
          ],
          body: SizedBox(),
        ),
      ),
    );

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height, 56);
    expect(appBar.title, isNull);
    expect(find.byIcon(Icons.more_vert), findsOneWidget);
  });

  testWidgets('desktop keeps the single tall toolbar', (tester) async {
    setSurfaceSize(tester, const Size(1200, 800));
    await tester.pumpWidget(buildPage());
    await tester.pump(const Duration(milliseconds: 300));

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.toolbarHeight, 76);
    expect(appBar.title, isA<Row>());
  });

  testWidgets('drawer uses a single compact app bar', (tester) async {
    setSurfaceSize(tester, const Size(480, 800));
    await tester.pumpWidget(
      const MaterialApp(
        home: SideDrawerScope(
          child: PageFramework(
            title: 'Form title',
            subtitle: Text('Form subtitle'),
            icon: Icon(Icons.edit_outlined),
            appBarActions: [
              IconButton(onPressed: null, icon: Icon(Icons.save)),
            ],
            body: SizedBox(),
          ),
        ),
      ),
    );

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height, 76);
    expect(appBar.title, isA<Row>());
    expect(find.byType(CloseButton), findsOneWidget);
    expect(find.text('Form title'), findsOneWidget);
  });

  testWidgets('desktop app bars inset actions from the window edge', (
    tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    setSurfaceSize(tester, const Size(1200, 800));
    await tester.pumpWidget(buildPage());
    await tester.pump(const Duration(milliseconds: 300));

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.actionsPadding, const EdgeInsetsDirectional.only(end: 12));

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('android app bars keep the default action padding', (
    tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    setSurfaceSize(tester, const Size(400, 800));
    await tester.pumpWidget(buildPage());
    await tester.pump(const Duration(milliseconds: 300));

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.actionsPadding, isNull);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('mobile title stays a single label while collapsing', (
    tester,
  ) async {
    setSurfaceSize(tester, const Size(400, 800));
    await tester.pumpWidget(buildPage());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.drag(find.byType(ListView), const Offset(0, -32));
    await tester.pump();

    expect(find.text('Account title'), findsOneWidget);
    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height, greaterThan(56));
    expect(appBar.preferredSize.height, lessThan(124));
  });

  testWidgets(
    'limited scrolling leaves the identity header partially collapsed',
    (tester) async {
      setSurfaceSize(tester, const Size(400, 800));
      await tester.pumpWidget(
        buildPage(
          body: ListView(
            children: const [SizedBox(height: 750, child: Text('Item 0'))],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));

      await tester.drag(find.byType(ListView), const Offset(0, -80));
      await tester.pumpAndSettle();

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.preferredSize.height, greaterThan(56));
      expect(appBar.preferredSize.height, lessThan(124));
      expect(find.text('Account title'), findsOneWidget);
    },
  );
}
