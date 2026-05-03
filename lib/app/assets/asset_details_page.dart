import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/assets/asset_form.dart';
import 'package:monekin/app/assets/asset_trade_sheet.dart';
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
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/editable_time_series_list.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/time_series_evolution_chart.dart';
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

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      await InvestmentService.instance.deleteAsset(widget.asset.id);
      MonekinSnackbar.success(SnackbarParams(t.assets.delete_success));
      RouteUtils.popRoute();
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

        return PageFramework(
          title: '',
          appBarActions: [
            MonekinPopupMenuButton(
              actionItems: [
                ListTileActionItem(
                  label: t.ui_actions.edit,
                  icon: Icons.edit_rounded,
                  onClick: () =>
                      RouteUtils.pushRoute(AssetFormPage(asset: widget.asset)),
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
              snapshot.data?.asset,
              snapshot.data?.transactions,
            ),
            child: _buildMobileLayout(
              context,
              valuations,
              displayValuation,
              snapshot.data?.asset,
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
  ) {
    asset ??= widget.asset;

    return Skeletonizer(
      enabled: valuations == null,
      child: StreamBuilder<double>(
        stream: InvestmentService.instance.getCurrentAssetValue(asset),
        builder: (context, valueSnapshot) {
          final value = valueSnapshot.data ?? asset!.initialValue;

          return ListTile(
            title: Text(asset!.name),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            subtitle: Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (displayValuation != null) ...[
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    child: CurrencyDisplayer(
                      amountToConvert: displayValuation.value,
                      currency: asset.currency,
                    ),
                  ),
                  Text(
                    '(${getMMMdDateFormatBasedOnYear(displayValuation.date).text})',
                  ),
                ] else
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    child: CurrencyDisplayer(
                      amountToConvert: value,
                      currency: asset.currency,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<({double value, double percent})>(
          stream: InvestmentService.instance.getAssetProfit(widget.asset),
          builder: (context, profitSnapshot) {
            final profitData = profitSnapshot.data;
            final percent = profitData?.percent ?? 0;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.assets.profit,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                  ),
                  TrendingValue(percentage: percent),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChartSection(
    BuildContext context,
    List<ValuationInDB>? valuations,
  ) {
    if (valuations == null) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: TimeSeriesEvolutionChart<ValuationInDB>(
            data: [
              ValuationInDB(
                id: 'INITIAL_VALUE',
                date: widget.asset.creationDate,
                value: widget.asset.initialValue,
              ),
              ...valuations,
            ],
            dateExtractor: (v) => v.date,
            valueExtractor: (v) => v.value,
            currency: widget.asset.currency,
            onHover: (valuation) {
              setState(() {
                _hoveredValuation = valuation;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            spacing: 16,
            children: [
              if (widget.asset.assetType.isPhysical)
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () => showTransactionSelectorModal(
                      context,
                      onTransactionSelected: (selectedTransaction) async {
                        try {
                          await InvestmentService.instance
                              .linkTransactionToAsset(
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
                      context: context,
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
                      context: context,
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
          ),
        ),
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
      children: [
        const SizedBox(height: 8),
        _buildCurrentValueTile(context, valuations, displayValuation, asset),
        _buildSummarySection(context),
        if (valuations != null && MediaQuery.of(context).size.height > 550)
          _buildChartSection(context, valuations),
        const SizedBox(height: 16),
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
              ),
              _buildSummarySection(context),
              _buildChartSection(context, valuations),
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
        accountId: valuation.accountId,
        assetId: valuation.assetId,
      );
}
