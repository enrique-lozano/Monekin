import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/details/account_details_actions.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/monekin_quick_actions_buttons.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({
    super.key,
    required this.account,
    required this.accountIconHeroTag,
  });

  final Account account;

  final Object? accountIconHeroTag;

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  ListTile buildCopyableTile(String title, String value) {
    final snackbarDisplayer = ScaffoldMessenger.of(context).showSnackBar;

    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      contentPadding: const EdgeInsets.only(left: 16, right: 12),
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

              final accountDetailsActions =
                  AccountDetailsActions.getAccountDetailsActions(
                context,
                account: account,
                navigateBackOnDelete: true,
              );

              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: _AccountDetailHeader(
                          account: account,
                          accountIconHeroTag: widget.accountIconHeroTag)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
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
                                  if (account.isClosed) ...[
                                    ListTile(
                                      title: Text(t.account.close_date),
                                      subtitle: Text(
                                        DateFormat.yMMMMEEEEd()
                                            .add_Hm()
                                            .format(account.closingDate!),
                                      ),
                                    ),
                                  ],
                                  ListTile(
                                    title: Text(t.account.types.title),
                                    subtitle: Text(account.type.title(context)),
                                  ),
                                  if (account.description != null) ...[
                                    ListTile(
                                      title: Text(t.account.form.notes),
                                      subtitle: Text(account.description!),
                                    ),
                                  ],
                                  if (account.iban != null) ...[
                                    buildCopyableTile(
                                        t.account.form.iban, account.iban!)
                                  ],
                                  if (account.swift != null) ...[
                                    buildCopyableTile(
                                        t.account.form.swift, account.swift!)
                                  ]
                                ],
                              )),
                          const SizedBox(height: 16),
                          CardWithHeader(
                            title: t.home.last_transactions,
                            onHeaderButtonClick: () {
                              RouteUtils.pushRoute(
                                context,
                                TransactionsPage(
                                    filters: TransactionFilters(
                                        accountsIDs: [widget.account.id])),
                              );
                            },
                            body: TransactionListComponent(
                              heroTagBuilder: (tr) =>
                                  'account-details-page__tr-icon-${tr.id}',
                              filters: TransactionFilters(
                                status: TransactionStatus.notIn({
                                  TransactionStatus.pending,
                                  TransactionStatus.voided
                                }),
                                accountsIDs: [widget.account.id],
                              ),
                              limit: 5,
                              showGroupDivider: false,
                              prevPage: AccountDetailsPage(
                                  account: widget.account,
                                  accountIconHeroTag:
                                      widget.accountIconHeroTag),
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

class _AccountDetailHeader extends SliverPersistentHeaderDelegate {
  const _AccountDetailHeader({
    required this.account,
    required this.accountIconHeroTag,
  });

  final Account account;
  final Object? accountIconHeroTag;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlap) {
    final shrinkPercent = shrinkOffset / maxExtent;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.of(context).background,
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(account.name),
              StreamBuilder(
                  initialData: 0.0,
                  stream:
                      AccountService.instance.getAccountMoney(account: account),
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 100),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: 32 - shrinkPercent * 16,
                                fontWeight: FontWeight.w600,
                              ),
                          child: CurrencyDisplayer(
                            amountToConvert: snapshot.data!,
                            currency: account.currency,
                          ),
                        ),
                        StreamBuilder(
                          stream: ExchangeRateService.instance
                              .calculateExchangeRateToPreferredCurrency(
                            amount: snapshot.data!,
                            fromCurrency: account.currency.code,
                          ),
                          builder: (context, currencySnapshot) {
                            if (currencySnapshot.connectionState ==
                                    ConnectionState.waiting ||
                                currencySnapshot.data != 0 &&
                                    currencySnapshot.data! == snapshot.data ||
                                snapshot.data! == 0) {
                              return Container();
                            }

                            return Row(
                              children: [
                                Text(
                                  String.fromCharCode(Icons
                                      .currency_exchange_rounded.codePoint),
                                  style: TextStyle(
                                    fontFamily: Icons
                                        .currency_exchange_rounded.fontFamily,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                CurrencyDisplayer(
                                    amountToConvert: currencySnapshot.data!),
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
            tag: accountIconHeroTag ?? UniqueKey(),
            child: account.displayIcon(context, size: 48 - shrinkPercent * 20),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
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

          return ModalContainer(
            title: t.account.close.title,
            footer: BottomSheetFooter(
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(t.account.close.success)));
                      }).catchError(
                        (err) {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$err')),
                          );
                        },
                      );
                    },
            ),
            bodyPadding: const EdgeInsets.symmetric(horizontal: 16),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                if (!hasNoTransactions || widget.currentBalance != 0) ...[
                  const SizedBox(height: 12),
                  InlineInfoCard(
                    mode: InlineInfoCardMode.warn,
                    text: widget.currentBalance != 0
                        ? t.account.close.should_have_zero_balance
                        : t.account.close.should_have_no_transactions,
                  )
                ],
                const SizedBox(height: 16),
              ],
            ),
          );
        });
  }
}
