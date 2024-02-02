import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/services/filters/date_range_service.dart';
import 'package:monekin/core/utils/constants.dart';

class Budget extends BudgetInDB {
  List<String> categories;
  List<String> accounts;

  Budget(
      {required super.id,
      required super.name,
      required super.limitAmount,
      required this.categories,
      required this.accounts,
      super.intervalPeriod,
      super.startDate,
      super.endDate})
      : assert(categories.isNotEmpty && accounts.isNotEmpty);

  List<DateTime> get currentDateRange {
    if (intervalPeriod != null) {
      if (intervalPeriod == Periodicity.day) {
        return [
          DateTime(currentYear, currentMonth, currentDayOfMonth),
          DateTime(currentYear, currentMonth, currentDayOfMonth + 1)
        ];
      }

      final dateRangeServ = DateRangeService(
          selectedDateRange: intervalPeriod == Periodicity.month
              ? DateRange.monthly
              : intervalPeriod == Periodicity.year
                  ? DateRange.annualy
                  : DateRange.weekly);

      final dates = dateRangeServ.getCurrentDateRange();

      return [dates[0]!, dates[1]!];
    }

    return [startDate!, endDate!];
  }

  int get daysLeft {
    return DateTime.now().difference(currentDateRange[1]).inDays;
  }

  /// Get the amount of money relative to this budget for a given date
  Stream<double> getValueOnDate(DateTime? date) {
    date ??= DateTime.now();

    return AccountService.instance
        .getAccountsBalance(
      filters: TransactionFilters(
        accountsIDs: accounts,
        categories: categories,
        minDate: currentDateRange[0],
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
