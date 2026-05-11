import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/assets/asset_form.dart';
import 'package:monekin/app/assets/asset_trade_sheet.dart';
import 'package:monekin/app/assets/widgets/asset_performance_bottom_sheet.dart';
import 'package:monekin/app/assets/widgets/asset_valuation_contribution_chart.dart';
import 'package:monekin/app/assets/widgets/valuation_form_dialog.dart';
import 'package:monekin/app/debts/components/transaction_selector.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/widgets/chart_time_period_selector.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/editable_time_series_list.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AssetDetailsPage extends StatefulWidget {
  const AssetDetailsPage({super.key, required this.asset});

  final Asset asset;

  @override
  State<AssetDetailsPage> createState() => _AssetDetailsPageState();
}

class _AssetDetailsPageState extends State<AssetDetailsPage> {
  ValuationInDB? _hoveredValuation;
  ChartTimePeriod _selectedChartPeriod = ChartTimePeriod.max;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<ValuationInDB> _buildFilteredChartData(List<ValuationInDB> valuations) {
    final allValuations = [
      ValuationInDB(
        id: 'INITIAL_VALUE',
        date: widget.asset.creationDate,
        value: widget.asset.initialValue,
        assetId: widget.asset.id,
      ),
      ...valuations,
    ];

    final sortedValuations = List<ValuationInDB>.from(allValuations)
      ..sort((a, b) => a.date.compareTo(b.date));

    final oldestDate = sortedValuations.first.date;
    final periodToUse =
        _selectedChartPeriod.isRangeAvailable(oldestDate: oldestDate)
        ? _selectedChartPeriod
        : ChartTimePeriod.max;

    return filterTimeSeriesByPeriod(
      data: sortedValuations,
      dateExtractor: (valuation) => valuation.date,
      period: periodToUse,
    );
  }

  List<AssetValuationContributionPoint> _buildChartPoints({
    required List<ValuationInDB> valuations,
    required List<MoneyTransaction> transactions,
  }) {
    final allValuations = [
      ValuationInDB(
        id: 'INITIAL_VALUE',
        date: widget.asset.creationDate,
        value: widget.asset.initialValue,
        assetId: widget.asset.id,
      ),
      ...valuations,
    ]..sort((a, b) => a.date.compareTo(b.date));

    final filteredValuations = _buildFilteredChartData(valuations);
    if (filteredValuations.isEmpty) {
      return const [];
    }

    final firstVisibleDate = filteredValuations.first.date;
    final txSorted =
        transactions
            .where((tx) => InvestmentService.statusAffectsValuation(tx))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    var txIndex = 0;
    var netContribution = widget.asset.initialValue;

    for (final tx in txSorted) {
      if (tx.date.isAfter(firstVisibleDate)) break;
      netContribution += InvestmentService.valuationDeltaForTransaction(tx);
      txIndex++;
    }

    return allValuations
        .where((valuation) => !valuation.date.isBefore(firstVisibleDate))
        .map((valuation) {
          while (txIndex < txSorted.length &&
              !txSorted[txIndex].date.isAfter(valuation.date)) {
            netContribution += InvestmentService.valuationDeltaForTransaction(
              txSorted[txIndex],
            );
            txIndex++;
          }

          return AssetValuationContributionPoint(
            date: valuation.date,
            valuation: valuation.value,
            netContribution: netContribution,
          );
        })
        .toList();
  }

  ChartTimePeriod _effectiveChartPeriod(DateTime oldestDate) {
    return _selectedChartPeriod.isRangeAvailable(oldestDate: oldestDate)
        ? _selectedChartPeriod
        : ChartTimePeriod.max;
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
                  InvestmentService.statusAffectsValuation(tx),
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));
    for (final tx in sorted) {
      net += InvestmentService.valuationDeltaForTransaction(tx);
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
      await InvestmentService.instance.insertOrUpdateValuation(newValuation);
      MonekinSnackbar.success(
        SnackbarParams(t.assets.valuation.update_value_success),
      );
    }
  }

  Future<void> _editValuation(ValuationInDB valuation, Asset asset) async {
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
      await InvestmentService.instance.insertOrUpdateValuation(
        updatedValuation,
      );
      MonekinSnackbar.success(
        SnackbarParams(t.assets.valuation.edit_valuation_success),
      );
    }
  }

  Future<void> _deleteValuation(ValuationInDB valuation) async {
    final t = Translations.of(context);
    await InvestmentService.instance.deleteValuation(valuation.id);
    MonekinSnackbar.success(
      SnackbarParams(t.assets.valuation.delete_valuation_success),
    );
  }

  Future<void> _deleteAllValuations(List<ValuationInDB> valuations) async {
    final t = Translations.of(context);
    final confirmed = await confirmDialog(
      context,
      dialogTitle: t.assets.valuation.delete_all_valuations,
      contentParagraphs: [],
    );

    if (confirmed == true) {
      await Future.wait(
        valuations.map((v) => InvestmentService.instance.deleteValuation(v.id)),
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
      await InvestmentService.instance
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
        InvestmentService.instance.getValuationsForAsset(widget.asset.id),
        InvestmentService.instance.getAssetById(widget.asset.id),
        TransactionService.instance.getTransactions(
          filters: TransactionFilterSet(assetIds: [widget.asset.id]),
        ),
        (a, b, c) => (valuations: a, asset: b, transactions: c),
      ),
      builder: (context, snapshot) {
        final valuations = snapshot.data == null
            ? null
            : (List<ValuationInDB>.from(snapshot.data!.valuations)
                ..sort((a, b) => b.date.compareTo(a.date)));

        final displayValuation = _hoveredValuation ?? valuations?.firstOrNull;

        final asset = snapshot.data?.asset ?? widget.asset;

        return PageFramework(
          title: asset.name,
          appBarActions: [
            MonekinPopupMenuButton(
              actionItems: [
                ListTileActionItem(
                  label: t.ui_actions.edit,
                  icon: Icons.edit_rounded,
                  onClick: () =>
                      RouteUtils.pushRoute(AssetFormPage(asset: asset)),
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
          body: BreakpointContainer(
            lgChild: _buildDesktopLayout(
              context,
              valuations,
              displayValuation,
              asset,
              snapshot.data?.transactions,
            ),
            child: _buildMobileLayout(
              context,
              valuations,
              displayValuation,
              asset,
              snapshot.data?.transactions,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentValueTile(
    BuildContext context,
    List<ValuationInDB>? valuations,
    ValuationInDB? displayValuation,
    Asset? asset,
    List<MoneyTransaction>? transactions,
  ) {
    asset ??= widget.asset;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeletonizer(
            enabled: valuations == null,
            child: StreamBuilder<double>(
              stream: InvestmentService.instance.getCurrentAssetValue(asset),
              builder: (context, valueSnapshot) {
                final value = valueSnapshot.data ?? asset!.initialValue;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle.merge(
                      style: Theme.of(context).textTheme.titleLarge,
                      child: CurrencyDisplayer(
                        amountToConvert: displayValuation?.value ?? value,
                        currency: asset?.currency ?? widget.asset.currency,
                      ),
                    ),
                    _buildTrendSection(
                      context,
                      valuations: valuations,
                      transactions: transactions,
                      asset: asset,
                      currentValue: value,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendSection(
    BuildContext context, {
    required List<ValuationInDB>? valuations,
    required List<MoneyTransaction>? transactions,
    required Asset? asset,
    required double currentValue,
  }) {
    final resolvedAsset = asset ?? widget.asset;

    if (valuations == null || transactions == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 8),
        child: Row(children: [Bone(width: 88, height: 24)]),
      );
    }

    final allSorted = [
      ValuationInDB(
        id: 'INITIAL_VALUE',
        date: widget.asset.creationDate,
        value: widget.asset.initialValue,
        assetId: widget.asset.id,
      ),
      ...valuations,
    ]..sort((a, b) => a.date.compareTo(b.date));
    final oldestDate = allSorted.first.date;
    final effectivePeriod = _effectiveChartPeriod(oldestDate);

    final points = _buildChartPoints(
      valuations: valuations,
      transactions: transactions,
    );
    final netNow = _netContributionNow(
      asset: resolvedAsset,
      transactions: transactions,
    );
    final rangeMetrics = _assetRangePerformanceMetrics(
      points: points.isEmpty ? null : points,
      currentValue: currentValue,
      netContributionNow: netNow,
    );
    final returnFraction = rangeMetrics == null
        ? 0.0
        : clampAssetPerformanceTrendFraction(
            rangeMetrics.performanceReturnFraction,
          );
    final rangeSnapshot = rangeMetrics;

    final trendValue = Builder(
      builder: (context) {
        final pr = rangeSnapshot;

        return Semantics(
          button: true,
          label: Translations.of(
            context,
          ).assets.details.performance_sheet_title,
          child: InkWell(
            onTap: points.isEmpty || pr == null
                ? null
                : () {
                    if (!mounted) return;

                    showAssetPerformanceBottomSheet(
                      context: context,
                      asset: resolvedAsset,
                      effectivePeriod: effectivePeriod,
                      rangeStartDate: pr.rangeStartDate,
                      performanceReturnMoney: pr.performanceReturnMoney,
                      performanceReturnFraction: pr.performanceReturnFraction,
                      valueDiffMoney: pr.valueDiffMoney,
                      valueDiffFraction: pr.valueDiffFraction,
                      netInvestedNow: netNow,
                    );
                  },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              spacing: 8,
              children: [
                TrendingValue(
                  percentage: returnFraction,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 2,
                  children: [
                    Text(
                      _selectedChartPeriod.localizedLabel(context),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.of(context).textBody,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: _hoveredValuation == null
          ? trendValue
          : Text(
              getMMMdDateFormatBasedOnYear(_hoveredValuation!.date).text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
    );
  }

  Widget _buildChartSection(
    BuildContext context,
    List<ValuationInDB>? valuations,
    List<MoneyTransaction>? transactions,
  ) {
    final t = Translations.of(context);
    final allChartData = valuations == null
        ? null
        : ([
            ValuationInDB(
              id: 'INITIAL_VALUE',
              date: widget.asset.creationDate,
              value: widget.asset.initialValue,
              assetId: widget.asset.id,
            ),
            ...valuations,
          ]..sort((a, b) => a.date.compareTo(b.date)));

    final chartData = valuations == null
        ? null
        : _buildChartPoints(
            valuations: valuations,
            transactions: transactions ?? const [],
          );

    return Column(
      spacing: 16,
      children: [
        if (allChartData != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ChartTimePeriodSelector(
                selectedPeriod:
                    _selectedChartPeriod.isRangeAvailable(
                      oldestDate: allChartData.first.date,
                    )
                    ? _selectedChartPeriod
                    : ChartTimePeriod.max,
                oldestDate: allChartData.first.date,
                onSelected: (period) {
                  setState(() {
                    _selectedChartPeriod = period;
                    _hoveredValuation = null;
                  });
                },
              ),
            ),
          ),
        if (chartData != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: AssetValuationContributionChart(
              points: chartData,
              currency: widget.asset.currency,
              valuationLabel: t.assets.valuation.value,
              netContributionLabel: t.assets.valuation.net_contribution,
              onHover: (point) {
                setState(() {
                  _hoveredValuation = point == null
                      ? null
                      : ValuationInDB(
                          id: 'HOVERED_VALUE',
                          date: point.date,
                          value: point.valuation,
                          assetId: widget.asset.id,
                        );
                });
              },
            ),
          ),

        if (valuations == null)
          const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Row _registerTransactionActionButtons(BuildContext context) {
    final t = Translations.of(context);

    return Row(
      spacing: 16,
      children: [
        if (widget.asset.assetType.isPhysical)
          Expanded(
            child: FilledButton.tonalIcon(
              onPressed: () => showTransactionSelectorModal(
                context,
                onTransactionSelected: (selectedTransaction) async {
                  try {
                    await InvestmentService.instance.linkTransactionToAsset(
                      transactionId: selectedTransaction.id,
                      assetId: widget.asset.id,
                    );
                    MonekinSnackbar.success(
                      SnackbarParams("Transaction linked with success"),
                    );
                  } catch (e) {
                    MonekinSnackbar.error(
                      SnackbarParams.fromError(e, showAtTop: true),
                    );
                  }
                },
                subtitle: t.assets.details.link_transaction_description,
                initialFilters: TransactionFilterSet(
                  transactionTypes: [
                    TransactionType.income,
                    TransactionType.expense,
                  ],
                  assetIds: [],
                ),
              ),
              icon: const Icon(Icons.add_link_rounded),
              label: Text(t.assets.details.link_transaction),
            ),
          ),
        if (widget.asset.assetType.isFinancial) ...[
          Expanded(
            child: FilledButton.tonalIcon(
              onPressed: () => showAssetTradeSheet(
                context,
                asset: widget.asset,
                isBuy: true,
              ),
              icon: const Icon(Icons.add_rounded),
              label: Text(t.assets.details.buy),
              style: FilledButton.styleFrom(
                foregroundColor: Colors.green,
                backgroundColor: Colors.green.withOpacity(0.1),
              ),
            ),
          ),
          Expanded(
            child: FilledButton.tonalIcon(
              onPressed: () => showAssetTradeSheet(
                context,
                asset: widget.asset,
                isBuy: false,
              ),
              icon: const Icon(Icons.remove_rounded),
              label: Text(t.assets.details.sell),
              style: FilledButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.red.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildValuationListSection(
    BuildContext context,
    List<ValuationInDB>? valuations,
    List<MoneyTransaction>? transactions,
    Asset? asset,
  ) {
    final t = Translations.of(context);
    asset ??= widget.asset;

    final itemsToDisplay =
        valuations?.map((v) => ValuationDisplayItem(v)).sorted((a, b) {
          final result = b.date.justDay().compareTo(a.date.justDay());

          return result;
        }) ??
        [];

    transactions?.forEach((transaction) {
      if (!itemsToDisplay.any(
        (item) => DateUtils.isSameDay(
          item.date.justDay(),
          transaction.date.justDay(),
        ),
      )) {
        itemsToDisplay.add(
          ValuationDisplayItem(
            ValuationInDB(
              id: generateUUID(),
              assetId: widget.asset.id,
              date: transaction.date,
              value:
                  itemsToDisplay
                      .firstWhereOrNull(
                        (item) => item.date.isBefore(transaction.date),
                      )
                      ?.value ??
                  asset?.initialValue ??
                  widget.asset.initialValue,
            ),
            isAutoGenerated: true,
          ),
        );
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, end: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.assets.valuation.history,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              FilledButton.tonalIcon(
                onPressed: () => _addValuation(asset!),
                icon: const Icon(Icons.add_rounded),
                label: Text(t.ui_actions.add),
              ),
            ],
          ),
        ),
        if (valuations != null && transactions != null)
          Flexible(
            child: Builder(
              builder: (context) {
                if (itemsToDisplay.isEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 12),
                      Expanded(
                        child: NoResults(
                          title: t.general.empty_warn,
                          description: t.assets.valuation.no_valuations,
                          noSearchResultsVariation: false,
                          showIllustration: MediaQuery.heightOf(context) > 750,
                        ),
                      ),
                    ],
                  );
                }

                return EditableTimeSeriesList<ValuationDisplayItem>(
                  items: itemsToDisplay.sorted((a, b) {
                    final result = b.date.justDay().compareTo(a.date.justDay());

                    return result;
                  }),
                  dateExtractor: (v) => v.date,
                  valueExtractor: (v) => v.value,
                  transactions: transactions,
                  currency: asset?.currency ?? widget.asset.currency,
                  onEdit: (valuation) => _editValuation(valuation, asset!),
                  onDelete: _deleteValuation,
                  scrollController: _scrollController,
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    List<ValuationInDB>? valuations,
    ValuationInDB? displayValuation,
    Asset? asset,
    List<MoneyTransaction>? transactions,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        _buildCurrentValueTile(
          context,
          valuations,
          displayValuation,
          asset,
          transactions,
        ),
        if (valuations != null && MediaQuery.of(context).size.height > 620) ...[
          _buildChartSection(context, valuations, transactions),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _registerTransactionActionButtons(context),
        ),
        Expanded(
          child: _buildValuationListSection(
            context,
            valuations,
            transactions,
            asset,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    List<ValuationInDB>? valuations,
    ValuationInDB? displayValuation,
    Asset? asset,
    List<MoneyTransaction>? transactions,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurrentValueTile(
                context,
                valuations,
                displayValuation,
                asset,
                transactions,
              ),
              const SizedBox(height: 16),
              _buildChartSection(context, valuations, transactions),
            ],
          ),
        ),
        Flexible(
          child: _buildValuationListSection(
            context,
            valuations,
            transactions,
            asset,
          ),
        ),
      ],
    );
  }
}

class ValuationDisplayItem extends ValuationInDB {
  final bool isAutoGenerated;

  ValuationDisplayItem(ValuationInDB valuation, {this.isAutoGenerated = false})
    : super(
        id: valuation.id,
        date: valuation.date,
        value: valuation.value,
        assetId: valuation.assetId,
      );
}
