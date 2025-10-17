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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DatePeriod(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DatePeriod(...).copyWith(id: 12, name: "My name")
  /// ```
  DatePeriod call({
    PeriodType periodType,
    Periodicity periodicity,
    int lastDays,
    (DateTime?, DateTime?) customDateRange,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDatePeriod.copyWith(...)` or call `instanceOfDatePeriod.copyWith.fieldName(value)` for a single field.
class _$DatePeriodCWProxyImpl implements _$DatePeriodCWProxy {
  const _$DatePeriodCWProxyImpl(this._value);

  final DatePeriod _value;

  @override
  DatePeriod periodType(PeriodType periodType) => call(periodType: periodType);

  @override
  DatePeriod periodicity(Periodicity periodicity) =>
      call(periodicity: periodicity);

  @override
  DatePeriod lastDays(int lastDays) => call(lastDays: lastDays);

  @override
  DatePeriod customDateRange((DateTime?, DateTime?) customDateRange) =>
      call(customDateRange: customDateRange);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DatePeriod(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DatePeriod(...).copyWith(id: 12, name: "My name")
  /// ```
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
      customDateRange:
          customDateRange == const $CopyWithPlaceholder() ||
              customDateRange == null
          ? _value.customDateRange
          // ignore: cast_nullable_to_non_nullable
          : customDateRange as (DateTime?, DateTime?),
    );
  }
}

extension $DatePeriodCopyWith on DatePeriod {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDatePeriod.copyWith(...)` or `instanceOfDatePeriod.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DatePeriodCWProxy get copyWith => _$DatePeriodCWProxyImpl(this);
}
