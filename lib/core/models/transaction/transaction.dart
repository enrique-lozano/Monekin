import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/rule_recurrent_limit.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/theme.dart';
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
enum TransactionType {
  income,
  expense,
  transfer;

  String displayName(BuildContext context, {bool plural = false}) {
    if (this == income) {
      return t.transaction.types.income(n: plural ? 10 : 1);
    } else if (this == expense) {
      return t.transaction.types.expense(n: plural ? 10 : 1);
    } else if (this == transfer) {
      return t.transaction.types.transfer(n: plural ? 10 : 1);
    }

    return '';
  }

  IconData icon() {
    if (this == income) {
      return Icons.south_east_rounded;
    } else if (this == expense) {
      return Icons.north_east_rounded;
    }

    return Icons.swap_vert_rounded;
  }

  Color color(BuildContext context) {
    if (this == income) {
      return CustomColors.of(context).success;
    } else if (this == expense) {
      return CustomColors.of(context).danger;
    }

    return appColorScheme(context).primary;
  }
}

enum NextPayStatus {
  /// The payment date has not yet arrived, but it is very close
  comingSoon,

  /// The payment should have already been made, that is, it was scheduled before the current date
  delayed,

  /// The payment date has not yet arrived nor is it close
  planified;

  Color color(BuildContext context) {
    if (this == planified) {
      return appColorScheme(context).primary;
    } else if (this == delayed) {
      return CustomColors.of(context).danger;
    }

    return Colors.amber;
  }

  IconData get icon {
    if (this == planified) {
      return Icons.event_rounded;
    } else if (this == delayed) {
      return Icons.warning_rounded;
    }

    return Icons.upcoming;
  }

  String displayDaysToPay(BuildContext context, int days) {
    final t = Translations.of(context);

    if (days == 0) {
      return t.general.today;
    }

    if (this == delayed) {
      return 'Atrasado por ${days.abs()}d';
    }

    return 'In ${days.abs()} days';
  }
}

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
          'The transaction should be recurrent or pending to get this data');
    }

    return date.difference(DateTime.now()).inDays;
  }

  /// Get the money that this transaction would generate for a given periodicity, without taken into account the start and end dates of a recurrency
  double getUnifiedMoneyForAPeriod({
    required TransactionPeriodicity periodicity,
    bool convertToPreferredCurrency = true,
  }) {
    final baseValue =
        convertToPreferredCurrency ? currentValueInPreferredCurrency : value;

    if (recurrentInfo.isNoRecurrent) {
      return baseValue;
    }

    if (periodicity == recurrentInfo.intervalPeriod) {
      return baseValue / recurrentInfo.intervalEach!;
    } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.day) {
      if (periodicity == TransactionPeriodicity.week) {
        return baseValue / 7;
      }
      if (periodicity == TransactionPeriodicity.month) {
        return baseValue / 30;
      }
      if (periodicity == TransactionPeriodicity.year) {
        return baseValue / 365;
      }
    } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.week) {
      if (periodicity == TransactionPeriodicity.day) {
        return baseValue * 7;
      }
      if (periodicity == TransactionPeriodicity.month) {
        return baseValue / 4;
      }
      if (periodicity == TransactionPeriodicity.year) {
        return baseValue / 52;
      }
    } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.month) {
      if (periodicity == TransactionPeriodicity.day) {
        return baseValue * 30;
      }
      if (periodicity == TransactionPeriodicity.week) {
        return baseValue * 4;
      }
      if (periodicity == TransactionPeriodicity.year) {
        return baseValue / 12;
      }
    } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.year) {
      if (periodicity == TransactionPeriodicity.day) {
        return baseValue * 365;
      }
      if (periodicity == TransactionPeriodicity.week) {
        return baseValue * 52;
      }
      if (periodicity == TransactionPeriodicity.month) {
        return baseValue * 12;
      }
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

    toReturn.add(date);

    while (limit == null || toReturn.length < limit) {
      late DateTime toPush;

      int multiplier = toReturn.length;

      if (recurrentInfo.intervalPeriod == TransactionPeriodicity.day) {
        toPush =
            date.add(Duration(days: recurrentInfo.intervalEach! * multiplier));
      } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.week) {
        toPush = date
            .add(Duration(days: recurrentInfo.intervalEach! * 7 * multiplier));
      } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.month) {
        toPush = date.copyWith(
            month: date.month + recurrentInfo.intervalEach! * multiplier);

        if (toPush.month >
            date.month + recurrentInfo.intervalEach! * multiplier) {
          toPush = date.copyWith(
              month: date.month + recurrentInfo.intervalEach! * multiplier + 1);
        }
      } else if (recurrentInfo.intervalPeriod == TransactionPeriodicity.year) {
        toPush = date.copyWith(
            year: date.year + recurrentInfo.intervalEach! * multiplier);
      }

      if (untilDate != null && toPush.compareTo(untilDate) > 0) {
        break;
      }

      toReturn.add(toPush);
    }

    return toReturn;
  }
}
