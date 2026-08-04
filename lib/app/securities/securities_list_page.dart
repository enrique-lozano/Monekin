import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/securities/security_details_page.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/app/securities/widgets/security_form_sheet.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_floating_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/valued_item_list.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum SecuritiesSortOption { nameAsc, nameDesc, valueDesc, valueAsc }

String _securityAvatarHeroTag(String securityId) =>
    'securities-list__security-avatar-$securityId';

/// A security together with its aggregated position across all accounts.
class _SecurityRow {
  _SecurityRow({required this.security, required this.marketValue});

  final SecurityInDB security;
  final double marketValue;
}

class SecuritiesListPage extends StatefulWidget {
  const SecuritiesListPage({super.key});

  @override
  State<SecuritiesListPage> createState() => _SecuritiesListPageState();
}

class _SecuritiesListPageState extends State<SecuritiesListPage> {
  String searchQuery = '';
  SecuritiesSortOption sortOption = SecuritiesSortOption.valueDesc;
  bool groupByType = false;

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
            marketValue: positions.fold<double>(
              0,
              (sum, h) => sum + h.marketValue,
            ),
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

  Widget _buildSecuritiesList(BuildContext context, List<_SecurityRow> rows) {
    const listPadding = EdgeInsets.fromLTRB(16, 0, 16, 96);

    if (!groupByType) {
      return ListView.separated(
        controller: _scrollController,
        padding: listPadding,
        itemCount: rows.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) => _buildRow(context, rows[index]),
      );
    }

    final groupedRows = <SecurityType, List<_SecurityRow>>{};
    for (final row in rows) {
      groupedRows.putIfAbsent(row.security.type, () => []).add(row);
    }

    return ListView(
      controller: _scrollController,
      padding: listPadding,
      children: [
        for (final type in SecurityType.values)
          if (groupedRows[type] case final entries?
              when entries.isNotEmpty) ...[
            ValuedItemSectionHeader(
              label: type.displayName(context),
              icon: type.icon(),
              color: type.color(),
              count: entries.length,
            ),
            for (var index = 0; index < entries.length; index++) ...[
              if (index > 0) const SizedBox(height: 10),
              _buildRow(context, entries[index]),
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
      title: t.assets.securities.title,
      floatingActionButton: AnimatedFloatingButtonBasedOnScroll(
        onPressed: _goToCreate,
        icon: const Icon(Icons.add_rounded),
        scrollController: _scrollController,
        text: t.assets.securities.create,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: ValuedItemSummaryCard(
                  label: t.assets.securities.total_value,
                  icon: Icons.show_chart_rounded,
                  backgroundIcon: Icons.account_balance_wallet_rounded,
                  value: StreamBuilder<double>(
                    stream: HoldingService.instance.getHoldingsMarketValue(
                      convertToPreferred: true,
                    ),
                    builder: (context, snapshot) {
                      return Skeletonizer(
                        enabled: !snapshot.hasData,
                        child: CurrencyDisplayer(
                          amountToConvert: snapshot.data ?? 10000,
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
                  displayActionItems: [
                    ListTileActionItem(
                      label: t.assets.securities.group_by_type,
                      icon: Icons.view_agenda_rounded,
                      role: ListTileActionRole.checkbox,
                      selected: groupByType,
                      onClick: () => setState(() => groupByType = !groupByType),
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

                    return _buildSecuritiesList(context, rows);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, _SecurityRow row) {
    final security = row.security;
    final scheme = Theme.of(context).colorScheme;
    final typeColor = security.type.color();

    return ValuedItemListTile(
      accentColor: typeColor,
      leading: Hero(
        tag: _securityAvatarHeroTag(security.id),
        child: SecurityAvatar(security: security, size: 44),
      ),
      title: Text(
        security.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Flexible(
            child: Text(
              security.type.displayName(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          if (security.ticker != null) ...[
            Text('·', style: TextStyle(color: scheme.onSurfaceVariant)),
            Flexible(
              child: Text(
                security.ticker!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ],
      ),
      trailing: CurrencyDisplayer(
        amountToConvert: row.marketValue,
        integerStyle: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
      ),
      onTap: () => RouteUtils.pushRoute(
        SecurityDetailsPage(
          security: security,
          securityAvatarHeroTag: _securityAvatarHeroTag(security.id),
        ),
      ),
    );
  }
}
