import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/widgets/interval_selector_help.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/rule_recurrent_limit.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

enum TransactionPeriodicity {
  day,
  week,
  month,
  year;

  String periodText(BuildContext context, int n) {
    final t = Translations.of(context);

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
}

/// All the possible types of a transaction
enum TransactionType { income, expense, transfer }

class MoneyTransaction extends TransactionInDB {
  Category? category;
  Account account;
  Account? receivingAccount;
  RecurrencyData recurrentInfo;

  double currentValueInPreferredCurrency;
  double? currentValueInDestinyInPreferredCurrency;

  MoneyTransaction(
      {required super.id,
      required super.date,
      required super.value,
      required super.isHidden,
      super.notes,
      super.title,
      super.status,
      super.valueInDestiny,
      required AccountInDB account,
      AccountInDB? receivingAccount,
      required CurrencyInDB accountCurrency,
      CurrencyInDB? receivingAccountCurrency,
      CategoryInDB? category,
      CategoryInDB? parentCategory,
      this.currentValueInDestinyInPreferredCurrency,
      required this.currentValueInPreferredCurrency,
      super.endDate,
      super.intervalEach,
      super.intervalPeriod,
      super.remainingTransactions})
      : category =
            category != null ? Category.fromDB(category, parentCategory) : null,
        account = Account.fromDB(account, accountCurrency),
        receivingAccount =
            receivingAccount != null && receivingAccountCurrency != null
                ? Account.fromDB(receivingAccount, receivingAccountCurrency)
                : null,
        recurrentInfo = RecurrencyData(
          intervalEach: intervalEach,
          intervalPeriod: intervalPeriod,
          ruleRecurrentLimit: intervalEach != null
              ? RecurrentRuleLimit(
                  endDate: endDate,
                  remainingIterations: remainingTransactions,
                )
              : null,
        ),
        super(
          accountID: account.id,
          categoryID: category?.id,
          receivingAccountID: receivingAccount?.id,
        );

  bool get isTransfer => receivingAccountID != null;
  bool get isIncomeOrExpense => categoryID != null;

  /// Display the title of the transaction, or the category in case the title is not specified for this transaction
  String displayName(BuildContext context) {
    final t = Translations.of(context);

    return title ??
        (isIncomeOrExpense
            ? category!.name
            : t.transfer.transfer_to(account: receivingAccount!.name));
  }

  /// Get the color that represent this category. Will be the category color when the transaction is an income or an expense, and the primary color of the app otherwise
  Color color(context) => isIncomeOrExpense
      ? ColorHex.get(category!.color)
      : Theme.of(context).colorScheme.primary;

  /// The type of the transaction (expense, income or transfer)
  TransactionType get type => isTransfer
      ? TransactionType.transfer
      : value < 0
          ? TransactionType.expense
          : TransactionType.income;

  /// Get the following dates of a recurring transaction, disregarding the most immediate upcoming transaction, referenced in the `date` attribute of this class.
  ///
  /// You can pass certain limits (date or number of iter.) as parameters so that the function does not return an array of infinite dates. These limits will not be taken into account if there is already a stricter limit in the transaction.
  List<DateTime> getNextDatesOfRecurrency({DateTime? untilDate, int? limit}) {
    if (recurrentInfo.isNoRecurrent) {
      throw Exception(
          'The transaction should be recurrent to get the following dates');
    }

    List<DateTime> toReturn = [];

    final trRemainingIter =
        recurrentInfo.ruleRecurrentLimit?.remainingIterations;
    if (trRemainingIter != null && (limit == null || trRemainingIter < limit)) {
      limit = trRemainingIter;
    }

    final trEndDate = recurrentInfo.ruleRecurrentLimit?.endDate;

    if (trEndDate != null &&
        (untilDate == null || trEndDate.compareTo(untilDate) < 0)) {
      untilDate = trEndDate;
    }

    if (untilDate == null && limit == null) {
      throw Exception('Trying to calculate infinite dates');
    }

    if (limit == 0) {
      return toReturn;
    }

    while (limit == null || toReturn.length < limit) {
      late DateTime toPush;

      if (recurrentInfo.intervalPeriod == TransactionPeriodicity.day) {
        toPush = date.add(Duration(days: recurrentInfo.intervalEach!));
      } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.week) {
        toPush = date.add(Duration(days: recurrentInfo.intervalEach! * 7));
      } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.month) {
        toPush = date.copyWith(month: date.month + recurrentInfo.intervalEach!);

        if (toPush.month > date.month + recurrentInfo.intervalEach!) {
          toPush = date.copyWith(
              month: date.month + recurrentInfo.intervalEach! + 1);
        }
      } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.year) {
        toPush = date.copyWith(year: date.year + recurrentInfo.intervalEach!);
      }

      if (untilDate != null && toPush.compareTo(untilDate) > 0) {
        break;
      }

      toReturn.add(toPush);
    }

    return toReturn;
  }
}
