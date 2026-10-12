import 'package:flutter/material.dart';
import 'package:monekin/app/assets/asset_details_page.dart';
import 'package:monekin/app/assets/asset_form.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/account/asset_service.dart';
import 'package:monekin/core/database/services/account/asset_valuation_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/asset/asset_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_floating_button.dart';
import 'package:monekin/core/presentation/responsive/page_content.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/presentation/widgets/valued_item_list.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum AssetsSortOption { nameAsc, nameDesc, valueAsc, valueDesc }

typedef _AssetListEntry = ({Asset asset, double value, double valueVariation});

String _assetIconHeroTag(String assetId) => 'assets-list__asset-icon-$assetId';

class AssetsListPage extends StatefulWidget {
  const AssetsListPage({super.key});

  @override
  State<AssetsListPage> createState() => _AssetsListPageState();
}

class _AssetsListPageState extends State<AssetsListPage> {
  String searchQuery = '';
  AssetsSortOption sortOption = AssetsSortOption.nameAsc;
  bool groupByType = false;
  bool showValueVariation = false;

  final ScrollController _scrollController = ScrollController();

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  Future<void> _goToCreate() async {
    await RouteUtils.showResponsiveForm(const AssetFormPage());
  }

  void _goToDetails(Asset asset) {
    RouteUtils.pushRoute(
      AssetDetailsPage(
        asset: asset,
        assetIconHeroTag: _assetIconHeroTag(asset.id),
      ),
    );
  }

  List<_AssetListEntry> _sortAssets(List<_AssetListEntry> items) {
    // Making the list mutable to be able to sort it
    final sorted = List<_AssetListEntry>.from(items);

    switch (sortOption) {
      case AssetsSortOption.nameAsc:
        sorted.sort((a, b) => a.asset.name.compareTo(b.asset.name));
        break;
      case AssetsSortOption.nameDesc:
        sorted.sort((a, b) => b.asset.name.compareTo(a.asset.name));
        break;
      case AssetsSortOption.valueAsc:
        sorted.sort((a, b) => a.value.compareTo(b.value));
        break;
      case AssetsSortOption.valueDesc:
        sorted.sort((a, b) => b.value.compareTo(a.value));
        break;
    }

    return sorted;
  }

  List<_AssetListEntry> _filterAssets(List<_AssetListEntry> items) {
    if (searchQuery.isEmpty) return items;

    return items
        .where(
          (item) =>
              item.asset.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Stream<List<_AssetListEntry>> _getAssetsWithValue() {
    return AssetService.instance.getAssets().switchMap((assets) {
      if (assets.isEmpty) {
        return Stream.value([]);
      }

      final streams = assets.map((asset) {
        return CombineLatestStream.combine2(
          AssetValuationService.instance.getCurrentAssetValue(asset),
          AssetValuationService.instance.getAssetProfit(asset),
          (currentValue, profit) => (
            asset: asset,
            value: currentValue,
            valueVariation: profit.percent,
          ),
        );
      });

      return CombineLatestStream.list(streams);
    });
  }

  Widget _buildAssetsList(List<_AssetListEntry> assets) {
    const listPadding = EdgeInsets.fromLTRB(16, 0, 16, 96);

    if (!groupByType) {
      return ListView.separated(
        controller: _scrollController,
        padding: listPadding,
        itemCount: assets.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final entry = assets[index];

          return _AssetListTile(
            asset: entry.asset,
            value: entry.value,
            valueVariation: entry.valueVariation,
            showValueVariation: showValueVariation,
            onTap: () => _goToDetails(entry.asset),
          );
        },
      );
    }

    final groupedAssets = <AssetType, List<_AssetListEntry>>{};
    for (final entry in assets) {
      groupedAssets.putIfAbsent(entry.asset.assetType, () => []).add(entry);
    }

    return ListView(
      controller: _scrollController,
      padding: listPadding,
      children: [
        for (final type in AssetType.values)
          if (groupedAssets[type] case final entries?
              when entries.isNotEmpty) ...[
            ValuedItemSectionHeader(
              label: type.displayName(context),
              icon: type.icon(),
              color: type.color(),
              count: entries.length,
            ),
            for (var index = 0; index < entries.length; index++) ...[
              if (index > 0) const SizedBox(height: 10),
              _AssetListTile(
                asset: entries[index].asset,
                value: entries[index].value,
                valueVariation: entries[index].valueVariation,
                showValueVariation: showValueVariation,
                onTap: () => _goToDetails(entries[index].asset),
              ),
            ],
            const SizedBox(height: 18),
          ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.assets.title,
      floatingActionButton: AnimatedFloatingButtonBasedOnScroll(
        onPressed: _goToCreate,
        icon: const Icon(Icons.add_rounded),
        scrollController: _scrollController,
        text: t.assets.create,
      ),
      body: PageContent(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: ValuedItemSummaryCard(
                label: t.assets.total_value,
                icon: Icons.inventory_2_rounded,
                backgroundIcon: Icons.account_balance_rounded,
                value: StreamBuilder(
                  // Includes linked portfolio rows (same economic value is also
                  // inside investment account balances) — intentional for this
                  // “all assets” total.
                  stream: AssetValuationService.instance
                      .getTotalAssetsValueAtDate(),
                  builder: (context, snapshot) {
                    final totalValue = snapshot.data;
                    return Skeletonizer(
                      enabled: !snapshot.hasData,
                      child: CurrencyDisplayer(
                        amountToConvert: totalValue ?? 10000,
                        currency: null,
                        integerStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: ValuedItemListToolbar(
                searchQuery: searchQuery,
                searchHint: t.general.tap_to_search,
                onSearchChanged: _onSearchChanged,
                sortActionItems: [
                  ListTileActionItem(
                    label: t.assets.sort.name_asc,
                    icon: Icons.sort_by_alpha_rounded,
                    selected: sortOption == AssetsSortOption.nameAsc,
                    onClick: () =>
                        setState(() => sortOption = AssetsSortOption.nameAsc),
                  ),
                  ListTileActionItem(
                    label: t.assets.sort.name_desc,
                    icon: Icons.sort_by_alpha_rounded,
                    selected: sortOption == AssetsSortOption.nameDesc,
                    onClick: () =>
                        setState(() => sortOption = AssetsSortOption.nameDesc),
                  ),
                  ListTileActionItem(
                    label: t.assets.sort.value_asc,
                    icon: Icons.trending_up_rounded,
                    selected: sortOption == AssetsSortOption.valueAsc,
                    onClick: () =>
                        setState(() => sortOption = AssetsSortOption.valueAsc),
                  ),
                  ListTileActionItem(
                    label: t.assets.sort.value_desc,
                    icon: Icons.trending_down_rounded,
                    selected: sortOption == AssetsSortOption.valueDesc,
                    onClick: () =>
                        setState(() => sortOption = AssetsSortOption.valueDesc),
                  ),
                ],
                displayActionItems: [
                  ListTileActionItem(
                    label: t.assets.group_by_type,
                    icon: Icons.view_agenda_rounded,
                    role: ListTileActionRole.checkbox,
                    selected: groupByType,
                    onClick: () => setState(() => groupByType = !groupByType),
                  ),
                  ListTileActionItem(
                    label: t.assets.show_value_variation,
                    icon: Icons.percent_rounded,
                    role: ListTileActionRole.checkbox,
                    selected: showValueVariation,
                    onClick: () => setState(
                      () => showValueVariation = !showValueVariation,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _getAssetsWithValue(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var assets = snapshot.data!;
                  assets = _filterAssets(assets);
                  assets = _sortAssets(assets);

                  if (assets.isEmpty) {
                    return NoResults(
                      title: t.general.empty_warn,
                      noSearchResultsVariation: searchQuery.isNotEmpty,
                      description: searchQuery.isNotEmpty
                          ? t.general.search_no_results
                          : t.assets.empty_description,
                    );
                  }

                  return _buildAssetsList(assets);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetListTile extends StatelessWidget {
  const _AssetListTile({
    required this.asset,
    required this.value,
    required this.valueVariation,
    required this.showValueVariation,
    required this.onTap,
  });

  final Asset asset;
  final double value;
  final double valueVariation;
  final bool showValueVariation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final typeColor = asset.assetType.color();

    return ValuedItemListTile(
      onTap: onTap,
      accentColor: typeColor,
      leading: Hero(
        tag: _assetIconHeroTag(asset.id),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: typeColor.withAlpha(28),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(asset.assetType.icon(), color: typeColor, size: 22),
        ),
      ),
      title: Text(
        asset.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        asset.assetType.displayName(context),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CurrencyDisplayer(
            amountToConvert: value,
            currency: asset.currency,
            integerStyle: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
          if (showValueVariation && valueVariation.isFinite)
            TrendingValue(
              percentage: valueVariation,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              padding: EdgeInsets.zero,
            )
          else if (showValueVariation)
            Text(
              '—',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
        ],
      ),
    );
  }
}
