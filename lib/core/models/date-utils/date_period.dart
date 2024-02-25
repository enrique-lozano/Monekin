import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';

part 'date_period.g.dart';

@CopyWith()
class DatePeriod {
  final PeriodType periodType;

  final Periodicity periodicity;
  final int lastDays;

  final (DateTime?, DateTime?) customDateRange;

  const DatePeriod({
    required this.periodType,
    this.periodicity = Periodicity.month,
    this.lastDays = 7,
    this.customDateRange = (null, null),
  });

  const DatePeriod.withPeriods(Periodicity periodicity)
      : this(periodType: PeriodType.cycle, periodicity: periodicity);

  const DatePeriod.lastDays(int days)
      : this(periodType: PeriodType.lastDays, lastDays: days);

  const DatePeriod.allTime() : this(periodType: PeriodType.allTime);

  const DatePeriod.customRange(DateTime? start, DateTime? end)
      : this(periodType: PeriodType.dateRange, customDateRange: (start, end));
}
