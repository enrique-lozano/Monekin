import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/asset_service.dart';
import 'package:monekin/core/database/services/account/asset_valuation_service.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/pie_chart_center_shade.dart';
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

    final allAccounts = await AccountService.instance.getAccounts().first;
    final accountFilter = filters.accountsIDs;
    final accounts = accountFilter == null
        ? allAccounts
        : allAccounts.where((a) => accountFilter.contains(a.id)).toList();

    final cashAndInvestmentItems = await Future.wait(
      accounts.map((account) async {
        final values = await Future.wait([
          AccountService.instance
              .getAccountMoney(
                account: account,
                date: date,
                convertToPreferredCurrency: true,
                trFilters: filters,
              )
              .first,
          HoldingService.instance
              .getHoldingsMarketValue(
                accountIds: [account.id],
                convertToPreferred: true,
                date: date,
              )
              .first,
        ]);

        final accountTotal = values[0];
        final holdings = values[1];
        return (
          cash: _BreakdownItem(
            title: account.name,
            amount: accountTotal - holdings,
          ),
          investments: _BreakdownItem(title: account.name, amount: holdings),
        );
      }),
    );

    final assets = await AssetService.instance.getAssets().first;
    final assetItems = await Future.wait(
      assets.map((asset) async {
        final value = await AssetValuationService.instance
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
      cashItems: cashAndInvestmentItems.map((item) => item.cash).toList(),
      investmentItems: cashAndInvestmentItems
          .map((item) => item.investments)
          .toList(),
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
        final totalCash = data.cashItems.fold<double>(
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
        if (totalCash > 0) {
          sections.add(
            _section(0, totalCash, Theme.of(context).colorScheme.primary),
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

        final chart = SizedBox(
          height: 260,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  startDegreeOffset: -90,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: sections,
                ),
              ),
              const PieChartCenterShade(centerSpaceRadius: 40),
            ],
          ),
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            final isRow = constraints.maxWidth >= 520;

            final legendItems = [
              _buildLegend(
                context,
                t.account.cash,
                totalCash,
                Theme.of(context).colorScheme.primary,
                fullWidth: isRow,
              ),
              _buildLegend(
                context,
                t.account.investments,
                totalInvestments,
                Theme.of(context).colorScheme.secondary,
                fullWidth: isRow,
              ),
              _buildLegend(
                context,
                t.assets.title,
                totalAssets,
                Theme.of(context).colorScheme.tertiary,
                fullWidth: isRow,
              ),
            ];

            if (isRow) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: chart),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 12,
                        children: legendItems,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chart,
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 8, children: legendItems),
                const SizedBox(height: 16),
              ],
            );
          },
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
    Color color, {
    required bool fullWidth,
  }) {
    final labelWidget = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    return Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        if (fullWidth) Expanded(child: labelWidget) else labelWidget,
        const SizedBox(width: 6),
        CurrencyDisplayer(amountToConvert: value),
      ],
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
    required this.cashItems,
    required this.investmentItems,
    required this.assetItems,
  });

  final CurrencyInDB preferredCurrency;
  final List<_BreakdownItem> cashItems;
  final List<_BreakdownItem> investmentItems;
  final List<_BreakdownItem> assetItems;
}
