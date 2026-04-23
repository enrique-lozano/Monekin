import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/details/account_details_actions.dart';
import 'package:monekin/app/accounts/details/investment_history_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/label_value_info_list.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/date_utils.dart';
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
                text: t.account.investment.history,
                onButtonClick: () {
                  RouteUtils.pushRoute(InvestmentHistoryPage(account: account));
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
                            getMMMdDateFormatBasedOnYear(
                              latestValuation.date,
                            ).format(latestValuation.date),
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

    return StreamBuilder(
      stream: AccountService.instance.getAccountById(widget.account.id),
      initialData: widget.account,
      builder: (context, snapshot) {
        final account = snapshot.data ?? widget.account;

        final accountDetailsActions =
            AccountDetailsActions.getAccountDetailsActions(
              context,
              account: account,
              navigateBackOnDelete: true,
            );

        final primaryActions = accountDetailsActions.primary;
        final desktopChips = accountDetailsActions.desktopChips;
        final menuActions = accountDetailsActions.menu;

        return PageFramework(
          title: t.account.details,
          appBarActions: [
            IconButton(
              icon: Icon(Icons.edit_rounded),
              tooltip: t.ui_actions.edit,
              onPressed: () =>
                  RouteUtils.pushRoute(AccountFormPage(account: account)),
            ),
            if (menuActions.isNotEmpty)
              MonekinPopupMenuButton(
                actionItems: [
                  if (BreakPoint.of(context).isSmallerThan(BreakpointID.md))
                    ...desktopChips,
                  ...menuActions,
                ],
              ),
          ],
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ).withSafeBottom(context),
                children: [
                  Column(
                    children: [
                      Hero(
                        tag: widget.accountIconHeroTag ?? UniqueKey(),
                        child: account.displayIcon(context, size: 48),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        account.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      StreamBuilder(
                        initialData: 0.0,
                        stream: AccountService.instance.getAccountMoney(
                          account: account,
                        ),
                        builder: (context, balanceSnapshot) {
                          return Column(
                            children: [
                              DefaultTextStyle.merge(
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium!,
                                child: CurrencyDisplayer(
                                  amountToConvert: balanceSnapshot.data!,
                                  currency: account.currency,
                                ),
                              ),
                              StreamBuilder(
                                stream: ExchangeRateService.instance
                                    .calculateExchangeRateToPreferredCurrency(
                                      amount: balanceSnapshot.data!,
                                      fromCurrency: account.currency.code,
                                    ),
                                builder: (context, currencySnapshot) {
                                  if (currencySnapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      currencySnapshot.data != 0 &&
                                          currencySnapshot.data! ==
                                              balanceSnapshot.data ||
                                      balanceSnapshot.data! == 0) {
                                    return const SizedBox.shrink();
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.currency_exchange_rounded,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        CurrencyDisplayer(
                                          amountToConvert:
                                              currencySnapshot.data!,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8,
                            children: [
                              ...primaryActions.map(
                                (action) => ActionChip(
                                  avatar: Icon(action.icon, size: 18),
                                  label: Text(action.label),
                                  onPressed: action.onClick,
                                ),
                              ),
                              if (desktopChips.isNotEmpty &&
                                  BreakPoint.of(
                                    context,
                                  ).isLargerOrEqualTo(BreakpointID.sm))
                                ...desktopChips.map(
                                  (action) => ActionChip(
                                    avatar: Icon(action.icon, size: 18),
                                    label: Text(action.label),
                                    onPressed: action.onClick,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  Builder(
                    builder: (context) {
                      final isWideScreen = BreakPoint.of(
                        context,
                      ).isLargerThan(BreakpointID.md);

                      final infoCard = CardWithHeader(
                        title: 'Info',
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
                      );

                      const transactionsToShow = 4;

                      final transactionsCard = CardWithHeader(
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
                            if (!snapshot.hasData ||
                                snapshot.data! < transactionsToShow) {
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
                          limit: transactionsToShow,
                          showGroupDivider: false,
                          onEmptyList: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              t.transaction.list.empty,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );

                      return ResponsiveRowColumn.withSymetricSpacing(
                        spacing: 16,
                        rowCrossAxisAlignment: CrossAxisAlignment.start,
                        direction: isWideScreen
                            ? Axis.horizontal
                            : Axis.vertical,
                        children: [
                          ResponsiveRowColumnItem(
                            rowFit: FlexFit.tight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 16,
                              children: [
                                if (account.type == AccountType.investment)
                                  _buildInvestmentCard(context, account),
                                infoCard,
                              ],
                            ),
                          ),
                          ResponsiveRowColumnItem(
                            rowFit: FlexFit.tight,
                            child: transactionsCard,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
