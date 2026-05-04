import 'package:flutter/material.dart';
import 'package:monekin/app/assets/asset_details_page.dart';
import 'package:monekin/app/assets/asset_form.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/animations/animated_floating_button.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

enum AssetsSortOption { nameAsc, nameDesc, valueAsc, valueDesc }

class AssetsListPage extends StatefulWidget {
  const AssetsListPage({super.key});

  @override
  State<AssetsListPage> createState() => _AssetsListPageState();
}

class _AssetsListPageState extends State<AssetsListPage> {
  String searchQuery = '';
  AssetsSortOption sortOption = AssetsSortOption.nameAsc;

  final ScrollController _scrollController = ScrollController();

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void _goToCreate() {
    RouteUtils.pushRoute(const AssetFormPage());
  }

  void _goToDetails(Asset asset) {
    RouteUtils.pushRoute(AssetDetailsPage(asset: asset));
  }

  List<(Asset, double)> _sortAssets(List<(Asset, double)> items) {
    // Making the list mutable to be able to sort it
    final sorted = List<(Asset, double)>.from(items);

    switch (sortOption) {
      case AssetsSortOption.nameAsc:
        sorted.sort((a, b) => a.$1.name.compareTo(b.$1.name));
        break;
      case AssetsSortOption.nameDesc:
        sorted.sort((a, b) => b.$1.name.compareTo(a.$1.name));
        break;
      case AssetsSortOption.valueAsc:
        sorted.sort((a, b) => a.$2.compareTo(b.$2));
        break;
      case AssetsSortOption.valueDesc:
        sorted.sort((a, b) => b.$2.compareTo(a.$2));
        break;
    }

    return sorted;
  }

  List<(Asset, double)> _filterAssets(List<(Asset, double)> items) {
    if (searchQuery.isEmpty) return items;

    return items
        .where(
          (item) =>
              item.$1.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Stream<List<(Asset, double)>> _getAssetsWithValue() {
    return InvestmentService.instance.getAssets().switchMap((assets) {
      if (assets.isEmpty) {
        return Stream.value([]);
      }

      final streams = assets.map((asset) {
        return InvestmentService.instance
            .getCurrentAssetValue(asset)
            .map((value) => (asset, value));
      });

      return CombineLatestStream.list(streams);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isTablet = BreakPoint.of(context).isLargerThan(BreakpointID.sm);

    return PageFramework(
      title: t.assets.title,
      floatingActionButton: !isTablet
          ? AnimatedFloatingButtonBasedOnScroll(
              onPressed: _goToCreate,
              icon: const Icon(Icons.add_rounded),
              scrollController: _scrollController,
              text: t.assets.create,
            )
          : null,
      body: Column(
        children: [
          ListTile(
            title: Text(t.assets.total_value),
            subtitle: StreamBuilder(
              // Includes linked portfolio rows (same economic value is also inside
              // investment account balances) — intentional for this “all assets” total.
              stream: InvestmentService.instance.getTotalAssetsValueAtDate(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final totalValue = snapshot.data!;
                return CurrencyDisplayer(
                  amountToConvert: totalValue,
                  currency: null, // You can set a default currency if needed
                  integerStyle: Theme.of(context).textTheme.headlineMedium!,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [const Divider(thickness: 2)],
            ),
          ),

          // Search bar
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
                            onPressed: () {
                              _onSearchChanged('');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sort option
                MonekinPopupMenuButton(
                  actionItems: [
                    ListTileActionItem(
                      label: t.assets.sort.name_asc,
                      icon: Icons.sort_by_alpha_rounded,
                      onClick: () =>
                          setState(() => sortOption = AssetsSortOption.nameAsc),
                    ),
                    ListTileActionItem(
                      label: t.assets.sort.name_desc,
                      icon: Icons.sort_by_alpha_rounded,
                      onClick: () => setState(
                        () => sortOption = AssetsSortOption.nameDesc,
                      ),
                    ),
                    ListTileActionItem(
                      label: t.assets.sort.value_asc,
                      icon: Icons.trending_up_rounded,
                      onClick: () => setState(
                        () => sortOption = AssetsSortOption.valueAsc,
                      ),
                    ),
                    ListTileActionItem(
                      label: t.assets.sort.value_desc,
                      icon: Icons.trending_down_rounded,
                      onClick: () => setState(
                        () => sortOption = AssetsSortOption.valueDesc,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Assets list
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

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: assets.length,
                  itemBuilder: (context, index) {
                    final asset = assets[index].$1;
                    final value = assets[index].$2;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(asset.name),
                        subtitle: Row(
                          spacing: 4,
                          children: [
                            Icon(asset.assetType.icon(), size: 14),
                            Text(asset.assetType.displayName(context)),
                          ],
                        ),
                        minVerticalPadding: 0,
                        trailing: CurrencyDisplayer(
                          amountToConvert: value,
                          currency: asset.currency,
                          integerStyle: Theme.of(
                            context,
                          ).textTheme.titleMedium!,
                        ),
                        leadingAndTrailingTextStyle: Theme.of(
                          context,
                        ).textTheme.labelLarge,
                        onTap: () => _goToDetails(asset),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
