// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_period_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DatePeriodStateCWProxy {
  DatePeriodState datePeriod(DatePeriod datePeriod);

  DatePeriodState periodModifier(int periodModifier);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DatePeriodState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DatePeriodState(...).copyWith(id: 12, name: "My name")
  /// ```
  DatePeriodState call({DatePeriod datePeriod, int periodModifier});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDatePeriodState.copyWith(...)` or call `instanceOfDatePeriodState.copyWith.fieldName(value)` for a single field.
class _$DatePeriodStateCWProxyImpl implements _$DatePeriodStateCWProxy {
  const _$DatePeriodStateCWProxyImpl(this._value);

  final DatePeriodState _value;

  @override
  DatePeriodState datePeriod(DatePeriod datePeriod) =>
      call(datePeriod: datePeriod);

  @override
  DatePeriodState periodModifier(int periodModifier) =>
      call(periodModifier: periodModifier);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DatePeriodState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DatePeriodState(...).copyWith(id: 12, name: "My name")
  /// ```
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
      periodModifier:
          periodModifier == const $CopyWithPlaceholder() ||
              periodModifier == null
          ? _value.periodModifier
          // ignore: cast_nullable_to_non_nullable
          : periodModifier as int,
    );
  }
}

extension $DatePeriodStateCopyWith on DatePeriodState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDatePeriodState.copyWith(...)` or `instanceOfDatePeriodState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DatePeriodStateCWProxy get copyWith => _$DatePeriodStateCWProxyImpl(this);
}
