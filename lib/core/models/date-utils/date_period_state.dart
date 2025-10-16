import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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

  @override
  String toString() {
    return 'DatePeriodState(datePeriod: $datePeriod, modifier $periodModifier) -> [$startDate, $endDate]';
  }

  /// Indicates whether the normal app behavior allows the user to navigate to the previous or previous period
  bool get canNavigate => datePeriod.periodType == PeriodType.cycle;

  DateTimeRange? get toDateTimeRange {
    if (startDate == null || endDate == null) {
      return null;
    }

    return DateTimeRange(start: startDate!, end: endDate!);
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

    switch (datePeriod.periodType) {
      case PeriodType.cycle:
        final (
          DateTime fromDate,
          DateTime toDate,
        ) = switch (datePeriod.periodicity) {
          Periodicity.year => (
            DateTime(currentYear + periodModifier, 1, 1),
            DateTime(currentYear + 1 + periodModifier, 1, 1),
          ),
          Periodicity.month => (
            DateTime(currentYear, currentMonth + periodModifier, 1),
            DateTime(currentYear, currentMonth + 1 + periodModifier, 1),
          ),
          Periodicity.week => (
            DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 1))
                .add(Duration(days: 7 * periodModifier)),
            DateTime.now()
                .add(
                  Duration(days: DateTime.daysPerWeek - DateTime.now().weekday),
                )
                .add(Duration(days: 7 * periodModifier)),
          ),
          Periodicity.day => (
            DateTime(
              currentYear,
              currentMonth,
              currentDayOfMonth + periodModifier,
            ),
            DateTime(
              currentYear,
              currentMonth,
              currentDayOfMonth + 1 + periodModifier,
            ),
          ),
        };

        return (fromDate, toDate);

      case PeriodType.dateRange:
        final dateRange = datePeriod.customDateRange;
        final startOrEndIsNull = dateRange.$1 == null || dateRange.$2 == null;

        if (periodModifier != 0 && startOrEndIsNull) {
          return (null, null);
        } else if (startOrEndIsNull) {
          return (dateRange.$1, dateRange.$2);
        }

        final durationToAdd = Duration(
          days: dateRange.$1!.dayDifference(dateRange.$2!) * periodModifier,
        );

        return (
          dateRange.$1!.add(durationToAdd),
          dateRange.$2!.add(durationToAdd),
        );

      case PeriodType.lastDays:
        final currentEndDate = DateTime.now().copyWith(
          day: currentDayOfMonth + periodModifier * datePeriod.lastDays,
        );

        return (
          currentEndDate.subtract(Duration(days: datePeriod.lastDays)),
          currentEndDate,
        );

      case PeriodType.allTime:
        return (null, null);
    }
  }

  String getText(BuildContext context, {bool showLongMonth = true}) {
    final t = Translations.of(context);

    String defaultFormatting() {
      final withoutYearDateFormat = showLongMonth
          ? DateFormat.MMMMd()
          : DateFormat.MMMd();
      final withYearDateFormat = showLongMonth
          ? DateFormat.yMMMd()
          : DateFormat.yMd();

      final startDateStr = startDate == null
          ? '---'
          : (startDate!.year == currentYear
                    ? withoutYearDateFormat
                    : withYearDateFormat)
                .format(startDate!);

      final endDateStr = endDate == null
          ? '---'
          : (endDate!.year == currentYear
                    ? withoutYearDateFormat
                    : withYearDateFormat)
                .format(endDate!);

      return '$startDateStr - $endDateStr';
    }

    switch (datePeriod.periodType) {
      case PeriodType.cycle:
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

      case PeriodType.lastDays:
        if (periodModifier == 0) {
          return t.general.time.ranges.types.last_days_form(
            x: datePeriod.lastDays,
          );
        }

        return defaultFormatting();

      case PeriodType.dateRange:
        if (datePeriod.customDateRange.$1 == null &&
            datePeriod.customDateRange.$2 == null) {
          return PeriodType.allTime.titleText(context);
        }

        return defaultFormatting();

      case PeriodType.allTime:
        return datePeriod.periodType.titleText(context);
    }
  }
}
