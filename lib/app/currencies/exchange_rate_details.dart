import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/app/currencies/widgets/currency_edit_fields.dart';
import 'package:monekin/app/currencies/widgets/exchange_rate_evolution_chart.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/exit_without_save_warn_dialog.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExchangeRateDetailsPage extends StatefulWidget {
  const ExchangeRateDetailsPage({super.key, required this.currency});

  final Currency currency;

  @override
  State<ExchangeRateDetailsPage> createState() =>
      _ExchangeRateDetailsPageState();
}

class _ExchangeRateDetailsPageState extends State<ExchangeRateDetailsPage>
    with SingleTickerProviderStateMixin {
  List<ExchangeRate>? _originalRates;
  List<ExchangeRate>? _currentRates;
  final List<String> _deletedRateIds = [];

  final GlobalKey<CurrencyEditFieldsState> _currencyFormKey = GlobalKey();

  ExchangeRate? _selectedRate;
  late TabController _tabController;

  /// The currency passed to the page, but with the updated info if edited.
  late Currency _currency;

  final breakpointChangeIn = BreakpointID.lg;
  final ScrollController scrollController = ScrollController();

  bool get _hasChanges {
    if (_originalRates == null || _currentRates == null) return false;

    if (_deletedRateIds.isNotEmpty) return true;
    if (_originalRates!.length != _currentRates!.length) return true;

    // Check for content changes in rates
    // This assumes order might be different, but usually we keep them sorted.
    // A simple check is to see if every item in _currentRates exists in _originalRates
    // But since we can edit rates, we need to check by ID and values.
    for (final rate in _currentRates!) {
      final original = _originalRates!
          .where((r) => r.id == rate.id)
          .firstOrNull;
      if (original == null) return true; // New rate
      if (original.exchangeRate != rate.exchangeRate ||
          original.date != rate.date) {
        return true; // Modified rate
      }
    }

    // Check for currency changes
    if (_currencyFormKey.currentState?.hasChanged ?? false) return true;

    return false;
  }

  @override
  void initState() {
    super.initState();

    _currency = widget.currency;
    _tabController = TabController(length: 2, vsync: this);

    getExchangeRates();
  }

  void getExchangeRates() {
    ExchangeRateService.instance
        .getExchangeRatesOf(widget.currency.code)
        .first
        .then((value) {
          setState(() {
            _originalRates = value;
            _currentRates = List.from(value);
            _deletedRateIds.clear();
          });
        });
  }

  void deleteAllRates() {
    setState(() {
      if (_originalRates != null) {
        for (final rate in _originalRates!) {
          if (!_deletedRateIds.contains(rate.id)) {
            _deletedRateIds.add(rate.id);
          }
        }
      }
      _currentRates?.clear();
    });
  }

  Future<void> saveChanges() async {
    final t = Translations.of(context);

    // 1. Delete removed rates
    if (_deletedRateIds.isNotEmpty) {
      await Future.wait(
        _deletedRateIds.map(
          (id) => ExchangeRateService.instance.deleteExchangeRateById(id),
        ),
      );
    }

    // 2. Upsert modified or new rates
    if (_currentRates != null) {
      final ratesToUpsert = _currentRates!.where((rate) {
        final original = _originalRates?.firstWhereOrNull(
          (r) => r.id == rate.id,
        );

        // If original is null, it is a new rate
        if (original == null) return true;

        // If values are different, it is a modified rate
        return original.exchangeRate != rate.exchangeRate ||
            original.date != rate.date;
      });

      if (ratesToUpsert.isNotEmpty) {
        await Future.wait(
          ratesToUpsert.map(
            (rate) =>
                ExchangeRateService.instance.insertOrUpdateExchangeRate(rate),
          ),
        );
      }
    }

    // 3. Save currency changes if any
    final formState = _currencyFormKey.currentState;

    if (formState?.hasChanged ?? false) {
      final updatedCurrency = _currency.copyWith(
        code: formState!.code,
        name: formState.displayName,
        symbol: formState.symbol,
        decimalPlaces: formState.decimalPlaces,
        type: formState.currencyType.dbValue,
      );

      await CurrencyService.instance.updateCurrency(
        _currency.code,
        updatedCurrency,
      );

      _currency =
          await CurrencyService.instance
              .getCurrencyByCode(updatedCurrency.code)
              .first ??
          _currency;

      setState(() {});
    }

    // FINISHED: Show success snackbar
    MonekinSnackbar.success(SnackbarParams("t.general.save_succes"));
    getExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final emptyTextWidget = Text(
      _currentRates == null ? '1.0000 (Exa 14, 2025)' : '--',
    );

    final displayRate = _selectedRate ?? _currentRates?.firstOrNull;

    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (_hasChanges) {
          showExitWithoutSaveWarnDialog(context);
        }
      },
      child: PageFramework(
        title: _currency.name,
        appBarActions: [
          MonekinPopupMenuButton(
            actionItems: [
              ListTileActionItem(
                label: t.currencies.exchange_rate_form.remove_all,
                icon: Icons.settings_backup_restore_rounded,
                onClick: () => deleteAllRates(),
              ),
              ListTileActionItem(
                label: t.ui_actions.delete,
                role: ListTileActionRole.delete,
                icon: Icons.delete_forever_rounded,
                onClick: _currency.isDefault
                    ? null
                    : () async {
                        final confirmed = await confirmDialog(
                          context,
                          dialogTitle: t.ui_actions.delete,
                          contentParagraphs: [],
                          canPop: false,
                        );

                        if (confirmed == true) {
                          CurrencyService.instance
                              .deleteCurrency(_currency.code)
                              .then((value) {
                                MonekinSnackbar.success(
                                  SnackbarParams("DELETE"),
                                );

                                RouteUtils.popRoute();
                              })
                              .catchError((err) {
                                MonekinSnackbar.error(
                                  SnackbarParams.fromError(err),
                                );
                              });
                        }
                      },
              ),
            ],
          ),
        ],
        tabBar: BreakPoint.of(context).isLargerOrEqualTo(breakpointChangeIn)
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: t.general.details),
                  Tab(text: t.currencies.historical),
                ],
              ),
        persistentFooterButtons: [
          PersistentFooterButton(
            child: FilledButton.icon(
              onPressed: !_hasChanges
                  ? null
                  : () async {
                      await saveChanges();
                    },
              icon: const Icon(Icons.save_rounded),
              label: Text(t.ui_actions.save_changes),
            ),
          ),
        ],
        body: BreakpointContainer(
          lgChild: buildDesktopLayout(context, displayRate, emptyTextWidget),
          child: buildMobileLayout(context, displayRate, emptyTextWidget),
        ),
      ),
    );
  }

  Widget buildDesktopLayout(
    BuildContext context,
    ExchangeRate? displayRate,
    Text emptyTextWidget,
  ) {
    final t = Translations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCurrentExchangeRateTile(context, displayRate),
              Expanded(child: secondTabContent(context)),
            ],
          ),
        ),
        Flexible(child: firstTabContent(emptyTextWidget)),
      ],
    );
  }

  Widget buildMobileLayout(
    BuildContext context,
    ExchangeRate? displayRate,
    Text emptyTextWidget,
  ) {
    final t = Translations.of(context);
    return Column(
      children: [
        const SizedBox(height: 8),
        buildCurrentExchangeRateTile(context, displayRate),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              firstTabContent(emptyTextWidget),
              secondTabContent(context),
            ],
          ),
        ),
      ],
    );
  }

  Skeletonizer buildCurrentExchangeRateTile(
    BuildContext context,
    ExchangeRate? displayRate,
  ) {
    return Skeletonizer(
      enabled: _currentRates == null,
      child: ListTile(
        title: Text('1 ${_currency.code} ='),
        titleTextStyle: Theme.of(context).textTheme.labelMedium,
        leading: Skeleton.keep(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: _currency.displayFlagIcon(size: 42),
          ),
        ),
        subtitle: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              NumberFormat.currency(
                symbol: appStateSettings[SettingKey.preferredCurrency] ?? '',
                decimalDigits: 4,
              ).format(displayRate?.exchangeRate ?? 1),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              ' (on ${DateFormat.yMMMd().format(displayRate?.date ?? DateTime.now())})',
            ),
          ],
        ),
      ),
    );
  }

  Widget secondTabContent(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_currentRates != null && MediaQuery.of(context).size.height > 550)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 0, 8),
            child: ExchangeRateEvolutionChart(
              exchangeRates: _currentRates!,
              onHover: (rate) {
                setState(() {
                  _selectedRate = rate;
                });
              },
            ),
          ),

        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, end: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.currencies.historical,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              FilledButton.tonalIcon(
                onPressed: () async {
                  final newRate = await showExchangeRateFormDialog(
                    context,
                    ExchangeRateFormDialog(currency: widget.currency),
                  );

                  if (newRate != null) {
                    final existingIndex = _currentRates?.indexWhere(
                      (r) => DateUtils.isSameDay(r.date, newRate.date),
                    );

                    if (existingIndex != null && existingIndex != -1) {
                      _currentRates![existingIndex] = ExchangeRate(
                        id: _currentRates![existingIndex].id,
                        date: newRate.date,
                        currency: newRate.currency,
                        exchangeRate: newRate.exchangeRate,
                      );
                    } else {
                      _currentRates?.add(newRate);
                    }

                    setState(() {});
                  }
                },
                icon: const Icon(Icons.add_rounded),
                label: Text(t.ui_actions.add),
              ),
            ],
          ),
        ),
        if (_currentRates != null)
          Flexible(
            child: Builder(
              builder: (context) {
                if (_currentRates!.isEmpty) {
                  return NoResults(description: t.currencies.historical_empty);
                }

                if (BreakPoint.of(context).isSmallerThan(breakpointChangeIn)) {
                  return buildExchangeRateList();
                }

                return RawScrollbar(
                  thumbVisibility: true,
                  controller: scrollController,
                  thumbColor: Theme.of(context).colorScheme.onSecondaryContainer
                      .withOpacity(0.3)
                      .darkenPastel(amount: 0.3),
                  radius: Radius.circular(20),
                  thickness: 10,
                  child: buildExchangeRateList(),
                );
              },
            ),
          ),
      ],
    );
  }

  Future<void> _editRate(ExchangeRate item) async {
    final updatedRate = await showExchangeRateFormDialog(
      context,
      ExchangeRateFormDialog(exchangeRateToEdit: item),
    );

    if (updatedRate != null) {
      setState(() {
        final index = _currentRates!.indexWhere((r) => r.id == item.id);
        if (index != -1) {
          _currentRates![index] = updatedRate;
        }
      });
    }
  }

  void _deleteRate(ExchangeRate item) {
    setState(() {
      _currentRates!.removeWhere((r) => r.id == item.id);
      if (_originalRates!.any((r) => r.id == item.id)) {
        _deletedRateIds.add(item.id);
      }
    });
  }

  ListView buildExchangeRateList() {
    final t = Translations.of(context);
    final isLargeScreen = BreakPoint.of(context).isLargerThan(BreakpointID.md);

    return ListView.separated(
      shrinkWrap: true,
      controller: scrollController,
      itemCount: _currentRates!.length,
      itemBuilder: (context, index) {
        final item = _currentRates![index];

        return ListTile(
          title: Text(DateFormat.yMMMMd().format(item.date)),
          subtitle: Text(
            NumberFormat.currency(
              symbol: '',
              decimalDigits: 4,
            ).format(item.exchangeRate),
          ),
          contentPadding: EdgeInsetsDirectional.only(
            start: 16,
            end: isLargeScreen ? 0 : 8,
          ),
          trailing: isLargeScreen
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.edit_rounded),
                      onPressed: () => _editRate(item),
                      tooltip: t.ui_actions.edit,
                    ),
                    IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteRate(item),
                      tooltip: t.ui_actions.delete,
                    ),
                  ],
                )
              : MonekinPopupMenuButton(
                  actionItems: [
                    ListTileActionItem(
                      label: t.ui_actions.edit,
                      icon: Icons.edit_rounded,
                      onClick: () => _editRate(item),
                    ),
                    ListTileActionItem(
                      label: t.ui_actions.delete,
                      icon: Icons.delete,
                      role: ListTileActionRole.delete,
                      onClick: () => _deleteRate(item),
                    ),
                  ],
                ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  SingleChildScrollView firstTabContent(Text emptyTextWidget) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Skeletonizer(
            enabled: _currentRates == null,
            child: ListTile(
              title: Skeleton.keep(child: Text(t.currencies.min_exchange_rate)),
              subtitle: _currentRates != null && _currentRates!.isNotEmpty
                  ? ExchangeRateRowInDetails(
                      exchangeRate: _currentRates!.reduce(
                        (value, element) =>
                            value.exchangeRate < element.exchangeRate
                            ? value
                            : element,
                      ),
                    )
                  : emptyTextWidget,
            ),
          ),

          Skeletonizer(
            enabled: _currentRates == null,
            child: ListTile(
              title: Skeleton.keep(child: Text(t.currencies.max_exchange_rate)),
              subtitle: _currentRates != null && _currentRates!.isNotEmpty
                  ? ExchangeRateRowInDetails(
                      exchangeRate: _currentRates!.reduce(
                        (value, element) =>
                            value.exchangeRate > element.exchangeRate
                            ? value
                            : element,
                      ),
                    )
                  : emptyTextWidget,
            ),
          ),

          if (!BreakPoint.of(
            context,
          ).isLargerOrEqualTo(breakpointChangeIn)) ...[
            const Divider(height: 16),

            CurrencyEditFields(
              key: _currencyFormKey,
              currency: _currency,
              isInFormMode: false,
              onChanged: () => setState(() {}),
            ),
          ],

          if (BreakPoint.of(context).isLargerOrEqualTo(breakpointChangeIn)) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: CardWithHeader(
                title: t.currencies.currency_settings,
                body: Column(
                  children: [
                    const SizedBox(height: 8),
                    const Divider(height: 4),
                    CurrencyEditFields(
                      key: _currencyFormKey,
                      currency: _currency,
                      onChanged: () => setState(() {}),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ExchangeRateRowInDetails extends StatelessWidget {
  const ExchangeRateRowInDetails({super.key, required this.exchangeRate});

  final ExchangeRate exchangeRate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8,
      children: [
        Flexible(
          child: Text(
            NumberFormat.currency(
              symbol: '',
              decimalDigits: 4,
            ).format(exchangeRate.exchangeRate),
          ),
        ),
        Text('(${DateFormat.yMMMd().format(exchangeRate.date)})'),
      ],
    );
  }
}
