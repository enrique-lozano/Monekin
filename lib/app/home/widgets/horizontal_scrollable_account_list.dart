import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/details/account_details.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class HorizontalScrollableAccountList extends StatelessWidget {
  const HorizontalScrollableAccountList({required this.dateRangeService});

  final DatePeriodState dateRangeService;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final borderRadius = BorderRadius.circular(getCardBorderRadius());

    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: StreamBuilder(
          stream: AccountService.instance.getAccounts(
            predicate: (acc, curr) => acc.closingDate.isNull(),
          ),
          builder: (context, snapshot) {
            return Row(
              children: [
                ...List.generate(snapshot.data?.length ?? 0, (index) {
                  final account = snapshot.data!.elementAt(index);

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      boxShadow: boxShadowGeneral(context),
                    ),
                    child: Card(
                      margin: const EdgeInsets.only(right: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: borderRadius),
                      child: Tappable(
                        onTap: () => RouteUtils.pushRoute(
                          context,
                          AccountDetailsPage(
                            account: account,
                            accountIconHeroTag:
                                'dashboard-page__account-icon-${account.id}',
                          ),
                        ),
                        bgColor: Theme.of(context).cardColor,
                        borderRadius: borderRadius,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: 250,
                            child: Row(
                              children: [
                                Hero(
                                  tag:
                                      'dashboard-page__account-icon-${account.id}',
                                  child: account.displayIcon(context, size: 28),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      account.name,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelLarge,
                                    ),
                                    Row(
                                      children: [
                                        StreamBuilder(
                                          initialData: 0.0,
                                          stream: AccountService.instance
                                              .getAccountMoney(
                                                account: account,
                                              ),
                                          builder: (context, snapshot) {
                                            return CurrencyDisplayer(
                                              amountToConvert: snapshot.data!,
                                              currency: account.currency,
                                              compactView:
                                                  snapshot.data! >= 10000000,
                                              integerStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        StreamBuilder(
                                          initialData: 0.0,
                                          stream: AccountService.instance
                                              .getAccountsMoneyVariation(
                                                accounts: [account],
                                                startDate:
                                                    dateRangeService.startDate,
                                                endDate:
                                                    dateRangeService.endDate,
                                                convertToPreferredCurrency:
                                                    false,
                                              ),
                                          builder: (context, snapshot) {
                                            return TrendingValue(
                                              percentage: snapshot.data!,
                                              decimalDigits: 0,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                // Add account card
                Opacity(
                  opacity: 0.6,
                  child: Tappable(
                    onTap: () {
                      RouteUtils.pushRoute(context, const AccountFormPage());
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadius,
                      side: BorderSide(
                        width: 2,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      margin: const EdgeInsets.all(0),
                      child: SizedBox(
                        width: 200,
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(t.account.form.create),
                            const SizedBox(height: 4),
                            const Icon(Icons.add),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
