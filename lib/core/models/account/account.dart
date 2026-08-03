import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// An enum representing the type of an account.
enum AccountType {
  // * Do not modify the names of the elements of this enum. These are used in the DB //
  // * Renaming a value requires a DB migration (see assets/sql/migrations).           //

  /// A cash/money account. Holds cash only. The default type.
  money,

  /// An investment account (broker, crypto exchange, portfolio) that holds cash
  /// plus financial holdings (securities).
  investment;

  IconData get icon => switch (this) {
    AccountType.money => Icons.wallet,
    AccountType.investment => Icons.trending_up_rounded,
  };

  String title(BuildContext context) {
    final t = Translations.of(context);

    return switch (this) {
      AccountType.money => t.account.types.money,
      AccountType.investment => t.account.types.investment,
    };
  }

  String description(BuildContext context) {
    final t = Translations.of(context);

    return switch (this) {
      AccountType.money => t.account.types.money_descr,
      AccountType.investment => t.account.types.investment_descr,
    };
  }
}

/// How an investment account keeps track of its holdings. Only meaningful for
/// [AccountType.investment] accounts.
enum AccountTrackingMode {
  // * Do not modify the names of the elements of this enum. These are used in the DB //
  // * Renaming a value requires a DB migration (see assets/sql/migrations).           //

  /// Positions are derived from buy/sell trades (type 'N' transactions), using a
  /// weighted-average cost basis.
  transactions,

  /// Positions are entered directly as manual snapshots (quantity + avg cost) at
  /// given dates. No buy/sell trades are recorded.
  holdings;

  IconData get icon => switch (this) {
    AccountTrackingMode.transactions => Icons.receipt_long_rounded,
    AccountTrackingMode.holdings => Icons.pie_chart_rounded,
  };

  String title(BuildContext context) {
    final t = Translations.of(context);

    return switch (this) {
      AccountTrackingMode.transactions => t.account.tracking_modes.transactions,
      AccountTrackingMode.holdings => t.account.tracking_modes.holdings,
    };
  }

  String description(BuildContext context) {
    final t = Translations.of(context);

    return switch (this) {
      AccountTrackingMode.transactions =>
        t.account.tracking_modes.transactions_descr,
      AccountTrackingMode.holdings => t.account.tracking_modes.holdings_descr,
    };
  }
}

class Account extends AccountInDB {
  Account({
    required super.id,
    required super.name,
    required super.iniValue,
    required super.date,
    required super.type,
    required super.displayOrder,
    required super.iconId,
    required this.currency,
    super.isSaving = false,
    super.trackingMode = AccountTrackingMode.transactions,
    super.closingDate,
    super.description,
    super.iban,
    super.swift,
    super.color,
  }) : super(currencyId: currency.code);

  /// Currency of all the transactions of this account. When you change this currency all transactions in this account
  /// will have the new currency but their amount/value will remain the same.
  CurrencyInDB currency;

  SupportedIcon get icon => SupportedIconService.instance.getIconByID(iconId);

  bool get isClosed => closingDate != null;

  Color getComputedColor(BuildContext context) {
    return color != null
        ? ColorHex.get(color!)
        : Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.primary;
  }

  IconDisplayer displayIcon(
    BuildContext context, {
    double size = 24,
    double? padding,
    double outlineWidth = 4,
    bool isOutline = false,
    void Function()? onTap,
  }) {
    bool isDark = isAppInDarkBrightness(context);

    return IconDisplayer(
      supportedIcon: icon,
      mainColor: getComputedColor(
        context,
      ).lighten(isDark ? IconDisplayer.darkLightenFactor : 0),
      secondaryColor: getComputedColor(
        context,
      ).lighten(isDark ? 0 : IconDisplayer.darkLightenFactor),
      displayMode: IconDisplayMode.polygon,
      size: size,
      borderRadius: 20,
      outlineWidth: outlineWidth,
      isOutline: isOutline,
      padding: padding,
      onTap: onTap,
    );
  }

  static Account fromDB(AccountInDB account, CurrencyInDB currency) => Account(
    id: account.id,
    currency: currency,
    iniValue: account.iniValue,
    date: account.date,
    displayOrder: account.displayOrder,
    description: account.description,
    iban: account.iban,
    swift: account.swift,
    name: account.name,
    iconId: account.iconId,
    closingDate: account.closingDate,
    type: account.type,
    isSaving: account.isSaving,
    trackingMode: account.trackingMode,
    color: account.color,
  );
}
