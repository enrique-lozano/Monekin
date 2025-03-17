import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/home/dashboard.page.dart';
import 'package:monekin/app/settings/edit_profile_modal.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';

import '../helpers.dart';

void main() {
  setUpAll(() async {
    await setupMonekin();
  });

  testWidgets('Navigation', (tester) async {
    await startMonekin(tester);

    await tester.tap(find.text('User'));
    await tester.pumpAndSettle();
    expect(
        find.widgetWithText(EditProfileModal, 'Edit profile'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    
    await tester.pumpAndSettle();

    final displayedMonth = find.descendant(
      of: find.byType(ActionChip).first, 
      matching: find.byType(Text));

    await tester.tap(displayedMonth);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(DatePeriodModal, 'Time range'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));

    await tester.pumpAndSettle();

    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();
    expect(find.byType(AccountFormPage), findsOneWidget);
    expect(find.text('Create account'), findsAny);
    await tester.pageBack();
    
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FloatingActionButton, 'New transaction'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(Dialog, 'Oops!'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.byType(AccountFormPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();


    final seeMoreText = find.text('See more');
    final financialHealthFinder = find.descendant(
      of: find.widgetWithText(CardWithHeader, 'Financial health'),
      matching: seeMoreText,
    );

    final byCategoriesFinder = find.descendant(
      of: find.widgetWithText(CardWithHeader, 'By categories'),
      matching: seeMoreText,
    );

    final balanceTrendFinder = find.descendant(
      of: find.widgetWithText(CardWithHeader, 'Balance trend'),
      matching: seeMoreText,
    );

    final byPeriodsFinder = find.descendant(
      of: find.widgetWithText(CardWithHeader, 'By periods'),
      matching: seeMoreText,
    );

    final cardFinders = [
      financialHealthFinder,
      byCategoriesFinder,
      balanceTrendFinder,
      byPeriodsFinder,
    ];

    for (int i = 0; i < cardFinders.length; i++) {
      await tester.tap(cardFinders[i]);
      await tester.pumpAndSettle();
      expect(find.byType(StatsPage), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.fling(cardFinders[i], Offset(0, -500), 500);
      await tester.pumpAndSettle();
    }

    await tester.tap(find.text('Transactions'));
    await tester.pumpAndSettle();
    expect(find.byType(TransactionsPage), findsOneWidget);
    expect(find.text('Transactions'), findsAny);

    await openMorePage(tester);

    await tester.tap(find.text('Dashboard'));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardPage), findsOneWidget);

  });
}
