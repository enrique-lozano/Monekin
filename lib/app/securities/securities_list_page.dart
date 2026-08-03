import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/details/holdings_card.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/securities/security_details_page.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/animations/animated_floating_button.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum SecuritiesSortOption { nameAsc, nameDesc, valueDesc, valueAsc }

/// A security together with its aggregated position across all accounts.
class _SecurityRow {
  _SecurityRow({
    required this.security,
    required this.units,
    required this.marketValue,
    required this.costBasis,
  });

  final SecurityInDB security;
  final double units;
  final double marketValue;
  final double costBasis;

  double get unrealizedPnl => marketValue - costBasis;
  double get unrealizedPnlPercent =>
      costBasis == 0 ? 0 : unrealizedPnl / costBasis;
}

class SecuritiesListPage extends StatefulWidget {
  const SecuritiesListPage({super.key});

  @override
  State<SecuritiesListPage> createState() => _SecuritiesListPageState();
}

class _SecuritiesListPageState extends State<SecuritiesListPage> {
  String searchQuery = '';
  SecuritiesSortOption sortOption = SecuritiesSortOption.valueDesc;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() => searchQuery = query);
  }

  Future<void> _goToCreate() async {
    final created = await showSecurityFormSheet(context);
    if (created != null && mounted) {
      await RouteUtils.pushRoute(SecurityDetailsPage(security: created));
    }
  }

  Stream<List<_SecurityRow>> _getRows() {
    return Rx.combineLatest2(
      SecurityService.instance.getSecurities(),
      HoldingService.instance.getAllHoldings(),
      (List<SecurityInDB> securities, List<HoldingWithSecurity> holdings) {
        return securities.map((security) {
          final positions = holdings.where((h) => h.security.id == security.id);

          return _SecurityRow(
            security: security,
            units: positions.fold<double>(0, (sum, h) => sum + h.quantity),
            marketValue: positions.fold<double>(
              0,
              (sum, h) => sum + h.marketValue,
            ),
            costBasis: positions.fold<double>(0, (sum, h) => sum + h.costBasis),
          );
        }).toList();
      },
    );
  }

  List<_SecurityRow> _filterAndSort(List<_SecurityRow> rows) {
    var result = rows;

    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      result = result
          .where(
            (r) =>
                r.security.name.toLowerCase().contains(q) ||
                (r.security.ticker?.toLowerCase().contains(q) ?? false),
          )
          .toList();
    }

    result = List<_SecurityRow>.from(result);
    switch (sortOption) {
      case SecuritiesSortOption.nameAsc:
        result.sort((a, b) => a.security.name.compareTo(b.security.name));
        break;
      case SecuritiesSortOption.nameDesc:
        result.sort((a, b) => b.security.name.compareTo(a.security.name));
        break;
      case SecuritiesSortOption.valueDesc:
        result.sort((a, b) => b.marketValue.compareTo(a.marketValue));
        break;
      case SecuritiesSortOption.valueAsc:
        result.sort((a, b) => a.marketValue.compareTo(b.marketValue));
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.assets.securities.title,
      floatingActionButton: AnimatedFloatingButtonBasedOnScroll(
        onPressed: _goToCreate,
        icon: const Icon(Icons.add_rounded),
        scrollController: _scrollController,
        text: t.assets.securities.create,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(t.assets.securities.total_value),
            subtitle: StreamBuilder<double>(
              stream: HoldingService.instance.getHoldingsMarketValue(
                convertToPreferred: true,
              ),
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: !snapshot.hasData,
                  child: CurrencyDisplayer(
                    amountToConvert: snapshot.data ?? 10000,
                    integerStyle: Theme.of(context).textTheme.headlineMedium!,
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(thickness: 2),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: SearchBar(
                    onChanged: _onSearchChanged,
                    hintText: t.general.tap_to_search,
                    trailing: [
                      AnimatedExpanded(
                        expand: searchQuery.isNotEmpty,
                        axis: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => _onSearchChanged(''),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MonekinPopupMenuButton(
                  actionItems: [
                    ListTileActionItem(
                      label: t.assets.sort.value_desc,
                      icon: Icons.trending_down_rounded,
                      selected: sortOption == SecuritiesSortOption.valueDesc,
                      onClick: () => setState(
                        () => sortOption = SecuritiesSortOption.valueDesc,
                      ),
                    ),
                    ListTileActionItem(
                      label: t.assets.sort.value_asc,
                      icon: Icons.trending_up_rounded,
                      selected: sortOption == SecuritiesSortOption.valueAsc,
                      onClick: () => setState(
                        () => sortOption = SecuritiesSortOption.valueAsc,
                      ),
                    ),
                    ListTileActionItem(
                      label: t.assets.sort.name_asc,
                      icon: Icons.sort_by_alpha_rounded,
                      selected: sortOption == SecuritiesSortOption.nameAsc,
                      onClick: () => setState(
                        () => sortOption = SecuritiesSortOption.nameAsc,
                      ),
                    ),
                    ListTileActionItem(
                      label: t.assets.sort.name_desc,
                      icon: Icons.sort_by_alpha_rounded,
                      selected: sortOption == SecuritiesSortOption.nameDesc,
                      onClick: () => setState(
                        () => sortOption = SecuritiesSortOption.nameDesc,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<_SecurityRow>>(
              stream: _getRows(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final rows = _filterAndSort(snapshot.data!);

                if (rows.isEmpty) {
                  return NoResults(
                    title: t.general.empty_warn,
                    noSearchResultsVariation: searchQuery.isNotEmpty,
                    description: searchQuery.isNotEmpty
                        ? t.general.search_no_results
                        : t.assets.securities.empty_description,
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: rows.length,
                  itemBuilder: (context, index) =>
                      _buildRow(context, rows[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, _SecurityRow row) {
    final security = row.security;

    return ListTile(
      leading: SecurityAvatar(security: security),
      title: Text(security.name),
      subtitle: Row(
        spacing: 4,
        children: [
          Text(security.type.displayName(context)),
          if (security.ticker != null) ...[
            const Text('·'),
            Text(security.ticker!),
          ],
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CurrencyDisplayer(
            amountToConvert: row.marketValue,
            integerStyle: Theme.of(context).textTheme.titleMedium!,
          ),
          if (row.units > 0)
            TrendingValue(percentage: row.unrealizedPnlPercent, fontSize: 12),
        ],
      ),
      onTap: () =>
          RouteUtils.pushRoute(SecurityDetailsPage(security: security)),
    );
  }
}
