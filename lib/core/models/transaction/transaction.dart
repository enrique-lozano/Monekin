import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/rule_recurrent_limit.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import 'next_pay_status.enum.dart';
import 'transaction_type.enum.dart';

class MoneyTransaction extends TransactionInDB {
  Category? category;
  Account account;
  Account? receivingAccount;
  RecurrencyData recurrentInfo;

  double currentValueInPreferredCurrency;
  double? currentValueInDestinyInPreferredCurrency;

  List<Tag> tags;

  MoneyTransaction({
    required super.id,
    required super.date,
    required super.value,
    required super.isHidden,
    required super.type,
    super.notes,
    super.title,
    super.status,
    super.valueInDestiny,
    super.locAddress,
    super.locLatitude,
    super.locLongitude,
    required AccountInDB account,
    AccountInDB? receivingAccount,
    required CurrencyInDB accountCurrency,
    CurrencyInDB? receivingAccountCurrency,
    CategoryInDB? category,
    CategoryInDB? parentCategory,
    this.currentValueInDestinyInPreferredCurrency,
    required this.currentValueInPreferredCurrency,
    required List<TagInDB> tags,
    super.endDate,
    super.intervalEach,
    super.intervalPeriod,
    super.remainingTransactions,
  }) : category = category != null
           ? Category.fromDB(category, parentCategory)
           : null,
       account = Account.fromDB(account, accountCurrency),
       receivingAccount =
           receivingAccount != null && receivingAccountCurrency != null
           ? Account.fromDB(receivingAccount, receivingAccountCurrency)
           : null,
       tags = tags.map((e) => Tag.fromTagInDB(e)).toList(),
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

  bool get isTransfer => type.isTransfer;
  bool get isIncomeOrExpense => type.isIncomeOrExpense;

  /// Display the title of the transaction, or the category in case the title is not specified for this transaction
  String displayName(BuildContext context) {
    final t = Translations.of(context);

    return title ??
        (isIncomeOrExpense
            ? category!.name
            : t.transfer.transfer_to(account: receivingAccount!.name));
  }

  /// Get the color that represent this category. Will be the category color when the transaction is an income or an expense, and the primary color of the app otherwise
  Color color(BuildContext context) => isIncomeOrExpense
      ? ColorHex.get(category!.color)
      : TransactionType.transfer.color(context);

  /// Get the balance (positive or negative) that this transaction cause to the user accounts
  double getCurrentBalanceInPreferredCurrency() {
    if (type == TransactionType.transfer) {
      return (currentValueInDestinyInPreferredCurrency ??
              currentValueInPreferredCurrency) -
          currentValueInPreferredCurrency;
    }

    return currentValueInPreferredCurrency;
  }

  bool get isReversed {
    return type == TransactionType.expense && value > 0 ||
        type == TransactionType.income && value < 0;
  }

  static IconData get reversedIcon {
    return Icons.shuffle_on_rounded;
  }

  IconDisplayer getDisplayIcon(
    BuildContext context, {
    double size = 22,
    double? padding,
  }) => isIncomeOrExpense
      ? IconDisplayer.fromCategory(
          context,
          category: category!,
          size: size,
          padding: padding,
          borderRadius: 999999,
        )
      : IconDisplayer(
          mainColor: color(context),
          icon: TransactionType.transfer.icon,
          size: size,
          padding: padding,
          borderRadius: 999999,
        );

  NextPayStatus? get nextPayStatus {
    if (recurrentInfo.isNoRecurrent && status != TransactionStatus.pending) {
      return null;
    }

    return daysToPay() < 0
        ? NextPayStatus.delayed
        : daysToPay() <= 10
        ? NextPayStatus.comingSoon
        : NextPayStatus.planified;
  }

  /// Get the days to the next payment. Will return an error in case of a non-recurrent transactions that is not pending
  ///
  /// If the day has already passed, it will return a negative number
  int daysToPay() {
    if (recurrentInfo.isNoRecurrent && status != TransactionStatus.pending) {
      throw Exception(
        'The transaction should be recurrent or pending to get this data',
      );
    }

    return date.difference(DateTime.now()).inDays;
  }

  /// Get the money that this transaction would generate for a given periodicity, without taken into account the start and end dates of a recurrency
  double getUnifiedMoneyForAPeriod({
    required Periodicity periodicity,
    bool convertToPreferredCurrency = true,
  }) {
    double baseValue = convertToPreferredCurrency
        ? currentValueInPreferredCurrency
        : value;

    if (recurrentInfo.isNoRecurrent) {
      return baseValue;
    }

    final intervalEachDivider = recurrentInfo.intervalEach ?? 1;

    baseValue = baseValue / intervalEachDivider;

    if (recurrentInfo.intervalPeriod != null) {
      return baseValue *
          Periodicity.getConversionFactor(
            recurrentInfo.intervalPeriod!,
            periodicity,
          );
    }

    throw Exception('We could not calculate this value');
  }

  bool get isOnLastPayment => getNextDatesOfRecurrency(limit: 2).length == 1;

  DateTime? get followingDateToNext =>
      getNextDatesOfRecurrency(limit: 2).elementAtOrNull(1);

  /// Get the following dates of a recurring transaction
  ///
  /// You can pass certain limits (date or number of iter.) as parameters so that the function does not return an array of infinite dates. These limits will not be taken into account if there is already a stricter limit in the transaction.
  List<DateTime> getNextDatesOfRecurrency({DateTime? untilDate, int? limit}) {
    if (recurrentInfo.isNoRecurrent) {
      throw Exception(
        'The transaction should be recurrent to get the following dates',
      );
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

    toReturn.add(date);

    while (limit == null || toReturn.length < limit) {
      late DateTime toPush;

      int multiplier = toReturn.length;

      if (recurrentInfo.intervalPeriod == Periodicity.day) {
        toPush = date.add(
          Duration(days: recurrentInfo.intervalEach! * multiplier),
        );
      } else if (recurrentInfo.intervalPeriod == Periodicity.week) {
        toPush = date.add(
          Duration(days: recurrentInfo.intervalEach! * 7 * multiplier),
        );
      } else if (recurrentInfo.intervalPeriod == Periodicity.month) {
        toPush = date.copyWith(
          month: date.month + recurrentInfo.intervalEach! * multiplier,
        );

        if (toPush.month >
            date.month + recurrentInfo.intervalEach! * multiplier) {
          toPush = date.copyWith(
            month: date.month + recurrentInfo.intervalEach! * multiplier + 1,
          );
        }
      } else if (recurrentInfo.intervalPeriod == Periodicity.year) {
        toPush = date.copyWith(
          year: date.year + recurrentInfo.intervalEach! * multiplier,
        );
      }

      if (untilDate != null && toPush.compareTo(untilDate) > 0) {
        break;
      }

      toReturn.add(toPush);
    }

    return toReturn;
  }
}
