import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:monekin/app/stats/widgets/portfolio/portfolio_treemap_layout.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum _PerformanceMode { daily, pnl, returnRate }

class PortfolioTreemapCard extends StatefulWidget {
  const PortfolioTreemapCard({super.key, required this.date});

  final DateTime date;

  @override
  State<PortfolioTreemapCard> createState() => _PortfolioTreemapCardState();
}

class _PortfolioTreemapCardState extends State<PortfolioTreemapCard> {
  _PerformanceMode _mode = _PerformanceMode.returnRate;
  _PortfolioTreemapSlice? _selectedSlice;
  late Future<List<_PortfolioTreemapSlice>> _slicesFuture;

  @override
  void initState() {
    super.initState();
    _slicesFuture = _loadSlices();
  }

  @override
  void didUpdateWidget(covariant PortfolioTreemapCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      _selectedSlice = null;
      _slicesFuture = _loadSlices();
    }
  }

  Future<List<_PortfolioTreemapSlice>> _loadSlices() async {
    final holdings = await HoldingService.instance
        .getHoldingValuationsAtDate(widget.date)
        .first;
    final slicesBySecurity = <String, _PortfolioTreemapSlice>{};

    for (final holding in holdings) {
      if (holding.market == 0 && holding.cost == 0) continue;

      final market = await ExchangeRateService.instance
          .calculateExchangeRateToPreferredCurrency(
            amount: holding.market,
            fromCurrency: holding.currencyId,
            date: widget.date,
          )
          .first;
      final cost = holding.cost == 0
          ? 0.0
          : await ExchangeRateService.instance
                .calculateExchangeRateToPreferredCurrency(
                  amount: holding.cost,
                  fromCurrency: holding.currencyId,
                  date: widget.date,
                )
                .first;
      final existing = slicesBySecurity[holding.securityId];
      if (existing == null) {
        slicesBySecurity[holding.securityId] = _PortfolioTreemapSlice(
          securityId: holding.securityId,
          label: holding.securityName,
          market: market,
          cost: cost,
        );
      } else {
        existing.market += market;
        existing.cost += cost;
      }
    }

    for (final slice in slicesBySecurity.values) {
      slice.dailyReturn = await _dailyReturnFor(slice.securityId);
    }

    return slicesBySecurity.values.where((slice) => slice.market > 0).toList()
      ..sort((a, b) => b.market.compareTo(a.market));
  }

  Future<double> _dailyReturnFor(String securityId) async {
    final prices = await SecurityService.instance
        .getPriceHistory(securityId)
        .first;
    final pricePoints = prices
        .where((point) => !point.date.isAfter(widget.date))
        .toList();
    if (pricePoints.length < 2) return 0;

    final currentPrice = pricePoints.last.price;
    final previousPrice = pricePoints[pricePoints.length - 2].price;
    return previousPrice == 0
        ? 0
        : (currentPrice - previousPrice) / previousPrice;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FutureBuilder<List<_PortfolioTreemapSlice>>(
      future: _slicesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 320,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final slices = snapshot.data!;
        if (slices.isEmpty) {
          return SizedBox(
            height: 220,
            child: Center(child: Text(t.general.insufficient_data)),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: ExpandingSegmentedTabs<_PerformanceMode>(
                  fullWidth: false,
                  height: 36,
                  items: [
                    SegmentedTabItem(
                      value: _PerformanceMode.daily,
                      icon: Icons.today_outlined,
                      label: t.stats.daily_performance,
                    ),
                    SegmentedTabItem(
                      value: _PerformanceMode.pnl,
                      icon: Icons.account_balance_outlined,
                      label: t.assets.securities.unrealized_pnl,
                    ),
                    SegmentedTabItem(
                      value: _PerformanceMode.returnRate,
                      icon: Icons.percent_rounded,
                      label: t.assets.details.performance_return,
                    ),
                  ],
                  selected: _mode,
                  onSelected: (mode) => setState(() => _mode = mode),
                ),
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final height = (constraints.maxWidth * 0.58).clamp(
                  290.0,
                  470.0,
                );
                final rects = squarifyTreemap(
                  items: slices,
                  weightOf: (slice) => slice.market,
                  width: constraints.maxWidth,
                  height: height,
                );

                return SizedBox(
                  height: height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        for (final rect in rects)
                          Positioned(
                            left: rect.left,
                            top: rect.top,
                            width: rect.width,
                            height: rect.height,
                            child: _TreemapTile(
                              slice: rect.item,
                              mode: _mode,
                              selected:
                                  _selectedSlice?.securityId ==
                                  rect.item.securityId,
                              onTap: () =>
                                  setState(() => _selectedSlice = rect.item),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (_selectedSlice case final selected?) ...[
              const SizedBox(height: 12),
              _SelectedSliceDetails(slice: selected, mode: _mode),
            ],
          ],
        );
      },
    );
  }
}

class _TreemapTile extends StatelessWidget {
  const _TreemapTile({
    required this.slice,
    required this.mode,
    required this.selected,
    required this.onTap,
  });

  final _PortfolioTreemapSlice slice;
  final _PerformanceMode mode;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final metric = slice.metricFor(mode);
    final background = _performanceColor(context, metric.colorScore);
    final foreground =
        ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Material(
        color: background,
        child: InkWell(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: selected ? Border.all(color: foreground, width: 2) : null,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;

                // Type scales with the tile, the way a treemap needs it to:
                // the biggest positions read as headlines and the small ones
                // still get a legible label instead of being left blank.
                final nameSize = math
                    .min(width * 0.13, height * 0.3)
                    .clamp(9.0, 26.0);
                final metricSize = nameSize * 0.82;

                final canShowName = width >= 42 && height >= 24;
                final canShowMetric = width >= 42 && height >= 38;

                final metricStyle = TextStyle(
                  fontSize: metricSize,
                  fontWeight: FontWeight.w600,
                  color: foreground.withValues(alpha: 0.92),
                );

                final content = Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (canShowName)
                        Text(
                          slice.label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: nameSize,
                            fontWeight: FontWeight.w700,
                            color: foreground,
                          ),
                        ),
                      if (canShowMetric)
                        mode == _PerformanceMode.pnl
                            ? CurrencyDisplayer(
                                amountToConvert: slice.pnl,
                                compactView: true,
                                showDecimals: false,
                                integerStyle: metricStyle,
                                currencyStyle: metricStyle,
                              )
                            : Text(
                                metric.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: metricStyle,
                              ),
                    ],
                  ),
                );

                if (canShowName) return content;

                return Tooltip(
                  message:
                      '${slice.label} · '
                      '${_percentageLabel(metric.colorScore)}',
                  child: content,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedSliceDetails extends StatelessWidget {
  const _SelectedSliceDetails({required this.slice, required this.mode});

  final _PortfolioTreemapSlice slice;
  final _PerformanceMode mode;

  @override
  Widget build(BuildContext context) {
    final metric = slice.metricFor(mode);
    return Row(
      children: [
        Expanded(
          child: Text(
            slice.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(width: 12),
        CurrencyDisplayer(amountToConvert: slice.market),
        const SizedBox(width: 12),
        TrendingValue(
          percentage: metric.colorScore,
          value: mode == _PerformanceMode.pnl ? slice.pnl : null,
          dataTypes: mode == _PerformanceMode.pnl
              ? const [TrendingValueDataType.value]
              : const [TrendingValueDataType.percentage],
          fontSize: 12,
        ),
      ],
    );
  }
}

class _PortfolioTreemapSlice {
  _PortfolioTreemapSlice({
    required this.securityId,
    required this.label,
    required this.market,
    required this.cost,
  });

  final String securityId;
  final String label;
  double market;
  double cost;
  double dailyReturn = 0;

  double get pnl => market - cost;
  double get returnRate => cost == 0 ? 0 : pnl / cost;

  _TreemapMetric metricFor(_PerformanceMode mode) {
    return switch (mode) {
      _PerformanceMode.daily => _TreemapMetric(
        colorScore: dailyReturn,
        label: _percentageLabel(dailyReturn),
      ),
      _PerformanceMode.pnl => _TreemapMetric(colorScore: returnRate, label: ''),
      _PerformanceMode.returnRate => _TreemapMetric(
        colorScore: returnRate,
        label: _percentageLabel(returnRate),
      ),
    };
  }
}

class _TreemapMetric {
  const _TreemapMetric({required this.colorScore, required this.label});

  final double colorScore;
  final String label;
}

Color _performanceColor(BuildContext context, double score) {
  final colors = AppColors.of(context);
  final neutral = Theme.of(context).colorScheme.surfaceContainerHighest;
  final clampedScore = score.clamp(-0.25, 0.25);
  if (clampedScore == 0) return neutral;

  final intensity = 0.25 + clampedScore.abs() / 0.25 * 0.65;
  return Color.lerp(
    neutral,
    clampedScore > 0 ? colors.success : colors.danger,
    intensity,
  )!;
}

String _percentageLabel(double value) =>
    '${value >= 0 ? '+' : ''}${(value * 100).toStringAsFixed(2)}%';
