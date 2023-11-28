import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/database/services/currency/currency_service.dart';
import '../../core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import '../../core/presentation/widgets/skeleton.dart';

class AccountWithMoney {
  final double money;
  final Account account;

  AccountWithMoney({required this.money, required this.account});
}

class CurrencyWithMoney {
  double money;
  final CurrencyInDB currency;

  CurrencyWithMoney({required this.money, required this.currency});
}

class AllAccountBalancePage extends StatefulWidget {
  const AllAccountBalancePage(
      {super.key,
      required this.date,
      this.filters = const TransactionFilters()});

  final DateTime date;

  final TransactionFilters filters;

  @override
  State<AllAccountBalancePage> createState() => _AllAccountBalancePageState();
}

class _AllAccountBalancePageState extends State<AllAccountBalancePage> {
  Future<List<AccountWithMoney>> getAccountsWithMoney(
    DateTime date, {
    TransactionFilters filters = const TransactionFilters(),
  }) async {
    final accounts = (await filters.accounts().first).where(
      (element) =>
          !element.isClosed || element.closingDate!.compareTo(date) >= 0,
    );

    final balances = accounts.map((account) async => AccountWithMoney(
        money: await AccountService.instance
            .getAccountMoney(
              account: account,
              trFilters: filters,
              convertToPreferredCurrency: true,
              date: date,
            )
            .first,
        account: account));

    final toReturn = await Future.wait(balances);
    toReturn.sort((a, b) => b.money.compareTo(a.money));

    return toReturn;
  }

  List<CurrencyWithMoney> getCurrenciesWithMoney(
    List<AccountWithMoney> accountsWithMoney,
  ) {
    final toReturn = <CurrencyWithMoney>[];

    for (final account in accountsWithMoney) {
      final currencyToPush = toReturn.firstWhereOrNull(
          (e) => e.currency.code == account.account.currency.code);

      if (currencyToPush != null) {
        currencyToPush.money += account.money;
      } else {
        toReturn.add(CurrencyWithMoney(
            money: account.money, currency: account.account.currency));
      }
    }

    toReturn.sort((a, b) => b.money.compareTo(a.money));

    return toReturn;
  }

  Widget emptyAccountsIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Text(t.account.no_accounts, textAlign: TextAlign.center),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FutureBuilder(
        future: getAccountsWithMoney(widget.date, filters: widget.filters),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          }
          final accounts = snapshot.data!;

          final totalMoney = accounts.map((e) => e.money).sum;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardWithHeader(
                title: t.stats.balance_by_account,
                body: accounts.isEmpty
                    ? emptyAccountsIndicator()
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final accountWithMoney = accounts[index];

                          return ListTile(
                            leading: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    borderRadius: BorderRadius.circular(1000)),
                                child: accountWithMoney.account.icon.display(
                                  size: 22,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            onTap: () => context.pushRoute(
                              AccountFormRoute(
                                  account: accountWithMoney.account),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        accountWithMoney.account.name,
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    CurrencyDisplayer(
                                        amountToConvert: accountWithMoney.money)
                                  ],
                                ),
                                AnimatedProgressBar(
                                    value: min(
                                        max(accountWithMoney.money / totalMoney,
                                            0),
                                        1)),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(indent: 56);
                        },
                        itemCount: accounts.length,
                        shrinkWrap: true,
                      ),
              ),
              const SizedBox(height: 16),
              CardWithHeader(
                title: t.stats.balance_by_currency,
                body: Builder(builder: (context) {
                  final currenciesWithMoney = getCurrenciesWithMoney(accounts);

                  if (currenciesWithMoney.isEmpty) {
                    return emptyAccountsIndicator();
                  }

                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final currencyWithMoney = currenciesWithMoney[index];

                      return ListTile(
                        leading: StreamBuilder(
                          stream: CurrencyService.instance.getCurrencyByCode(
                              currencyWithMoney.currency.code),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Skeleton(width: 42, height: 42);
                            }

                            final currency = snapshot.data!;

                            return Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: currency.displayFlagIcon(size: 32));
                          },
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StreamBuilder(
                                    stream: CurrencyService.instance
                                        .getCurrencyByCode(
                                            currencyWithMoney.currency.code),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Skeleton(
                                            width: 42, height: 42);
                                      }

                                      final currency = snapshot.data!;

                                      return Flexible(
                                        child: Text(
                                          currency.name,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                        ),
                                      );
                                    }),
                                const SizedBox(width: 6),
                                CurrencyDisplayer(
                                    amountToConvert: currencyWithMoney.money)
                              ],
                            ),
                            AnimatedProgressBar(
                                value: min(
                                    max(currencyWithMoney.money / totalMoney,
                                        0),
                                    1)),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(indent: 56);
                    },
                    itemCount: currenciesWithMoney.length,
                    shrinkWrap: true,
                  );
                }),
              ),
            ],
          );
        });
  }
}
