import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/utils/constants.dart';

part 'date_period_state.g.dart';

@CopyWith()
class DatePeriodState {
  final DatePeriod datePeriod;
  final int periodModifier;

  const DatePeriodState({
    this.datePeriod = const DatePeriod(periodType: PeriodType.cycle),
    this.periodModifier = 0,
  });

  DateTime? get startDate => getDates().$1;
  DateTime? get endDate => getDates().$2;

  /// Returns the duration of the current period state. Will return null
  /// if the `startDate` or the `endDate` of this period are null.
  Duration? get periodStateDuration {
    if (startDate == null || endDate == null) {
      return null;
    }

    return endDate!.difference(startDate!);
  }

  /// Given the current period status, return the dates of the next period
  (DateTime? fromDate, DateTime? toDate) getNextDates() {
    return getDates(periodModifier: periodModifier + 1);
  }

  /// Given the current period status, return the dates of the next period
  (DateTime? fromDate, DateTime? toDate) getPrevDates() {
    return getDates(periodModifier: periodModifier - 1);
  }

  /// Get the dates of the current period status
  (DateTime? fromDate, DateTime? toDate) getDates({int? periodModifier}) {
    periodModifier ??= this.periodModifier;

    if (datePeriod.periodType == PeriodType.cycle) {
      if (datePeriod.periodicity == Periodicity.year) {
        return (
          DateTime(currentYear + periodModifier, 1, 1),
          DateTime(currentYear + 1 + periodModifier, 1, 1)
        );
      } else if (datePeriod.periodicity == Periodicity.month) {
        return (
          DateTime(currentYear, currentMonth + periodModifier, 1),
          DateTime(currentYear, currentMonth + 1 + periodModifier, 1)
        );
      } else if (datePeriod.periodicity == Periodicity.week) {
        final now = DateTime.now();

        return (
          now
              .subtract(Duration(days: now.weekday - 1))
              .add(Duration(days: 7 * periodModifier)),
          now
              .add(Duration(days: DateTime.daysPerWeek - now.weekday))
              .add(Duration(days: 7 * periodModifier))
        );
      } else if (datePeriod.periodicity == Periodicity.day) {
        return (
          DateTime(
              currentYear, currentMonth, currentDayOfMonth + periodModifier),
          DateTime(
              currentYear, currentMonth, currentDayOfMonth + 1 + periodModifier)
        );
      }
    } else if (datePeriod.periodType == PeriodType.dateRange) {
      final daysBetweenRange = Duration(
          days: datePeriod.customDateRange.$2!
                  .difference(datePeriod.customDateRange.$1!)
                  .inDays *
              periodModifier);

      return (
        datePeriod.customDateRange.$1!.add(daysBetweenRange),
        datePeriod.customDateRange.$2!.add(daysBetweenRange)
      );
    } else if (datePeriod.periodType == PeriodType.lastDays) {
      return (
        DateTime(currentYear, currentMonth,
                currentDayOfMonth + periodModifier * datePeriod.lastDays)
            .subtract(
          Duration(days: datePeriod.lastDays),
        ),
        DateTime(currentYear, currentMonth,
            currentDayOfMonth + periodModifier * datePeriod.lastDays)
      );
    }

    return (null, null);
  }

  String getText(BuildContext context, {bool showLongMonth = true}) {
    String defaultFormatting() {
      if (startDate?.year == currentYear && endDate?.year == currentYear) {
        return '${DateFormat.MMMd().format(startDate!)} - ${DateFormat.MMMd().format(endDate!)}';
      }

      return '${DateFormat.yMd().format(startDate!)} - ${DateFormat.yMd().format(endDate!)}';
    }

    if (datePeriod.periodType == PeriodType.cycle) {
      if (datePeriod.periodicity == Periodicity.year) {
        return DateFormat.y().format(startDate!);
      }

      if (datePeriod.periodicity == Periodicity.month) {
        if (startDate!.year == currentYear) {
          return DateFormat.MMMM().format(startDate!);
        }

        if (showLongMonth) {
          return DateFormat.yMMMM().format(startDate!);
        }

        return DateFormat.yMMM().format(startDate!);
      }

      return defaultFormatting();
    } else if (datePeriod.periodType == PeriodType.dateRange) {
      return defaultFormatting();
    } else if (datePeriod.periodType == PeriodType.lastDays) {
      return defaultFormatting();
    }

    return datePeriod.periodType.titleText(context);
  }
}
