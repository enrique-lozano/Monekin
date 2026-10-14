import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/services/exchange-rate/today_rate_plan.dart';

void main() {
  group('planTodayRate', () {
    test('inserts when that calendar day has no rate', () {
      final decision = planTodayRate(
        quoteDate: DateTime(2026, 10, 13, 16, 30),
        quoteRate: 0.89381,
        existingDates: [DateTime(2026, 10, 12, 23, 59)],
      );

      expect(decision.plan, TodayRatePlan.insert);
      expect(decision.date, DateTime(2026, 10, 13));
      expect(decision.rate, 0.89381);
    });

    test('keeps a user rate on the same calendar day', () {
      final decision = planTodayRate(
        quoteDate: DateTime(2026, 10, 13),
        quoteRate: 0.89,
        existingDates: [DateTime(2026, 10, 13, 8)],
      );

      expect(decision.plan, TodayRatePlan.keepExisting);
      expect(decision.date, DateTime(2026, 10, 13));
    });

    test('does not treat a different day as the same rate', () {
      final decision = planTodayRate(
        quoteDate: DateTime(2026, 10, 13),
        quoteRate: 1.1,
        existingDates: [DateTime(2026, 10, 14)],
      );

      expect(decision.plan, TodayRatePlan.insert);
    });
  });
}
