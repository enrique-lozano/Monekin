import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';

void main() {
  group('DatePeriodState weekly cycle', () {
    const period = DatePeriodState(
      datePeriod: DatePeriod.withPeriods(Periodicity.week),
    );

    test('runs from Monday at midnight to the next Monday at midnight', () {
      final now = DateTime.now();
      final (start, end) = period.getDates();

      expect(start, DateTime(now.year, now.month, now.day - now.weekday + 1));
      expect(end, DateTime(start!.year, start.month, start.day + 7));
      expect(start.weekday, DateTime.monday);
      expect(now.isBefore(start), isFalse);
      expect(now.isBefore(end!), isTrue);
    });

    test('previous week ends exactly where the current one starts', () {
      final (prevStart, prevEnd) = period.getPrevDates();
      final (start, _) = period.getDates();

      expect(prevEnd, start);
      expect(prevStart, DateTime(start!.year, start.month, start.day - 7));
    });
  });
}
