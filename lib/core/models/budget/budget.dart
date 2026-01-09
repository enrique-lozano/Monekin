import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart'
    show BudgetInDB, TransactionFilterInDB, TransactionFilterSetInDB;
import 'package:monekin/core/models/budget/target_progress_status.enum.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/mixins/financial_target_direction.enum.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../transaction/transaction_type.enum.dart';
import 'target_timeline_status.enum.dart';

class Budget extends BudgetInDB with FinancialTargetMixin {
  final TransactionFilterSetInDB _dbTrFilters;

  @override
  double get targetAmount => limitAmount;

  @override
  FinancialTargetDirection get targetDirection =>
      FinancialTargetDirection.toExpense;

  Budget({
    required super.id,
    required super.name,
    required super.limitAmount,
    required TransactionFilterSetInDB trFilters,
    super.intervalPeriod,
    super.startDate,
    super.endDate,
  }) : _dbTrFilters = trFilters,
       super(filterID: trFilters.id);

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

  /// Get the localized label of the timeline status. This is not the
  /// same as the enum display name. For example:
  ///
  /// - Enum display name: "Active"
  /// - Timeline status label: "Active budget"
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

  @override
  TransactionFilterSet get trFilters =>
      TransactionFilterSet.fromDB(_dbTrFilters).copyWith(
        status: TransactionStatus.getStatusThatCountsForStats(
          _dbTrFilters.status,
        ),
        transactionTypes: [TransactionType.expense],
        minDate: currentDateRange.start,
        maxDate: currentDateRange.end,
      );

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
