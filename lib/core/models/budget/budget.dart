import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';

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
    this.categories =
        categories != null && categories.isEmpty ? null : categories;

    this.accounts = accounts != null && accounts.isEmpty ? null : accounts;
  }

  (DateTime, DateTime) get currentDateRange {
    final toReturn = DatePeriodState(
            datePeriod: intervalPeriod != null
                ? DatePeriod.withPeriods(intervalPeriod!)
                : DatePeriod.customRange(startDate, endDate))
        .getDates();

    return (toReturn.$1!, toReturn.$2!);
  }

  int get daysLeft {
    return DateTime.now().difference(currentDateRange.$2).inDays;
  }

  /// Get the amount of money relative to this budget for a given date
  Stream<double> getValueOnDate(DateTime? date) {
    date ??= DateTime.now();

    return AccountService.instance
        .getAccountsBalance(
      filters: TransactionFilters(
        transactionTypes: [TransactionType.expense],
        accountsIDs: accounts,
        includeParentCategoriesInSearch: true,
        categories: categories,
        minDate: currentDateRange.$1,
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
}
