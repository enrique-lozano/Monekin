import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/utils/database_enum.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/mixins/financial_target_direction.enum.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';

enum GoalType implements DatabaseEnum<int> {
  expense(0),
  income(1);

  const GoalType(this.id);

  final int id;

  @override
  int get databaseValue => id;
}

class Goal extends GoalInDB
    with FinancialTargetMixin
    implements FinancialTarget {
  final TransactionFilterSetInDB _dbTrFilters;

  Goal({
    required super.id,
    required super.name,
    required super.amount,
    required super.initialAmount,
    required super.startDate,
    super.endDate,
    required super.type,
    required TransactionFilterSetInDB trFilters,
  }) : _dbTrFilters = trFilters,
       super(filterID: trFilters.id);

  @override
  double get targetAmount => amount;

  @override
  FinancialTargetDirection get targetDirection => type == GoalType.expense
      ? FinancialTargetDirection.toExpense
      : FinancialTargetDirection.toIncome;

  @override
  TransactionFilterSet get trFilters =>
      TransactionFilterSet.fromDB(_dbTrFilters).copyWith(
        status: TransactionStatus.getStatusThatCountsForStats(
          _dbTrFilters.status,
        ),
        transactionTypes: type == GoalType.expense
            ? [TransactionType.expense]
            : [TransactionType.income],
        minDate: startDate,
        maxDate: endDate,
      );

  @override
  get periodState =>
      DatePeriodState(datePeriod: DatePeriod.customRange(startDate, endDate));

  int? get daysToTheEnd {
    return endDate?.difference(DateTime.now()).inDays;
  }

  int get daysToTheStart {
    return startDate.difference(DateTime.now()).inDays;
  }
}
