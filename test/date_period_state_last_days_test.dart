import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';

void main() {
  group('DatePeriodState lastDays', () {
    test('end bound is the start of tomorrow, so it includes the rest of today',
        () {
      const period = DatePeriodState(datePeriod: DatePeriod.lastDays(30));

      final now = DateTime.now();
      final startOfTomorrow = DateTime(now.year, now.month, now.day + 1);

      expect(period.endDate, startOfTomorrow);
      expect(
        period.startDate,
        startOfTomorrow.subtract(const Duration(days: 30)),
      );

      // A transaction created a few seconds after the period was computed
      // must still fall inside the range.
      final later = now.add(const Duration(seconds: 30));
      expect(later.isBefore(period.endDate!), isTrue);
    });

    test('previous period ends exactly where the current one starts', () {
      const period = DatePeriodState(datePeriod: DatePeriod.lastDays(7));

      final (prevStart, prevEnd) = period.getPrevDates();

      expect(prevEnd, period.startDate);
      expect(prevStart, period.startDate!.subtract(const Duration(days: 7)));
    });
  });
}
