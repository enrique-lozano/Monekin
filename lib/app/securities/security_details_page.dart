import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/details/account_snapshots.dart';
import 'package:monekin/app/accounts/details/holdings_card.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/app/securities/widgets/security_classification_card.dart';
import 'package:monekin/app/securities/widgets/security_form_sheet.dart';
import 'package:monekin/app/securities/widgets/security_price_form_dialog.dart';
import 'package:monekin/app/securities/widgets/security_price_import_sheet.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/page_content.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/editable_time_series_list.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/evolution_card.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/time_series_evolution_chart.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/label_value_info_list.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/trailing_value.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

/// A single price observation used to draw the price chart.
class _PricePoint {
  const _PricePoint(this.date, this.price);
  final DateTime date;
  final double price;
}

enum _DetailTab { about, positions, trades, history }

typedef _Position = ({HoldingWithSecurity data, Account account});

class SecurityDetailsPage extends StatefulWidget {
  const SecurityDetailsPage({
    super.key,
    required this.security,
    this.securityAvatarHeroTag,
  });

  final SecurityInDB security;
  final String? securityAvatarHeroTag;

  @override
  State<SecurityDetailsPage> createState() => _SecurityDetailsPageState();
}

class _SecurityDetailsPageState extends State<SecurityDetailsPage> {
  _PricePoint? _hoveredPoint;
  DatePeriodState _dateRange = const DatePeriodState(
    datePeriod: DatePeriod.allTime(),
  );
  _DetailTab _selectedTab = _DetailTab.about;

  /// The trades list is paginated client-side the same way as the history one.
  static const _tradesPageSize = 20;
  int _tradesPagesShown = 1;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Price series helpers
  // ---------------------------------------------------------------------------

  List<_PricePoint> _buildPricePoints(
    SecurityInDB security,
    List<TransactionInDB> trades,
    List<SecurityPriceInDB> history,
  ) {
    final points = <_PricePoint>[
      for (final h in history) _PricePoint(h.date, h.price),
    ];

    // Trades are also real price observations; include the ones we can't already
    // see in the recorded history.
    for (final tr in trades) {
      if (tr.pricePerUnit == null) continue;
      final alreadyTracked = points.any(
        (p) =>
            DateUtils.isSameDay(p.date, tr.date) && p.price == tr.pricePerUnit,
      );
      if (!alreadyTracked) {
        points.add(_PricePoint(tr.date, tr.pricePerUnit!));
      }
    }

    if (points.isEmpty && security.currentPrice != null) {
      points.add(
        _PricePoint(
          security.priceDate ?? DateTime.now(),
          security.currentPrice!,
        ),
      );
    }

    points.sort((a, b) => a.date.compareTo(b.date));
    return points;
  }

  List<_PricePoint> _visiblePoints(List<_PricePoint> all) {
    return _dateRange.filterTimeSeries(all, dateExtractor: (p) => p.date);
  }

  void _onPeriodChanged(DatePeriod period) {
    setState(() {
      _dateRange = _dateRange.copyWith(periodModifier: 0, datePeriod: period);
      _hoveredPoint = null;
    });
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  Future<void> _delete(SecurityInDB security) async {
    final t = Translations.of(context);

    final confirmed = await confirmDialog(
      context,
      dialogTitle: t.assets.securities.delete,
      contentParagraphs: [Text(t.assets.securities.delete_confirmation)],
    );

    if (confirmed != true) return;

    try {
      await SecurityService.instance.deleteSecurity(security.id);
      MonekinSnackbar.success(
        SnackbarParams(t.assets.securities.delete_success),
      );
      RouteUtils.popRoute();
    } catch (_) {
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.assets.securities.in_use_error),
      );
    }
  }

  Future<void> _tradeFromPosition({
    required Account account,
    required SecurityInDB security,
    required bool isBuy,
  }) async {
    await showTradeSheet(
      context,
      account: account,
      security: security,
      isBuy: isBuy,
    );
  }

  Future<void> _editTrade(TransactionInDB trade) async {
    final rich = await TransactionService.instance
        .getTransactionById(trade.id)
        .first;
    if (rich == null || !mounted) return;

    await RouteUtils.showResponsiveForm(
      TransactionFormPage(transactionToEdit: rich),
    );
  }

  Future<void> _addPricePoint(SecurityInDB security, Currency? currency) async {
    final point = await showSecurityPriceFormDialog(
      context,
      SecurityPriceFormDialog(
        securityId: security.id,
        currencySymbol: currency?.symbol,
      ),
    );

    if (point != null) {
      await SecurityService.instance.upsertPricePoint(point);
    }
  }

  Future<void> _editPricePoint(
    SecurityPriceInDB point,
    SecurityInDB security,
    Currency? currency,
  ) async {
    final updated = await showSecurityPriceFormDialog(
      context,
      SecurityPriceFormDialog(
        securityId: security.id,
        currencySymbol: currency?.symbol,
        pointToEdit: point,
      ),
    );

    if (updated != null) {
      await SecurityService.instance.upsertPricePoint(updated);
    }
  }

  Future<void> _deletePricePoint(SecurityPriceInDB point) async {
    await SecurityService.instance.deletePricePoint(point.id, point.securityID);
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final stream = SecurityService.instance
        .getSecurityById(widget.security.id)
        .switchMap((securityOrNull) {
          final security = securityOrNull ?? widget.security;

          return Rx.combineLatest4(
            HoldingService.instance.getHoldingsForSecurity(security.id),
            SecurityService.instance.getSecurityTrades(security.id),
            SecurityService.instance.getPriceHistory(security.id),
            CurrencyService.instance.getCurrencyByCode(security.currencyId),
            (
              List<_Position> positions,
              List<TransactionInDB> trades,
              List<SecurityPriceInDB> history,
              Currency? currency,
            ) => (
              security: security,
              positions: positions,
              trades: trades,
              history: history,
              currency: currency,
            ),
          );
        });

    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        final security = snapshot.data?.security ?? widget.security;
        final positions = snapshot.data?.positions ?? const <_Position>[];
        final trades = snapshot.data?.trades ?? const <TransactionInDB>[];
        final history = snapshot.data?.history ?? const <SecurityPriceInDB>[];
        final currency = snapshot.data?.currency;

        final allPoints = _buildPricePoints(security, trades, history);

        return PageFramework(
          title: security.name,
          subtitle: Text(
            [
              security.type.displayName(context),
              if (security.ticker != null) security.ticker!,
              security.currencyId,
            ].join(' · '),
          ),
          icon: Hero(
            tag: widget.securityAvatarHeroTag ?? UniqueKey(),
            child: SecurityAvatar(security: security, size: 40),
          ),
          appBarActions: [
            MonekinPopupMenuButton(
              actionItems: [
                ListTileActionItem(
                  label: t.assets.holdings.update_price,
                  icon: Icons.price_change_rounded,
                  onClick: () =>
                      showUpdatePriceSheet(context, security: security),
                ),
                ListTileActionItem(
                  label: t.assets.securities.import.title,
                  icon: Icons.file_upload_outlined,
                  onClick: () => showSecurityPriceImportSheet(
                    context,
                    securityId: security.id,
                  ),
                ),
                ListTileActionItem(
                  label: t.ui_actions.edit,
                  icon: Icons.edit_rounded,
                  onClick: () =>
                      showSecurityFormSheet(context, securityToEdit: security),
                ),
                ListTileActionItem(
                  label: t.ui_actions.delete,
                  icon: Icons.delete_rounded,
                  role: ListTileActionRole.delete,
                  onClick: () => _delete(security),
                ),
              ],
            ),
          ],
          body: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            children: [
              PageContent(
                child: BreakpointContainer(
                  lgBuilder: (context) => _buildDesktopLayout(
                    security,
                    currency,
                    positions,
                    trades,
                    history,
                    allPoints,
                  ),
                  builder: (context) {
                    final evolutionCard = _buildEvolutionCard(
                      security,
                      currency,
                      allPoints,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (BreakPoint.of(
                          context,
                        ).isLargerOrEqualTo(BreakpointID.md))
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: evolutionCard,
                          )
                        else
                          evolutionCard,
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildPositionCard(currency, positions),
                        ),
                        const SizedBox(height: 24),
                        _buildSegmentedSection(
                          security,
                          currency,
                          positions,
                          trades,
                          history,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEvolutionCard(
    SecurityInDB security,
    Currency? currency,
    List<_PricePoint> allPoints,
  ) {
    final visible = _visiblePoints(allPoints);
    final latestPrice =
        security.currentPrice ?? (visible.isNotEmpty ? visible.last.price : 0);
    final displayPrice = _hoveredPoint?.price ?? latestPrice;
    final initialPrice = visible.length >= 2 && visible.first.price != 0
        ? visible.first.price
        : null;

    return EvolutionCard(
      valueLabel: Translations.of(context).assets.securities.price,
      initialValue: initialPrice,
      finalValue: displayPrice,
      currency: currency,
      chart: TimeSeriesEvolutionChart<_PricePoint>(
        expand: true,
        data: visible,
        dateExtractor: (point) => point.date,
        valueExtractor: (point) => point.price,
        currency: currency,
        showYAxisTitles: false,
        onHover: (point) => setState(() => _hoveredPoint = point),
      ),
      currentPeriod: _dateRange.datePeriod,
      oldestDate: allPoints.isEmpty ? null : allPoints.first.date,
      showDateSelector: allPoints.isNotEmpty,
      onPresetSelected: _onPeriodChanged,
    );
  }

  Widget _buildDesktopLayout(
    SecurityInDB security,
    Currency? currency,
    List<_Position> positions,
    List<TransactionInDB> trades,
    List<SecurityPriceInDB> history,
    List<_PricePoint> allPoints,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildEvolutionCard(security, currency, allPoints),
              const SizedBox(height: 16),
              _buildSegmentedSection(
                security,
                currency,
                positions,
                trades,
                history,
                includeAboutTab: false,
                horizontalPadding: 0,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAbout(security, currency),
              const SizedBox(height: 16),
              SecurityClassificationCard(security: security),
              const SizedBox(height: 16),
              _buildPositionCard(currency, positions),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2 — Position summary
  // ---------------------------------------------------------------------------

  Widget _buildPositionCard(Currency? currency, List<_Position> positions) {
    final t = Translations.of(context);

    final totalUnits = positions.fold<double>(
      0,
      (sum, p) => sum + p.data.quantity,
    );
    final marketValue = positions.fold<double>(
      0,
      (sum, p) => sum + p.data.marketValue,
    );
    final costBasis = positions.fold<double>(
      0,
      (sum, p) => sum + p.data.costBasis,
    );
    final pnl = marketValue - costBasis;
    final pnlPct = costBasis == 0 ? 0.0 : pnl / costBasis;
    final avgCost = totalUnits == 0 ? 0.0 : costBasis / totalUnits;

    return CardWithHeader(
      title: t.assets.securities.your_position,
      body: LabelValueInfoList(
        items: [
          LabelValueInfoListItem(
            label: t.assets.securities.market_value,
            value: CurrencyDisplayer(
              amountToConvert: marketValue,
              currency: currency,
            ),
          ),
          LabelValueInfoListItem(
            label: t.assets.securities.units_held,
            value: Text(
              UINumberFormatter.decimal(
                amountToConvert: totalUnits,
              ).getFormattedAmount(),
            ),
          ),
          LabelValueInfoListItem(
            label: t.assets.holdings.avg_cost,
            value: CurrencyDisplayer(
              amountToConvert: avgCost,
              currency: currency,
            ),
          ),
          LabelValueInfoListItem(
            label: t.assets.securities.unrealized_pnl,
            value: TrendingValue(
              percentage: pnlPct,
              value: pnl,
              valueCurrency: currency,
              dataTypes: const [
                TrendingValueDataType.value,
                TrendingValueDataType.percentage,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3 — Segmented content
  // ---------------------------------------------------------------------------

  Widget _buildSegmentedSection(
    SecurityInDB security,
    Currency? currency,
    List<_Position> positions,
    List<TransactionInDB> trades,
    List<SecurityPriceInDB> history, {
    bool includeAboutTab = true,
    double horizontalPadding = 16,
  }) {
    final t = Translations.of(context);

    final selected = !includeAboutTab && _selectedTab == _DetailTab.about
        ? _DetailTab.positions
        : _selectedTab;

    final content = switch (selected) {
      _DetailTab.about => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAbout(security, currency),
          const SizedBox(height: 16),
          SecurityClassificationCard(security: security),
        ],
      ),
      _DetailTab.positions => _buildPositions(security, positions, currency),
      _DetailTab.trades => _buildTrades(trades, currency),
      _DetailTab.history => _buildHistory(security, currency, history),
    };

    final items = [
      if (includeAboutTab)
        SegmentedTabItem(
          value: _DetailTab.about,
          icon: Icons.info_outline_rounded,
          label: t.assets.securities.tabs.about,
        ),
      SegmentedTabItem(
        value: _DetailTab.positions,
        icon: Icons.account_balance_wallet_outlined,
        label: t.assets.securities.tabs.positions,
      ),
      SegmentedTabItem(
        value: _DetailTab.trades,
        icon: Icons.swap_vert_rounded,
        label: t.assets.securities.tabs.trades,
      ),
      SegmentedTabItem(
        value: _DetailTab.history,
        icon: Icons.view_timeline_rounded,
        label: t.assets.securities.tabs.price_history,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: ExpandingSegmentedTabs<_DetailTab>(
            items: items,
            selected: selected,
            onSelected: (v) => setState(() => _selectedTab = v),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: content,
        ),
      ],
    );
  }

  Widget _buildAbout(SecurityInDB security, Currency? currency) {
    final t = Translations.of(context);

    return CardWithHeader(
      title: t.assets.securities.tabs.about,
      body: Column(
        children: [
          LabelValueInfoList(
            items: [
              LabelValueInfoListItem(
                label: t.assets.holdings.security_type,
                value: Text(security.type.displayName(context)),
              ),
              LabelValueInfoListItem(
                label: t.assets.holdings.ticker,
                value: Text(security.ticker ?? '—'),
              ),
              LabelValueInfoListItem(
                label: t.currencies.currency,
                value: Text(
                  currency == null
                      ? security.currencyId
                      : '${currency.code} · ${currency.name}',
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: () =>
                    showSecurityFormSheet(context, securityToEdit: security),
                icon: const Icon(Icons.edit_rounded),
                label: Text(t.assets.securities.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPositions(
    SecurityInDB security,
    List<_Position> positions,
    Currency? currency,
  ) {
    final t = Translations.of(context);

    return CardWithHeader(
      title: t.assets.securities.positions,
      bodyPadding: const EdgeInsets.symmetric(vertical: 4),
      body: positions.isEmpty
          ? NoResults(
              title: t.general.empty_warn,
              description: t.assets.securities.no_positions,
              showIllustration: false,
            )
          : Column(
              children: positions.map((p) {
                return ListTile(
                  leading: p.account.displayIcon(context),
                  title: Text(p.account.name),
                  subtitle: Text(
                    '${UINumberFormatter.decimal(amountToConvert: p.data.quantity).getFormattedAmount()} · '
                    '${t.assets.holdings.avg_cost}: ${UINumberFormatter.decimal(amountToConvert: p.data.holding.avgCostPrice).getFormattedAmount()}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TrailingValue(
                        amount: p.data.marketValue,
                        currency: currency,
                        secondary: TrendingValue(
                          percentage: p.data.unrealizedPnlPercent,
                          fontSize: 12,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      if (p.account.trackingMode ==
                          AccountTrackingMode.holdings)
                        IconButton(
                          icon: const Icon(Icons.timeline_rounded),
                          tooltip: t.assets.holdings.positions_history,
                          onPressed: () => RouteUtils.pushRoute(
                            AccountSnapshotsPage(account: p.account),
                          ),
                        )
                      else
                        MonekinPopupMenuButton(
                          actionItems: [
                            ListTileActionItem(
                              label: t.assets.holdings.buy,
                              icon: Icons.add_rounded,
                              onClick: () => _tradeFromPosition(
                                account: p.account,
                                security: security,
                                isBuy: true,
                              ),
                            ),
                            ListTileActionItem(
                              label: t.assets.holdings.sell,
                              icon: Icons.remove_rounded,
                              onClick: () => _tradeFromPosition(
                                account: p.account,
                                security: security,
                                isBuy: false,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildTrades(List<TransactionInDB> trades, Currency? currency) {
    final t = Translations.of(context);

    final sorted = List<TransactionInDB>.from(trades)
      ..sort((a, b) => b.date.compareTo(a.date));

    final visibleCount = _visibleTradesCount(sorted.length);

    return CardWithHeader(
      title: t.assets.securities.tabs.trades,
      bodyPadding: const EdgeInsets.symmetric(vertical: 4),
      body: sorted.isEmpty
          ? NoResults(
              title: t.general.empty_warn,
              description: t.assets.securities.no_trades,
              showIllustration: false,
            )
          : Column(
              children: [
                for (var i = 0; i < visibleCount; i++)
                  Builder(
                    builder: (context) {
                      final trade = sorted[i];
                      final qty = trade.quantity ?? 0;
                      final isBuy = qty >= 0;
                      final color = isBuy ? Colors.green : Colors.red;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: color.withAlpha(30),
                          foregroundColor: color,
                          child: Icon(
                            isBuy ? Icons.add_rounded : Icons.remove_rounded,
                          ),
                        ),
                        title: Text(
                          isBuy
                              ? t.assets.holdings.buy
                              : t.assets.holdings.sell,
                        ),
                        subtitle: Text(
                          '${_dateLabel(trade.date)} · '
                          '${UINumberFormatter.decimal(amountToConvert: qty.abs()).getFormattedAmount()} × '
                          '${UINumberFormatter.currency(amountToConvert: trade.pricePerUnit ?? 0, currency: currency).getFormattedAmount()}',
                        ),
                        trailing: TrailingValue(
                          amount: trade.value.abs(),
                          currency: currency,
                        ),
                        onTap: () => _editTrade(trade),
                      );
                    },
                  ),
              ],
            ),
      footer: sorted.length > visibleCount
          ? CardFooterWithSingleButton(
              onButtonClick: () => setState(() => _tradesPagesShown++),
            )
          : null,
    );
  }

  /// Number of trade rows to render for the currently requested number of
  /// pages. The tab loads all trades to feed the chart, but the list itself is
  /// paginated client-side to avoid building thousands of tiles up front.
  int _visibleTradesCount(int totalCount) =>
      (_tradesPagesShown * _tradesPageSize).clamp(0, totalCount);

  Widget _buildHistory(
    SecurityInDB security,
    Currency? currency,
    List<SecurityPriceInDB> history,
  ) {
    final t = Translations.of(context);

    final sorted = List<SecurityPriceInDB>.from(history)
      ..sort((a, b) => b.date.compareTo(a.date));

    return EditableTimeSeriesCard<SecurityPriceInDB>(
      title: t.assets.securities.tabs.price_history,
      headerAction: CardHeaderAction(
        text: t.ui_actions.add,
        icon: const Icon(Icons.add_rounded, size: 15),
        onTap: () => _addPricePoint(security, currency),
      ),
      items: sorted,
      dateExtractor: (p) => p.date,
      valueExtractor: (p) => p.price,
      currency: currency!,
      emptyDescription: t.assets.securities.no_price_history,
      onEdit: (p) => _editPricePoint(p, security, currency),
      onDelete: (p) => _deletePricePoint(p),
      preventDeletingLast: true,
    );
  }

  String _dateLabel(DateTime date) {
    return MaterialLocalizations.of(context).formatMediumDate(date);
  }
}
