import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/assets/asset_form.dart';
import 'package:monekin/app/assets/widgets/asset_valuation_contribution_chart.dart';
import 'package:monekin/app/assets/widgets/valuation_form_dialog.dart';
import 'package:monekin/app/debts/components/transaction_selector.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/details/transaction_details.page.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/asset_service.dart';
import 'package:monekin/core/database/services/account/asset_valuation_service.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/page_content.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/dates/date_range_chips.dart';
import 'package:monekin/core/presentation/widgets/editable_time_series_list.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/evolution_card.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/label_value_info_list.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

/// Clamps extreme fractions so [TrendingValue] stays readable in the UI.
double _clampTrendFraction(double fraction) {
  if (fraction.isNaN || !fraction.isFinite) return 0;
  if (fraction > 10) return 10;
  if (fraction < -10) return -10;
  return fraction;
}

class AssetDetailsPage extends StatefulWidget {
  const AssetDetailsPage({
    super.key,
    required this.asset,
    this.assetIconHeroTag,
  });

  final Asset asset;
  final String? assetIconHeroTag;

  @override
  State<AssetDetailsPage> createState() => _AssetDetailsPageState();
}

enum _DetailTab { about, transactions, history }

class _AssetDetailsPageState extends State<AssetDetailsPage> {
  AssetValuationInDB? _hoveredValuation;
  double? _hoveredNetContribution;
  DatePeriodState _dateRange = const DatePeriodState(
    datePeriod: DatePeriod.allTime(),
  );
  _DetailTab _selectedTab = _DetailTab.history;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Merges the asset's real [valuations] with a synthetic point for its
  /// initial value at creation. If a real valuation already exists on the
  /// asset's creation day, the synthetic point is dropped: otherwise, since
  /// it's timestamped with the exact creation time while manually-added
  /// valuations are timestamped at midnight, it could sort *after* that real
  /// valuation and silently override it when the chart samples that day.
  List<AssetValuationInDB> _valuationsWithInitial(
    List<AssetValuationInDB> valuations,
  ) {
    final hasValuationOnCreationDay = valuations.any(
      (v) => v.date.justDay() == widget.asset.creationDate.justDay(),
    );

    return [
      if (!hasValuationOnCreationDay)
        AssetValuationInDB(
          id: 'INITIAL_VALUE',
          date: widget.asset.creationDate,
          value: widget.asset.initialValue,
          assetId: widget.asset.id,
        ),
      ...valuations,
    ]..sort((a, b) => a.date.compareTo(b.date));
  }

  List<AssetValuationInDB> _buildFilteredChartData(
    List<AssetValuationInDB> valuations,
  ) {
    return _dateRange.filterTimeSeries(
      _valuationsWithInitial(valuations),
      dateExtractor: (valuation) => valuation.date,
    );
  }

  List<AssetValuationContributionPoint> _buildChartPoints({
    required List<AssetValuationInDB> valuations,
    required List<MoneyTransaction> transactions,
  }) {
    final allValuations = _valuationsWithInitial(valuations);

    final filteredValuations = _buildFilteredChartData(valuations);
    if (filteredValuations.isEmpty) {
      return const [];
    }

    final firstVisibleDate = filteredValuations.first.date;
    final txSorted =
        transactions
            .where(
              (tx) =>
                  AssetValuationService.statusAffectsValuation(tx) &&
                  !AssetValuationService.isAcquisitionTransaction(
                    tx,
                    widget.asset,
                  ),
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    // Cumulative invested capital at (and including) [date].
    double netContributionAt(DateTime date) {
      var net = widget.asset.initialValue;
      for (final tx in txSorted) {
        if (tx.date.isAfter(date)) break;
        net += AssetValuationService.valuationDeltaForTransaction(tx);
      }
      return net;
    }

    AssetValuationInDB? latestValuationAt(DateTime date) {
      AssetValuationInDB? result;
      for (final valuation in allValuations) {
        if (valuation.date.isAfter(date)) break;
        result = valuation;
      }
      return result;
    }

    // Step dates include transactions too, not just valuations — otherwise the
    // net line steps late when a tx has no same-day valuation.
    final stepDates = <DateTime>{firstVisibleDate};
    for (final valuation in allValuations) {
      if (!valuation.date.isBefore(firstVisibleDate)) {
        stepDates.add(valuation.date);
      }
    }
    for (final tx in txSorted) {
      if (!tx.date.isBefore(firstVisibleDate)) {
        stepDates.add(tx.date);
      }
    }

    final sortedDates = stepDates.toList()..sort();

    return sortedDates.map((date) {
      final latestValuation = latestValuationAt(date);
      final baseValue = latestValuation?.value ?? widget.asset.initialValue;
      final baseNet = latestValuation == null
          ? widget.asset.initialValue
          : netContributionAt(latestValuation.date);
      final net = netContributionAt(date);

      // Carry the last explicit valuation forward, but lift it by any capital
      // invested since that valuation, so a purchase recorded without a fresh
      // valuation still shows on the value line instead of leaving it flat
      // until the next valuation is entered.
      return AssetValuationContributionPoint(
        date: date,
        valuation: baseValue + (net - baseNet),
        netContribution: net,
      );
    }).toList();
  }

  DateTimeRange _chartTimeRange(DateTime oldestDate) {
    final oldestDay = oldestDate.justDay();
    final periodStart = (_dateRange.startDate ?? oldestDay).justDay();
    final periodEnd = (_dateRange.endDate ?? DateTime.now()).justDay();

    // Clamp the axis to available data.
    final start = periodStart.isBefore(oldestDay) ? oldestDay : periodStart;
    final end = periodEnd.isBefore(start) ? start : periodEnd;

    return DateTimeRange(start: start, end: end.add(const Duration(days: 1)));
  }

  void _onPeriodChanged(DatePeriod period) {
    setState(() {
      _dateRange = _dateRange.copyWith(periodModifier: 0, datePeriod: period);
      _hoveredValuation = null;
      _hoveredNetContribution = null;
    });
  }

  double _netContributionNow({
    required Asset asset,
    required List<MoneyTransaction> transactions,
  }) {
    var net = asset.initialValue;
    final sorted =
        transactions
            .where(
              (tx) =>
                  tx.assetID == asset.id &&
                  AssetValuationService.statusAffectsValuation(tx) &&
                  !AssetValuationService.isAcquisitionTransaction(tx, asset),
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));
    for (final tx in sorted) {
      net += AssetValuationService.valuationDeltaForTransaction(tx);
    }
    return net;
  }

  /// Metrics for the visible chart range vs now.
  ///
  /// [performanceReturnMoney] = (V₁−V₀) − (C₁−C₀): period gain after netting
  /// new invested flows (0 when valuation change is fully explained by cash in).
  /// [valueDiffMoney] = V₁−V₀: raw valuation change over the range.
  ({
    double performanceReturnMoney,
    double performanceReturnFraction,
    double valueDiffMoney,
    double valueDiffFraction,
    DateTime rangeStartDate,
  })?
  _assetRangePerformanceMetrics({
    required List<AssetValuationContributionPoint>? points,
    required double currentValue,
    required double netContributionNow,
  }) {
    if (points == null || points.isEmpty) return null;
    final p0 = points.first;
    final v0 = p0.valuation;
    final c0 = p0.netContribution;
    final v1 = currentValue;
    final c1 = netContributionNow;

    final performanceReturnMoney = (v1 - v0) - (c1 - c0);
    final valueDiffMoney = v1 - v0;

    double performanceReturnFraction;
    if (performanceReturnMoney.abs() < 1e-9) {
      performanceReturnFraction = 0;
    } else {
      final basis = c0.abs() >= 1e-9 ? c0.abs() : math.max(v0.abs(), 1e-9);
      performanceReturnFraction = performanceReturnMoney / basis;
    }

    double valueDiffFraction;
    if (valueDiffMoney.abs() < 1e-9) {
      valueDiffFraction = 0;
    } else {
      final vBasis = v0.abs() >= 1e-9 ? v0.abs() : 1e-9;
      valueDiffFraction = valueDiffMoney / vBasis;
    }

    return (
      performanceReturnMoney: performanceReturnMoney,
      performanceReturnFraction: performanceReturnFraction,
      valueDiffMoney: valueDiffMoney,
      valueDiffFraction: valueDiffFraction,
      rangeStartDate: p0.date,
    );
  }

  Future<void> _addValuation(Asset asset) async {
    final t = Translations.of(context);
    final newValuation = await showValuationFormDialog(
      context,
      ValuationFormDialog(
        assetId: asset.id,
        currencySymbol: asset.currency.symbol,
        firstDate: asset.creationDate,
      ),
    );

    if (newValuation != null) {
      await AssetValuationService.instance.insertOrUpdateValuation(
        newValuation,
      );
      MonekinSnackbar.success(
        SnackbarParams(t.assets.valuation.update_value_success),
      );
    }
  }

  Future<void> _editValuation(AssetValuationInDB valuation, Asset asset) async {
    final t = Translations.of(context);
    final updatedValuation = await showValuationFormDialog(
      context,
      ValuationFormDialog(
        assetId: asset.id,
        currencySymbol: asset.currency.symbol,
        valuationToEdit: valuation,
        firstDate: asset.creationDate,
      ),
    );

    if (updatedValuation != null) {
      await AssetValuationService.instance.insertOrUpdateValuation(
        updatedValuation,
      );
      MonekinSnackbar.success(
        SnackbarParams(t.assets.valuation.edit_valuation_success),
      );
    }
  }

  Future<void> _deleteValuation(AssetValuationInDB valuation) async {
    final t = Translations.of(context);
    await AssetValuationService.instance.deleteValuation(valuation.id);
    MonekinSnackbar.success(
      SnackbarParams(t.assets.valuation.delete_valuation_success),
    );
  }

  Future<void> _deleteAllValuations(List<AssetValuationInDB> valuations) async {
    final t = Translations.of(context);
    final confirmed = await confirmDialog(
      context,
      dialogTitle: t.assets.valuation.delete_all_valuations,
      contentParagraphs: [],
    );

    if (confirmed == true) {
      await Future.wait(
        valuations.map(
          (v) => AssetValuationService.instance.deleteValuation(v.id),
        ),
      );
      MonekinSnackbar.success(
        SnackbarParams(t.assets.valuation.delete_all_valuations_success),
      );
    }
  }

  Future<void> _deleteAsset() async {
    final t = Translations.of(context);
    final confirmed = await confirmDialog(
      context,
      dialogTitle: t.assets.delete,
      contentParagraphs: [Text(t.assets.delete_confirmation)],
    );

    if (confirmed == true) {
      await AssetService.instance
          .deleteAsset(widget.asset.id)
          .then((_) {
            MonekinSnackbar.success(SnackbarParams(t.assets.delete_success));

            RouteUtils.popRoute();
          })
          .catchError((error) async {
            final linkedTxs = await TransactionService.instance
                .countTransactions(
                  filters: TransactionFilterSet(
                    assetIds: [widget.asset.id],
                    transactionTypes: [TransactionType.investment],
                  ),
                )
                .first;

            if (linkedTxs > 0) {
              MonekinSnackbar.error(
                SnackbarParams.fromError(
                  'There are investment transactions linked to this asset. Please delete or unlink them before deleting the asset.',
                ),
              );

              return;
            }

            MonekinSnackbar.error(SnackbarParams.fromError(error));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
      stream: Rx.combineLatest3(
        AssetValuationService.instance.getValuationsForAsset(widget.asset.id),
        AssetService.instance.getAssetById(widget.asset.id),
        TransactionService.instance.getTransactions(
          filters: TransactionFilterSet(assetIds: [widget.asset.id]),
        ),
        (a, b, c) => (valuations: a, asset: b, transactions: c),
      ),
      builder: (context, snapshot) {
        final valuations = snapshot.data == null
            ? null
            : (List<AssetValuationInDB>.from(snapshot.data!.valuations)
                ..sort((a, b) => b.date.compareTo(a.date)));

        final asset = snapshot.data?.asset ?? widget.asset;
        final assetColor = asset.assetType.color();

        return PageFramework(
          title: asset.name,
          subtitle: Text(asset.assetType.displayName(context)),
          icon: Hero(
            tag: widget.assetIconHeroTag ?? UniqueKey(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: assetColor.withAlpha(38),
                shape: BoxShape.circle,
              ),
              child: Icon(asset.assetType.icon(), color: assetColor),
            ),
          ),
          appBarActions: [
            MonekinPopupMenuButton(
              actionItems: [
                ListTileActionItem(
                  label: t.ui_actions.edit,
                  icon: Icons.edit_rounded,
                  onClick: () => RouteUtils.showResponsiveForm(
                    AssetFormPage(asset: asset),
                  ),
                ),
                if (valuations != null && valuations.isNotEmpty)
                  ListTileActionItem(
                    label: t.assets.valuation.delete_all_valuations,
                    icon: Icons.restore_rounded,
                    onClick: () => _deleteAllValuations(valuations),
                  ),
                ListTileActionItem(
                  label: t.ui_actions.delete,
                  icon: Icons.delete_rounded,
                  role: ListTileActionRole.delete,
                  onClick: _deleteAsset,
                ),
              ],
            ),
          ],
          body: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              PageContent(
                child: BreakpointContainer(
                  lgBuilder: (context) => _buildDesktopLayout(
                    context,
                    valuations,
                    asset,
                    snapshot.data?.transactions,
                  ),
                  builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTopMobile(
                        context,
                        valuations,
                        asset,
                        snapshot.data?.transactions,
                      ),
                      const SizedBox(height: 24),
                      _buildSegmentedSection(
                        context,
                        valuations,
                        snapshot.data?.transactions,
                        asset,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// When the asset has a linked liability (e.g. a mortgage), show the net
  /// worth of the asset: current value minus the outstanding debt.
  Widget _buildNetWorthSection(
    BuildContext context,
    Asset asset,
    double currentValue, {
    bool cardFooter = false,
  }) {
    final debtId = asset.linkedDebtId;
    if (debtId == null) return const SizedBox.shrink();

    final t = Translations.of(context);

    return StreamBuilder<Debt?>(
      stream: DebtService.instance.getDebtById(debtId),
      builder: (context, debtSnap) {
        final debt = debtSnap.data;
        if (debt == null) return const SizedBox.shrink();

        return StreamBuilder<double>(
          stream: DebtService.instance.getDebtRemainingAmount(debt).switchMap((
            remaining,
          ) {
            if (debt.currencyId == asset.currency.code) {
              return Stream.value(remaining);
            }
            return ExchangeRateService.instance.calculateExchangeRate(
              fromCurrency: debt.currencyId,
              toCurrency: asset.currency.code,
              amount: remaining,
            );
          }),
          builder: (context, remainingSnap) {
            if (!remainingSnap.hasData) return const SizedBox.shrink();

            final remaining = remainingSnap.data!;
            final netWorth = currentValue - remaining;

            Widget metric(
              String label,
              double amount, {
              bool emphasized = false,
            }) {
              final valueStyle = emphasized
                  ? Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                  : Theme.of(context).textTheme.bodyMedium;

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    CurrencyDisplayer(
                      amountToConvert: amount,
                      currency: asset.currency,
                      integerStyle: valueStyle ?? const TextStyle(),
                    ),
                  ],
                ),
              );
            }

            Widget row(String label, double amount, {TextStyle? style}) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: style),
                  CurrencyDisplayer(
                    amountToConvert: amount,
                    currency: asset.currency,
                    integerStyle: style ?? const TextStyle(),
                  ),
                ],
              );
            }

            if (cardFooter) {
              return IntrinsicHeight(
                child: Row(
                  spacing: 16,
                  children: [
                    metric(t.assets.details.gross_value, currentValue),
                    const VerticalDivider(width: 1),
                    metric(t.assets.details.liability, -remaining),
                    const VerticalDivider(width: 1),
                    metric(
                      t.assets.details.net_worth,
                      netWorth,
                      emphasized: true,
                    ),
                  ],
                ),
              );
            }

            return Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  row(t.assets.details.gross_value, currentValue),
                  const SizedBox(height: 4),
                  row(t.assets.details.liability, -remaining),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(height: 1),
                  ),
                  row(
                    t.assets.details.net_worth,
                    netWorth,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// The endpoint the performance figures are measured against: the hovered
  /// chart point while the user inspects the chart, "now" otherwise.
  ({double value, double netContribution}) _performanceEndpoint({
    required double currentValue,
    required double netContributionNow,
  }) {
    final hovered = _hoveredValuation;

    if (hovered == null) {
      return (value: currentValue, netContribution: netContributionNow);
    }

    return (
      value: hovered.value,
      netContribution: _hoveredNetContribution ?? netContributionNow,
    );
  }

  /// Performance figures for the visible chart range, shown inline as a card
  /// (mirroring the "your position" card of the securities page) instead of
  /// hidden behind a bottom sheet.
  Widget _buildPerformanceCard(
    BuildContext context,
    List<AssetValuationInDB>? valuations,
    List<MoneyTransaction>? transactions,
    Asset? asset,
  ) {
    final t = Translations.of(context);
    final resolvedAsset = asset ?? widget.asset;

    if (valuations == null || transactions == null) {
      return const SizedBox.shrink();
    }

    final points = _buildChartPoints(
      valuations: valuations,
      transactions: transactions,
    );
    if (points.isEmpty) return const SizedBox.shrink();

    return StreamBuilder<double>(
      stream: AssetValuationService.instance.getCurrentAssetValue(
        resolvedAsset,
      ),
      builder: (context, valueSnapshot) {
        // Current position only, not chart hover (matches securities page).
        final metrics = _assetRangePerformanceMetrics(
          points: points,
          currentValue: valueSnapshot.data ?? resolvedAsset.initialValue,
          netContributionNow: _netContributionNow(
            asset: resolvedAsset,
            transactions: transactions,
          ),
        );

        if (metrics == null) return const SizedBox.shrink();

        return CardWithHeader(
          title: t.assets.details.performance_title,
          subtitle:
              '${datePeriodShortLabel(context, _dateRange)} · '
              '${getMMMdDateFormatBasedOnYear(metrics.rangeStartDate).text}',
          body: LabelValueInfoList(
            items: [
              LabelValueInfoListItem(
                label: t.assets.details.performance_return,
                value: TrendingValue(
                  percentage: _clampTrendFraction(
                    metrics.performanceReturnFraction,
                  ),
                  value: metrics.performanceReturnMoney,
                  valueCurrency: resolvedAsset.currency,
                  dataTypes: const [
                    TrendingValueDataType.value,
                    TrendingValueDataType.percentage,
                  ],
                ),
                trailing: _infoTooltip(
                  context,
                  t.assets.details.performance_return_help,
                ),
              ),
              LabelValueInfoListItem(
                label: t.assets.details.performance_invested_value,
                value: CurrencyDisplayer(
                  amountToConvert: _netContributionNow(
                    asset: resolvedAsset,
                    transactions: transactions,
                  ),
                  currency: resolvedAsset.currency,
                ),
                trailing: _infoTooltip(
                  context,
                  t.assets.details.performance_invested_value_caption,
                ),
              ),
              LabelValueInfoListItem(
                label: t.assets.details.performance_value_diff,
                value: TrendingValue(
                  percentage: _clampTrendFraction(metrics.valueDiffFraction),
                  value: metrics.valueDiffMoney,
                  valueCurrency: resolvedAsset.currency,
                  dataTypes: const [
                    TrendingValueDataType.value,
                    TrendingValueDataType.percentage,
                  ],
                ),
                trailing: _infoTooltip(
                  context,
                  t.assets.details.performance_value_diff_caption,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoTooltip(BuildContext context, String message) {
    return Tooltip(
      constraints: BoxConstraints(
        maxWidth: math.min(MediaQuery.widthOf(context) * 0.95, 250),
      ),
      triggerMode: TooltipTriggerMode.tap,
      message: message,
      child: const Icon(Icons.info_outline_rounded, size: 18),
    );
  }

  /// Links an existing income/expense transaction to [asset]. From now on,
  /// linking a transaction requires it to already exist; only one dated
  /// on/before the asset's creation date (the acquisition) may ever be
  /// linked (see [AssetValuationService.isAcquisitionTransaction]).
  void _linkTransaction(
    BuildContext context,
    Asset asset,
    List<MoneyTransaction> transactions,
  ) {
    final t = Translations.of(context);
    final hasAcquisitionTransaction = transactions.any(
      (tx) => AssetValuationService.isAcquisitionTransaction(tx, asset),
    );

    showTransactionSelectorModal(
      context,
      initialFilters: TransactionFilterSet(
        transactionTypes: [TransactionType.income, TransactionType.expense],
        assetIds: [],
        minDate: hasAcquisitionTransaction
            ? asset.creationDate.add(const Duration(seconds: 1))
            : null,
      ),
      onTransactionSelected: (transaction) async {
        try {
          await AssetService.instance.linkTransactionToAsset(
            transactionId: transaction.id,
            assetId: asset.id,
          );
          MonekinSnackbar.success(
            SnackbarParams(
              t.assets.actions.link_transaction.success,
              showAtTop: true,
            ),
          );
        } catch (e) {
          MonekinSnackbar.error(SnackbarParams.fromError(e, showAtTop: true));
        }
      },
    );
  }

  Widget _buildValuationListSection(
    BuildContext context,
    List<AssetValuationInDB>? valuations,
    Asset? asset,
  ) {
    final t = Translations.of(context);
    final resolvedAsset = asset ?? widget.asset;

    if (valuations == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final sorted = List<AssetValuationInDB>.from(valuations)
      ..sort((a, b) => b.date.justDay().compareTo(a.date.justDay()));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: EditableTimeSeriesCard<AssetValuationInDB>(
        title: t.assets.valuation.history,
        headerAction: CardHeaderAction(
          text: t.ui_actions.add,
          icon: const Icon(Icons.add_rounded, size: 15),
          onTap: () => _addValuation(resolvedAsset),
        ),
        items: sorted,
        dateExtractor: (v) => v.date,
        valueExtractor: (v) => v.value,
        currency: resolvedAsset.currency,
        emptyDescription: t.assets.valuation.no_valuations,
        onEdit: (v) => _editValuation(v, resolvedAsset),
        onDelete: _deleteValuation,
      ),
    );
  }

  Widget _buildTopMobile(
    BuildContext context,
    List<AssetValuationInDB>? valuations,
    Asset? asset,
    List<MoneyTransaction>? transactions,
  ) {
    final resolvedAsset = asset ?? widget.asset;

    final evolutionCard = _buildEvolutionCard(
      context,
      valuations,
      resolvedAsset,
      transactions,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        if (BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: evolutionCard,
          )
        else
          evolutionCard,
        if (resolvedAsset.linkedDebtId != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StreamBuilder<double>(
              stream: AssetValuationService.instance.getCurrentAssetValue(
                resolvedAsset,
              ),
              builder: (context, snapshot) => _buildNetWorthSection(
                context,
                resolvedAsset,
                snapshot.data ?? resolvedAsset.initialValue,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildPerformanceCard(
            context,
            valuations,
            transactions,
            resolvedAsset,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    List<AssetValuationInDB>? valuations,
    Asset asset,
    List<MoneyTransaction>? transactions,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildEvolutionCard(
                context,
                valuations,
                asset,
                transactions,
                includeFooter: true,
              ),
              const SizedBox(height: 16),
              _buildSegmentedSection(
                context,
                valuations,
                transactions,
                asset,
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
              _buildAbout(context, asset, transactions, horizontalPadding: 0),
              const SizedBox(height: 16),
              _buildPerformanceCard(context, valuations, transactions, asset),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEvolutionCard(
    BuildContext context,
    List<AssetValuationInDB>? valuations,
    Asset asset,
    List<MoneyTransaction>? transactions, {
    bool includeFooter = false,
  }) {
    final t = Translations.of(context);

    if (valuations == null) {
      return EvolutionCard(
        valueLabel: t.assets.valuation.value,
        finalValue: asset.initialValue,
        currency: asset.currency,
        loading: true,
        chart: const Center(child: CircularProgressIndicator()),
        currentPeriod: _dateRange.datePeriod,
        onPresetSelected: _onPeriodChanged,
        showDateSelector: false,
        chartHeight: 220,
      );
    }

    final allChartData = _valuationsWithInitial(valuations);
    final chartData = _buildChartPoints(
      valuations: valuations,
      transactions: transactions ?? const [],
    );

    return StreamBuilder<double>(
      stream: AssetValuationService.instance.getCurrentAssetValue(asset),
      builder: (context, snapshot) {
        final currentValue = snapshot.data ?? asset.initialValue;
        final endpoint = _performanceEndpoint(
          currentValue: currentValue,
          netContributionNow: _netContributionNow(
            asset: asset,
            transactions: transactions ?? const [],
          ),
        );
        final metrics = _assetRangePerformanceMetrics(
          points: chartData.isEmpty ? null : chartData,
          currentValue: endpoint.value,
          netContributionNow: endpoint.netContribution,
        );

        return EvolutionCard(
          chartHeight: 220,
          valueLabel: t.assets.valuation.value,
          initialValue: metrics == null
              ? null
              : endpoint.value - metrics.performanceReturnMoney,
          finalValue: endpoint.value,
          currency: asset.currency,
          chart: AssetValuationContributionChart(
            expand: true,
            points: chartData,
            timeRange: allChartData.isEmpty
                ? null
                : _chartTimeRange(allChartData.first.date),
            currency: asset.currency,
            valuationLabel: t.assets.valuation.value,
            netContributionLabel: t.assets.valuation.net_contribution,
            netContributionHelpText: t.assets.valuation.net_contribution_help,
            transactionDates: (transactions ?? const [])
                .map((transaction) => transaction.date)
                .toList(),
            transactionsLabel: t.transaction.display(n: 2),
            onHover: _handleChartHover,
          ),
          currentPeriod: _dateRange.datePeriod,
          oldestDate: allChartData.isEmpty ? null : allChartData.first.date,
          showDateSelector: allChartData.isNotEmpty,
          onPresetSelected: _onPeriodChanged,
          footer: !includeFooter || asset.linkedDebtId == null
              ? null
              : _buildNetWorthSection(
                  context,
                  asset,
                  currentValue,
                  cardFooter: true,
                ),
        );
      },
    );
  }

  void _handleChartHover(AssetValuationContributionPoint? point) {
    setState(() {
      _hoveredValuation = point == null
          ? null
          : AssetValuationInDB(
              id: 'HOVERED_VALUE',
              date: point.date,
              value: point.valuation,
              assetId: widget.asset.id,
            );
      _hoveredNetContribution = point?.netContribution;
    });
  }

  /// On desktop, the "about" info is shown as a persistent card next to this
  /// section (see [_buildDesktopBody]) instead of behind a tab.
  Widget _buildSegmentedSection(
    BuildContext context,
    List<AssetValuationInDB>? valuations,
    List<MoneyTransaction>? transactions,
    Asset? asset, {
    bool includeAboutTab = true,
    double horizontalPadding = 16,
  }) {
    final t = Translations.of(context);

    final selected = (!includeAboutTab && _selectedTab == _DetailTab.about)
        ? _DetailTab.history
        : _selectedTab;

    final content = switch (selected) {
      _DetailTab.about => _buildAbout(context, asset, transactions),
      _DetailTab.transactions => _buildTransactionsSection(
        context,
        transactions,
        asset ?? widget.asset,
      ),
      _DetailTab.history => _buildValuationListSection(
        context,
        valuations,
        asset,
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: ExpandingSegmentedTabs<_DetailTab>(
            items: [
              if (includeAboutTab)
                SegmentedTabItem(
                  value: _DetailTab.about,
                  icon: Icons.info_outline_rounded,
                  label: t.assets.details.about,
                ),
              SegmentedTabItem(
                value: _DetailTab.transactions,
                icon: Icons.swap_vert_rounded,
                label: t.transaction.display(n: 20),
              ),
              SegmentedTabItem(
                value: _DetailTab.history,
                icon: Icons.view_timeline_rounded,
                label: t.assets.valuation.history,
              ),
            ],
            selected: selected,
            onSelected: (v) => setState(() => _selectedTab = v),
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildTransactionsSection(
    BuildContext context,
    List<MoneyTransaction>? transactions,
    Asset asset,
  ) {
    final t = Translations.of(context);

    final sorted = transactions == null
        ? null
        : (List<MoneyTransaction>.from(transactions)
            ..sort((a, b) => b.date.compareTo(a.date)));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CardWithHeader(
        title: t.transaction.display(n: sorted?.length ?? 0),
        headerAction: CardHeaderAction(
          text: t.ui_actions.add,
          icon: const Icon(Icons.add_rounded, size: 15),
          onTap: () => _linkTransaction(context, asset, sorted ?? const []),
        ),
        bodyPadding: const EdgeInsets.symmetric(vertical: 4),
        body: sorted == null
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator()),
              )
            : sorted.isEmpty
            ? NoResults(
                title: t.general.empty_warn,
                description: t.transaction.list.empty,
                showIllustration: false,
              )
            : Column(
                children: sorted
                    .map(
                      (tx) =>
                          AssetValuationService.isAcquisitionTransaction(
                            tx,
                            asset,
                          )
                          ? _buildAcquisitionTransactionTile(context, tx)
                          : TransactionListTile(
                              transaction: tx,
                              heroTag: 'asset-details-page__tr-icon-${tx.id}',
                            ),
                    )
                    .toList(),
              ),
      ),
    );
  }

  /// Highlights the linked transaction that represents the asset's purchase
  /// (see [AssetValuationService.isAcquisitionTransaction]), so it reads as
  /// distinct from later transactions that add or remove value.
  Widget _buildAcquisitionTransactionTile(
    BuildContext context,
    MoneyTransaction tx,
  ) {
    final t = Translations.of(context);
    final color = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withAlpha(28),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              t.assets.details.acquisition_transaction_badge,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        TransactionListTile(
          transaction: tx,
          heroTag: 'asset-details-page__tr-icon-${tx.id}',
        ),
      ],
    );
  }

  Widget _buildAbout(
    BuildContext context,
    Asset? asset,
    List<MoneyTransaction>? transactions, {
    double horizontalPadding = 16,
  }) {
    final t = Translations.of(context);
    final resolvedAsset = asset ?? widget.asset;

    final acquisitionTransaction = transactions?.firstWhereOrNull(
      (tx) => AssetValuationService.isAcquisitionTransaction(tx, resolvedAsset),
    );

    return Padding(
      padding: EdgeInsets.only(right: horizontalPadding),
      child: CardWithHeader(
        title: t.assets.details.about,
        body: Column(
          children: [
            LabelValueInfoList(
              items: [
                LabelValueInfoListItem(
                  label: t.assets.form.asset_type,
                  value: Text(resolvedAsset.assetType.displayName(context)),
                ),
                LabelValueInfoListItem(
                  label: t.currencies.currency,
                  value: Text(
                    '${resolvedAsset.currency.code} · ${resolvedAsset.currency.name}',
                  ),
                ),
                LabelValueInfoListItem(
                  label: t.assets.form.initial_value,
                  value: CurrencyDisplayer(
                    amountToConvert: resolvedAsset.initialValue,
                    currency: resolvedAsset.currency,
                  ),
                  trailing: acquisitionTransaction != null
                      ? const Icon(Icons.chevron_right, size: 18)
                      : null,
                  onTap: acquisitionTransaction != null
                      ? () => RouteUtils.pushRoute(
                          TransactionDetailsPage(
                            transaction: acquisitionTransaction,
                            heroTag: 'asset-about__initial-value',
                          ),
                        )
                      : null,
                ),
                LabelValueInfoListItem(
                  label: t.assets.form.acquisition_date,
                  value: Text(
                    getMMMdDateFormatBasedOnYear(
                      resolvedAsset.creationDate,
                    ).text,
                  ),
                ),
                if (resolvedAsset.description != null &&
                    resolvedAsset.description!.isNotEmpty)
                  LabelValueInfoListItem(
                    label: t.assets.form.description,
                    value: Text(resolvedAsset.description!),
                  ),
              ],
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  style: getMediumButtonStyle(context),
                  onPressed: () => RouteUtils.showResponsiveForm(
                    AssetFormPage(asset: resolvedAsset),
                  ),
                  icon: const Icon(Icons.edit_rounded),
                  label: Text(t.ui_actions.edit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
