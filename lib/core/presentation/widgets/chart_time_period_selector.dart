import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';

enum ChartTimePeriod { oneWeek, oneMonth, oneYear, fiveYears, max }

extension ChartTimePeriodX on ChartTimePeriod {
  String localizedLabel(BuildContext context) {
    switch (this) {
      case ChartTimePeriod.oneWeek:
        return _buildLabel(
          multiplier: 1,
          periodText: Periodicity.week.periodText(context, isPlural: false),
        );
      case ChartTimePeriod.oneMonth:
        return _buildLabel(
          multiplier: 1,
          periodText: Periodicity.month.periodText(context, isPlural: false),
        );
      case ChartTimePeriod.oneYear:
        return _buildLabel(
          multiplier: 1,
          periodText: Periodicity.year.periodText(context, isPlural: false),
        );
      case ChartTimePeriod.fiveYears:
        return _buildLabel(
          multiplier: 5,
          periodText: Periodicity.year.periodText(context, isPlural: true),
        );
      case ChartTimePeriod.max:
        return toBeginningOfSentenceCase('max') ?? 'Max';
    }
  }

  DateTime? startDateFrom(DateTime referenceDate) {
    switch (this) {
      case ChartTimePeriod.oneWeek:
        return referenceDate.subtract(const Duration(days: 7));
      case ChartTimePeriod.oneMonth:
        return DateTime(
          referenceDate.year,
          referenceDate.month - 1,
          referenceDate.day,
        );
      case ChartTimePeriod.oneYear:
        return DateTime(
          referenceDate.year - 1,
          referenceDate.month,
          referenceDate.day,
        );
      case ChartTimePeriod.fiveYears:
        return DateTime(
          referenceDate.year - 5,
          referenceDate.month,
          referenceDate.day,
        );
      case ChartTimePeriod.max:
        return null;
    }
  }

  bool isRangeAvailable({
    required DateTime oldestDate,
    DateTime? referenceDate,
  }) {
    final startDate = startDateFrom(referenceDate ?? DateTime.now());

    if (startDate == null) return true;

    return !oldestDate.isAfter(startDate);
  }

  String _buildLabel({required int multiplier, required String periodText}) {
    final normalized = periodText.trim();
    final unit = normalized.isEmpty
        ? ''
        : normalized.substring(0, 1).toUpperCase();

    return '$multiplier$unit';
  }
}

List<T> filterTimeSeriesByPeriod<T>({
  required List<T> data,
  required DateTime Function(T item) dateExtractor,
  required ChartTimePeriod period,
  DateTime? referenceDate,
}) {
  if (data.isEmpty) return const [];

  final sortedData = List<T>.from(data)
    ..sort((a, b) => dateExtractor(a).compareTo(dateExtractor(b)));

  final startDate = period.startDateFrom(referenceDate ?? DateTime.now());
  if (startDate == null) return sortedData;

  return sortedData
      .where((item) => !dateExtractor(item).isBefore(startDate))
      .toList();
}

class ChartTimePeriodSelector extends StatelessWidget {
  const ChartTimePeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.oldestDate,
    required this.onSelected,
  });

  final ChartTimePeriod selectedPeriod;
  final DateTime oldestDate;
  final ValueChanged<ChartTimePeriod> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: ChartTimePeriod.values.map((period) {
          final isEnabled = period.isRangeAvailable(oldestDate: oldestDate);

          return ChoiceChip(
            label: Text(period.localizedLabel(context)),
            selected: selectedPeriod == period,
            onSelected: isEnabled ? (_) => onSelected(period) : null,
          );
        }).toList(),
      ),
    );
  }
}
