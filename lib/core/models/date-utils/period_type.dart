import 'package:flutter/material.dart';
import 'package:monekin/i18n/translations.g.dart';

enum PeriodType {
  allTime,
  cycle,
  lastDays,
  dateRange;

  String titleText(BuildContext context) {
    final t = Translations.of(context);

    if (this == cycle) {
      return t.general.time.ranges.types.cycle;
    } else if (this == dateRange) {
      return t.general.time.ranges.types.date_range;
    } else if (this == allTime) {
      return t.general.time.ranges.types.all;
    } else if (this == lastDays) {
      return t.general.time.ranges.types.last_days;
    }

    return '';
  }

  IconData icon() {
    if (this == cycle) {
      return Icons.timelapse_rounded;
    } else if (this == dateRange) {
      return Icons.date_range_rounded;
    } else if (this == allTime) {
      return Icons.apps_rounded;
    } else {
      return Icons.today_rounded;
    }
  }
}
