import 'dart:math';

import 'package:intl/intl.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';

/// One slice of a [DatePeriodState], as drawn by the "by periods" bar chart.
class DatePeriodSegment {
  const DatePeriodSegment({
    required this.start,
    required this.end,
    required this.shortTitle,
    required this.longTitle,
  });

  final DateTime start;
  final DateTime end;

  /// Axis label, e.g. `Jan` or `10-15`.
  final String shortTitle;

  /// Tooltip label, e.g. `January` or `Jan 10 - Jan 15`.
  final String longTitle;

  int get lengthInDays => max(1, end.difference(start).inDays);

  bool contains(DateTime date) => !date.isBefore(start) && date.isBefore(end);

  /// Days of the slice that have already gone by at [date], at least one.
  int elapsedDaysAt(DateTime date) =>
      date.isAfter(end) ? lengthInDays : max(1, date.difference(start).inDays);
}

extension DatePeriodSegmentation on DatePeriodState {
  /// Splits this period into the slices displayed by the "by periods" bar
  /// chart: days within a week, blocks of a few days within a month, months
  /// within a year and years for anything longer.
  ///
  /// [oldestDate] is the start used for periods without a lower bound, and is
  /// usually the date of the oldest account. Set [includeFutureSegments] to
  /// false to leave out the slices that have not started yet, which is what
  /// stats about what already happened need.
  List<DatePeriodSegment> splitIntoSegments({
    DateTime? oldestDate,
    bool includeFutureSegments = true,
  }) {
    final segments = _segmentsOf(this, startDate, endDate, oldestDate);

    if (includeFutureSegments) return segments;

    final now = DateTime.now();

    return segments.where((segment) => segment.start.isBefore(now)).toList();
  }
}

List<DatePeriodSegment> _segmentsOf(
  DatePeriodState range,
  DateTime? startDate,
  DateTime? endDate,
  DateTime? oldestDate,
) {
  final segments = <DatePeriodSegment>[];

  void add({
    required DateTime start,
    required DateTime end,
    required String shortTitle,
    required String longTitle,
  }) {
    segments.add(
      DatePeriodSegment(
        start: start,
        end: end,
        shortTitle: shortTitle,
        longTitle: longTitle,
      ),
    );
  }

  final effectiveStart =
      startDate ?? oldestDate ?? DateTime(DateTime.now().year - 3);
  final effectiveEnd = endDate ?? DateTime.now();

  if (range.datePeriod.periodType == PeriodType.cycle) {
    if (startDate == null || endDate == null) return segments;

    switch (range.datePeriod.periodicity) {
      case Periodicity.month:
        const dayRanges = [
          [1, 6],
          [6, 10],
          [10, 15],
          [15, 20],
          [20, 25],
          [25, null],
        ];

        for (final r in dayRanges) {
          final start = DateTime(startDate.year, startDate.month, r[0]!);
          final end = DateTime(
            start.year,
            r[1] == null ? start.month + 1 : start.month,
            r[1] ?? 1,
          );

          add(
            start: start,
            end: end,
            shortTitle: '${r[0]}-${r[1] ?? ''}',
            longTitle:
                '${DateFormat.MMMd().format(start)} - ${DateFormat.MMMd().format(end)}',
          );
        }

      case Periodicity.year:
        for (
          var i = startDate.month;
          i <= endDate.subtract(const Duration(milliseconds: 1)).month;
          i++
        ) {
          final start = DateTime(startDate.year, i);

          add(
            start: start,
            end: DateTime(start.year, i + 1),
            shortTitle: DateFormat.MMM().format(start),
            longTitle: DateFormat.MMMM().format(start),
          );
        }

      case Periodicity.week:
        for (var i = 0; i < DateTime.daysPerWeek; i++) {
          final start = startDate.add(Duration(days: i));

          add(
            start: start,
            end: start.add(const Duration(days: 1)),
            shortTitle: DateFormat.E().format(start),
            longTitle: DateFormat.yMMMEd().format(start),
          );
        }

      case Periodicity.day:
        break;
    }

    return segments;
  }

  if (range.datePeriod.periodType == PeriodType.dateRange ||
      range.datePeriod.periodType == PeriodType.lastDays) {
    final dayDiff = effectiveEnd.difference(effectiveStart).inDays;

    final Periodicity? periodicity = dayDiff <= 7
        ? Periodicity.week
        : dayDiff <= 31
        ? Periodicity.month
        : dayDiff <= 365 && effectiveStart.year == effectiveEnd.year
        ? Periodicity.year
        : null;

    return _segmentsOf(
      DatePeriodState(
        datePeriod: periodicity != null
            ? DatePeriod.withPeriods(periodicity)
            : const DatePeriod.allTime(),
      ),
      effectiveStart,
      effectiveEnd,
      oldestDate,
    );
  }

  for (
    var year = max(effectiveStart.year, DateTime.now().year - 5);
    year <= effectiveEnd.year;
    year++
  ) {
    final start = DateTime(year);

    add(
      start: start,
      end: DateTime(year + 1),
      shortTitle: DateFormat.y().format(start),
      longTitle: DateFormat.y().format(start),
    );
  }

  return segments;
}
