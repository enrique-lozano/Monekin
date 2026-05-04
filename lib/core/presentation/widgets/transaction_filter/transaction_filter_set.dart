import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/utils/uuid.dart';

import '../../../models/transaction/transaction_type.enum.dart';

part 'transaction_filter_set.g.dart';

@CopyWith()
/// A set of filters to apply to transactions queries
class TransactionFilterSet {
  /// Accounts that this filter contains. Will be null if this filter is not in use, or if all accounts are selected
  final Iterable<String>? accountsIDs;

  /// When true, if accountsIDs is specified, transactions with a
  /// receiving account in the list will also be included in results.
  ///
  /// Defaults to `true`
  final bool includeReceivingAccountsInAccountFilters;

  /// Categories that this filter contains. Will be null if this filter is not in use, or if all categories are selected
  final Iterable<String>? categoriesIds;

  /// If we specify a categories filter, return the transactions within a subcategory which parent is on the list
  ///
  /// Defaults to `false`
  final bool includeParentCategoriesInSearch;

  final List<TransactionStatus?>? status;

  final DateTime? minDate;
  final DateTime? maxDate;

  final String? searchValue;

  final List<TransactionType>? transactionTypes;
  final bool? isRecurrent;

  final double? minValue;
  final double? maxValue;

  final Iterable<String?>? tagsIDs;
  final String? debtId;

  /// When set, excludes transactions already linked to this debt ID from results.
  /// Useful in transaction selectors to avoid showing already-assigned transactions.
  final String? excludeDebtId;

  /// When set, returns the transactions that have one of the specified assets linked. If an
  /// empty array is passed, will return the transactions that do not have any asset linked
  final Iterable<String>? assetIds;

  const TransactionFilterSet({
    this.minDate,
    this.maxDate,
    this.searchValue,
    this.includeParentCategoriesInSearch = false,
    this.includeReceivingAccountsInAccountFilters = true,
    this.minValue,
    this.maxValue,
    this.transactionTypes,
    this.isRecurrent,
    this.accountsIDs,
    this.categoriesIds,
    this.status,
    this.tagsIDs,
    this.debtId,
    this.excludeDebtId,
    this.assetIds,
  });

  /// Factory constructor to create a [TransactionFilterSet] from a [TransactionFilterSetInDB]
  factory TransactionFilterSet.fromDB(TransactionFilterSetInDB dbModel) {
    return TransactionFilterSet(
      minDate: dbModel.minDate,
      maxDate: dbModel.maxDate,
      searchValue: dbModel.searchValue,
      minValue: dbModel.minValue,
      maxValue: dbModel.maxValue,
      transactionTypes: dbModel.transactionTypes,
      accountsIDs: dbModel.accountsIDs,
      categoriesIds: dbModel.categoriesIds,
      status: dbModel.status,
      tagsIDs: dbModel.tagsIDs,
      // debtId is not stored in DB filter sets for now
      // assetIds is not stored in DB filter sets for now
    );
  }

  TransactionFilterSetInDB toDBModel({String? id}) {
    return TransactionFilterSetInDB(
      id: id ?? generateUUID(),
      minDate: minDate,
      maxDate: maxDate,
      searchValue: searchValue,
      minValue: minValue,
      maxValue: maxValue,
      transactionTypes: transactionTypes,
      accountsIDs: accountsIDs?.toList(),
      categoriesIds: categoriesIds?.toList(),
      status: status,
      tagsIDs: tagsIDs?.toList(),
    );
  }

  bool get hasFilter => [
    minDate,
    maxDate,
    searchValue?.trim().nullIfEmpty(),
    minValue,
    maxValue,
    transactionTypes,
    isRecurrent,
    accountsIDs,
    categoriesIds,
    status,
    tagsIDs,
    debtId,
    assetIds,
  ].any((element) => element != null);

  Stream<List<Account>> accounts() => accountsIDs != null
      ? AccountService.instance.getAccounts(
          predicate: (acc, curr) => acc.id.isIn(accountsIDs!),
        )
      : AccountService.instance.getAccounts();

  Expression<bool> Function(
    Transactions transaction,
    Accounts account,
    Currencies accountCurrency,
    Accounts receivingAccount,
    Currencies receivingAccountCurrency,
    Categories c,
    Categories,
  )?
  toTransactionExpression({
    Iterable<Expression<bool>> Function(
      Transactions transaction,
      Accounts account,
      Currencies accountCurrency,
      Accounts receivingAccount,
      Currencies receivingAccountCurrency,
      Categories c,
      Categories,
    )?
    extraFilters,
  }) {
    return (
      transaction,
      account,
      accountCurrency,
      receivingAccount,
      receivingAccountCurrency,
      c,
      p6,
    ) => buildDriftExpr([
      if (tagsIDs != null)
        CustomExpression(
          "t.id IN (SELECT transactionID FROM transactionTags WHERE tagID IN (${tagsIDs!.where((element) => element != null).map((s) => "'$s'").join(', ')})) ${tagsIDs!.any((element) => element == null) ? 'OR t.id NOT IN (SELECT transactionID FROM transactionTags)' : ''}",
        ),

      if (maxValue != null)
        CustomExpression(
          '(ABS(t.value * COALESCE(excRate.exchangeRate,1)) <= $maxValue)',
        ),

      if (minValue != null)
        CustomExpression(
          '(ABS(t.value * COALESCE(excRate.exchangeRate,1)) >= $minValue)',
        ),

      // Transaction types:
      if (transactionTypes != null)
        transaction.type.isInValues(transactionTypes!),

      // Is recurrent:
      if (isRecurrent == false) transaction.intervalPeriod.isNull(),
      if (isRecurrent == true) transaction.intervalPeriod.isNotNull(),

      // Other filters:
      if (debtId != null) transaction.debtId.equals(debtId!),
      if (excludeDebtId != null)
        transaction.debtId.isNull() |
            transaction.debtId.equals(excludeDebtId!).not(),

      if (assetIds != null)
        assetIds!.isEmpty
            ? transaction.assetID.isNull()
            : transaction.assetID.isIn(assetIds!),

      if (searchValue != null && searchValue!.isNotEmpty)
        (transaction.notes.contains(searchValue!) |
            transaction.title.contains(searchValue!) |
            c.name.contains(searchValue!)),
      if (minDate != null) transaction.date.isBiggerOrEqualValue(minDate!),
      if (maxDate != null) transaction.date.isSmallerThanValue(maxDate!),
      if (accountsIDs != null && !includeReceivingAccountsInAccountFilters)
        transaction.accountID.isIn(accountsIDs!),
      if (accountsIDs != null && includeReceivingAccountsInAccountFilters)
        transaction.accountID.isIn(accountsIDs!) |
            transaction.receivingAccountID.isIn(accountsIDs!),
      if (categoriesIds != null && includeParentCategoriesInSearch)
        transaction.categoryID.isIn(categoriesIds!) |
            c.parentCategoryID.isIn(categoriesIds!),
      if (categoriesIds != null && !includeParentCategoriesInSearch)
        transaction.categoryID.isIn(categoriesIds!),
      if (status != null) transaction.status.isInValues(status!),
      if (extraFilters != null)
        buildDriftExpr(
          extraFilters(
            transaction,
            account,
            accountCurrency,
            receivingAccount,
            receivingAccountCurrency,
            c,
            p6,
          ).toList(),
        ),
    ]);
  }

  @override
  String toString() {
    return 'TransactionFilterSet(accountsIDs: $accountsIDs, categoriesIds: $categoriesIds, includeParentCategoriesInSearch: $includeParentCategoriesInSearch, status: $status, minDate: $minDate, maxDate: $maxDate, searchValue: $searchValue, transactionTypes: $transactionTypes, isRecurrent: $isRecurrent, minValue: $minValue, maxValue: $maxValue, tagsIDs: $tagsIDs)';
  }
}
