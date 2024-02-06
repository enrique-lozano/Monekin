import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';

part 'transaction_filters.g.dart';

@CopyWith()
class TransactionFilters {
  /// Accounts that this filter contains. Will be null if this filter is not in use, or if all accounts are selected
  final Iterable<String>? accountsIDs;

  final bool includeReceivingAccountsInAccountFilters;

  /// Categories that this filter contains. Will be null if this filter is not in use, or if all categories are selected
  final Iterable<String>? categories;

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

  const TransactionFilters(
      {this.minDate,
      this.maxDate,
      this.searchValue,
      this.includeParentCategoriesInSearch = false,
      this.includeReceivingAccountsInAccountFilters = true,
      this.minValue,
      this.maxValue,
      this.transactionTypes,
      this.isRecurrent,
      this.accountsIDs,
      this.categories,
      this.status,
      this.tagsIDs});

  get hasFilter => [
        minDate,
        maxDate,
        searchValue,
        minValue,
        maxValue,
        transactionTypes,
        isRecurrent,
        accountsIDs,
        categories,
        status,
        tagsIDs,
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
  )? toTransactionExpression({
    Iterable<Expression<bool>> Function(
            Transactions transaction,
            Accounts account,
            Currencies accountCurrency,
            Accounts receivingAccount,
            Currencies receivingAccountCurrency,
            Categories c,
            Categories)?
        extraFilters,
  }) {
    return (transaction, account, accountCurrency, receivingAccount,
            receivingAccountCurrency, c, p6) =>
        AppDB.instance.buildExpr([
          if (tagsIDs != null)
            CustomExpression(
                "t.id IN (SELECT transactionID FROM transactionTags WHERE tagID IN (${tagsIDs!.where((element) => element != null).map((s) => "'$s'").join(', ')})) ${tagsIDs!.any((element) => element == null) ? 'OR t.id NOT IN (SELECT transactionID FROM transactionTags)' : ''}"),

          if (maxValue != null)
            CustomExpression(
                '(ABS(t.value * COALESCE(excRate.exchangeRate,1)) <= $maxValue)'),

          if (minValue != null)
            CustomExpression(
                '(ABS(t.value * COALESCE(excRate.exchangeRate,1)) >= $minValue)'),

          // Transaction types:
          if (transactionTypes != null &&
              transactionTypes!
                  .map((e) => e.index)
                  .contains(TransactionType.transfer.index))
            transaction.receivingAccountID.isNotNull(),
          if (transactionTypes != null &&
              !transactionTypes!
                  .map((e) => e.index)
                  .contains(TransactionType.transfer.index))
            transaction.receivingAccountID.isNull(),
          if (transactionTypes != null &&
              transactionTypes!.length == 1 &&
              transactionTypes![0].index == TransactionType.income.index)
            transaction.value.isBiggerThanValue(0) &
                transaction.receivingAccountID.isNull(),
          if (transactionTypes != null &&
              transactionTypes!.length == 1 &&
              transactionTypes![0].index == TransactionType.expense.index)
            transaction.value.isSmallerThanValue(0) &
                transaction.receivingAccountID.isNull(),

          // Is recurrent:
          if (isRecurrent == false) transaction.intervalPeriod.isNull(),
          if (isRecurrent == true) transaction.intervalPeriod.isNotNull(),

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
          if (categories != null && includeParentCategoriesInSearch)
            transaction.categoryID.isIn(categories!) |
                c.parentCategoryID.isIn(categories!),
          if (categories != null && !includeParentCategoriesInSearch)
            transaction.categoryID.isIn(categories!),
          if (status != null) transaction.status.isInValues(status!),
          if (extraFilters != null)
            AppDB.instance.buildExpr(extraFilters(
                    transaction,
                    account,
                    accountCurrency,
                    receivingAccount,
                    receivingAccountCurrency,
                    c,
                    p6)
                .toList()),
        ]);
  }
}
