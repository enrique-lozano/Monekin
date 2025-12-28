import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/home/dashboard.page.dart';
import 'package:monekin/app/settings/widgets/edit_profile_modal.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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
      find.widgetWithText(EditProfileModal, t.settings.edit_profile),
      findsOneWidget,
    );
    await tester.tap(find.byIcon(Icons.close));

    await tester.pumpAndSettle();

    final displayedMonth = find.descendant(
      of: find.byType(ActionChip).first,
      matching: find.byType(Text),
    );

    await tester.tap(displayedMonth);
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(DatePeriodModal, t.general.time.ranges.display),
      findsOneWidget,
    );
    await tester.tap(find.byIcon(Icons.close));

    await tester.pumpAndSettle();

    await tester.tap(find.text(t.account.form.create));
    await tester.pumpAndSettle();
    expect(find.byType(AccountFormPage), findsOneWidget);
    expect(find.text(t.account.form.create), findsAny);
    await tester.pageBack();

    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(FloatingActionButton, t.transaction.create),
    );
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(Dialog, t.home.should_create_account_header),
      findsOneWidget,
    );
    await tester.tap(find.text(t.ui_actions.continue_text));
    await tester.pumpAndSettle();
    expect(find.byType(AccountFormPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    final seeMoreText = find.text(t.ui_actions.see_more);
    final financialHealthFinder = find.descendant(
      of: find.widgetWithText(CardWithHeader, t.financial_health.display),
      matching: seeMoreText,
    );

    final byCategoriesFinder = find.descendant(
      of: find.widgetWithText(CardWithHeader, t.stats.by_categories),
      matching: seeMoreText,
    );

    final balanceTrendFinder = find.descendant(
      of: find.widgetWithText(CardWithHeader, t.stats.balance_evolution),
      matching: seeMoreText,
    );

    final byPeriodsFinder = find.descendant(
      of: find.widgetWithText(CardWithHeader, t.stats.by_periods),
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

      await tester.fling(cardFinders[i], const Offset(0, -500), 500);
      await tester.pumpAndSettle();
    }

    await tester.tap(find.text(t.transaction.display(n: 2)));
    await tester.pumpAndSettle();
    expect(find.byType(TransactionsPage), findsOneWidget);
    expect(find.text(t.transaction.display(n: 2)), findsAny);

    await openMorePage(tester);

    await tester.tap(find.text(t.home.title));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardPage), findsOneWidget);
  });
}
