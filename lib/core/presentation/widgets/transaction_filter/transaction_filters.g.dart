// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_filters.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionFiltersCWProxy {
  TransactionFilters minDate(DateTime? minDate);

  TransactionFilters maxDate(DateTime? maxDate);

  TransactionFilters searchValue(String? searchValue);

  TransactionFilters includeParentCategoriesInSearch(
      bool includeParentCategoriesInSearch);

  TransactionFilters includeReceivingAccountsInAccountFilters(
      bool includeReceivingAccountsInAccountFilters);

  TransactionFilters minValue(double? minValue);

  TransactionFilters maxValue(double? maxValue);

  TransactionFilters transactionTypes(List<TransactionType>? transactionTypes);

  TransactionFilters isRecurrent(bool? isRecurrent);

  TransactionFilters accountsIDs(Iterable<String>? accountsIDs);

  TransactionFilters categories(Iterable<String>? categories);

  TransactionFilters status(List<TransactionStatus?>? status);

  TransactionFilters tagsIDs(Iterable<String?>? tagsIDs);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionFilters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionFilters(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionFilters call({
    DateTime? minDate,
    DateTime? maxDate,
    String? searchValue,
    bool? includeParentCategoriesInSearch,
    bool? includeReceivingAccountsInAccountFilters,
    double? minValue,
    double? maxValue,
    List<TransactionType>? transactionTypes,
    bool? isRecurrent,
    Iterable<String>? accountsIDs,
    Iterable<String>? categories,
    List<TransactionStatus?>? status,
    Iterable<String?>? tagsIDs,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionFilters.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionFilters.copyWith.fieldName(...)`
class _$TransactionFiltersCWProxyImpl implements _$TransactionFiltersCWProxy {
  const _$TransactionFiltersCWProxyImpl(this._value);

  final TransactionFilters _value;

  @override
  TransactionFilters minDate(DateTime? minDate) => this(minDate: minDate);

  @override
  TransactionFilters maxDate(DateTime? maxDate) => this(maxDate: maxDate);

  @override
  TransactionFilters searchValue(String? searchValue) =>
      this(searchValue: searchValue);

  @override
  TransactionFilters includeParentCategoriesInSearch(
          bool includeParentCategoriesInSearch) =>
      this(includeParentCategoriesInSearch: includeParentCategoriesInSearch);

  @override
  TransactionFilters includeReceivingAccountsInAccountFilters(
          bool includeReceivingAccountsInAccountFilters) =>
      this(
          includeReceivingAccountsInAccountFilters:
              includeReceivingAccountsInAccountFilters);

  @override
  TransactionFilters minValue(double? minValue) => this(minValue: minValue);

  @override
  TransactionFilters maxValue(double? maxValue) => this(maxValue: maxValue);

  @override
  TransactionFilters transactionTypes(
          List<TransactionType>? transactionTypes) =>
      this(transactionTypes: transactionTypes);

  @override
  TransactionFilters isRecurrent(bool? isRecurrent) =>
      this(isRecurrent: isRecurrent);

  @override
  TransactionFilters accountsIDs(Iterable<String>? accountsIDs) =>
      this(accountsIDs: accountsIDs);

  @override
  TransactionFilters categories(Iterable<String>? categories) =>
      this(categories: categories);

  @override
  TransactionFilters status(List<TransactionStatus?>? status) =>
      this(status: status);

  @override
  TransactionFilters tagsIDs(Iterable<String?>? tagsIDs) =>
      this(tagsIDs: tagsIDs);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionFilters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionFilters(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionFilters call({
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
    Object? categories = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? tagsIDs = const $CopyWithPlaceholder(),
  }) {
    return TransactionFilters(
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
      categories: categories == const $CopyWithPlaceholder()
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as Iterable<String>?,
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

extension $TransactionFiltersCopyWith on TransactionFilters {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionFilters.copyWith(...)` or like so:`instanceOfTransactionFilters.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionFiltersCWProxy get copyWith =>
      _$TransactionFiltersCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `TransactionFilters(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionFilters(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  TransactionFilters copyWithNull({
    bool minDate = false,
    bool maxDate = false,
    bool searchValue = false,
    bool minValue = false,
    bool maxValue = false,
    bool transactionTypes = false,
    bool isRecurrent = false,
    bool accountsIDs = false,
    bool categories = false,
    bool status = false,
    bool tagsIDs = false,
  }) {
    return TransactionFilters(
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
      categories: categories == true ? null : this.categories,
      status: status == true ? null : this.status,
      tagsIDs: tagsIDs == true ? null : this.tagsIDs,
    );
  }
}
