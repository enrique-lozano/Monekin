// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_period_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DatePeriodStateCWProxy {
  DatePeriodState datePeriod(DatePeriod datePeriod);

  DatePeriodState periodModifier(int periodModifier);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DatePeriodState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePeriodState(...).copyWith(id: 12, name: "My name")
  /// ````
  DatePeriodState call({
    DatePeriod? datePeriod,
    int? periodModifier,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDatePeriodState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDatePeriodState.copyWith.fieldName(...)`
class _$DatePeriodStateCWProxyImpl implements _$DatePeriodStateCWProxy {
  const _$DatePeriodStateCWProxyImpl(this._value);

  final DatePeriodState _value;

  @override
  DatePeriodState datePeriod(DatePeriod datePeriod) =>
      this(datePeriod: datePeriod);

  @override
  DatePeriodState periodModifier(int periodModifier) =>
      this(periodModifier: periodModifier);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DatePeriodState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePeriodState(...).copyWith(id: 12, name: "My name")
  /// ````
  DatePeriodState call({
    Object? datePeriod = const $CopyWithPlaceholder(),
    Object? periodModifier = const $CopyWithPlaceholder(),
  }) {
    return DatePeriodState(
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

extension $DatePeriodStateCopyWith on DatePeriodState {
  /// Returns a callable class that can be used as follows: `instanceOfDatePeriodState.copyWith(...)` or like so:`instanceOfDatePeriodState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DatePeriodStateCWProxy get copyWith => _$DatePeriodStateCWProxyImpl(this);
}
