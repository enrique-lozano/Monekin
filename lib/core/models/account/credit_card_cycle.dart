import 'dart:math';

/// The billing cycle of a credit card account, relative to a reference date.
///
/// A cut-off day closes the statement **at the end of that day**: purchases
/// made on the cut-off day still belong to the statement that closes on it.
/// Days that a month does not have (29, 30, 31) fall back to the last day of
/// that month.
///
/// All dates are local dates at midnight.
class CreditCardCycle {
  const CreditCardCycle._({
    required this.cutoffDay,
    required this.dueDay,
    required this.previousCutoff,
    required this.previousPaymentDueDate,
    required this.lastCutoff,
    required this.nextCutoff,
    required this.paymentDueDate,
    required this.nextPaymentDueDate,
  });

  /// Builds the cycle that [date] (defaults to now) falls into.
  factory CreditCardCycle.of({
    required int cutoffDay,
    required int dueDay,
    DateTime? date,
  }) {
    final nextCutoff = cutoffOnOrAfter(cutoffDay, date ?? DateTime.now());

    final lastCutoff = dayInMonth(
      nextCutoff.year,
      nextCutoff.month - 1,
      cutoffDay,
    );

    final previousCutoff = dayInMonth(
      nextCutoff.year,
      nextCutoff.month - 2,
      cutoffDay,
    );

    return CreditCardCycle._(
      cutoffDay: cutoffDay,
      dueDay: dueDay,
      previousCutoff: previousCutoff,
      previousPaymentDueDate: _dueDateAfter(previousCutoff, dueDay),
      lastCutoff: lastCutoff,
      nextCutoff: nextCutoff,
      paymentDueDate: _dueDateAfter(lastCutoff, dueDay),
      nextPaymentDueDate: _dueDateAfter(nextCutoff, dueDay),
    );
  }

  final int cutoffDay;
  final int dueDay;

  /// The statement closed right before [lastCutoff].
  final DateTime previousCutoff;

  /// When the statement closed on [previousCutoff] had to be paid. Always
  /// before today.
  final DateTime previousPaymentDueDate;

  /// The last statement that is already closed (strictly before today).
  final DateTime lastCutoff;

  /// The statement currently open. It closes at the end of this day (it can be
  /// today).
  final DateTime nextCutoff;

  /// When the statement closed on [lastCutoff] has to be paid.
  final DateTime paymentDueDate;

  /// When the statement that closes on [nextCutoff] will have to be paid.
  final DateTime nextPaymentDueDate;

  /// First instant after [previousCutoff].
  DateTime get previousPeriodStart => _nextDay(previousCutoff);

  /// First instant of the current period (the day after [lastCutoff]).
  DateTime get periodStart => _nextDay(lastCutoff);

  /// First instant after the current period (the day after [nextCutoff]).
  DateTime get periodEnd => _nextDay(nextCutoff);

  /// Days from [date] (defaults to now) until the statement closes. `0` means
  /// it closes today.
  int daysToCutoff([DateTime? date]) =>
      _daysBetween(_dateOnly(date ?? DateTime.now()), nextCutoff);

  /// Days from [date] (defaults to now) until [paymentDueDate]. Negative once
  /// the due date has passed.
  int daysToPaymentDue([DateTime? date]) =>
      _daysBetween(_dateOnly(date ?? DateTime.now()), paymentDueDate);

  /// The cut-off of the statement [date] belongs to: the first cut-off on or
  /// after its day.
  static DateTime cutoffOnOrAfter(int cutoffDay, DateTime date) {
    final day = _dateOnly(date);
    final sameMonth = dayInMonth(day.year, day.month, cutoffDay);

    return sameMonth.isBefore(day)
        ? dayInMonth(day.year, day.month + 1, cutoffDay)
        : sameMonth;
  }

  /// The cut-off [months] months after [cutoff] (negative goes back).
  DateTime cutoffAfter(DateTime cutoff, int months) =>
      dayInMonth(cutoff.year, cutoff.month + months, cutoffDay);

  /// When the statement closed on [cutoff] has to be paid.
  DateTime dueDateOf(DateTime cutoff) => _dueDateAfter(cutoff, dueDay);

  /// The [day] of the given month, clamped to the last day of that month.
  /// [month] may overflow (13 is January of the next year, 0 is December of
  /// the previous one).
  static DateTime dayInMonth(int year, int month, int day) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return DateTime(year, month, min(day, lastDay));
  }

  /// The first [dueDay] strictly after [cutoff].
  static DateTime _dueDateAfter(DateTime cutoff, int dueDay) {
    final sameMonth = dayInMonth(cutoff.year, cutoff.month, dueDay);
    return sameMonth.isAfter(cutoff)
        ? sameMonth
        : dayInMonth(cutoff.year, cutoff.month + 1, dueDay);
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static DateTime _nextDay(DateTime d) => DateTime(d.year, d.month, d.day + 1);

  // Using UTC avoids off-by-one errors around DST changes.
  static int _daysBetween(DateTime from, DateTime to) => DateTime.utc(
    to.year,
    to.month,
    to.day,
  ).difference(DateTime.utc(from.year, from.month, from.day)).inDays;
}
