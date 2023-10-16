import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/transactions/transaction_list.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/filter_sheet_modal.dart';
import 'package:monekin/core/presentation/widgets/monekin_quick_actions_buttons.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/database/services/transaction/transaction_service.dart';
import '../transactions/form/transaction_form.page.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key, required this.account});

  final Account account;

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  List<ListTileActionItem> getAccountDetailsActions(BuildContext context,
      {required Account account, bool navigateBackOnDelete = false}) {
    final t = Translations.of(context);

    return [
      ListTileActionItem(
          label: t.general.edit,
          icon: Icons.edit,
          onClick: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AccountFormPage(
                          account: account,
                        )),
              )),
      ListTileActionItem(
          label: t.transfer.create,
          icon: Icons.swap_vert_rounded,
          onClick: account.isArchived
              ? null
              : () async {
                  showAccountsWarn() => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                t.transfer.need_two_accounts_warning_header),
                            content: SingleChildScrollView(
                                child: Text(t.transfer
                                    .need_two_accounts_warning_message)),
                            actions: [
                              TextButton(
                                  child: Text(t.general.understood),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          );
                        },
                      );

                  navigateToTransferForm() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionFormPage(
                                fromAccount: account,
                                mode: TransactionFormMode.transfer,
                              )));

                  final numberOfAccounts =
                      (await AccountService.instance.getAccounts().first)
                          .length;

                  if (numberOfAccounts <= 1) {
                    await showAccountsWarn();
                  } else {
                    await navigateToTransferForm();
                  }
                }),
      ListTileActionItem(
          label: account.isArchived ? t.general.unarchive : t.general.archive,
          icon: account.isArchived
              ? Icons.unarchive_rounded
              : Icons.archive_rounded,
          role: ListTileActionRole.warn,
          onClick: () async {
            if (account.isArchived) {
              await AccountService.instance
                  .updateAccount(account.copyWith(isArchived: false))
                  .then((value) {
                if (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.account.archive.unarchive_succes)),
                  );
                }
              }).catchError((err) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$err')));
              });

              return;
            }

            final currentBalance = await AccountService.instance
                .getAccountMoney(account: account)
                .first;

            showArchiveWarnDialog(account, currentBalance);
          }),
      ListTileActionItem(
          label: t.general.delete,
          icon: Icons.delete,
          role: ListTileActionRole.delete,
          onClick: () => deleteTransactionWithAlertAndSnackBar(
                context,
                transactionId: account.id,
                navigateBack: navigateBackOnDelete,
              )),
    ];
  }

  showArchiveWarnDialog(Account account, double currentBalance) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(currentBalance == 0 ? t.account.archive.title : 'Ops!'),
        content: SingleChildScrollView(
            child: Text(currentBalance == 0
                ? t.account.archive.warn
                : t.account.archive.should_have_zero_balance)),
        actions: [
          TextButton(
            child: Text(
                currentBalance == 0 ? t.general.confirm : t.general.understood),
            onPressed: () {
              if (currentBalance != 0) {
                Navigator.pop(context);
                return;
              }

              AccountService.instance
                  .updateAccount(account.copyWith(isArchived: true))
                  .then((value) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.account.archive.success)));
              }).catchError((err) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$err')));
              });
            },
          ),
        ],
      ),
    );
  }

  deleteTransactionWithAlertAndSnackBar(BuildContext context,
      {required String transactionId, required bool navigateBack}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t.account.delete.warning_header),
          content:
              SingleChildScrollView(child: Text(t.account.delete.warning_text)),
          actions: [
            TextButton(
              child: Text(t.general.confirm),
              onPressed: () {
                AccountService.instance
                    .deleteAccount(transactionId)
                    .then((value) {
                  Navigator.pop(context);

                  if (navigateBack) {
                    Navigator.pop(context);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(t.account.delete.success)));
                }).catchError((err) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$err')));
                });
              },
            ),
          ],
        );
      },
    );
  }

  ListTile buildCopyableTile(String title, String value) {
    final snackbarDisplayer = ScaffoldMessenger.of(context).showSnackBar;

    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value)).then((_) {
              snackbarDisplayer(
                SnackBar(content: Text(t.general.clipboard.success(x: title))),
              );
            }).catchError((_) {
              snackbarDisplayer(
                SnackBar(content: Text(t.general.clipboard.error)),
              );
            });
          },
          icon: const Icon(Icons.copy_rounded)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
        stream: AccountService.instance.getAccountById(widget.account.id),
        initialData: widget.account,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(t.account.details),
            ),
            body: Builder(builder: (context) {
              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }

              final account = snapshot.data!;

              final accountDetailsActions = getAccountDetailsActions(
                context,
                account: account,
                navigateBackOnDelete: true,
              );

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(account.name),
                                StreamBuilder(
                                    initialData: 0.0,
                                    stream: AccountService.instance
                                        .getAccountMoney(account: account),
                                    builder: (context, snapshot) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CurrencyDisplayer(
                                            amountToConvert: snapshot.data!,
                                            currency: account.currency,
                                            textStyle: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          StreamBuilder(
                                            stream: ExchangeRateService.instance
                                                .calculateExchangeRateToPreferredCurrency(
                                              amount: snapshot.data!,
                                              fromCurrency:
                                                  account.currency.code,
                                            ),
                                            builder:
                                                (context, currencySnapshot) {
                                              if (currencySnapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting ||
                                                  currencySnapshot.data != 0 &&
                                                      currencySnapshot.data! ==
                                                          snapshot.data) {
                                                return Container();
                                              }

                                              return Row(
                                                children: [
                                                  Text(
                                                    String.fromCharCode(Icons
                                                        .currency_exchange_rounded
                                                        .codePoint),
                                                    style: TextStyle(
                                                      fontFamily: Icons
                                                          .currency_exchange_rounded
                                                          .fontFamily,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  CurrencyDisplayer(
                                                      amountToConvert:
                                                          currencySnapshot
                                                              .data!),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      );
                                    }),
                              ],
                            ),
                            Hero(
                                tag: 'account-icon-${widget.account.id}',
                                child: account.displayIcon(context, size: 48)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: Column(
                        children: [
                          CardWithHeader(
                              title: 'Info',
                              body: Column(
                                children: [
                                  ListTile(
                                    title: Text(t.account.date),
                                    subtitle: Text(
                                      DateFormat.yMMMMEEEEd()
                                          .add_Hm()
                                          .format(account.date),
                                    ),
                                  ),
                                  const Divider(indent: 12),
                                  ListTile(
                                    title: Text(t.account.types.title),
                                    subtitle: Text(account.type.title(context)),
                                  ),
                                  if (account.description != null) ...[
                                    const Divider(indent: 12),
                                    ListTile(
                                      title: Text(t.account.form.notes),
                                      subtitle: Text(account.description!),
                                    ),
                                  ],
                                  if (account.iban != null) ...[
                                    const Divider(indent: 12),
                                    buildCopyableTile(
                                        t.account.form.iban, account.iban!)
                                  ],
                                  if (account.swift != null) ...[
                                    const Divider(indent: 12),
                                    buildCopyableTile(
                                        t.account.form.swift, account.swift!)
                                  ]
                                ],
                              )),
                          const SizedBox(height: 16),
                          CardWithHeader(
                            title: t.home.last_transactions,
                            onHeaderButtonClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransactionsPage(
                                            filters: TransactionFilters(
                                                accounts: [widget.account]),
                                          )));
                            },
                            body: StreamBuilder(
                                stream: TransactionService.instance
                                    .getTransactions(
                                        predicate: (transaction,
                                                account,
                                                accountCurrency,
                                                receivingAccount,
                                                receivingAccountCurrency,
                                                c,
                                                p6) =>
                                            AppDB.instance.buildExpr([
                                              transaction.status.isNotInValues([
                                                TransactionStatus.pending,
                                                TransactionStatus.voided
                                              ])
                                            ]),
                                        limit: 5,
                                        orderBy: (p0, p1, p2, p3, p4, p5, p6) =>
                                            drift.OrderBy([
                                              drift.OrderingTerm(
                                                  expression: p0.date,
                                                  mode: drift.OrderingMode.desc)
                                            ])),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const LinearProgressIndicator();
                                  }

                                  if (snapshot.data!.isEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Text(
                                        t.transaction.list.empty,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }
                                  return TransactionListComponent(
                                      transactions: snapshot.data!,
                                      showGroupDivider: false,
                                      prevPage: AccountDetailsPage(
                                        account: widget.account,
                                      ));
                                }),
                          ),
                          const SizedBox(height: 16),
                          CardWithHeader(
                              title: t.general.quick_actions,
                              body: MonekinQuickActionsButton(
                                  actions: accountDetailsActions)),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
          );
        });
  }
}
