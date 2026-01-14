import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/budget/target_timeline_status.enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

///  The progress status of a target (budget or goal) based on its current progress.
enum TargetProgressStatus {
  /// Target is on track and looking good so far (for budgets: under budget; for goals: on track)
  onTrack,

  /// Target is off track and showing signs of concern (for budgets: over budget; for goals: behind schedule)
  warning,

  /// Target is a limit and has been exceeded (Overspending) or a goal and has been reached (Goal Reached)
  reached,

  /// Target is active but there is not enough data to determine if it is on track or not (e.g. no end date)
  indeterminate,

  /// Target has finished and was successfully met (for budgets: within budget; for goals: met or exceeded)
  success,

  /// Target has finished and was not met (for budgets: over budget; for goals: not met)
  fail;

  static TargetProgressStatus? fromPercentages(
    double percentage,
    double? todayPercent,
    TargetTimelineStatus timelineStatus, {
    required bool isTargetLimit,
  }) {
    switch (timelineStatus) {
      case TargetTimelineStatus.active:
        if (percentage >= 1) {
          // If 100% reached:
          // Limit (Budget) -> BAD (reached ie: limitExceeded)
          // Target (Goal) -> GOOD (reached ie: goalReached)
          return TargetProgressStatus.reached;
        } else if (todayPercent == null) {
          return TargetProgressStatus.indeterminate;
        } else if (percentage > todayPercent) {
          // Progress is faster than time:
          // Limit (Budget) -> Spending too fast -> BAD (warning)
          // Target (Goal) -> Saving fast -> GOOD (onTrack)
          return isTargetLimit
              ? TargetProgressStatus.warning
              : TargetProgressStatus.onTrack;
        } else {
          // Progress is slower than time:
          // Limit (Budget) -> Spending slow -> GOOD (onTrack)
          // Target (Goal) -> Saving slow -> BAD (warning)
          return isTargetLimit
              ? TargetProgressStatus.onTrack
              : TargetProgressStatus.warning;
        }
      case TargetTimelineStatus.past:
        if (percentage <= 1) {
          // Limit (Budget) (<100%) -> Success
          // Target (Goal) (<100%) -> Fail
          return isTargetLimit
              ? TargetProgressStatus.success
              : TargetProgressStatus.fail;
        } else {
          // Limit (Budget) (>100%) -> Fail
          // Target (Goal) (>100%) -> Success
          return isTargetLimit
              ? TargetProgressStatus.fail
              : TargetProgressStatus.success;
        }
      case TargetTimelineStatus.future:
        return null;
    }
  }

  IconData icon(bool isTargetLimit) {
    switch (this) {
      case TargetProgressStatus.onTrack:
        return Icons.thumb_up_alt_rounded;
      case TargetProgressStatus.indeterminate:
        return Icons.query_stats_rounded;
      case TargetProgressStatus.warning:
        return Icons.warning_rounded;
      case TargetProgressStatus.success:
        return Icons.done_all_rounded;
      case TargetProgressStatus.reached:
        return isTargetLimit ? Icons.close_rounded : Icons.done_all_rounded;
      case TargetProgressStatus.fail:
        return Icons.close_rounded;
    }
  }

  Color color(bool isTargetLimit) {
    switch (this) {
      case TargetProgressStatus.onTrack:
      case TargetProgressStatus.success:
        return Colors.green;
      case TargetProgressStatus.indeterminate:
        return Colors.blueGrey;
      case TargetProgressStatus.reached:
        return isTargetLimit ? Colors.red : Colors.green;
      case TargetProgressStatus.warning:
        return Colors.orange;
      case TargetProgressStatus.fail:
        return Colors.red;
    }
  }

  String displayName(BuildContext context, {required bool isTargetLimit}) {
    final t = Translations.of(context);

    if (isTargetLimit) {
      switch (this) {
        case TargetProgressStatus.onTrack:
          return t.budgets.progress.labels.active_on_track;
        case TargetProgressStatus.indeterminate:
          return t.budgets.progress.labels.active_indeterminate;
        case TargetProgressStatus.warning:
          return t.budgets.progress.labels.active_overspending;
        case TargetProgressStatus.reached:
          return t.budgets.progress.labels.fail;
        case TargetProgressStatus.success:
          return t.budgets.progress.labels.success;
        case TargetProgressStatus.fail:
          return t.budgets.progress.labels.fail;
      }
    } else {
      switch (this) {
        case TargetProgressStatus.onTrack:
          return t.goals.progress.labels.active_on_track;
        case TargetProgressStatus.indeterminate:
          return t.goals.progress.labels.active_indeterminate;
        case TargetProgressStatus.warning:
          return t.goals.progress.labels.active_behind_schedule;
        case TargetProgressStatus.reached:
          return t.goals.progress.labels.success;
        case TargetProgressStatus.success:
          return t.goals.progress.labels.success;
        case TargetProgressStatus.fail:
          return t.goals.progress.labels.fail;
      }
    }
  }

  String description({
    required BuildContext context,
    required bool isTargetLimit,
    CurrencyInDB? currency,
    double? dailyAmountLeft,
    required double? amountLeft,
    int? daysLeft,
    double? failedByAmount,
  }) {
    final t = Translations.of(context);

    final formatter = NumberFormat.currency(
      symbol: currency?.symbol ?? '',
      decimalDigits: 0,
    );

    // Helper to format
    String amount(double? val) => formatter.format(val ?? 0);
    int days = daysLeft ?? 0;

    switch (this) {
      case TargetProgressStatus.onTrack:
        if (isTargetLimit) {
          return t.budgets.progress.description.active_on_track(
            dailyAmount: amount(dailyAmountLeft),
            remainingDays: days,
          );
        } else {
          return t.goals.progress.description.active_on_track(
            dailyAmount: amount(dailyAmountLeft),
            remainingDays: days,
          );
        }
      case TargetProgressStatus.indeterminate:
        if (isTargetLimit) {
          return t.budgets.progress.description.active_indeterminate(
            amount: amount(amountLeft),
          );
        } else {
          return t.goals.progress.description.active_indeterminate(
            amount: amount(amountLeft),
          );
        }
      case TargetProgressStatus.warning:
        if (isTargetLimit) {
          return t.budgets.progress.description.active_overspending(
            dailyAmount: amount(dailyAmountLeft),
            remainingDays: days,
          );
        } else {
          return t.goals.progress.description.active_behind_schedule(
            dailyAmount: amount(dailyAmountLeft),
            remainingDays: days,
          );
        }
      case TargetProgressStatus.success:
        if (isTargetLimit) {
          return t.budgets.progress.description.success;
        } else {
          return t.goals.progress.description.success;
        }
      case TargetProgressStatus.reached:
        if (isTargetLimit) {
          return t.budgets.progress.description.fail(
            amount: amount(failedByAmount),
          );
        } else {
          return t.goals.progress.description.success;
        }
      case TargetProgressStatus.fail:
        if (isTargetLimit) {
          return t.budgets.progress.description.fail(
            amount: amount(failedByAmount),
          );
        } else {
          return t.goals.progress.description.fail(
            amount: amount(failedByAmount),
          );
        }
    }
  }
}
