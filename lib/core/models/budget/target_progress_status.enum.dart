import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/budget/target_timeline_status.enum.dart';
import 'package:monekin/core/models/mixins/financial_target_direction.enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

///  The progress status of a target (budget or goal) based on its current progress.
enum TargetProgressStatus {
  /// Target is on track (for expenses: under budget; for income: on track)
  good,

  /// Target is off track (for expenses: over budget; for income: behind schedule)
  bad,

  /// Target has already been fulfilled before the end date, but the timeline is still
  /// active so this situation can be reversed.
  alreadyFulfilled,

  /// Target has finished and was successfully met (for expenses: within budget; for income: met or exceeded)
  success,

  /// Target has finished and was not met (for expenses: over budget; for income: not met)
  fail;

  static TargetProgressStatus? fromPercentages(
    double percentage,
    double todayPercent,
    TargetTimelineStatus timelineStatus, {
    FinancialTargetDirection direction = FinancialTargetDirection.toExpense,
  }) {
    final isExpense = direction == FinancialTargetDirection.toExpense;

    switch (timelineStatus) {
      case TargetTimelineStatus.active:
        if (percentage >= 1) {
          return TargetProgressStatus.alreadyFulfilled;
        } else if (percentage > todayPercent) {
          return isExpense
              ? TargetProgressStatus.bad
              : TargetProgressStatus.good;
        } else {
          return isExpense
              ? TargetProgressStatus.good
              : TargetProgressStatus.bad;
        }
      case TargetTimelineStatus.past:
        if (percentage <= 1) {
          return isExpense
              ? TargetProgressStatus.success
              : TargetProgressStatus.fail;
        } else {
          return isExpense
              ? TargetProgressStatus.fail
              : TargetProgressStatus.success;
        }
      case TargetTimelineStatus.future:
        return null;
    }
  }

  IconData get iconData {
    switch (this) {
      case TargetProgressStatus.good:
        return Icons.thumb_up_alt_rounded;
      case TargetProgressStatus.bad:
        return Icons.front_hand_rounded;
      case TargetProgressStatus.success:
        return Icons.done_all_rounded;
      case TargetProgressStatus.fail || TargetProgressStatus.alreadyFulfilled:
        return Icons.close_rounded;
    }
  }

  Color get color {
    switch (this) {
      case TargetProgressStatus.good || TargetProgressStatus.success:
        return Colors.green;
      case TargetProgressStatus.bad:
        return Colors.orange;
      case TargetProgressStatus.fail || TargetProgressStatus.alreadyFulfilled:
        return Colors.red;
    }
  }

  String displayName(BuildContext context) {
    final t = Translations.of(context);

    switch (this) {
      case TargetProgressStatus.good:
        return t.budgets.progress.labels.active_on_track;
      case TargetProgressStatus.bad:
        return t.budgets.progress.labels.active_overspending;
      case TargetProgressStatus.success:
        return t.budgets.progress.labels.success;
      case TargetProgressStatus.fail || TargetProgressStatus.alreadyFulfilled:
        return t.budgets.progress.labels.fail;
    }
  }

  String description(
    BuildContext context, {
    CurrencyInDB? currency,
    double? dailyAmountLeft,
    int? daysLeft,
    double? failedByAmount,
  }) {
    final t = Translations.of(context);

    final formatter = NumberFormat.currency(
      symbol: currency?.symbol ?? '',
      decimalDigits: 0,
    );

    switch (this) {
      case TargetProgressStatus.good:
        return t.budgets.progress.description.active_on_track(
          dailyAmount: formatter.format(dailyAmountLeft),
          remainingDays: daysLeft!,
        );
      case TargetProgressStatus.bad:
        return t.budgets.progress.description.active_overspending(
          dailyAmount: formatter.format(dailyAmountLeft),
          remainingDays: daysLeft!,
        );
      case TargetProgressStatus.success:
        return t.budgets.progress.description.success;
      case TargetProgressStatus.fail:
        return t.budgets.progress.description.fail(
          amount: formatter.format(failedByAmount),
        );
      case TargetProgressStatus.alreadyFulfilled:
        return t.budgets.progress.description.active_exceeded(
          amount: formatter.format(failedByAmount),
        );
    }
  }
}
