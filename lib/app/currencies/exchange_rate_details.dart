import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/app/currencies/widgets/currency_edit_fields.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/currency/currency_type.enum.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/page_content.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/dates/date_range_chips.dart';
import 'package:monekin/core/presentation/widgets/editable_time_series_list.dart';
import 'package:monekin/core/presentation/widgets/evolution_charts/time_series_evolution_chart.dart';
import 'package:monekin/core/presentation/widgets/exit_without_save_warn_dialog.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum _DetailTab { rates, usedIn, settings }

/// A single row of the "used in" section: either a money/investment account
/// denominated in this currency, or a security priced in this currency
/// (aggregated across every account that holds it).
class _UsedInEntry {
  _UsedInEntry.account({required Account this.account, required this.amount})
    : security = null,
      quantity = null;

  _UsedInEntry.security({
    required SecurityInDB this.security,
    required this.quantity,
    required this.amount,
  }) : account = null;

  final Account? account;
  final SecurityInDB? security;
  final double? quantity;

  /// Amount in this currency (the one being viewed).
  final double amount;
}

class ExchangeRateDetailsPage extends StatefulWidget {
  const ExchangeRateDetailsPage({super.key, required this.currency});

  final Currency currency;

  @override
  State<ExchangeRateDetailsPage> createState() =>
      _ExchangeRateDetailsPageState();
}

class _ExchangeRateDetailsPageState extends State<ExchangeRateDetailsPage> {
  List<ExchangeRate>? _originalRates;
  List<ExchangeRate>? _currentRates;
  final List<String> _deletedRateIds = [];

  final GlobalKey<CurrencyEditFieldsState> _currencyFormKey = GlobalKey();

  ExchangeRate? _selectedRate;
  DatePeriodState _dateRange = const DatePeriodState(
    datePeriod: DatePeriod.allTime(),
  );

  _DetailTab _selectedTab = _DetailTab.rates;

  /// Whether the "used in" list is fully expanded (vs. showing a preview).
  bool _usedInExpanded = false;

  /// The user's preferred/base currency, used to display exchange-rate values.
  Currency? _preferredCurrency;

  /// The currency passed to the page, but with the updated info if edited.
  late Currency _currency;

  /// Reactive list of accounts and securities that use this currency. Shared
  /// (replayed) so both the mobile tab badge and the "used in" card can listen.
  late final Stream<List<_UsedInEntry>> _usedInStream = _watchUsedIn()
      .shareReplay(maxSize: 1);

  final ScrollController scrollController = ScrollController();

  bool get _hasChanges {
    if (_originalRates == null || _currentRates == null) return false;

    if (_deletedRateIds.isNotEmpty) return true;
    if (_originalRates!.length != _currentRates!.length) return true;

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

    if (_currencyFormKey.currentState?.hasChanged ?? false) return true;

    return false;
  }

  @override
  void initState() {
    super.initState();

    _currency = widget.currency;

    _loadPreferredCurrency();
    getExchangeRates();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _loadPreferredCurrency() {
    final code = appStateSettings[SettingKey.preferredCurrency];
    if (code == null) return;

    CurrencyService.instance.getCurrencyByCode(code).first.then((c) {
      if (mounted && c != null) {
        setState(() => _preferredCurrency = c);
      }
    });
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

  List<ExchangeRate>? _sortedRatesAsc() {
    if (_currentRates == null) return null;

    return List<ExchangeRate>.from(_currentRates!)
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  List<ExchangeRate> _buildFilteredChartRates() {
    return _dateRange.filterTimeSeries(
      _sortedRatesAsc() ?? const <ExchangeRate>[],
      dateExtractor: (rate) => rate.date,
    );
  }

  DateTimeRange? _chartTimeRange(List<ExchangeRate> sortedRates) {
    if (sortedRates.isEmpty) return null;

    final oldestDay = sortedRates.first.date.justDay();
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
      _selectedRate = null;
    });
  }

  Stream<List<_UsedInEntry>> _watchUsedIn() {
    final code = _currency.code;

    final accountsStream = AccountService.instance.getAccounts(
      predicate: (acc, curr) => curr.code.equals(code),
    );
    final holdingsStream = HoldingService.instance.getAllHoldings();

    return accountsStream.switchMap((accounts) {
      final moneyStreams = accounts
          .map(
            (acc) => AccountService.instance.getAccountMoney(
              account: acc,
              convertToPreferredCurrency: false,
            ),
          )
          .toList();

      final Stream<List<double>> accountsMoney = moneyStreams.isEmpty
          ? Stream<List<double>>.value(const [])
          : Rx.combineLatestList(moneyStreams);

      return Rx.combineLatest2<
        List<double>,
        List<HoldingWithSecurity>,
        List<_UsedInEntry>
      >(accountsMoney, holdingsStream, (moneys, holdings) {
        final entries = <_UsedInEntry>[];

        // Investment accounts already include holdings in `getAccountMoney`;
        // securities below may overlap slightly — accepted for simplicity.
        for (var i = 0; i < accounts.length; i++) {
          entries.add(
            _UsedInEntry.account(account: accounts[i], amount: moneys[i]),
          );
        }

        // Securities priced in this currency, aggregated across all accounts.
        final grouped = <String, ({SecurityInDB security, double qty})>{};
        for (final h in holdings) {
          if (h.security.currencyId != code) continue;
          final prev = grouped[h.security.id];
          grouped[h.security.id] = (
            security: h.security,
            qty: (prev?.qty ?? 0) + h.quantity,
          );
        }

        for (final g in grouped.values) {
          if (g.qty <= 0.0000001) continue;
          entries.add(
            _UsedInEntry.security(
              security: g.security,
              quantity: g.qty,
              amount: g.qty * (g.security.currentPrice ?? 0),
            ),
          );
        }

        return entries;
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

  Future<void> deleteCurrency() async {
    final confirmed = await confirmDialog(
      context,
      icon: Icons.delete_forever_rounded,
      dialogTitle: t.currencies.currency_form.delete,
      contentParagraphs: [],
    );

    if (confirmed == true) {
      try {
        await CurrencyService.instance.deleteCurrency(_currency.code);

        MonekinSnackbar.success(
          SnackbarParams(t.currencies.currency_form.delete_success),
        );

        RouteUtils.popRoute();
      } catch (err) {
        MonekinSnackbar.error(SnackbarParams.fromError(err));
      }
    }
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

        if (original == null) return true;

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

    MonekinSnackbar.success(
      SnackbarParams(t.currencies.currency_form.edit_success),
    );
    getExchangeRates();
  }

  Future<void> _addRate() async {
    final newRate = await showExchangeRateFormDialog(
      context,
      ExchangeRateFormDialog(currency: widget.currency),
    );

    if (newRate == null) return;

    final existingIndex = _currentRates?.indexWhere(
      (r) => DateUtils.isSameDay(r.date, newRate.date),
    );

    setState(() {
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
    });
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

  String _fmtRate(double v) =>
      NumberFormat.decimalPatternDigits(decimalDigits: 4).format(v);

  String _fmtNum2(double v) =>
      NumberFormat.decimalPatternDigits(decimalDigits: 2).format(v);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final isWide = BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.lg);

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
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text('${_currency.code} · ${_currency.symbol}'),
            _typeBadge(),
          ],
        ),
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: _currency.displayFlagIcon(size: 38),
        ),
        appBarActions: [
          if (isWide) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilledButton.icon(
                onPressed: _addRate,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(t.currencies.exchange_rate_form.add),
              ),
            ),
            const SizedBox(width: 4),
          ],
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
                onClick: _currency.isDefault ? null : () => deleteCurrency(),
              ),
            ],
          ),
        ],
        persistentFooterButtons: [
          PersistentFooterButton(
            child: FilledButton.icon(
              style: getMediumButtonStyle(context),
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
        body: ListView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          children: [
            PageContent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeaderBlock(),
                  const SizedBox(height: 16),
                  _buildChartAndStats(),
                  const SizedBox(height: 24),
                  BreakpointContainer(
                    lgBuilder: (context) => _buildDesktopBottom(),
                    builder: (context) => _buildMobileBottom(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header + hero rate
  // ---------------------------------------------------------------------------

  Widget _buildHeaderBlock() {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final hint = AppColors.of(context).textHint;
    final preferredCode = appStateSettings[SettingKey.preferredCurrency] ?? '';

    final loading = _currentRates == null;

    final chartRates = loading
        ? const <ExchangeRate>[]
        : _buildFilteredChartRates();
    final latestOverall = (loading || _currentRates!.isEmpty)
        ? null
        : _currentRates!.reduce((a, b) => a.date.isAfter(b.date) ? a : b);

    final displayRate = _selectedRate ?? latestOverall;
    final displayValue = displayRate?.exchangeRate ?? 1;

    double? base;
    if (chartRates.length >= 2 && chartRates.first.exchangeRate != 0) {
      base = chartRates.first.exchangeRate;
    }
    final changeValue = base == null ? null : displayValue - base;
    final changeFraction = base == null
        ? null
        : (displayValue - base) / base.abs();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeletonizer(
            enabled: loading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.currencies.details
                      .equals_to(code: _currency.code)
                      .toUpperCase(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: hint,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _fmtRate(displayValue),
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      preferredCode,
                      style: theme.textTheme.titleMedium?.copyWith(color: hint),
                    ),
                  ],
                ),
                if (changeValue != null && changeFraction != null) ...[
                  const SizedBox(height: 4),
                  TrendingValue(
                    percentage: changeFraction,
                    value: changeValue,
                    dataTypes: const [
                      TrendingValueDataType.value,
                      TrendingValueDataType.percentage,
                    ],
                    // Rates need more precision than the two decimals money
                    // gets, hence the plain decimal display.
                    showValueDecimals: true,
                    decimalDigits: 4,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _typeBadge() {
    final t = Translations.of(context);
    final color = Theme.of(context).colorScheme.primary;

    final label = switch (_currency.currencyType) {
      CurrencyType.fiat => t.currencies.types.fiat,
      CurrencyType.crypto => t.currencies.types.crypto,
      CurrencyType.custom => t.currencies.types.other,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Chart + min/max/updated stats
  // ---------------------------------------------------------------------------

  Widget _buildChartAndStats() {
    final sortedAsc = _sortedRatesAsc();
    final chartRates = _currentRates == null
        ? null
        : _buildFilteredChartRates();
    final tall = MediaQuery.of(context).size.height > 550;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (sortedAsc != null && sortedAsc.isNotEmpty && tall) ...[
          if (chartRates != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TimeSeriesEvolutionChart<ExchangeRate>(
                data: chartRates,
                timeRange: _chartTimeRange(sortedAsc),
                dateExtractor: (r) => r.date,
                valueExtractor: (r) => r.exchangeRate,
                showYAxisTitles: false,
                onHover: (rate) => setState(() => _selectedRate = rate),
              ),
            ),
          const SizedBox(height: 12),
          DateRangeChips(
            currentPeriod: _dateRange.datePeriod,
            oldestDate: sortedAsc.first.date,
            onPresetSelected: _onPeriodChanged,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 20),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildStatsRow(),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    final t = Translations.of(context);
    final loading = _currentRates == null;
    final chartRates = loading
        ? const <ExchangeRate>[]
        : _buildFilteredChartRates();
    final preferredCode = appStateSettings[SettingKey.preferredCurrency] ?? '';

    ExchangeRate? minRate;
    ExchangeRate? maxRate;
    if (chartRates.isNotEmpty) {
      minRate = chartRates.reduce(
        (a, b) => a.exchangeRate <= b.exchangeRate ? a : b,
      );
      maxRate = chartRates.reduce(
        (a, b) => a.exchangeRate >= b.exchangeRate ? a : b,
      );
    }

    final latest = (loading || _currentRates!.isEmpty)
        ? null
        : _currentRates!.reduce((a, b) => a.date.isAfter(b.date) ? a : b);

    final isToday =
        latest != null && DateUtils.isSameDay(latest.date, DateTime.now());

    String rateText(ExchangeRate? r) =>
        r == null ? '--' : '${_fmtRate(r.exchangeRate)} $preferredCode';
    String dateText(DateTime? d) =>
        d == null ? '' : DateFormat.yMMMd().format(d);

    return Skeletonizer(
      enabled: loading,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildStatItem(
                t.currencies.details.min,
                rateText(minRate),
                dateText(minRate?.date),
              ),
            ),
            _statDivider(),
            Expanded(
              child: _buildStatItem(
                t.currencies.details.max,
                rateText(maxRate),
                dateText(maxRate?.date),
              ),
            ),
            _statDivider(),
            Expanded(
              child: _buildStatItem(
                t.currencies.details.updated,
                latest == null
                    ? '--'
                    : (isToday ? t.general.today : dateText(latest.date)),
                latest == null ? '' : (isToday ? dateText(latest.date) : ''),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statDivider() => Container(
    width: 1,
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
    color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
  );

  Widget _buildStatItem(String label, String primary, String secondary) {
    final theme = Theme.of(context);
    final hint = AppColors.of(context).textHint;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: AppUtils.isMobileSize(context) ? 4 : 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: hint,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            primary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (secondary.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              secondary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(color: hint),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom sections (tabs on mobile, two columns on desktop)
  // ---------------------------------------------------------------------------

  Widget _buildMobileBottom() {
    final t = Translations.of(context);

    return StreamBuilder<List<_UsedInEntry>>(
      stream: _usedInStream,
      builder: (context, snapshot) {
        final entries = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ExpandingSegmentedTabs<_DetailTab>(
                selected: _selectedTab,
                onSelected: (v) => setState(() => _selectedTab = v),
                items: [
                  SegmentedTabItem(
                    value: _DetailTab.rates,
                    icon: Icons.show_chart_rounded,
                    label: t.currencies.details.tabs.rates,
                  ),
                  SegmentedTabItem(
                    value: _DetailTab.usedIn,
                    icon: Icons.account_balance_wallet_outlined,
                    label: t.currencies.details.tabs.used_in,
                    badgeCount: entries?.length,
                  ),
                  SegmentedTabItem(
                    value: _DetailTab.settings,
                    icon: Icons.settings_rounded,
                    label: t.currencies.details.tabs.settings,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_selectedTab == _DetailTab.rates) _buildRatesCard(),
                  if (_selectedTab == _DetailTab.usedIn)
                    _buildUsedInCard(entries),
                  // Kept mounted so unsaved edits survive tab switches.
                  Visibility(
                    visible: _selectedTab == _DetailTab.settings,
                    maintainState: true,
                    child: _buildSettingsCard(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDesktopBottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildRatesCard(),
                const SizedBox(height: 12),
                StreamBuilder<List<_UsedInEntry>>(
                  stream: _usedInStream,
                  builder: (context, snapshot) =>
                      _buildUsedInCard(snapshot.data),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: _buildSettingsCard()),
        ],
      ),
    );
  }

  Widget _countBadge(int count) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$count',
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Rates card (historical list)
  // ---------------------------------------------------------------------------

  Widget _buildRatesCard() {
    final t = Translations.of(context);

    if (_currentRates == null) {
      return Skeletonizer(
        enabled: true,
        child: CardWithHeader(
          title: t.currencies.historical,
          bodyPadding: const EdgeInsets.symmetric(vertical: 4),
          body: Column(
            children: List.generate(
              4,
              (_) => const ListTile(
                title: Text('Placeholder date'),
                trailing: Text('0,0000'),
              ),
            ),
          ),
        ),
      );
    }

    return EditableTimeSeriesCard<ExchangeRate>(
      title: t.currencies.historical,
      titleBuilder: (title) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(title, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 8),
          _countBadge(_currentRates!.length),
        ],
      ),
      headerAction: CardHeaderAction(
        text: t.ui_actions.add,
        icon: const Icon(Icons.add_rounded, size: 15),
        onTap: _addRate,
      ),
      items: _currentRates!,
      dateExtractor: (r) => r.date,
      valueExtractor: (r) => r.exchangeRate,
      currency: _preferredCurrency ?? _currency,
      emptyDescription: t.currencies.historical_empty,
      onEdit: _editRate,
      onDelete: _deleteRate,
    );
  }

  // ---------------------------------------------------------------------------
  // "Used in" card
  // ---------------------------------------------------------------------------

  Widget _buildUsedInCard(List<_UsedInEntry>? entries) {
    final t = Translations.of(context);

    if (entries == null) {
      return Skeletonizer(
        enabled: true,
        child: CardWithHeader(
          title: t.currencies.details.used_in,
          bodyPadding: const EdgeInsets.symmetric(vertical: 4),
          body: Column(
            children: List.generate(
              3,
              (_) => const ListTile(
                leading: CircleAvatar(radius: 20),
                title: Text('Placeholder account name'),
                subtitle: Text('Account type'),
                trailing: Text('0,00'),
              ),
            ),
          ),
        ),
      );
    }

    if (entries.isEmpty) {
      return CardWithHeader(
        title: t.currencies.details.used_in,
        body: NoResults(
          description: t.currencies.details.no_usage,
          showIllustration: false,
        ),
      );
    }

    const previewCount = 5;
    final showAll = _usedInExpanded || entries.length <= previewCount;
    final visible = showAll ? entries : entries.sublist(0, previewCount);
    final total = entries.fold<double>(0, (sum, e) => sum + e.amount);

    return CardWithHeader(
      title: t.currencies.details.used_in,
      titleBuilder: (title) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(title, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 8),
          _countBadge(entries.length),
        ],
      ),
      headerAction: showAll
          ? null
          : CardHeaderAction(
              text: t.ui_actions.see_all,
              onTap: () => setState(() => _usedInExpanded = true),
            ),
      bodyPadding: const EdgeInsets.symmetric(vertical: 4),
      body: Column(
        children: [
          for (final e in visible) _buildUsedInTile(e),
          Divider(
            height: 1,
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
          _buildTotalRow(total),
        ],
      ),
    );
  }

  Widget _buildUsedInTile(_UsedInEntry e) {
    final Widget leading;
    final String title;
    final String subtitle;

    if (e.account != null) {
      leading = e.account!.displayIcon(context);
      title = e.account!.name;
      subtitle = e.account!.type.title(context);
    } else {
      final s = e.security!;
      leading = SecurityAvatar(security: s, size: 40);
      title = s.name;
      final qtyStr = _fmtNum2(e.quantity ?? 0);
      final priceStr = '${_fmtNum2(s.currentPrice ?? 0)} ${_currency.symbol}';
      subtitle = '${s.ticker ?? s.name} · $qtyStr × $priceStr';
    }

    return ListTile(
      leading: leading,
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: _UsedInAmount(amount: e.amount, currency: _currency),
    );
  }

  Widget _buildTotalRow(double total) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              t.currencies.details.total_exposure.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppColors.of(context).textHint,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          _UsedInAmount(amount: total, currency: _currency, emphasize: true),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Settings card
  // ---------------------------------------------------------------------------

  Widget _buildSettingsCard() {
    final t = Translations.of(context);

    return CardWithHeader(
      title: t.currencies.currency_settings,
      body: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 8),
        child: CurrencyEditFields(
          key: _currencyFormKey,
          currency: _currency,
          isInFormMode: false,
          onChanged: () => setState(() {}),
        ),
      ),
    );
  }
}

/// Displays an amount in its own currency, with the converted value in the
/// user's preferred currency below it (hidden when they are the same).
class _UsedInAmount extends StatelessWidget {
  const _UsedInAmount({
    required this.amount,
    required this.currency,
    this.emphasize = false,
  });

  final double amount;
  final Currency currency;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hint = AppColors.of(context).textHint;
    final preferredCode = appStateSettings[SettingKey.preferredCurrency];

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CurrencyDisplayer(
          amountToConvert: amount,
          currency: currency,
          integerStyle:
              (emphasize
                      ? theme.textTheme.titleLarge!
                      : theme.textTheme.titleMedium!)
                  .copyWith(fontWeight: FontWeight.w700),
        ),
        if (preferredCode != null && preferredCode != currency.code)
          StreamBuilder<double>(
            stream: ExchangeRateService.instance
                .calculateExchangeRateToPreferredCurrency(
                  fromCurrency: currency.code,
                  amount: amount,
                ),
            builder: (context, snapshot) {
              final converted = snapshot.data ?? amount;

              return CurrencyDisplayer(
                amountToConvert: converted,
                integerStyle: theme.textTheme.bodySmall!.copyWith(color: hint),
                currencyStyle: theme.textTheme.bodySmall!.copyWith(color: hint),
                decimalsStyle: theme.textTheme.bodySmall!.copyWith(color: hint),
              );
            },
          ),
      ],
    );
  }
}
