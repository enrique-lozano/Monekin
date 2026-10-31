import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/currencies/widgets/exchange_rate_source_indicator.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  Widget buildIndicator({
    bool loading = false,
    double? rate = 0.89509,
    bool matchesRate = false,
    VoidCallback? onUseValue,
    double width = 448,
    double textScale = 1,
    TextDirection direction = TextDirection.ltr,
  }) {
    return TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
            child: Directionality(
              textDirection: direction,
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: width,
                  child: ExchangeRateSourceIndicator(
                    loading: loading,
                    rate: rate,
                    matchesRate: matchesRate,
                    onUseValue: onUseValue ?? () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('no source UI appears without a rate or a pending request', (
    tester,
  ) async {
    await tester.pumpWidget(buildIndicator(rate: null));

    expect(find.text(frankfurterEcbCredit), findsNothing);
    expect(find.byType(Card), findsNothing);
    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('loading and filled states are information, not controls', (
    tester,
  ) async {
    final form = t.currencies.exchange_rate_form;
    await tester.pumpWidget(buildIndicator(loading: true, rate: null));
    expect(find.text(form.ecb_loading), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(IconButton), findsNothing);
    final loadingStart = tester.getTopLeft(find.text(form.ecb_loading)).dx;

    await tester.pumpWidget(buildIndicator(matchesRate: true));
    expect(find.text(form.ecb_filled), findsOneWidget);
    expect(find.byIcon(Icons.check_rounded), findsNothing);
    expect(find.byIcon(Icons.info_outline), findsNothing);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(Chip), findsNothing);
    expect(find.byType(IconButton), findsNothing);
    expect(tester.getTopLeft(find.text(form.ecb_filled)).dx, loadingStart);
    expect(find.text(frankfurterEcbCredit), findsOneWidget);
  });

  testWidgets('a differing rate has an explicit, working use-value action', (
    tester,
  ) async {
    var applied = false;
    final form = t.currencies.exchange_rate_form;
    await tester.pumpWidget(buildIndicator(onUseValue: () => applied = true));

    expect(find.text(form.ecb_value(rate: '0.89509')), findsOneWidget);
    expect(find.text(frankfurterEcbCredit), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byIcon(Icons.sync_rounded), findsOneWidget);
    expect(find.byType(TextButton), findsNothing);
    await tester.tap(find.byTooltip(form.ecb_use_value));
    expect(applied, isTrue);
  });

  testWidgets('filled and differing states retain the same card structure', (
    tester,
  ) async {
    final form = t.currencies.exchange_rate_form;
    await tester.pumpWidget(buildIndicator());
    final differentBounds = tester.getRect(find.byType(Card));
    final creditBounds = tester.getRect(find.text(frankfurterEcbCredit));
    final textBounds = tester.getRect(
      find.text(form.ecb_value(rate: '0.89509')),
    );
    final resetBounds = tester.getRect(find.byType(IconButton));
    expect(resetBounds.left, greaterThan(textBounds.right));
    expect(resetBounds.width, greaterThanOrEqualTo(42));
    expect(resetBounds.height, greaterThanOrEqualTo(42));
    await tester.longPress(find.byType(IconButton));
    await tester.pumpAndSettle();
    expect(find.text(form.ecb_use_value), findsOneWidget);

    await tester.pumpWidget(buildIndicator(matchesRate: true));
    expect(tester.getRect(find.byType(Card)), differentBounds);
    expect(tester.getRect(find.text(frankfurterEcbCredit)), creditBounds);
    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('source card uses theme surfaces, outline and a bank emblem', (
    tester,
  ) async {
    await tester.pumpWidget(buildIndicator());
    final card = tester.widget<Card>(find.byType(Card));
    final theme = Theme.of(tester.element(find.byType(Card)));
    final shape = card.shape! as RoundedRectangleBorder;
    expect(card.color, theme.colorScheme.surfaceContainerHigh);
    expect(shape.side.color, theme.colorScheme.primary.withValues(alpha: 0.35));
    expect(find.byIcon(Icons.account_balance_rounded), findsOneWidget);
    expect(
      tester.getRect(find.byIcon(Icons.account_balance_rounded)).right,
      lessThan(tester.getRect(find.text(frankfurterEcbCredit)).left),
    );
  });

  for (final width in [280.0, 448.0, 720.0]) {
    for (final direction in TextDirection.values) {
      testWidgets('source states fit at $width, 2x text, $direction', (
        tester,
      ) async {
        for (final state in ['loading', 'filled', 'different']) {
          await tester.pumpWidget(
            buildIndicator(
              width: width,
              textScale: 2,
              direction: direction,
              loading: state == 'loading',
              matchesRate: state == 'filled',
            ),
          );
          expect(tester.takeException(), isNull);
          final bounds = tester.getRect(
            find.byType(ExchangeRateSourceIndicator),
          );
          final credit = tester.getRect(find.text(frankfurterEcbCredit));
          expect(credit.left, greaterThanOrEqualTo(bounds.left));
          expect(credit.right, lessThanOrEqualTo(bounds.right));
          if (state == 'different') {
            final action = tester.getRect(find.byType(IconButton));
            expect(action.overlaps(credit), isFalse);
            if (direction == TextDirection.ltr) {
              expect(action.left, greaterThanOrEqualTo(credit.right));
            } else {
              expect(action.right, lessThanOrEqualTo(credit.left));
            }
          } else {
            expect(find.byType(IconButton), findsNothing);
          }
        }
      });
    }
  }
}
