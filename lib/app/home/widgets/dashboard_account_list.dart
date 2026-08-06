import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/all_accounts_page.dart';
import 'package:monekin/app/accounts/details/account_details.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Maximum number of accounts shown inline on the dashboard.
const _maxAccountsToShow = 3;

/// A vertical list of the user's active accounts (up to [_maxAccountsToShow]),
/// replacing the old horizontally-scrollable account cards.
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
        final total = accounts?.length ?? 0;
        final visible = accounts?.take(_maxAccountsToShow).toList();

        return CardWithHeader(
          title: t.home.my_accounts,
          bodyPadding: const EdgeInsets.only(top: 4, bottom: 8),
          headerAction: total > _maxAccountsToShow
              ? CardHeaderAction(
                  icon: const Icon(Icons.add_rounded),
                  text: t.account.form.create,
                  onTap: () => RouteUtils.pushRoute(const AccountFormPage()),
                )
              : null,
          footer: total > _maxAccountsToShow
              ? CardFooterWithSingleButton(
                  text: t.ui_actions.see_all_count(n: total),
                  onButtonClick: () =>
                      RouteUtils.pushRoute(const AllAccountsPage()),
                )
              : null,
          body: Column(
            children: [
              if (accounts == null)
                for (var i = 0; i < 3; i++) const _AccountRowSkeleton()
              else ...[
                for (final account in visible!)
                  _AccountRow(
                    account: account,
                    dateRangeService: dateRangeService,
                  ),
              ],
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
