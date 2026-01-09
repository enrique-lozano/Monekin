import 'package:monekin/core/database/services/transaction/transaction_service.dart';
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
  double get targetAmount;

  /// The direction of the financial target (Income/Savings or Expense).
  /// This determines how transaction balances are treated.
  FinancialTargetDirection get targetDirection;

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
}
