import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/i18n/translations.g.dart';

enum AccountType {
  /// A normal type of account The default type
  normal,

  /// This type of accounts can not have transactions. You only can add and withdraw money from it from other accounts
  saving;

  IconData get icon {
    if (this == normal) {
      return Icons.wallet;
    } else if (this == saving) {
      return Icons.savings;
    }

    return Icons.question_mark;
  }

  String title(BuildContext context) {
    final t = Translations.of(context);

    if (this == normal) {
      return t.account.types.normal;
    } else if (this == saving) {
      return t.account.types.saving;
    }

    return '';
  }

  String description(BuildContext context) {
    final t = Translations.of(context);

    if (this == normal) {
      return t.account.types.normal_descr;
    } else if (this == saving) {
      return t.account.types.saving_descr;
    }

    return '';
  }
}

class Account extends AccountInDB {
  Account(
      {required super.id,
      required super.name,
      required super.iniValue,
      required super.date,
      required super.type,
      required super.iconId,
      required this.currency,
      bool isArchived = false,
      super.description,
      super.iban,
      super.swift})
      : super(currencyId: currency.code, isArchived: isArchived);

  /// Currency of all the transactions of this account. When you change this currency all transactions in this account
  /// will have the new currency but their amount/value will remain the same.
  CurrencyInDB currency;

  SupportedIcon get icon => SupportedIconService.instance.getIconByID(iconId);

  Widget displayIcon(BuildContext context, {double size = 22}) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(1000)),
      child: icon.display(size: size, color: Theme.of(context).primaryColor),
    );
  }

  static Account fromDB(AccountInDB account, CurrencyInDB currency) => Account(
        id: account.id,
        currency: currency,
        iniValue: account.iniValue,
        date: account.date,
        description: account.description,
        iban: account.iban,
        swift: account.swift,
        name: account.name,
        iconId: account.iconId,
        isArchived: account.isArchived,
        type: account.type,
      );
}
