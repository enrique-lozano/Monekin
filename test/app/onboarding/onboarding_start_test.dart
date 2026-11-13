import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/onboarding/onboarding_start.page.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  Widget app(Widget page, {double textScale = 1}) {
    final colors = ColorScheme.fromSeed(seedColor: Colors.blue);
    return TranslationProvider(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: colors,
          extensions: [AppColors.fromColorScheme(colors)],
        ),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: page,
      ),
    );
  }

  void setSize(WidgetTester tester, Size size) {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(() {
      tester.view.resetDevicePixelRatio();
      tester.view.resetPhysicalSize();
    });
  }

  testWidgets('groups the heading with the icon and anchors options', (
    tester,
  ) async {
    setSize(tester, const Size(373, 900));
    final icon = find.byType(DisplayAppIcon);
    await tester.pumpWidget(app(const OnboardingStartPage()));
    expect(tester.getTopLeft(icon), const Offset(32, 24));
    expect(tester.getSize(icon), const Size(80, 80));
    final title = find.text(t.intro.start_options.title);
    expect(
      tester.getTopLeft(title).dy - tester.getBottomLeft(icon).dy,
      closeTo(36, 0.1),
    );
    final subtitle = find.text(t.intro.start_options.descr);
    expect(
      tester.getTopLeft(subtitle).dy,
      greaterThan(tester.getBottomLeft(title).dy),
    );
    final sampleTile = find
        .ancestor(
          of: find.text(t.intro.start_options.sample),
          matching: find.byType(Material),
        )
        .first;
    expect(tester.getBottomLeft(sampleTile).dy, closeTo(876, 0.1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('divider follows the entire single-line label when it fits', (
    tester,
  ) async {
    setSize(tester, const Size(450, 800));
    await tester.pumpWidget(app(const OnboardingStartPage()));

    final label = find.text(t.intro.start_options.other_ways);
    final paragraph = tester.renderObject<RenderParagraph>(label);
    expect(paragraph.didExceedMaxLines, isFalse);
    expect(tester.getSize(label).width, greaterThan((450 - 48) / 2));
    expect(
      tester.getTopLeft(find.byType(Divider)).dx,
      greaterThanOrEqualTo(tester.getTopRight(label).dx + 8),
    );
    expect(tester.widget<Text>(label).maxLines, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('short screens and enlarged text can scroll to every option', (
    tester,
  ) async {
    setSize(tester, const Size(320, 420));
    await tester.pumpWidget(app(const OnboardingStartPage(), textScale: 1.5));
    expect(tester.takeException(), isNull);
    final label = find.text(t.intro.start_options.other_ways);
    expect(tester.widget<Text>(label).maxLines, 1);
    expect(tester.widget<Text>(label).overflow, TextOverflow.ellipsis);
    expect(
      tester.getTopLeft(find.byType(Divider)).dx,
      greaterThanOrEqualTo(tester.getTopRight(label).dx + 8),
    );

    final sample = find.text(t.intro.start_options.sample);
    await tester.ensureVisible(sample);
    await tester.pumpAndSettle();
    expect(sample.hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('wide layout keeps both action columns visible', (tester) async {
    setSize(tester, const Size(1000, 800));
    await tester.pumpWidget(app(const OnboardingStartPage()));
    expect(
      find.text(t.intro.start_options.start_now).hitTestable(),
      findsOneWidget,
    );
    expect(
      find.text(t.intro.start_options.sample).hitTestable(),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
