import 'package:flutter/widgets.dart';
import 'package:monekin/i18n/translations.g.dart';

/// Enum representing different time periods or intervals.
enum Periodicity {
  day,
  week,
  month,
  year;

  /// Returns a localized string representing the current period,
  /// with support for singular or plural form based on [isPlural].
  ///
  /// [context] - The [BuildContext] for localization access.
  /// [isPlural] - Boolean indicating whether to return the plural form.
  ///
  /// For example, if the enum value is [Periodicity.day] and [isPlural] is true,
  /// it might return "days" in the appropriate language.
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

  /// Returns a localized string for describing "all periods" of the current [Periodicity] value.
  ///
  /// [context] - The [BuildContext] for localization access.
  ///
  /// For example, if the enum value is [Periodicity.week], this method might return
  /// "weekly" in the appropriate language.
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

  /// Conversion factors between different periodicity units.
  ///
  /// This map stores conversion factors between two [Periodicity] values, with the key
  /// being a tuple (from, to) and the value being the factor. If a conversion isn't found
  /// in this map, it may be calculated by inverting an existing factor.
  static const Map<(Periodicity, Periodicity), double> _conversionFactors = {
    (Periodicity.day, Periodicity.week): 7,
    (Periodicity.day, Periodicity.month): 30,
    (Periodicity.day, Periodicity.year): 365,
    (Periodicity.week, Periodicity.month): 4.345,
    (Periodicity.week, Periodicity.year): 52.143,
    (Periodicity.month, Periodicity.year): 12,
  };

  /// Retrieves the conversion factor to convert from one [Periodicity] unit to another.
  ///
  /// [from] - The source [Periodicity] unit.
  /// [to] - The target [Periodicity] unit.
  ///
  /// Returns a [double] representing the conversion factor, or 1 if the units
  /// are the same or an appropriate conversion factor cannot be found.
  static double getConversionFactor(Periodicity from, Periodicity to) {
    if (from == to) return 1;

    final direct = _conversionFactors[(from, to)];
    if (direct != null) return direct;

    final inverse = _conversionFactors[(to, from)];
    if (inverse != null) return 1 / inverse;

    return 1; // Default case
  }
}
