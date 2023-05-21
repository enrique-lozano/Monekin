import 'package:finlytics/core/utils/date_getter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateRange {
  weekly,
  monthly,
  quaterly,
  annualy,
  infinite,
  custom,
}

class DateRangeService {
  DateRange selectedDateRange = DateRange.monthly;

  DateTime? startDate;
  DateTime? endDate;

  DateRangeService() {
    resetDateRanges();
  }

  void resetDateRanges() {
    final newRanges = (getCurrentDateRange());

    startDate = newRanges[0];
    endDate = newRanges[1];
  }

  Widget _buildDateButton(BuildContext context,
      {IconData? icon,
      required String label,
      required DateRange dateRange,
      String? iconText,
      required int index}) {
    assert(iconText != null || icon != null);
    assert(!(iconText != null && icon != null));

    final BorderSide border = BorderSide(
        color: Theme.of(context).dividerColor.withOpacity(0.2), width: 1);

    final selected = dateRange == selectedDateRange;

    return Material(
      child: Container(
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).dividerColor.withOpacity(0.2)
                : null,
            border: Border(
              right: index % 2 == 0 && !selected ? border : BorderSide.none,
              bottom: index <= 3 && !selected ? border : BorderSide.none,
            )),
        child: InkWell(
          onTap: () {
            Navigator.pop(context, dateRange);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconText != null)
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(4)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Text(
                    iconText,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ),
                ),
              if (icon != null) Icon(icon, size: 25),
              const SizedBox(height: 4),
              Text(label)
            ],
          ),
        ),
      ),
    );
  }

  /// Returns a date with the first/last day of the current quaterly
  _getQuaterlyDates() {
    int startMonth = -1;
    int endMonth = -1;

    if (currentMonth < 3) {
      startMonth = 0;
      endMonth = 3;
    } else if (currentMonth < 6) {
      startMonth = 3;
      endMonth = 6;
    } else if (currentMonth < 9) {
      startMonth = 6;
      endMonth = 9;
    } else if (currentMonth < 12) {
      startMonth = 9;
      endMonth = 12;
    }

    if (startMonth == -1 || endDate == -1) {
      throw Exception('startMonth or endMonth not setted correctly');
    }

    return [DateTime(currentYear, startMonth), DateTime(currentYear, endMonth)];
  }

  /// If [dateRange] is null, the current value of the selectedDateRange will be used
  String getTextOfRange(
      {required DateTime? startDate,
      required DateTime? endDate,
      DateRange? dateRange}) {
    String text = '';

    if (startDate == null || endDate == null) return 'Por siempre';

    dateRange ??= selectedDateRange;

    if (dateRange == DateRange.monthly) {
      if (startDate.year == currentYear) {
        text = DateFormat.MMMM().format(startDate);
      } else {
        text = DateFormat.yMMMM().format(startDate);
      }
    } else if (dateRange == DateRange.annualy) {
      text = DateFormat.y().format(startDate);
    } else if (dateRange == DateRange.quaterly) {
      text = 'Q${(startDate.month / 3).ceil()} - ${startDate.year}';
    }

    return text;
  }

  /// Gets the current start and end date of the specified time range. That is, get the start and end date of this month, this month, this year...
  List<DateTime?> getCurrentDateRange() {
    DateTime? startDate;
    DateTime? endDate;

    if (selectedDateRange == DateRange.custom) {
      return [startDate, endDate];
    } else if (selectedDateRange == DateRange.annualy) {
      startDate = DateTime(currentYear, 1, 1);
      endDate = DateTime(currentYear + 1, 1, 1);
    } else if (selectedDateRange == DateRange.monthly) {
      startDate = DateTime(currentYear, currentMonth, 1);
      endDate = DateTime(currentYear, currentMonth + 1, 1);
    } else if (selectedDateRange == DateRange.weekly) {
      // TODO
    } else if (selectedDateRange == DateRange.quaterly) {
      final quarters = _getQuaterlyDates();

      startDate = quarters[0];
      endDate = quarters[1];
    } else if (selectedDateRange == DateRange.infinite) {
      startDate = null;
      endDate = null;
    }

    return [startDate, endDate];
  }

  /// Get a range parting of the current selected range and a multiplier. Giving a 1 in the multiplier param will give the next dateRange parting of the current [startDate,endDate] and giving a -1 the previous one.
  List<DateTime?> getDateRange(int multiplier) {
    if (startDate == null || endDate == null) {
      return [null, null];
    }

    DateTime? startDateToReturn;
    DateTime? endDateToReturn;

    if (selectedDateRange == DateRange.custom) {
      startDateToReturn = startDate!.add(
          Duration(days: startDate!.difference(endDate!).inDays) * multiplier);
      endDateToReturn = endDate!.add(
          Duration(days: endDate!.difference(endDate!).inDays) * multiplier);
    } else if (selectedDateRange == DateRange.annualy) {
      startDateToReturn = DateTime(
        startDate!.year + 1 * multiplier,
        startDate!.month,
        startDate!.day,
      );
      endDateToReturn = DateTime(
        endDate!.year + 1 * multiplier,
        endDate!.month,
        endDate!.day,
      );
    } else if (selectedDateRange == DateRange.monthly) {
      startDateToReturn = DateTime(
        startDate!.year,
        startDate!.month + 1 * multiplier,
        startDate!.day,
      );
      endDateToReturn = DateTime(
        endDate!.year,
        endDate!.month + 1 * multiplier,
        endDate!.day,
      );
    } else if (selectedDateRange == DateRange.weekly) {
      startDateToReturn = startDate!.add(Duration(days: 7 * multiplier));
      endDateToReturn = endDate!.add(Duration(days: 7 * multiplier));
    } else if (selectedDateRange == DateRange.quaterly) {
      startDateToReturn = DateTime(
        startDate!.year,
        startDate!.month + 3 * multiplier,
        startDate!.day,
      );

      endDateToReturn = DateTime(
        endDate!.year,
        endDate!.month + 3 * multiplier,
        endDate!.day,
      );
    } else if (selectedDateRange == DateRange.infinite) {
      return [null, null];
    }

    return [startDateToReturn, endDateToReturn];
  }

  Future<void> openDateModal(BuildContext context) async {
    final result = await showDialog<DateRange>(
      context: context,
      builder: (context) {
        return Align(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Select date range'),
                  automaticallyImplyLeading: false,
                  elevation: 4,
                ),
                Container(
                    color: Theme.of(context).colorScheme.background,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.8,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildDateButton(context,
                            index: 0,
                            icon: Icons.calendar_month,
                            dateRange: DateRange.custom,
                            label: 'Custom'),
                        _buildDateButton(context,
                            index: 1,
                            icon: Icons.all_inclusive,
                            dateRange: DateRange.infinite,
                            label: 'Always'),
                        _buildDateButton(context,
                            dateRange: DateRange.annualy,
                            index: 2,
                            iconText: '365',
                            label: 'Annualy'),
                        _buildDateButton(context,
                            dateRange: DateRange.quaterly,
                            index: 3,
                            iconText: '90',
                            label: 'Quaterly'),
                        _buildDateButton(context,
                            dateRange: DateRange.monthly,
                            index: 4,
                            iconText: '30',
                            label: 'Monthly'),
                        _buildDateButton(context,
                            dateRange: DateRange.weekly,
                            index: 5,
                            iconText: '7',
                            label: 'Weekly'),
                      ],
                    )),
              ],
            ),
          ),
        ));
      },
    );

    if (result != null && result != selectedDateRange) {
      selectedDateRange = result;
      resetDateRanges();
    }
  }
}
