extension DateTimeExtension on DateTime {
  DateTime justDay(
      {int yearOffset = 0, int monthOffset = 0, int dayOffset = 0}) {
    return DateTime(year + yearOffset, month + monthOffset, day + dayOffset);
  }

  DateTime firstDayOfMonth() {
    return DateTime(year, month, 1);
  }

  int dayDifference(DateTime date, {bool withHourCount = false}) {
    if (withHourCount) {
      return difference(date).inDays;
    }

    final from = date.justDay();
    final to = justDay();

    return (to.difference(from).inHours / 24).round();
  }
}
