import 'package:flutter/widgets.dart';
import 'package:parsa/i18n/translations.g.dart';

enum Periodicity {
  day,
  week,
  month,
  year;

  String periodText(BuildContext context, {required bool isPlural}) {
    final t = Translations.of(context);
    final n = isPlural ? 2 : 1;

    if (this == day) {
      return t.general.time.ranges.day(n: n);
    } else if (this == week) {
      return t.general.time.ranges.week(n: n);
    } else if (this == month) {
      return t.general.time.ranges.month(n: n);
    } else if (this == year) {
      return t.general.time.ranges.year(n: n);
    }

    return '';
  }

  String allThePeriodsText(BuildContext context) {
    final t = Translations.of(context);

    if (this == day) {
      return t.general.time.all.diary;
    } else if (this == week) {
      return t.general.time.all.weekly;
    } else if (this == month) {
      return t.general.time.all.monthly;
    } else if (this == year) {
      return t.general.time.all.annually;
    }

    return '';
  }
}
