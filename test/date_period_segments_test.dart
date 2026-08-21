import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_segments.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';

void main() {
  group('DatePeriodState.splitIntoSegments', () {
    test('splits a month into the 6 blocks of the bar chart', () {
      const period = DatePeriodState();

      final segments = period.splitIntoSegments();
      final start = period.startDate!;

      expect(segments.length, 6);
      expect(segments.first.start, start);
      expect(segments.last.end, period.endDate);
      expect(segments.every((segment) => segment.lengthInDays >= 4), isTrue);

      for (var i = 1; i < segments.length; i++) {
        expect(segments[i].start, segments[i - 1].end);
      }
    });

    test('splits a year into its months and a week into its days', () {
      final year = DatePeriodState(
        datePeriod: DatePeriod.withPeriods(Periodicity.year),
      ).splitIntoSegments();
      final week = DatePeriodState(
        datePeriod: DatePeriod.withPeriods(Periodicity.week),
      ).splitIntoSegments();

      expect(year.length, 12);
      expect(week.length, 7);
      expect(week.every((segment) => segment.lengthInDays == 1), isTrue);
    });

    test('a custom range borrows the granularity of its length', () {
      List<DatePeriodSegment> ofDays(int days) => DatePeriodState(
        datePeriod: DatePeriod(
          periodType: PeriodType.dateRange,
          customDateRange: (
            DateTime(2024, 3, 4),
            DateTime(2024, 3, 4).add(Duration(days: days)),
          ),
        ),
      ).splitIntoSegments();

      expect(ofDays(5).length, 7);
      expect(ofDays(20).length, 6);
      expect(ofDays(90).length, 4);
    });

    test('knows how much of each slice has gone by', () {
      final segments = const DatePeriodState().splitIntoSegments();
      final first = segments.first;
      final day = first.start.add(const Duration(days: 1));

      expect(first.contains(day), isTrue);
      expect(segments.last.contains(day), isFalse);
      expect(first.elapsedDaysAt(day), 1);
      expect(first.elapsedDaysAt(first.start), 1);
      expect(first.elapsedDaysAt(DateTime(2100)), first.lengthInDays);
    });

    test('can leave out the slices that have not started yet', () {
      final wholeMonth = const DatePeriodState().splitIntoSegments();
      final soFar = const DatePeriodState().splitIntoSegments(
        includeFutureSegments: false,
      );

      expect(soFar.length, lessThanOrEqualTo(wholeMonth.length));
      expect(
        soFar.every((segment) => segment.start.isBefore(DateTime.now())),
        isTrue,
      );
      expect(soFar, isNotEmpty);
    });
  });
}
