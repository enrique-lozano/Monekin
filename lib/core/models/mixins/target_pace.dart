import 'dart:math';

import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';

/// Linear pace figures of an active target with a closed date range. Days are
/// counted as whole calendar days, with today counted as elapsed.
class TargetPace {
  const TargetPace._({
    required this.totalDays,
    required this.elapsedDays,
    required this.currentValue,
    required this.targetAmount,
  });

  final int totalDays;
  final int elapsedDays;
  final double currentValue;
  final double targetAmount;

  /// Returns `null` if [now] is outside the target period or it has no end
  /// date.
  static TargetPace? of(
    FinancialTarget target, {
    required double currentValue,
    DateTime? now,
  }) {
    final range = target.periodState.toDateTimeRange;
    now ??= DateTime.now();
    if (range == null ||
        now.isBefore(range.start) ||
        !now.isBefore(range.end)) {
      return null;
    }

    final totalDays = range.end.dayDifference(range.start);
    if (totalDays <= 0) return null;

    return TargetPace._(
      totalDays: totalDays,
      elapsedDays: (now.dayDifference(range.start) + 1).clamp(1, totalDays),
      currentValue: currentValue,
      targetAmount: target.targetAmount,
    );
  }

  int get remainingDays => totalDays - elapsedDays;

  /// Value expected by today if the target were spread evenly.
  double get expectedValue => targetAmount * elapsedDays / totalDays;

  /// Value at the end of the period if the current pace continues.
  double get projectedValue => currentValue * totalDays / elapsedDays;

  double get amountLeft => targetAmount - currentValue;

  /// Amount left to reach the target, per remaining day.
  double get dailyAmountLeft => max(amountLeft, 0) / max(remainingDays, 1);
}
