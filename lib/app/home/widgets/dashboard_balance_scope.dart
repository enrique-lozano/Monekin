import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

/// Which accounts the dashboard balance adds up.
enum DashboardBalanceScope {
  // * Stored by name in the app data. Don't rename. //

  /// Every account: what you have minus what you owe (credit cards and other
  /// negative balances subtract).
  netWorth,

  /// Money accounts only, leaving out credit cards and investments: what you
  /// can spend.
  available;

  String title(BuildContext context) {
    final t = Translations.of(context);

    return switch (this) {
      DashboardBalanceScope.netWorth => t.home.balance_scope.net_worth,
      DashboardBalanceScope.available => t.home.balance_scope.available,
    };
  }

  static DashboardBalanceScope fromName(String? name) =>
      DashboardBalanceScope.values.firstWhereOrNull((e) => e.name == name) ??
      DashboardBalanceScope.netWorth;

  /// Balance of the accounts in this scope at [date], in the preferred
  /// currency. See [AccountService.getAccountsMoney].
  Stream<double> watchBalance({DateTime? date}) {
    final service = AccountService.instance;

    return switch (this) {
      DashboardBalanceScope.netWorth => service.getAccountsMoney(date: date),
      DashboardBalanceScope.available =>
        service
            .getAccounts(
              predicate: (acc, curr) =>
                  acc.type.isInValues([AccountType.money]),
            )
            .map((accounts) => accounts.map((a) => a.id).toList())
            .distinct(const ListEquality<String>().equals)
            .switchMap(
              (ids) => service.getAccountsMoney(accountIds: ids, date: date),
            ),
    };
  }
}
