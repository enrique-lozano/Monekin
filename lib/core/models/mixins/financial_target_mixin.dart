import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/budget/target_progress_status.enum.dart';
import 'package:monekin/core/models/budget/target_timeline_status.enum.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/mixins/financial_target_direction.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/utils/date_utils.dart';

/// Interface for financial targets that can be displayed in the UI
abstract interface class FinancialTarget {
  String get id;
  String get name;
  TransactionFilterSet get trFilters;
  double get targetAmount;
  FinancialTargetDirection get targetDirection;
  DatePeriodState get periodState;

  /// Whether the target is a limit (e.g. Budget) or a goal to reach (e.g. Savings Goal)
  ///
  /// - True: Values above the target are BAD.
  /// - False: Values above the target are GOOD.
  bool get isTargetLimit;

  TargetTimelineStatus get timelineStatus;
  double? get todayPercent;
  Stream<TargetProgressStatus?> get progressStatus;
  Stream<double> get percentageAlreadyUsed;
  Stream<double> get currentValue;

  bool get isActive;
  bool get isPast;
  bool get isFuture;
}

/// Mixin for financial targets like Budgets and Goals
///
/// Goals can be of two types:
///  - Income/Savings → balance ≥ target
///  - Expense        → -balance ≥ target
///
/// Budgets are always of type Expense → -balance <= target
mixin FinancialTargetMixin implements FinancialTarget {
  /// Get the amount of money relative to this target for a given date
  Stream<double> getValueOnDate(DateTime? date) {
    date ??= DateTime.now();

    return TransactionService.instance
        .getTransactionsValueBalance(filters: trFilters.copyWith(maxDate: date))
        .map((res) {
          if (targetDirection.isInverted) {
            res = res * -1;
          }

          if (res <= 0) {
            return 0.0;
          }

          return res;
        });
  }

  /// Get the amount of money relative to this target for the current date-time
  @override
  Stream<double> get currentValue {
    return getValueOnDate(null);
  }

  /// Get the percentage of the target already filled. The return value can be greater than 1 (>100%)
  @override
  Stream<double> get percentageAlreadyUsed {
    if (targetAmount == 0) return Stream.value(0.0);
    return currentValue.map((event) => event / targetAmount);
  }

  @override
  double? get todayPercent {
    final range = periodState.toDateTimeRange;
    if (range == null) return null;

    return getPercentBetweenDates(range, DateTime.now());
  }

  /// Get the current time status of the target based on the current date.
  @override
  TargetTimelineStatus get timelineStatus {
    final range = periodState.toDateTimeRange;
    if (range == null) return TargetTimelineStatus.active;

    final now = DateTime.now();
    if (now.compareTo(range.end) > 0) {
      return TargetTimelineStatus.past;
    }
    if (now.compareTo(range.start) < 0) {
      return TargetTimelineStatus.future;
    }
    return TargetTimelineStatus.active;
  }

  /// Whether or not the target is relative to the current datetime.
  /// That is, if the target has not already passed and has already started
  @override
  bool get isActive => timelineStatus == TargetTimelineStatus.active;

  /// True if the period range of the target has passed
  @override
  bool get isPast => timelineStatus == TargetTimelineStatus.past;

  /// True if the target has not started yet
  @override
  bool get isFuture => timelineStatus == TargetTimelineStatus.future;

  /// Get the process status of the budget based on the current date and value
  @override
  Stream<TargetProgressStatus?> get progressStatus {
    return percentageAlreadyUsed.map((percentage) {
      final tp = todayPercent != null ? todayPercent! / 100 : null;

      return TargetProgressStatus.fromPercentages(
        percentage,
        tp,
        timelineStatus,
        isTargetLimit: isTargetLimit,
      );
    });
  }
}
