import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/date_utils.dart';

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
            : DatePeriod.customRange(startDate, endDate));
  }

  int get daysToTheEnd {
    return currentDateRange.end.difference(DateTime.now()).inDays;
  }

  int get daysToTheStart {
    return currentDateRange.start.difference(DateTime.now()).inDays;
  }

  double get todayPercent => getPercentBetweenDates(
        currentDateRange,
        DateTime.now(),
      );

  /// Whether or not the budget is relative to the current datetime.
  /// That is, if the budget has not already passed and has already started
  bool get isActiveBudget => !isPastBudget && !isFutureBudget;

  /// True if the period range of the budget has passed
  bool get isPastBudget => DateTime.now().compareTo(currentDateRange.end) > 0;

  /// True if the budget has not started yet
  bool get isFutureBudget =>
      DateTime.now().compareTo(currentDateRange.start) < 0;

  TransactionFilters get trFilters => TransactionFilters(
        status: TransactionStatus.notIn(
            {TransactionStatus.pending, TransactionStatus.voided}),
        transactionTypes: [TransactionType.expense],
        minDate: currentDateRange.start,
        maxDate: currentDateRange.end,
        includeParentCategoriesInSearch: true,
        categories: categories,
        accountsIDs: accounts,
      );

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
}
