import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/details/widgets/valuation_form_dialog.dart';
import 'package:monekin/app/assets/asset_form.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/editable_time_series_list.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/time_series_evolution_chart.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
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

  Future<void> _addValuation() async {
    final t = Translations.of(context);
    final newValuation = await showValuationFormDialog(
      context,
      ValuationFormDialog(
        assetId: widget.asset.id,
        currencySymbol: widget.asset.currency.symbol,
      ),
    );

    if (newValuation != null) {
      await InvestmentService.instance.insertOrUpdateValuation(newValuation);
      MonekinSnackbar.success(
        SnackbarParams(t.assets.valuation.update_value_success),
      );
    }
  }

  Future<void> _editValuation(ValuationInDB valuation) async {
    final t = Translations.of(context);
    final updatedValuation = await showValuationFormDialog(
      context,
      ValuationFormDialog(
        assetId: widget.asset.id,
        currencySymbol: widget.asset.currency.symbol,
        valuationToEdit: valuation,
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

    return StreamBuilder<List<ValuationInDB>>(
      stream: InvestmentService.instance.getValuationsForAsset(widget.asset.id),
      builder: (context, snapshot) {
        final valuations = snapshot.data == null
            ? null
            : (List<ValuationInDB>.from(snapshot.data!)
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
                    icon: Icons.delete_rounded,
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
            lgChild: _buildDesktopLayout(context, valuations, displayValuation),
            child: _buildMobileLayout(context, valuations, displayValuation),
          ),
        );
      },
    );
  }

  Widget _buildCurrentValueTile(
    BuildContext context,
    List<ValuationInDB>? valuations,
    ValuationInDB? displayValuation,
  ) {
    return Skeletonizer(
      enabled: valuations == null,
      child: StreamBuilder<double>(
        stream: InvestmentService.instance.getAssetValue(widget.asset),
        builder: (context, valueSnapshot) {
          final value = valueSnapshot.data ?? widget.asset.initialValue;

          return ListTile(
            title: Text(widget.asset.name),
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
                      currency: widget.asset.currency,
                    ),
                  ),
                  Text(
                    '(${getMMMdDateFormatBasedOnYear(displayValuation.date).format(displayValuation.date)})',
                  ),
                ] else
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    child: CurrencyDisplayer(
                      amountToConvert: value,
                      currency: widget.asset.currency,
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
      child: TimeSeriesEvolutionChart<ValuationInDB>(
        data: valuations,
        dateExtractor: (v) => v.date,
        valueExtractor: (v) => v.value,
        currency: widget.asset.currency,
        onHover: (valuation) {
          setState(() {
            _hoveredValuation = valuation;
          });
        },
      ),
    );
  }

  Widget _buildValuationListSection(
    BuildContext context,
    List<ValuationInDB>? valuations,
  ) {
    final t = Translations.of(context);

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
              if (valuations != null && valuations.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.add_rounded),
                  onPressed: _addValuation,
                ),
            ],
          ),
        ),
        if (valuations != null)
          Flexible(
            child: Builder(
              builder: (context) {
                if (valuations.isEmpty) {
                  return NoResults(
                    title: t.general.empty_warn,
                    description: t.assets.valuation.no_valuations,
                    noSearchResultsVariation: false,
                  );
                }

                return EditableTimeSeriesList<ValuationInDB>(
                  items: valuations,
                  dateExtractor: (v) => v.date,
                  subtitleBuilder: (context, item) => DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.bodyMedium,
                    child: CurrencyDisplayer(
                      amountToConvert: item.value,
                      currency: widget.asset.currency,
                    ),
                  ),
                  onEdit: _editValuation,
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
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildCurrentValueTile(context, valuations, displayValuation),
        _buildSummarySection(context),
        if (valuations != null && MediaQuery.of(context).size.height > 550)
          _buildChartSection(context, valuations),
        const SizedBox(height: 16),
        Expanded(child: _buildValuationListSection(context, valuations)),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    List<ValuationInDB>? valuations,
    ValuationInDB? displayValuation,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCurrentValueTile(context, valuations, displayValuation),
              _buildSummarySection(context),
              _buildChartSection(context, valuations),
            ],
          ),
        ),
        Flexible(child: _buildValuationListSection(context, valuations)),
      ],
    );
  }
}
