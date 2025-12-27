import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/budget/target_timeline_status.enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

///  The progress status of a target (budget or goal) based on its current progress.
enum TargetProgressStatus {
  good,
  bad,
  alreadyExceeded,
  success,
  fail;

  static TargetProgressStatus? fromPercentages(
    double percentage,
    double todayPercent,
    TargetTimelineStatus timelineStatus,
  ) {
    switch (timelineStatus) {
      case TargetTimelineStatus.active:
        if (percentage > 1) {
          return TargetProgressStatus.alreadyExceeded;
        } else if (percentage > todayPercent) {
          return TargetProgressStatus.bad;
        } else {
          return TargetProgressStatus.good;
        }
      case TargetTimelineStatus.past:
        if (percentage <= 1) {
          return TargetProgressStatus.success;
        } else {
          return TargetProgressStatus.fail;
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
      case TargetProgressStatus.fail || TargetProgressStatus.alreadyExceeded:
        return Icons.close_rounded;
    }
  }

  Color get color {
    switch (this) {
      case TargetProgressStatus.good || TargetProgressStatus.success:
        return Colors.green;
      case TargetProgressStatus.bad:
        return Colors.orange;
      case TargetProgressStatus.fail || TargetProgressStatus.alreadyExceeded:
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
      case TargetProgressStatus.fail || TargetProgressStatus.alreadyExceeded:
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
      case TargetProgressStatus.alreadyExceeded:
        return t.budgets.progress.description.active_exceeded(
          amount: formatter.format(failedByAmount),
        );
    }
  }
}
