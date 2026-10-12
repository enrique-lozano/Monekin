import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/models/mixins/target_pace.dart';

class _FakeTarget implements FinancialTarget {
  _FakeTarget(this.range, {this.initialValue = 0});

  final DateTimeRange range;

  @override
  final double initialValue;

  @override
  double get targetAmount => 500;

  @override
  DatePeriodState get periodState => DatePeriodState(
    datePeriod: DatePeriod.customRange(range.start, range.end),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('computes the pace figures of an active target', () {
    final target = _FakeTarget(
      DateTimeRange(start: DateTime(2026, 10, 1), end: DateTime(2026, 11, 1)),
    );

    final pace = TargetPace.of(
      target,
      currentValue: 100,
      now: DateTime(2026, 10, 9, 15),
    )!;

    expect(pace.remainingDays, 22);
    expect(pace.dailyAmountLeft, closeTo(18.18, 0.01));
    expect(pace.expectedValue - pace.currentValue, closeTo(45.16, 0.01));
    expect(pace.projectedValue, closeTo(344.44, 0.01));
  });

  test('returns null outside the target period', () {
    final target = _FakeTarget(
      DateTimeRange(start: DateTime(2026, 10, 1), end: DateTime(2026, 11, 1)),
    );

    expect(
      TargetPace.of(target, currentValue: 100, now: DateTime(2026, 11, 1)),
      isNull,
    );
    expect(
      TargetPace.of(target, currentValue: 100, now: DateTime(2026, 9, 30)),
      isNull,
    );
  });

  test('applies the pace only to the progress made over the initial value', () {
    final target = _FakeTarget(
      DateTimeRange(start: DateTime(2026, 10, 1), end: DateTime(2026, 11, 1)),
      initialValue: 190,
    );

    final pace = TargetPace.of(
      target,
      currentValue: 290,
      now: DateTime(2026, 10, 9, 15),
    )!;

    // 9 of 31 days: 190 + (500 - 190) * 9 / 31, and 190 + 100 * 31 / 9
    expect(pace.expectedValue, closeTo(280, 0.01));
    expect(pace.projectedValue, closeTo(534.44, 0.01));
    expect(pace.dailyAmountLeft, closeTo(9.55, 0.01));
  });

  test('does not project negative values', () {
    final target = _FakeTarget(
      DateTimeRange(start: DateTime(2026, 10, 1), end: DateTime(2026, 11, 1)),
      initialValue: 400,
    );

    final pace = TargetPace.of(
      target,
      currentValue: 0,
      now: DateTime(2026, 10, 9, 15),
    )!;

    expect(pace.projectedValue, 0);
  });
}
