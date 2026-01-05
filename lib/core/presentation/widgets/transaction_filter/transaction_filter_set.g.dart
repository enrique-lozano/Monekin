// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_filter_set.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionFilterSetCWProxy {
  TransactionFilterSet minDate(DateTime? minDate);

  TransactionFilterSet maxDate(DateTime? maxDate);

  TransactionFilterSet searchValue(String? searchValue);

  TransactionFilterSet includeParentCategoriesInSearch(
    bool includeParentCategoriesInSearch,
  );

  TransactionFilterSet includeReceivingAccountsInAccountFilters(
    bool includeReceivingAccountsInAccountFilters,
  );

  TransactionFilterSet minValue(double? minValue);

  TransactionFilterSet maxValue(double? maxValue);

  TransactionFilterSet transactionTypes(
    List<TransactionType>? transactionTypes,
  );

  TransactionFilterSet isRecurrent(bool? isRecurrent);

  TransactionFilterSet accountsIDs(Iterable<String>? accountsIDs);

  TransactionFilterSet categoriesIds(Iterable<String>? categoriesIds);

  TransactionFilterSet status(List<TransactionStatus?>? status);

  TransactionFilterSet tagsIDs(Iterable<String?>? tagsIDs);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransactionFilterSet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransactionFilterSet(...).copyWith(id: 12, name: "My name")
  /// ```
  TransactionFilterSet call({
    DateTime? minDate,
    DateTime? maxDate,
    String? searchValue,
    bool includeParentCategoriesInSearch,
    bool includeReceivingAccountsInAccountFilters,
    double? minValue,
    double? maxValue,
    List<TransactionType>? transactionTypes,
    bool? isRecurrent,
    Iterable<String>? accountsIDs,
    Iterable<String>? categoriesIds,
    List<TransactionStatus?>? status,
    Iterable<String?>? tagsIDs,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTransactionFilterSet.copyWith(...)` or call `instanceOfTransactionFilterSet.copyWith.fieldName(value)` for a single field.
class _$TransactionFilterSetCWProxyImpl
    implements _$TransactionFilterSetCWProxy {
  const _$TransactionFilterSetCWProxyImpl(this._value);

  final TransactionFilterSet _value;

  @override
  TransactionFilterSet minDate(DateTime? minDate) => call(minDate: minDate);

  @override
  TransactionFilterSet maxDate(DateTime? maxDate) => call(maxDate: maxDate);

  @override
  TransactionFilterSet searchValue(String? searchValue) =>
      call(searchValue: searchValue);

  @override
  TransactionFilterSet includeParentCategoriesInSearch(
    bool includeParentCategoriesInSearch,
  ) => call(includeParentCategoriesInSearch: includeParentCategoriesInSearch);

  @override
  TransactionFilterSet includeReceivingAccountsInAccountFilters(
    bool includeReceivingAccountsInAccountFilters,
  ) => call(
    includeReceivingAccountsInAccountFilters:
        includeReceivingAccountsInAccountFilters,
  );

  @override
  TransactionFilterSet minValue(double? minValue) => call(minValue: minValue);

  @override
  TransactionFilterSet maxValue(double? maxValue) => call(maxValue: maxValue);

  @override
  TransactionFilterSet transactionTypes(
    List<TransactionType>? transactionTypes,
  ) => call(transactionTypes: transactionTypes);

  @override
  TransactionFilterSet isRecurrent(bool? isRecurrent) =>
      call(isRecurrent: isRecurrent);

  @override
  TransactionFilterSet accountsIDs(Iterable<String>? accountsIDs) =>
      call(accountsIDs: accountsIDs);

  @override
  TransactionFilterSet categoriesIds(Iterable<String>? categoriesIds) =>
      call(categoriesIds: categoriesIds);

  @override
  TransactionFilterSet status(List<TransactionStatus?>? status) =>
      call(status: status);

  @override
  TransactionFilterSet tagsIDs(Iterable<String?>? tagsIDs) =>
      call(tagsIDs: tagsIDs);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransactionFilterSet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransactionFilterSet(...).copyWith(id: 12, name: "My name")
  /// ```
  TransactionFilterSet call({
    Object? minDate = const $CopyWithPlaceholder(),
    Object? maxDate = const $CopyWithPlaceholder(),
    Object? searchValue = const $CopyWithPlaceholder(),
    Object? includeParentCategoriesInSearch = const $CopyWithPlaceholder(),
    Object? includeReceivingAccountsInAccountFilters =
        const $CopyWithPlaceholder(),
    Object? minValue = const $CopyWithPlaceholder(),
    Object? maxValue = const $CopyWithPlaceholder(),
    Object? transactionTypes = const $CopyWithPlaceholder(),
    Object? isRecurrent = const $CopyWithPlaceholder(),
    Object? accountsIDs = const $CopyWithPlaceholder(),
    Object? categoriesIds = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? tagsIDs = const $CopyWithPlaceholder(),
  }) {
    return TransactionFilterSet(
      minDate: minDate == const $CopyWithPlaceholder()
          ? _value.minDate
          // ignore: cast_nullable_to_non_nullable
          : minDate as DateTime?,
      maxDate: maxDate == const $CopyWithPlaceholder()
          ? _value.maxDate
          // ignore: cast_nullable_to_non_nullable
          : maxDate as DateTime?,
      searchValue: searchValue == const $CopyWithPlaceholder()
          ? _value.searchValue
          // ignore: cast_nullable_to_non_nullable
          : searchValue as String?,
      includeParentCategoriesInSearch:
          includeParentCategoriesInSearch == const $CopyWithPlaceholder() ||
              includeParentCategoriesInSearch == null
          ? _value.includeParentCategoriesInSearch
          // ignore: cast_nullable_to_non_nullable
          : includeParentCategoriesInSearch as bool,
      includeReceivingAccountsInAccountFilters:
          includeReceivingAccountsInAccountFilters ==
                  const $CopyWithPlaceholder() ||
              includeReceivingAccountsInAccountFilters == null
          ? _value.includeReceivingAccountsInAccountFilters
          // ignore: cast_nullable_to_non_nullable
          : includeReceivingAccountsInAccountFilters as bool,
      minValue: minValue == const $CopyWithPlaceholder()
          ? _value.minValue
          // ignore: cast_nullable_to_non_nullable
          : minValue as double?,
      maxValue: maxValue == const $CopyWithPlaceholder()
          ? _value.maxValue
          // ignore: cast_nullable_to_non_nullable
          : maxValue as double?,
      transactionTypes: transactionTypes == const $CopyWithPlaceholder()
          ? _value.transactionTypes
          // ignore: cast_nullable_to_non_nullable
          : transactionTypes as List<TransactionType>?,
      isRecurrent: isRecurrent == const $CopyWithPlaceholder()
          ? _value.isRecurrent
          // ignore: cast_nullable_to_non_nullable
          : isRecurrent as bool?,
      accountsIDs: accountsIDs == const $CopyWithPlaceholder()
          ? _value.accountsIDs
          // ignore: cast_nullable_to_non_nullable
          : accountsIDs as Iterable<String>?,
      categoriesIds: categoriesIds == const $CopyWithPlaceholder()
          ? _value.categoriesIds
          // ignore: cast_nullable_to_non_nullable
          : categoriesIds as Iterable<String>?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as List<TransactionStatus?>?,
      tagsIDs: tagsIDs == const $CopyWithPlaceholder()
          ? _value.tagsIDs
          // ignore: cast_nullable_to_non_nullable
          : tagsIDs as Iterable<String?>?,
    );
  }
}

extension $TransactionFilterSetCopyWith on TransactionFilterSet {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTransactionFilterSet.copyWith(...)` or `instanceOfTransactionFilterSet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionFilterSetCWProxy get copyWith =>
      _$TransactionFilterSetCWProxyImpl(this);

  /// Returns a copy of the object with the selected fields set to `null`.
  /// A flag set to `false` leaves the field unchanged. Prefer `copyWith(field: null)` or `copyWith.fieldName(null)` for single-field updates.
  ///
  /// Example:
  /// ```dart
  /// TransactionFilterSet(...).copyWithNull(firstField: true, secondField: true)
  /// ```
  TransactionFilterSet copyWithNull({
    bool minDate = false,
    bool maxDate = false,
    bool searchValue = false,
    bool minValue = false,
    bool maxValue = false,
    bool transactionTypes = false,
    bool isRecurrent = false,
    bool accountsIDs = false,
    bool categoriesIds = false,
    bool status = false,
    bool tagsIDs = false,
  }) {
    return TransactionFilterSet(
      minDate: minDate == true ? null : this.minDate,
      maxDate: maxDate == true ? null : this.maxDate,
      searchValue: searchValue == true ? null : this.searchValue,
      includeParentCategoriesInSearch: includeParentCategoriesInSearch,
      includeReceivingAccountsInAccountFilters:
          includeReceivingAccountsInAccountFilters,
      minValue: minValue == true ? null : this.minValue,
      maxValue: maxValue == true ? null : this.maxValue,
      transactionTypes: transactionTypes == true ? null : this.transactionTypes,
      isRecurrent: isRecurrent == true ? null : this.isRecurrent,
      accountsIDs: accountsIDs == true ? null : this.accountsIDs,
      categoriesIds: categoriesIds == true ? null : this.categoriesIds,
      status: status == true ? null : this.status,
      tagsIDs: tagsIDs == true ? null : this.tagsIDs,
    );
  }
}
