import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/monekin_quick_actions_buttons.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../transactions/form/transaction_form.page.dart';

@RoutePage()
class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key, required this.account});

  final Account account;

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  List<ListTileActionItem> getAccountDetailsActions(
    BuildContext context, {
    required Account account,
    bool navigateBackOnDelete = false,
  }) {
    final t = Translations.of(context);

    return [
      ListTileActionItem(
        label: t.general.edit,
        icon: Icons.edit,
        onClick: () => context.pushRoute(AccountFormRoute(account: account)),
      ),
      ListTileActionItem(
          label: t.transfer.create,
          icon: TransactionType.transfer.icon,
          onClick: account.isClosed
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

                  navigateToTransferForm() => context.pushRoute(
                        TransactionFormRoute(
                          fromAccount: account,
                          mode: TransactionFormMode.transfer,
                        ),
                      );

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
          label: account.isClosed
              ? t.account.reopen_short
              : t.account.close.title_short,
          icon: account.isClosed
              ? Icons.unarchive_rounded
              : Icons.archive_rounded,
          role: ListTileActionRole.warn,
          onClick: () async {
            if (account.isClosed) {
              showReopenAccountDialog(account);
              return;
            }

            final currentBalance = await AccountService.instance
                .getAccountMoney(account: account)
                .first;

            await showCloseAccountDialog(account, currentBalance);
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

  showReopenAccountDialog(Account account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.account.reopen),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(t.account.reopen_descr)],
          ),
        ),
        actions: [
          TextButton(
            child: Text(t.general.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(t.general.confirm),
            onPressed: () {
              AccountService.instance
                  .updateAccount(
                    account.copyWith(
                      closingDate: const drift.Value(null),
                    ),
                  )
                  .then((value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(t.account.close.unarchive_succes)),
                      );
                    }
                  })
                  .whenComplete(() => Navigator.pop(context))
                  .catchError((err) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('$err')));
                  });
            },
          ),
        ],
      ),
    );
  }

  Future<bool?> showCloseAccountDialog(Account account, double currentBalance) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) =>
          ArchiveWarnDialog(currentBalance: currentBalance, account: account),
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
                                                          snapshot.data ||
                                                  snapshot.data! == 0) {
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
                                  if (account.isClosed) ...[
                                    ListTile(
                                      title: Text(t.account.close_date),
                                      subtitle: Text(
                                        DateFormat.yMMMMEEEEd()
                                            .add_Hm()
                                            .format(account.closingDate!),
                                      ),
                                    ),
                                    const Divider(indent: 12),
                                  ],
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
                              context.pushRoute(
                                TransactionsRoute(
                                    filters: TransactionFilters(
                                        accountsIDs: [widget.account.id])),
                              );
                            },
                            body: TransactionListComponent(
                              filters: TransactionFilters(
                                status: TransactionStatus.notIn({
                                  TransactionStatus.pending,
                                  TransactionStatus.voided
                                }),
                                accountsIDs: [widget.account.id],
                              ),
                              limit: 5,
                              showGroupDivider: false,
                              prevPage:
                                  AccountDetailsPage(account: widget.account),
                              onEmptyList: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  t.transaction.list.empty,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CardWithHeader(
                            title: t.general.quick_actions,
                            body: MonekinQuickActionsButton(
                                actions: accountDetailsActions),
                          ),
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

class ArchiveWarnDialog extends StatefulWidget {
  const ArchiveWarnDialog({
    super.key,
    required this.currentBalance,
    required this.account,
  });

  final double currentBalance;
  final Account account;

  @override
  State<ArchiveWarnDialog> createState() => _ArchiveWarnDialogState();
}

class _ArchiveWarnDialogState extends State<ArchiveWarnDialog> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: TransactionService.instance.countTransactions(
          predicate: TransactionFilters(
              accountsIDs: [widget.account.id], minDate: date),
          convertToPreferredCurrency: false,
        ),
        builder: (context, snapshot) {
          final hasNoTransactions =
              !snapshot.hasData || snapshot.data!.numberOfRes == 0;

          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.account.close.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 22),
                        Text(t.account.close.warn),
                        const SizedBox(height: 22),
                        DateTimeFormField(
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.event),
                            labelText: '${t.account.close_date} *',
                          ),
                          initialDate: date,
                          firstDate: widget.account.date,
                          lastDate: DateTime.now(),
                          dateFormat: DateFormat.yMMMd().add_jm(),
                          validator: (e) =>
                              e == null ? t.general.validations.required : null,
                          onDateSelected: (DateTime value) {
                            setState(() {
                              date = value;
                            });
                          },
                        ),
                        if (!hasNoTransactions ||
                            widget.currentBalance != 0) ...[
                          const SizedBox(height: 12),
                          InlineInfoCard(
                            mode: InlineInfoCardMode.warn,
                            text: widget.currentBalance != 0
                                ? t.account.close.should_have_zero_balance
                                : t.account.close.should_have_no_transactions,
                          )
                        ]
                      ],
                    )),
                BottomSheetFooter(
                  submitText: t.general.continue_text,
                  submitIcon: Icons.check,
                  onSaved: !hasNoTransactions || widget.currentBalance != 0
                      ? null
                      : () {
                          AccountService.instance
                              .updateAccount(
                            widget.account.copyWith(
                              closingDate: drift.Value(date),
                            ),
                          )
                              .then((value) {
                            Navigator.pop(context, true);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(t.account.close.success)));
                          }).catchError(
                            (err) {
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$err')),
                              );
                            },
                          );
                        },
                )
              ],
            ),
          );
        });
  }
}
