import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/models/mixins/target_pace.dart';

class _FakeTarget implements FinancialTarget {
  _FakeTarget(this.range);

  final DateTimeRange range;

  @override
  double get targetAmount => 500;

  @override
  DatePeriodState get periodState => DatePeriodState(
    datePeriod: DatePeriod.customRange(range.start, range.end),
  );

  @override
  bool get isActive {
    final now = DateTime.now();
    return !now.isBefore(range.start) && now.isBefore(range.end);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('computes the pace figures of an active target', () {
    final now = DateTime.now();
    // 31-day period with today as its 9th day
    final start = DateTime(now.year, now.month, now.day - 8);
    final target = _FakeTarget(
      DateTimeRange(
        start: start,
        end: DateTime(start.year, start.month, start.day + 31),
      ),
    );

    final pace = TargetPace.of(target, currentValue: 100)!;

    expect(pace.remainingDays, 22);
    expect(pace.dailyAmountLeft, closeTo(18.18, 0.01));
    expect(pace.expectedValue - pace.currentValue, closeTo(45.16, 0.01));
    expect(pace.projectedValue, closeTo(344.44, 0.01));
  });

  test('returns null for targets that are not active', () {
    final now = DateTime.now();
    final target = _FakeTarget(
      DateTimeRange(
        start: DateTime(now.year - 1, 1, 1),
        end: DateTime(now.year - 1, 2, 1),
      ),
    );

    expect(TargetPace.of(target, currentValue: 100), isNull);
  });
}
