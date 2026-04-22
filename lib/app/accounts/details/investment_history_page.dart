import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/details/widgets/valuation_form_dialog.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/editable_time_series_list.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/time_series_evolution_chart.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InvestmentHistoryPage extends StatefulWidget {
  const InvestmentHistoryPage({super.key, required this.account});

  final Account account;

  @override
  State<InvestmentHistoryPage> createState() => _InvestmentHistoryPageState();
}

class _InvestmentHistoryPageState extends State<InvestmentHistoryPage> {
  ValuationInDB? _hoveredValuation;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _addValuation() async {
    final newValuation = await showValuationFormDialog(
      context,
      ValuationFormDialog(
        accountId: widget.account.id,
        currencySymbol: widget.account.currency.symbol,
      ),
    );

    if (newValuation != null) {
      await InvestmentService.instance.insertOrUpdateValuation(newValuation);
      MonekinSnackbar.success(
        SnackbarParams(t.account.investment.update_value_success),
      );
    }
  }

  Future<void> _editValuation(ValuationInDB valuation) async {
    final updatedValuation = await showValuationFormDialog(
      context,
      ValuationFormDialog(
        accountId: widget.account.id,
        currencySymbol: widget.account.currency.symbol,
        valuationToEdit: valuation,
      ),
    );

    if (updatedValuation != null) {
      await InvestmentService.instance.insertOrUpdateValuation(
        updatedValuation,
      );
      MonekinSnackbar.success(
        SnackbarParams(t.account.investment.edit_valuation_success),
      );
    }
  }

  Future<void> _deleteValuation(ValuationInDB valuation) async {
    await InvestmentService.instance.deleteValuation(valuation.id);
    MonekinSnackbar.success(
      SnackbarParams(t.account.investment.delete_valuation_success),
    );
  }

  Future<void> _deleteAllValuations(List<ValuationInDB> valuations) async {
    final confirmed = await confirmDialog(
      context,
      dialogTitle: t.account.investment.delete_all_valuations,
      contentParagraphs: [],
    );

    if (confirmed == true) {
      await Future.wait(
        valuations.map((v) => InvestmentService.instance.deleteValuation(v.id)),
      );
      MonekinSnackbar.success(
        SnackbarParams(t.account.investment.delete_all_valuations_success),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder<List<ValuationInDB>>(
      stream: InvestmentService.instance.getValuationsForAccount(
        widget.account.id,
      ),
      builder: (context, snapshot) {
        final valuations = snapshot.data
        final valuations = snapshot.data == null
            ? null
            : (List<ValuationInDB>.from(snapshot.data!)
              ..sort((a, b) => b.date.compareTo(a.date)));
        final displayValuation =
            _hoveredValuation ?? valuations?.firstOrNull;

        return PageFramework(
          title: t.account.investment.history,
          appBarActions: [
            MonekinPopupMenuButton(
              actionItems: [
                ListTileActionItem(
                  label: t.account.investment.delete_all_valuations,
                  icon: Icons.settings_backup_restore_rounded,
                  onClick: valuations != null && valuations.isNotEmpty
                      ? () => _deleteAllValuations(valuations)
                      : null,
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
      child: ListTile(
        leading: Skeleton.keep(child: account.displayIcon(context, size: 42)),
        title: Text(widget.account.name),
        titleTextStyle: Theme.of(context).textTheme.labelMedium,
        subtitle: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (displayValuation != null) ...[
              DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.headlineSmall,
                child: CurrencyDisplayer(
                  amountToConvert: displayValuation.value,
                  currency: widget.account.currency,
                ),
              ),
              Text('(${DateFormat.yMMMd().format(displayValuation.date)})'),
            ] else
              Text(
                valuations == null
                    ? '0.00 (Jan 1, 2025)'
                    : t.account.investment.no_valuations,
              ),
          ],
        ),
      ),
    );
  }

  Account get account => widget.account;

  Widget _buildSummarySection(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
          stream: InvestmentService.instance.getInvestmentProfit(account),
          builder: (context, profitSnapshot) {
            final profit = profitSnapshot.data;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.account.investment.invested_capital,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      StreamBuilder(
                        stream: InvestmentService.instance.getInvestedCapital(
                          account,
                        ),
                        builder: (context, snapshot) {
                          return DefaultTextStyle.merge(
                            style: Theme.of(context).textTheme.titleMedium,
                            child: CurrencyDisplayer(
                              amountToConvert: snapshot.data ?? 0,
                              currency: account.currency,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  if (profit != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          t.account.investment.profit,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Row(
                          children: [
                            DefaultTextStyle.merge(
                              style: TextStyle(
                                color: profit.value >= 0
                                    ? AppColors.of(context).success
                                    : AppColors.of(context).danger,
                                fontWeight: FontWeight.w600,
                              ),
                              child: CurrencyDisplayer(
                                amountToConvert: profit.value,
                                currency: account.currency,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${(profit.percent * 100).toStringAsFixed(2)}%)',
                              style: TextStyle(
                                fontSize: 12,
                                color: profit.value >= 0
                                    ? AppColors.of(context).success
                                    : AppColors.of(context).danger,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                t.account.investment.history,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              FilledButton.tonalIcon(
                onPressed: _addValuation,
                icon: const Icon(Icons.add_rounded),
                label: Text(t.ui_actions.add),
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
                    description: t.account.investment.history_empty,
                  );
                }

                if (BreakPoint.of(context).isSmallerThan(BreakpointID.lg)) {
                  return _buildValuationList(valuations);
                }

                return RawScrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  thumbColor: Theme.of(context).colorScheme.onSecondaryContainer
                      .withValues(alpha: 0.3)
                      .darkenPastel(amount: 0.3),
                  radius: const Radius.circular(20),
                  thickness: 10,
                  child: _buildValuationList(valuations),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildValuationList(List<ValuationInDB> valuations) {
    return EditableTimeSeriesList<ValuationInDB>(
      items: valuations,
      dateExtractor: (v) => v.date,
      subtitleBuilder: (context, item) => DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.bodyMedium,
        child: CurrencyDisplayer(
          amountToConvert: item.value,
          currency: widget.account.currency,
        ),
      ),
      onEdit: _editValuation,
      onDelete: _deleteValuation,
      scrollController: _scrollController,
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    List<ValuationInDB>? valuations,
    ValuationInDB? displayValuation,
  ) {
    return Column(
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
