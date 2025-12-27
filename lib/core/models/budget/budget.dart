import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/budget/target_progress_status.enum.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../transaction/transaction_type.enum.dart';
import 'target_timeline_status.enum.dart';

class Budget extends BudgetInDB {
  List<String>? categories;
  List<String>? accounts;

  Budget({
    required super.id,
    required super.name,
    required super.limitAmount,
    required List<String>? categories,
    required List<String>? accounts,
    super.intervalPeriod,
    super.startDate,
    super.endDate,
  }) {
    this.categories = categories != null && categories.isEmpty
        ? null
        : categories;

    this.accounts = accounts != null && accounts.isEmpty ? null : accounts;
  }

  DateTimeRange get currentDateRange {
    final toReturn = periodState.getDates();

    // Since the budgets should define a periodicity or a mandatory custom range, the start and
    //  the end date will always be not null

    return DateTimeRange(start: toReturn.$1!, end: toReturn.$2!);
  }

  DatePeriodState get periodState {
    return DatePeriodState(
      datePeriod: intervalPeriod != null
          ? DatePeriod.withPeriods(intervalPeriod!)
          : DatePeriod.customRange(startDate, endDate),
    );
  }

  int get daysToTheEnd {
    return currentDateRange.end.difference(DateTime.now()).inDays;
  }

  int get daysToTheStart {
    return currentDateRange.start.difference(DateTime.now()).inDays;
  }

  double get todayPercent =>
      getPercentBetweenDates(currentDateRange, DateTime.now());

  /// Get the current time status of the budget based on the current date.
  TargetTimelineStatus get timelineStatus {
    final now = DateTime.now();
    if (now.compareTo(currentDateRange.end) > 0) {
      return TargetTimelineStatus.past;
    }
    if (now.compareTo(currentDateRange.start) < 0) {
      return TargetTimelineStatus.future;
    }
    return TargetTimelineStatus.active;
  }

  String timelineStatusLabel(BuildContext context) {
    final t = Translations.of(context).budgets.target_timeline_statuses;
    switch (timelineStatus) {
      case TargetTimelineStatus.active:
        return t.active;
      case TargetTimelineStatus.past:
        return t.past;
      case TargetTimelineStatus.future:
        return t.future;
    }
  }

  /// Whether or not the budget is relative to the current datetime.
  /// That is, if the budget has not already passed and has already started
  bool get isActiveBudget => timelineStatus == TargetTimelineStatus.active;

  /// True if the period range of the budget has passed
  bool get isPastBudget => timelineStatus == TargetTimelineStatus.past;

  /// True if the budget has not started yet
  bool get isFutureBudget => timelineStatus == TargetTimelineStatus.future;

  TransactionFilters get trFilters => TransactionFilters(
    status: TransactionStatus.notIn({
      TransactionStatus.pending,
      TransactionStatus.voided,
    }),
    transactionTypes: [TransactionType.E],
    minDate: currentDateRange.start,
    maxDate: currentDateRange.end,
    categories: categories,
    accountsIDs: accounts,
  );

  /// Get the amount of money relative to this budget for a given date
  Stream<double> getValueOnDate(DateTime? date) {
    date ??= DateTime.now();

    return TransactionService.instance
        .getTransactionsValueBalance(
          filters: TransactionFilters(
            transactionTypes: [TransactionType.E],
            accountsIDs: accounts,
            categories: categories,
            minDate: currentDateRange.start,
            maxDate: date,
          ),
        )
        .map((res) {
          res = res * -1;

          if (res <= 0) {
            return 0.0;
          }

          return res;
        });
  }

  /// Get the amount of money relative to this budget for the current date-time
  Stream<double> get currentValue {
    return getValueOnDate(null);
  }

  /// Get the percentage of the budget already filled. The return value can be greather than 1 (>100%)
  Stream<double> get percentageAlreadyUsed {
    return currentValue.map((event) => event / limitAmount);
  }

  /// Get the process status of the budget based on the current date and value
  Stream<TargetProgressStatus?> get progressStatus {
    return percentageAlreadyUsed.map((percentage) {
      return TargetProgressStatus.fromPercentages(
        percentage,
        todayPercent / 100,
        timelineStatus,
      );
    });
  }
}
