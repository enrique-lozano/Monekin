import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/presentation/widgets/page_refresh.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  ScrollPhysics refreshPhysics(BuildContext context) =>
      AlwaysScrollableScrollPhysics(
        parent: ScrollConfiguration.of(context).getScrollPhysics(context),
      );

  Widget buildPage(
    Future<void> Function() onRefresh, {
    double height = 100,
    Widget? content,
  }) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      home: Scaffold(
        body: PageRefresh(
          onRefresh: onRefresh,
          builder: (context, button) => SingleChildScrollView(
            physics: AppUtils.hasPointerInput ? null : refreshPhysics(context),
            child: Column(
              children: [
                ?button,
                content ?? SizedBox(height: height, width: double.infinity),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pull(WidgetTester tester, {double distance = 350}) async {
    await tester.dragFrom(
      tester.getTopLeft(find.byType(SingleChildScrollView).first) +
          const Offset(50, 40),
      Offset(0, distance),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();
  }

  testWidgets('pull refreshes short content and waits for completion', (
    tester,
  ) async {
    final completion = Completer<void>();
    var refreshes = 0;
    await tester.pumpWidget(
      buildPage(() {
        refreshes++;
        return completion.future;
      }),
    );

    await pull(tester);
    expect(refreshes, 1);
    expect(find.byType(RefreshProgressIndicator), findsOneWidget);

    await pull(tester);
    expect(refreshes, 1);
    completion.complete();
    await tester.pumpAndSettle();
    expect(find.byType(RefreshProgressIndicator), findsNothing);
  });

  testWidgets('short pulls and normal scrolling do not refresh', (
    tester,
  ) async {
    var refreshes = 0;
    await tester.pumpWidget(
      buildPage(() async {
        refreshes++;
      }, height: 1800),
    );

    await pull(tester, distance: 30);
    await tester.pumpAndSettle();
    expect(refreshes, 0);
    await pull(tester, distance: -300);
    await tester.pumpAndSettle();
    await pull(tester, distance: 100);
    await tester.pumpAndSettle();
    expect(refreshes, 0);
  });

  testWidgets('an empty page still accepts pull-to-refresh', (tester) async {
    var refreshes = 0;
    await tester.pumpWidget(
      buildPage(() async {
        refreshes++;
      }, height: 0),
    );
    await pull(tester);
    await tester.pumpAndSettle();
    expect(refreshes, 1);
  });

  testWidgets('nested scroll and chart pan gestures do not refresh', (
    tester,
  ) async {
    var refreshes = 0;
    var pans = 0;
    await tester.pumpWidget(
      buildPage(
        () async => refreshes++,
        content: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView(children: const [SizedBox(height: 600)]),
            ),
            GestureDetector(
              key: const Key('chart'),
              behavior: HitTestBehavior.opaque,
              onPanUpdate: (_) => pans++,
              child: const SizedBox(height: 200, width: double.infinity),
            ),
          ],
        ),
      ),
    );

    await tester.drag(find.byType(ListView), const Offset(0, 350));
    await tester.pumpAndSettle();
    expect(refreshes, 0);
    await tester.pumpWidget(
      buildPage(
        () async => refreshes++,
        content: GestureDetector(
          key: const Key('chart'),
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (_) => pans++,
          child: const SizedBox(height: 200, width: double.infinity),
        ),
      ),
    );
    await tester.timedDrag(
      find.byKey(const Key('chart')),
      const Offset(150, 0),
      const Duration(milliseconds: 300),
    );
    await tester.pumpAndSettle();
    expect(pans, greaterThan(0));
    expect(refreshes, 0);
  });

  testWidgets(
    'desktop button and F5 share the guarded refresh action',
    (tester) async {
      var completion = Completer<void>();
      var refreshes = 0;
      await tester.pumpWidget(
        buildPage(() {
          refreshes++;
          return completion.future;
        }),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(t.ui_actions.refresh));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(refreshes, 1);
      expect(
        tester.widget<IconButton>(find.byType(IconButton)).onPressed,
        isNull,
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.f5);
      await tester.pump();
      expect(refreshes, 1);

      completion.complete();
      await tester.pumpAndSettle();
      completion = Completer<void>();
      await tester.sendKeyEvent(LogicalKeyboardKey.f5);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(refreshes, 2);
      completion.complete();
      await tester.pumpAndSettle();
    },
    variant: TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'F5 does not refresh a page covered by another route',
    (tester) async {
      var refreshes = 0;
      await tester.pumpWidget(
        buildPage(() async {
          refreshes++;
        }),
      );
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(PageRefresh));
      unawaited(
        showDialog<void>(
          context: context,
          builder: (_) => const AlertDialog(content: Text('Modal')),
        ),
      );
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.f5);
      await tester.pump();
      expect(refreshes, 0);
      Navigator.of(context).pop();
      await tester.pumpAndSettle();
    },
    variant: TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets('refresh waits for the callback to load its queries', (
    tester,
  ) async {
    final parentData = Completer<int>();
    final nestedData = Completer<int>();
    Stream<int> parent = Stream.value(1);
    Stream<int> nested = Stream.value(2);
    late StateSetter rebuild;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              rebuild = setState;
              return PageRefresh(
                onRefresh: () async {
                  rebuild(() {
                    parent = Stream.fromFuture(parentData.future);
                    nested = Stream.fromFuture(nestedData.future);
                  });
                  await Future.wait([parentData.future, nestedData.future]);
                },
                builder: (context, _) => SingleChildScrollView(
                  physics: refreshPhysics(context),
                  child: StreamBuilder(
                    stream: parent,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          width: double.infinity,
                          height: 100,
                        );
                      }
                      return StreamBuilder(
                        stream: nested,
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Text('${snapshot.data}'),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await pull(tester);
    parentData.complete(3);
    await tester.pump();
    await tester.pump();
    expect(find.byType(RefreshProgressIndicator), findsOneWidget);
    nestedData.complete(4);
    await tester.pumpAndSettle();
    expect(find.text('4'), findsOneWidget);
    expect(find.byType(RefreshProgressIndicator), findsNothing);
  });

  testWidgets(
    'refresh errors are surfaced and a retry is possible',
    (tester) async {
      var refreshes = 0;
      await tester.pumpWidget(
        buildPage(() async {
          if (refreshes++ == 0) throw StateError('Query failed');
        }),
      );
      await tester.tap(find.byTooltip(t.ui_actions.refresh));
      await tester.pumpAndSettle();
      expect(find.textContaining('Query failed'), findsOneWidget);
      expect(find.byType(RefreshProgressIndicator), findsNothing);
      await tester.tap(find.byTooltip(t.ui_actions.refresh));
      await tester.pumpAndSettle();
      expect(refreshes, 2);
      await tester.pump(const Duration(seconds: 7));
      await tester.pumpAndSettle();
    },
    variant: TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'query errors from the refresh callback allow retry',
    (tester) async {
      Stream<int> stream = Stream.value(1);
      var refreshes = 0;
      await tester.pumpWidget(
        MaterialApp(
          scaffoldMessengerKey: snackbarKey,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => PageRefresh(
                onRefresh: () async {
                  setState(() {
                    stream = switch (refreshes++) {
                      0 => Stream.value(1),
                      _ => Stream.value(3),
                    };
                  });
                  if (refreshes == 1) {
                    await Stream<int>.error(
                      StateError('Snapshot failed'),
                    ).first;
                  } else {
                    await Stream.value(3).first;
                  }
                },
                builder: (context, button) => SingleChildScrollView(
                  physics: AppUtils.hasPointerInput
                      ? null
                      : refreshPhysics(context),
                  child: Column(
                    children: [
                      ?button,
                      StreamBuilder(
                        stream: stream,
                        builder: (context, snapshot) {
                          return Text('${snapshot.data}');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(t.ui_actions.refresh));
      await tester.pumpAndSettle();
      expect(find.textContaining('Snapshot failed'), findsOneWidget);
      expect(find.byType(RefreshProgressIndicator), findsNothing);
      await tester.pump(const Duration(seconds: 7));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(t.ui_actions.refresh));
      await tester.pumpAndSettle();
      expect(find.text('3'), findsOneWidget);
      expect(refreshes, 2);
      expect(find.byType(RefreshProgressIndicator), findsNothing);
      expect(tester.takeException(), isNull);
    },
    variant: TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets('disposing during a pending refresh completes safely', (
    tester,
  ) async {
    final data = Completer<int>();
    Stream<int> stream = Stream.value(1);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => PageRefresh(
              onRefresh: () async {
                setState(() => stream = Stream.fromFuture(data.future));
                await data.future;
              },
              builder: (context, _) => SingleChildScrollView(
                physics: refreshPhysics(context),
                child: StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    return Text('${snapshot.data}');
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await pull(tester);
    expect(find.byType(RefreshProgressIndicator), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    data.complete(2);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'desktop scrolling does not trigger refresh',
    (tester) async {
      var refreshes = 0;
      await tester.pumpWidget(
        buildPage(() async {
          refreshes++;
        }, height: 1800),
      );
      await pull(tester);
      await tester.pumpAndSettle();
      expect(refreshes, 0);
      await pull(tester, distance: -300);
      await tester.pumpAndSettle();
      final scroll = tester.state<ScrollableState>(
        find.byType(Scrollable).first,
      );
      expect(scroll.position.pixels, greaterThan(0));
      expect(refreshes, 0);
    },
    variant: TargetPlatformVariant({TargetPlatform.windows}),
  );
}
