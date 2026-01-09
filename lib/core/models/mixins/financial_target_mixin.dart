import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/budget/target_progress_status.enum.dart';
import 'package:monekin/core/models/budget/target_timeline_status.enum.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/mixins/financial_target_direction.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';

/// Mixin for financial targets like Budgets and Goals
///
/// Goals can be of two types:
///  - Income/Savings → balance ≥ target
///  - Expense        → -balance ≥ target
///
/// Budgets are always of type Expense → -balance <= target
mixin FinancialTargetMixin {
  TransactionFilterSet get trFilters;

  /// The target amount for this financial target, in the user preferred currency.
  double get targetAmount;

  /// The direction of the financial target (Income/Savings or Expense).
  /// This determines how transaction balances are treated.
  FinancialTargetDirection get targetDirection;

  DatePeriodState get periodState;

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
  Stream<double> get currentValue {
    return getValueOnDate(null);
  }

  /// Get the percentage of the target already filled. The return value can be greater than 1 (>100%)
  Stream<double> get percentageAlreadyUsed {
    if (targetAmount == 0) return Stream.value(0.0);
    return currentValue.map((event) => event / targetAmount);
  }

  /// Get the current time status of the target based on the current date.
  TargetTimelineStatus get timelineStatus {
    final now = DateTime.now();

    final startDate = periodState.startDate!;
    final endDate = periodState.endDate;

    if (endDate != null && now.compareTo(endDate) > 0) {
      return TargetTimelineStatus.past;
    }
    if (now.compareTo(startDate) < 0) {
      return TargetTimelineStatus.future;
    }
    return TargetTimelineStatus.active;
  }

  /// Whether or not the target is relative to the current datetime.
  /// That is, if the target has not already passed and has already started
  bool get isActive => timelineStatus == TargetTimelineStatus.active;

  /// True if the period range of the target has passed
  bool get isPast => timelineStatus == TargetTimelineStatus.past;

  /// True if the target has not started yet
  bool get isFuture => timelineStatus == TargetTimelineStatus.future;

  /// Get the process status of the budget based on the current date and value
  Stream<TargetProgressStatus?> get progressStatus;
}
