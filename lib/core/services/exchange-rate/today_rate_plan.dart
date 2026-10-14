enum TodayRatePlan { insert, keepExisting }

class TodayRateDecision {
  const TodayRateDecision({
    required this.plan,
    required this.date,
    required this.rate,
  });

  final TodayRatePlan plan;

  /// Calendar day the quote belongs to, with no time component.
  final DateTime date;
  final double rate;
}

bool isSameCalendarDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Decide whether a fetched ECB quote may be stored.
///
/// A rate the user already has for that calendar day is kept. The quote date
/// is the ECB business day Frankfurter returned, which can be earlier than
/// the local clock on weekends and before the daily fix.
TodayRateDecision planTodayRate({
  required DateTime quoteDate,
  required double quoteRate,
  required Iterable<DateTime> existingDates,
}) {
  final day = DateTime(quoteDate.year, quoteDate.month, quoteDate.day);
  final exists = existingDates.any((date) => isSameCalendarDay(date, day));

  return TodayRateDecision(
    plan: exists ? TodayRatePlan.keepExisting : TodayRatePlan.insert,
    date: day,
    rate: quoteRate,
  );
}
