// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_period.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DatePeriodCWProxy {
  DatePeriod periodType(PeriodType periodType);

  DatePeriod periodicity(Periodicity periodicity);

  DatePeriod lastDays(int lastDays);

  DatePeriod customDateRange((DateTime?, DateTime?) customDateRange);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DatePeriod(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePeriod(...).copyWith(id: 12, name: "My name")
  /// ````
  DatePeriod call({
    PeriodType? periodType,
    Periodicity? periodicity,
    int? lastDays,
    (DateTime?, DateTime?)? customDateRange,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDatePeriod.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDatePeriod.copyWith.fieldName(...)`
class _$DatePeriodCWProxyImpl implements _$DatePeriodCWProxy {
  const _$DatePeriodCWProxyImpl(this._value);

  final DatePeriod _value;

  @override
  DatePeriod periodType(PeriodType periodType) => this(periodType: periodType);

  @override
  DatePeriod periodicity(Periodicity periodicity) =>
      this(periodicity: periodicity);

  @override
  DatePeriod lastDays(int lastDays) => this(lastDays: lastDays);

  @override
  DatePeriod customDateRange((DateTime?, DateTime?) customDateRange) =>
      this(customDateRange: customDateRange);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DatePeriod(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePeriod(...).copyWith(id: 12, name: "My name")
  /// ````
  DatePeriod call({
    Object? periodType = const $CopyWithPlaceholder(),
    Object? periodicity = const $CopyWithPlaceholder(),
    Object? lastDays = const $CopyWithPlaceholder(),
    Object? customDateRange = const $CopyWithPlaceholder(),
  }) {
    return DatePeriod(
      periodType:
          periodType == const $CopyWithPlaceholder() || periodType == null
              ? _value.periodType
              // ignore: cast_nullable_to_non_nullable
              : periodType as PeriodType,
      periodicity:
          periodicity == const $CopyWithPlaceholder() || periodicity == null
              ? _value.periodicity
              // ignore: cast_nullable_to_non_nullable
              : periodicity as Periodicity,
      lastDays: lastDays == const $CopyWithPlaceholder() || lastDays == null
          ? _value.lastDays
          // ignore: cast_nullable_to_non_nullable
          : lastDays as int,
      customDateRange: customDateRange == const $CopyWithPlaceholder() ||
              customDateRange == null
          ? _value.customDateRange
          // ignore: cast_nullable_to_non_nullable
          : customDateRange as (DateTime?, DateTime?),
    );
  }
}

extension $DatePeriodCopyWith on DatePeriod {
  /// Returns a callable class that can be used as follows: `instanceOfDatePeriod.copyWith(...)` or like so:`instanceOfDatePeriod.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DatePeriodCWProxy get copyWith => _$DatePeriodCWProxyImpl(this);
}
