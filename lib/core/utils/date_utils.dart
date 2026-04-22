import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/utils/constants.dart';

/// Given a datetime to check and a valid daterange, calculate the percent of the
/// date to check inside this range.
///
/// Will return a number from 0 to 100 indicating the percentage.
/// Can be negative or greater that 100 if the date to check is outside the range
double getPercentBetweenDates(DateTimeRange timeRange, DateTime timeToCheck) {
  int millisecondDifference =
      timeRange.end.millisecondsSinceEpoch -
      timeRange.start.millisecondsSinceEpoch +
      const Duration(days: 1).inMilliseconds;

  double percent =
      (timeToCheck.millisecondsSinceEpoch -
          timeRange.start.millisecondsSinceEpoch) /
      millisecondDifference;

  return percent * 100;
}

/// Get a date format that will display the month and day,
/// and the year only if it's different from the current year
DateFormat getMMMdDateFormatBasedOnYear(
  DateTime date, {
  shortenMonthInPrevYears = true,
}) {
  if (date.year == currentYear) {
    return DateFormat.MMMMd();
  } else {
    return shortenMonthInPrevYears ? DateFormat.yMMMd() : DateFormat.yMMMMd();
  }
}
