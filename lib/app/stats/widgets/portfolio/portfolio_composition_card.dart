import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/taxonomy/taxonomy_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// One slice of the portfolio composition (a security, a security type or a
/// classification category), with amounts already converted to the user's
/// preferred currency.
class _Slice {
  _Slice({
    required this.label,
    required this.market,
    required this.cost,
    this.color,
  });

  final String label;
  double market;
  double cost;

  /// Explicit slice color (used by classification categories). When null the
  /// card falls back to its rotating palette.
  final Color? color;

  double get pnl => market - cost;
  double get pnlPercent => cost == 0 ? 0 : pnl / cost;
}

enum _GroupBy { security, type, account, classification }

class PortfolioCompositionCard extends StatefulWidget {
  const PortfolioCompositionCard({super.key, this.date});

  /// Value the composition as of this date. Defaults to now when null.
  final DateTime? date;

  @override
  State<PortfolioCompositionCard> createState() =>
      _PortfolioCompositionCardState();
}

class _PortfolioCompositionCardState extends State<PortfolioCompositionCard> {
  _GroupBy _groupBy = _GroupBy.security;
  int _touchedIndex = -1;

  /// Taxonomies available for the "By classification" grouping, loaded once.
  List<TaxonomyInDB> _taxonomies = const [];
  String? _selectedTaxonomyId;

  @override
  void initState() {
    super.initState();
    _loadTaxonomies();
  }

  Future<void> _loadTaxonomies() async {
    final taxonomies = await TaxonomyService.instance.getTaxonomies().first;
    if (!mounted) return;
    setState(() {
      _taxonomies = taxonomies;
      _selectedTaxonomyId ??= taxonomies.isEmpty ? null : taxonomies.first.id;
    });
  }

  static const _palette = [
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pink,
    Colors.amber,
    Colors.cyan,
  ];

  Future<List<_Slice>> _load() async {
    // Resolve context-dependent labels up-front so we don't touch context
    // after an await.
    final typeLabels = {
      for (final st in SecurityType.values) st: st.displayName(context),
    };
    final unclassifiedLabel = Translations.of(
      context,
    ).assets.securities.classification.unclassified;

    final holdings = await HoldingService.instance
        .getHoldingValuationsAtDate(widget.date)
        .first;

    // Convert every holding's market/cost to the preferred currency once.
    final converted =
        <
          ({
            String securityId,
            String accountId,
            SecurityType type,
            String securityName,
            double market,
            double cost,
          })
        >[];
    for (final h in holdings) {
      if (h.market == 0 && h.cost == 0) continue;

      final market = await ExchangeRateService.instance
          .calculateExchangeRateToPreferredCurrency(
            amount: h.market,
            fromCurrency: h.currencyId,
            date: widget.date,
          )
          .first;
      final cost = h.cost == 0
          ? 0.0
          : await ExchangeRateService.instance
                .calculateExchangeRateToPreferredCurrency(
                  amount: h.cost,
                  fromCurrency: h.currencyId,
                  date: widget.date,
                )
                .first;

      converted.add((
        securityId: h.securityId,
        accountId: h.accountId,
        type: h.securityType,
        securityName: h.securityName,
        market: market,
        cost: cost,
      ));
    }

    if (_groupBy == _GroupBy.classification) {
      return _buildClassificationSlices(converted, unclassifiedLabel);
    }

    final accountNames = _groupBy == _GroupBy.account
        ? {
            for (final a in await AccountService.instance.getAccounts().first)
              a.id: a.name,
          }
        : const <String, String>{};

    final map = <String, _Slice>{};

    for (final h in converted) {
      final key = switch (_groupBy) {
        _GroupBy.type => h.type.name,
        _GroupBy.account => h.accountId,
        _GroupBy.security || _GroupBy.classification => h.securityId,
      };
      final label = switch (_groupBy) {
        _GroupBy.type => typeLabels[h.type] ?? h.type.name,
        _GroupBy.account => accountNames[h.accountId] ?? h.accountId,
        _GroupBy.security || _GroupBy.classification => h.securityName,
      };

      final existing = map[key];
      if (existing == null) {
        map[key] = _Slice(label: label, market: h.market, cost: h.cost);
      } else {
        existing.market += h.market;
        existing.cost += h.cost;
      }
    }

    final slices = map.values.where((s) => s.market != 0).toList()
      ..sort((a, b) => b.market.compareTo(a.market));

    return slices;
  }

  /// Splits each holding's market/cost across its assigned categories of the
  /// selected taxonomy by their weight; any unallocated remainder rolls into an
  /// "Unclassified" slice.
  Future<List<_Slice>> _buildClassificationSlices(
    List<
      ({
        String securityId,
        String accountId,
        SecurityType type,
        String securityName,
        double market,
        double cost,
      })
    >
    converted,
    String unclassifiedLabel,
  ) async {
    final taxonomyId = _selectedTaxonomyId;
    if (taxonomyId == null) return const [];

    final categories = await TaxonomyService.instance
        .getCategories(taxonomyId)
        .first;
    final categoryById = {for (final c in categories) c.id: c};

    final assignments = await TaxonomyService.instance
        .getAssignmentsForTaxonomy(taxonomyId)
        .first;
    final bySecurity = <String, List<SecurityTaxonomyAssignmentInDB>>{};
    for (final a in assignments) {
      bySecurity.putIfAbsent(a.securityID, () => []).add(a);
    }

    final map = <String, _Slice>{};

    void addSlice({
      required String key,
      required String label,
      Color? color,
      required double market,
      required double cost,
    }) {
      final existing = map[key];
      if (existing == null) {
        map[key] = _Slice(
          label: label,
          market: market,
          cost: cost,
          color: color,
        );
      } else {
        existing.market += market;
        existing.cost += cost;
      }
    }

    for (final h in converted) {
      final list = bySecurity[h.securityId] ?? const [];

      var allocatedFraction = 0.0;
      for (final a in list) {
        final fraction = a.weight / 10000;
        allocatedFraction += fraction;

        final category = categoryById[a.categoryID];
        addSlice(
          key: a.categoryID,
          label: category?.name ?? '—',
          color: category == null ? null : ColorHex.get(category.color),
          market: h.market * fraction,
          cost: h.cost * fraction,
        );
      }

      final leftover = 1 - allocatedFraction;
      if (leftover > 0.0001) {
        addSlice(
          key: '__unclassified',
          label: unclassifiedLabel,
          color: Colors.grey,
          market: h.market * leftover,
          cost: h.cost * leftover,
        );
      }
    }

    final slices = map.values.where((s) => s.market != 0).toList()
      ..sort((a, b) => b.market.compareTo(a.market));

    return slices;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FutureBuilder<List<_Slice>>(
      future: _load(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 260,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final slices = snapshot.data!;

        if (slices.isEmpty) {
          return SizedBox(
            height: 260,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 35,
                    sections: [
                      PieChartSectionData(
                        color: Colors.grey.withOpacity(0.175),
                        value: 100,
                        radius: 50,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 35 * 2.25,
                    height: 35 * 2.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withOpacity(0.1),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    t.general.insufficient_data,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          );
        }

        final total = slices.fold<double>(0, (sum, s) => sum + s.market);
        final totalCost = slices.fold<double>(0, (sum, s) => sum + s.cost);
        final totalPnl = total - totalCost;
        final totalPnlPct = totalCost == 0 ? 0.0 : totalPnl / totalCost;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: ExpandingSegmentedTabs<_GroupBy>(
                fullWidth: false,
                items: [
                  SegmentedTabItem(
                    value: _GroupBy.security,
                    icon: Icons.show_chart_rounded,
                    label: t.assets.securities.by_security,
                  ),
                  SegmentedTabItem(
                    value: _GroupBy.type,
                    icon: Icons.category_outlined,
                    label: t.assets.securities.by_type,
                  ),
                  SegmentedTabItem(
                    value: _GroupBy.account,
                    icon: Icons.account_balance_wallet_outlined,
                    label: t.assets.securities.by_account,
                  ),
                  if (_taxonomies.isNotEmpty)
                    SegmentedTabItem(
                      value: _GroupBy.classification,
                      icon: Icons.donut_small_outlined,
                      label: t.assets.securities.by_classification,
                    ),
                ],
                selected: _groupBy,
                onSelected: (value) {
                  setState(() {
                    _groupBy = value;
                    _touchedIndex = -1;
                  });
                },
              ),
            ),
            if (_groupBy == _GroupBy.classification &&
                _taxonomies.isNotEmpty) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  value: _selectedTaxonomyId,
                  borderRadius: BorderRadius.circular(12),
                  items: [
                    for (final taxonomy in _taxonomies)
                      DropdownMenuItem(
                        value: taxonomy.id,
                        child: Text(taxonomy.name),
                      ),
                  ],
                  onChanged: (value) => setState(() {
                    _selectedTaxonomyId = value;
                    _touchedIndex = -1;
                  }),
                ),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 60,
                      pieTouchData: PieTouchData(
                        touchCallback: (event, response) {
                          setState(() {
                            _touchedIndex =
                                response?.touchedSection?.touchedSectionIndex ??
                                -1;
                          });
                        },
                      ),
                      sections: [
                        for (var i = 0; i < slices.length; i++)
                          PieChartSectionData(
                            color:
                                slices[i].color ??
                                _palette[i % _palette.length],
                            value: slices[i].market,
                            radius: _touchedIndex == i ? 64 : 56,
                            showTitle: false,
                          ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CurrencyDisplayer(
                        amountToConvert: total,
                        integerStyle: Theme.of(context).textTheme.titleLarge!,
                      ),
                      TrendingValue(
                        percentage: totalPnlPct,
                        value: totalPnl,
                        dataTypes: const [TrendingValueDataType.value],
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(slices.length, (i) {
              final slice = slices[i];
              final pct = total == 0 ? 0.0 : slice.market / total;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: slice.color ?? _palette[i % _palette.length],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slice.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '${(pct * 100).toStringAsFixed(1)}%',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CurrencyDisplayer(amountToConvert: slice.market),
                        TrendingValue(
                          percentage: slice.pnlPercent,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
