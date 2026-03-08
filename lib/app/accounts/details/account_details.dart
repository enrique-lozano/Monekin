import 'dart:math';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/details/account_details_actions.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/label_value_info_list.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/investment/investment_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/monekin_quick_actions_buttons.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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
  LabelValueInfoListItem buildCopyableTile(String title, String value) {
    return LabelValueInfoListItem(
      label: title,
      value: Text(value, softWrap: false, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: value))
              .then((_) {
                MonekinSnackbar.success(
                  SnackbarParams(t.general.clipboard.success(x: title)),
                );
              })
              .catchError((_) {
                MonekinSnackbar.error(
                  SnackbarParams(t.general.clipboard.error),
                );
              });
        },
        icon: const Icon(Icons.copy_rounded),
      ),
    );
  }

  Widget _buildInvestmentCard(BuildContext context, Account account) {
    final t = Translations.of(context);

    return StreamBuilder(
      stream: InvestmentService.instance.getInvestmentProfit(account),
      builder: (context, profitSnapshot) {
        return StreamBuilder(
          stream: InvestmentService.instance.getLatestValuationForAccount(
            account.id,
          ),
          builder: (context, valuationSnapshot) {
            final profit = profitSnapshot.data;
            final latestValuation = valuationSnapshot.data;

            return CardWithHeader(
              title: t.account.investment.details_header,
              footer: CardFooterWithSingleButton(
                text: t.account.investment.update_value,
                onButtonClick: () async {
                  await showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (_) => _UpdateValuationDialog(account: account),
                  );
                },
              ),
              body: LabelValueInfoList(
                items: [
                  LabelValueInfoListItem(
                    label: t.account.investment.invested_capital,
                    value: StreamBuilder(
                      stream: InvestmentService.instance.getInvestedCapital(
                        account,
                      ),
                      builder: (context, snapshot) {
                        return CurrencyDisplayer(
                          amountToConvert: snapshot.data ?? 0,
                          currency: account.currency,
                        );
                      },
                    ),
                  ),
                  if (profit != null) ...[
                    LabelValueInfoListItem(
                      label: t.account.investment.profit,
                      value: Row(
                        children: [
                          CurrencyDisplayer(
                            amountToConvert: profit.value,
                            currency: account.currency,
                            showDecimals: true,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${(profit.percent * 100).toStringAsFixed(2)} %)',
                            style: TextStyle(
                              color: profit.value >= 0
                                  ? AppColors.of(context).success
                                  : AppColors.of(context).danger,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  LabelValueInfoListItem(
                    label: t.account.investment.last_valuation,
                    value: latestValuation == null
                        ? Text(
                            t.account.investment.no_valuations,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          )
                        : Text(
                            DateFormat.yMMMd().add_Hm().format(
                              latestValuation.date,
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.account.details,
      body: StreamBuilder(
        stream: AccountService.instance.getAccountById(widget.account.id),
        initialData: widget.account,
        builder: (context, snapshot) {
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
                  accountIconHeroTag: widget.accountIconHeroTag,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ).withSafeBottom(context),
                  child: Column(
                    children: [
                      CardWithHeader(
                        title: 'Info',
                        footer: CardFooterWithSingleButton(
                          text: t.ui_actions.edit,
                          onButtonClick: () => RouteUtils.pushRoute(
                            AccountFormPage(account: account),
                          ),
                        ),
                        body: LabelValueInfoList(
                          items: [
                            LabelValueInfoListItem(
                              value: Text(
                                DateFormat.yMMMMEEEEd().add_Hm().format(
                                  account.date,
                                ),
                              ),
                              label: t.account.date,
                            ),
                            if (account.isClosed) ...[
                              LabelValueInfoListItem(
                                label: t.account.close_date,
                                value: Text(
                                  DateFormat.yMMMMEEEEd().add_Hm().format(
                                    account.closingDate!,
                                  ),
                                ),
                              ),
                            ],
                            LabelValueInfoListItem(
                              label: t.account.types.title,
                              value: Text(account.type.title(context)),
                            ),
                            if (account.iban != null) ...[
                              buildCopyableTile(
                                t.account.form.iban,
                                account.iban!,
                              ),
                            ],
                            if (account.swift != null) ...[
                              buildCopyableTile(
                                t.account.form.swift,
                                account.swift!,
                              ),
                            ],
                            if (account.description != null) ...[
                              LabelValueInfoListItem(
                                label: t.account.form.notes,
                                value: Text(account.description!),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (account.type == AccountType.investment) ...[
                        const SizedBox(height: 16),
                        _buildInvestmentCard(context, account),
                      ],
                      const SizedBox(height: 16),
                      CardWithHeader(
                        title: t.home.last_transactions,
                        bodyPadding: const EdgeInsets.symmetric(vertical: 6),
                        footer: StreamBuilder(
                          stream: TransactionService.instance.countTransactions(
                            filters: TransactionFilterSet(
                              status: TransactionStatus.notIn({
                                TransactionStatus.pending,
                                TransactionStatus.voided,
                              }),
                              accountsIDs: [widget.account.id],
                            ),
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data! < 5) {
                              return const SizedBox.shrink();
                            }

                            return CardFooterWithSingleButton(
                              onButtonClick: () {
                                RouteUtils.pushRoute(
                                  TransactionsPage(
                                    filters: TransactionFilterSet(
                                      accountsIDs: [widget.account.id],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        body: TransactionListComponent(
                          tileBuilder: (transaction) => TransactionListTile(
                            transaction: transaction,
                            showAccount: false,
                            heroTag:
                                'account-details-page__tr-icon-${transaction.id}',
                          ),
                          filters: TransactionFilterSet(
                            status: TransactionStatus.notIn({
                              TransactionStatus.pending,
                              TransactionStatus.voided,
                            }),
                            accountsIDs: [widget.account.id],
                          ),
                          limit: 5,
                          showGroupDivider: false,

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
                          actions: accountDetailsActions,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
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
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(width: 2, color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: shrinkPercent > 0.5
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: shrinkPercent > 0.5
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
            children: [
              Text(account.name),
              StreamBuilder(
                initialData: 0.0,
                stream: AccountService.instance.getAccountMoney(
                  account: account,
                ),
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 100),
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(
                              fontSize:
                                  32 - (1 - pow(1 - shrinkPercent, 4)) * 15,
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
                                String.fromCharCode(
                                  Icons.currency_exchange_rounded.codePoint,
                                ),
                                style: TextStyle(
                                  fontFamily: Icons
                                      .currency_exchange_rounded
                                      .fontFamily,
                                ),
                              ),
                              const SizedBox(width: 4),
                              CurrencyDisplayer(
                                amountToConvert: currencySnapshot.data!,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          Hero(
            tag: accountIconHeroTag ?? UniqueKey(),
            child: account.displayIcon(
              context,
              size: 48 - (1 - pow(1 - shrinkPercent, 4)) * 20,
            ),
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
  bool shouldRebuild(covariant _AccountDetailHeader oldDelegate) =>
      oldDelegate.account != account;
}

class _UpdateValuationDialog extends StatefulWidget {
  const _UpdateValuationDialog({required this.account});

  final Account account;

  @override
  State<_UpdateValuationDialog> createState() => _UpdateValuationDialogState();
}

class _UpdateValuationDialogState extends State<_UpdateValuationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.account.investment.update_value,
      subtitle: t.account.investment.update_value_descr,
      footer: BottomSheetFooter(
        submitText: t.ui_actions.save,
        onSaved: () async {
          if (!_formKey.currentState!.validate()) return;

          final value = double.tryParse(_valueController.text);
          if (value == null) return;

          await InvestmentService.instance
              .insertValuation(
                ValuationInDB(
                  id: generateUUID(),
                  accountId: widget.account.id,
                  date: _date,
                  value: value,
                ),
              )
              .then((_) {
                RouteUtils.popRoute();
                MonekinSnackbar.success(
                  SnackbarParams(t.account.investment.update_value_success),
                );
              })
              .catchError((err) {
                MonekinSnackbar.error(SnackbarParams.fromError(err));
              });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _valueController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: '${t.account.investment.portfolio_value} *',
                  suffixText: widget.account.currency.symbol,
                ),
                validator: (value) => fieldValidator(
                  value,
                  isRequired: true,
                  validator: ValidatorType.double,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),
              DateTimeFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.event),
                  labelText: '${t.general.time.date} *',
                ),
                initialDate: _date,
                lastDate: DateTime.now(),
                dateFormat: DateFormat.yMMMd().add_jm(),
                validator: (e) =>
                    e == null ? t.general.validations.required : null,
                onDateSelected: (DateTime value) {
                  setState(() {
                    _date = value;
                  });
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
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
        filters: TransactionFilterSet(
          accountsIDs: [widget.account.id],
          minDate: date,
        ),
        convertToPreferredCurrency: false,
      ),
      builder: (context, snapshot) {
        final hasNoTransactions = !snapshot.hasData || snapshot.data! == 0;

        return ModalContainer(
          title: t.account.close.title,
          footer: BottomSheetFooter(
            submitText: t.ui_actions.continue_text,
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
                          RouteUtils.popRoute(true);

                          MonekinSnackbar.success(
                            SnackbarParams(t.account.close.success),
                          );
                        })
                        .catchError((err) {
                          RouteUtils.popRoute();

                          MonekinSnackbar.error(SnackbarParams.fromError(err));
                        });
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
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
