import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/accounts/details/account_details.dart';
import 'package:monekin/app/accounts/widgets/account_group.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Maximum number of rows (accounts and/or account groups) shown inline on the
/// dashboard.
const _maxRowsToShow = 3;

/// A vertical list of the user's active accounts (up to [_maxRowsToShow] rows),
/// where the accounts sharing a group are collapsed into an expandable row.
class DashboardAccountList extends StatelessWidget {
  const DashboardAccountList({super.key, required this.dateRangeService});

  final DatePeriodState dateRangeService;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
      stream: AccountService.instance.getAccounts(
        predicate: (acc, curr) => acc.closingDate.isNull(),
      ),
      builder: (context, snapshot) {
        final accounts = snapshot.data;
        final rows = accounts == null ? null : groupAccounts(accounts);
        final hasHiddenRows = (rows?.length ?? 0) > _maxRowsToShow;

        return CardWithHeader(
          title: t.home.my_accounts,
          bodyPadding: const EdgeInsets.only(top: 4, bottom: 8),
          headerAction: hasHiddenRows
              ? CardHeaderAction(
                  icon: const Icon(Icons.add_rounded),
                  text: t.account.form.create,
                  onTap: () => RouteUtils.pushRoute(const AccountFormPage()),
                )
              : null,
          footer: hasHiddenRows
              ? CardFooterWithSingleButton(
                  text: t.ui_actions.see_all_count(n: accounts!.length),
                  onButtonClick: () =>
                      RouteUtils.pushRoute(const AllAccountsPage()),
                )
              : null,
          body: Column(
            children: [
              if (rows == null)
                for (var i = 0; i < 3; i++) const _AccountRowSkeleton()
              else
                for (final row in rows.take(_maxRowsToShow))
                  if (row.groupName == null || row.accounts.length == 1)
                    _AccountRow(
                      account: row.accounts.first,
                      dateRangeService: dateRangeService,
                    )
                  else
                    _AccountGroupRow(
                      groupName: row.groupName!,
                      accounts: row.accounts,
                      dateRangeService: dateRangeService,
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _AccountRow extends StatelessWidget {
  const _AccountRow({required this.account, required this.dateRangeService});

  final Account account;
  final DatePeriodState dateRangeService;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'dashboard-page__account-icon-${account.id}',
        child: account.displayIcon(context, size: 26),
      ),
      title: Text(account.name),
      subtitle: Text(account.type.title(context)),
      onTap: () => RouteUtils.pushRoute(
        AccountDetailsPage(
          account: account,
          accountIconHeroTag: 'dashboard-page__account-icon-${account.id}',
          dateRangeService: dateRangeService,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StreamBuilder(
            initialData: 0.0,
            stream: AccountService.instance.getAccountMoney(account: account),
            builder: (context, snapshot) {
              final amount = snapshot.data ?? 0.0;

              return CurrencyDisplayer(
                amountToConvert: amount,
                currency: account.currency,
                compactView: amount >= 10000000,
                integerStyle: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
              );
            },
          ),
          StreamBuilder(
            initialData: 0.0,
            stream: AccountService.instance.getAccountsBalanceRelativeChange(
              accounts: [account],
              startDate: dateRangeService.startDate,
              endDate: dateRangeService.endDate,
              convertToPreferredCurrency: false,
            ),
            builder: (context, snapshot) {
              return TrendingValue(
                percentage: snapshot.data ?? 0,
                decimalDigits: 0,
                fontSize: 12,
                padding: EdgeInsets.zero,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// An expandable row that aggregates all the accounts of a group.
class _AccountGroupRow extends StatefulWidget {
  const _AccountGroupRow({
    required this.groupName,
    required this.accounts,
    required this.dateRangeService,
  });

  final String groupName;
  final List<Account> accounts;
  final DatePeriodState dateRangeService;

  @override
  State<_AccountGroupRow> createState() => _AccountGroupRowState();
}

class _AccountGroupRowState extends State<_AccountGroupRow> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    // Only a group whose accounts all share one currency can be summed as it
    // is; anything else has to go through the user preferred currency.
    final currencies = widget.accounts.map((a) => a.currency.code).toSet();
    final sharedCurrency = currencies.length == 1
        ? widget.accounts.first.currency
        : null;

    return ExpansionTile(
      key: ValueKey('dashboard-page__account-group-${widget.groupName}'),
      shape: const Border(),
      collapsedShape: const Border(),
      childrenPadding: const EdgeInsets.only(left: 16),
      onExpansionChanged: (value) => setState(() => _isExpanded = value),
      leading: accountGroupIcon(context, widget.accounts, size: 26),
      // The expand affordance lives next to the name so the balance stays the
      // rightmost element, aligned with the standalone account rows.
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              widget.groupName,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(width: 4),
          AnimatedRotation(
            turns: _isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.expand_more,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      subtitle: Text(t.account.group.accounts_count(n: widget.accounts.length)),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StreamBuilder(
            initialData: 0.0,
            stream: AccountService.instance.getAccountsMoney(
              accountIds: widget.accounts.map((a) => a.id),
              convertToPreferredCurrency: sharedCurrency == null,
            ),
            builder: (context, snapshot) {
              final amount = snapshot.data ?? 0.0;

              return CurrencyDisplayer(
                amountToConvert: amount,
                currency: sharedCurrency,
                compactView: amount >= 10000000,
                integerStyle: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
              );
            },
          ),
          StreamBuilder(
            initialData: 0.0,
            stream: AccountService.instance.getAccountsBalanceRelativeChange(
              accounts: widget.accounts,
              startDate: widget.dateRangeService.startDate,
              endDate: widget.dateRangeService.endDate,
              convertToPreferredCurrency: sharedCurrency == null,
            ),
            builder: (context, snapshot) {
              return TrendingValue(
                percentage: snapshot.data ?? 0,
                decimalDigits: 0,
                fontSize: 12,
                padding: EdgeInsets.zero,
              );
            },
          ),
        ],
      ),
      children: [
        for (final account in widget.accounts)
          _AccountRow(
            account: account,
            dateRangeService: widget.dateRangeService,
          ),
      ],
    );
  }
}

class _AccountRowSkeleton extends StatelessWidget {
  const _AccountRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            const Bone.circle(size: 40),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone.text(width: 120),
                  const SizedBox(height: 4),
                  Bone.text(width: 70),
                ],
              ),
            ),
            Bone.text(width: 60),
          ],
        ),
      ),
    );
  }
}
