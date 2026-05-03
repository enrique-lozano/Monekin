import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class NetWorthCompositionCard extends StatelessWidget {
  const NetWorthCompositionCard({
    super.key,
    required this.filters,
    required this.dateRangeService,
  });

  final TransactionFilterSet filters;
  final DatePeriodState dateRangeService;

  Future<_NetWorthCompositionData> _loadCompositionData() async {
    final date = dateRangeService.endDate ?? DateTime.now();
    final preferredCurrency = await CurrencyService.instance
        .ensureAndGetPreferredCurrency()
        .first;

    final accounts = await AccountService.instance
        .getAccounts(
          predicate: (account, currency) =>
              account.type.isNotValue(AccountType.investment.name),
        )
        .first;

    final accountItems = await Future.wait(
      accounts.map((account) async {
        final amount = await AccountService.instance
            .getAccountMoney(
              account: account,
              date: date,
              convertToPreferredCurrency: true,
            )
            .first;
        return _BreakdownItem(title: account.name, amount: amount);
      }),
    );

    final investmentAccounts = await AccountService.instance
        .getAccounts(
          predicate: (account, currency) =>
              account.type.equals(AccountType.investment.name),
        )
        .first;

    final investmentItems = await Future.wait(
      investmentAccounts.map((account) async {
        final amount = await AccountService.instance
            .getAccountMoney(
              account: account,
              date: date,
              convertToPreferredCurrency: true,
            )
            .first;
        return _BreakdownItem(title: account.name, amount: amount);
      }),
    );

    final assets = await InvestmentService.instance
        .getAssets(predicate: (a, curr) => a.linkedAccountID.isNull())
        .first;
    final assetItems = await Future.wait(
      assets.map((asset) async {
        final value = await InvestmentService.instance
            .getAssetValueAtDate(
              asset,
              date: date,
              convertToPreferredCurrency: true,
            )
            .first;

        return _BreakdownItem(title: asset.name, amount: value);
      }),
    );

    return _NetWorthCompositionData(
      preferredCurrency: preferredCurrency,
      accountItems: accountItems,
      investmentItems: investmentItems,
      assetItems: assetItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FutureBuilder<_NetWorthCompositionData>(
      future: _loadCompositionData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 260,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!;
        final totalAccounts = data.accountItems.fold<double>(
          0,
          (sum, item) => sum + item.amount,
        );
        final totalInvestments = data.investmentItems.fold<double>(
          0,
          (sum, item) => sum + item.amount,
        );
        final totalAssets = data.assetItems.fold<double>(
          0,
          (sum, item) => sum + item.amount,
        );

        final sections = <PieChartSectionData>[];
        if (totalAccounts > 0) {
          sections.add(
            _section(0, totalAccounts, Theme.of(context).colorScheme.primary),
          );
        }
        if (totalInvestments > 0) {
          sections.add(
            _section(
              1,
              totalInvestments,
              Theme.of(context).colorScheme.secondary,
            ),
          );
        }
        if (totalAssets > 0) {
          sections.add(
            _section(2, totalAssets, Theme.of(context).colorScheme.tertiary),
          );
        }

        if (sections.isEmpty) {
          return Center(child: Text(t.general.insufficient_data));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 260,
              child: PieChart(
                PieChartData(
                  startDegreeOffset: -90,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: sections,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildLegend(
                  context,
                  t.general.accounts,
                  totalAccounts,
                  Theme.of(context).colorScheme.primary,
                ),
                _buildLegend(
                  context,
                  t.account.types.investment,
                  totalInvestments,
                  Theme.of(context).colorScheme.secondary,
                ),
                _buildLegend(
                  context,
                  t.assets.title,
                  totalAssets,
                  Theme.of(context).colorScheme.tertiary,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  PieChartSectionData _section(int index, double value, Color color) {
    return PieChartSectionData(
      color: color,
      value: value,
      radius: 56,
      showTitle: false,
    );
  }

  Widget _buildLegend(
    BuildContext context,
    String label,
    double value,
    Color color,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 6),
            CurrencyDisplayer(amountToConvert: value),
          ],
        ),
      ],
    );
  }

  Widget _buildBreakdownRow(BuildContext context, _BreakdownItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              item.title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CurrencyDisplayer(amountToConvert: item.amount),
        ],
      ),
    );
  }
}

class _BreakdownItem {
  _BreakdownItem({required this.title, required this.amount});

  final String title;
  final double amount;
}

class _NetWorthCompositionData {
  _NetWorthCompositionData({
    required this.preferredCurrency,
    required this.accountItems,
    required this.investmentItems,
    required this.assetItems,
  });

  final CurrencyInDB preferredCurrency;
  final List<_BreakdownItem> accountItems;
  final List<_BreakdownItem> investmentItems;
  final List<_BreakdownItem> assetItems;
}
