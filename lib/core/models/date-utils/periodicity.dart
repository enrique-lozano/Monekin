import 'package:flutter/widgets.dart';
import 'package:monekin/i18n/translations.g.dart';

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

  static const Map<(Periodicity, Periodicity), double> _conversionFactors = {
    (Periodicity.day, Periodicity.week): 7,
    (Periodicity.day, Periodicity.month): 30,
    (Periodicity.day, Periodicity.year): 365,
    (Periodicity.week, Periodicity.month): 4.345,
    (Periodicity.week, Periodicity.year): 52.143,
    (Periodicity.month, Periodicity.year): 12,
  };

  static double getConversionFactor(Periodicity from, Periodicity to) {
    if (from == to) return 1;
    
    final direct = _conversionFactors[(from, to)];
    if (direct != null) return direct;
    
    final inverse = _conversionFactors[(to, from)];
    if (inverse != null) return 1 / inverse;
    
    return 1; // Default case
  }
}
