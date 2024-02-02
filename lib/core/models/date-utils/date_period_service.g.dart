// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_period_service.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DatePeriodServiceCWProxy {
  DatePeriodService datePeriod(DatePeriod datePeriod);

  DatePeriodService periodModifier(int periodModifier);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DatePeriodService(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePeriodService(...).copyWith(id: 12, name: "My name")
  /// ````
  DatePeriodService call({
    DatePeriod? datePeriod,
    int? periodModifier,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDatePeriodService.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDatePeriodService.copyWith.fieldName(...)`
class _$DatePeriodServiceCWProxyImpl implements _$DatePeriodServiceCWProxy {
  const _$DatePeriodServiceCWProxyImpl(this._value);

  final DatePeriodService _value;

  @override
  DatePeriodService datePeriod(DatePeriod datePeriod) =>
      this(datePeriod: datePeriod);

  @override
  DatePeriodService periodModifier(int periodModifier) =>
      this(periodModifier: periodModifier);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DatePeriodService(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePeriodService(...).copyWith(id: 12, name: "My name")
  /// ````
  DatePeriodService call({
    Object? datePeriod = const $CopyWithPlaceholder(),
    Object? periodModifier = const $CopyWithPlaceholder(),
  }) {
    return DatePeriodService(
      datePeriod:
          datePeriod == const $CopyWithPlaceholder() || datePeriod == null
              ? _value.datePeriod
              // ignore: cast_nullable_to_non_nullable
              : datePeriod as DatePeriod,
      periodModifier: periodModifier == const $CopyWithPlaceholder() ||
              periodModifier == null
          ? _value.periodModifier
          // ignore: cast_nullable_to_non_nullable
          : periodModifier as int,
    );
  }
}

extension $DatePeriodServiceCopyWith on DatePeriodService {
  /// Returns a callable class that can be used as follows: `instanceOfDatePeriodService.copyWith(...)` or like so:`instanceOfDatePeriodService.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DatePeriodServiceCWProxy get copyWith =>
      _$DatePeriodServiceCWProxyImpl(this);
}
