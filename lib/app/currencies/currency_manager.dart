import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/app/currencies/edit_currency_page.dart';
import 'package:monekin/app/currencies/exchange_rate_details.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/app/currencies/widgets/currency_manager_menu.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/settings_list_utils.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/exchange-rate/ecb_rate_sync.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart' hide Skeleton;
import 'package:sqlite3/sqlite3.dart' show SqliteException;

import '../../core/presentation/widgets/no_results.dart';

void showEcbSyncResultSnackbar(BuildContext context, EcbSyncResult result) {
  final t = Translations.of(context);
  final summary = result.addedRates > 0
      ? t.currencies.update_rates_success(n: result.addedRates)
      : result.unpublishedCurrencies.isNotEmpty
      ? t.currencies.update_rates_supported_up_to_date
      : t.currencies.update_rates_up_to_date;
  final warnings = [
    if (result.connectionFailed) t.currencies.update_rates_error,
    if (result.unpublishedCurrencies.isNotEmpty)
      t.currencies.update_rates_unavailable(
        currencies: result.unpublishedCurrencies.join(', '),
      ),
  ];

  if (result.connectionFailed && result.addedRates == 0) {
    MonekinSnackbar.error(
      SnackbarParams(
        t.currencies.update_rates_error,
        message: result.unpublishedCurrencies.isEmpty
            ? null
            : warnings.skip(1).join('\n'),
        showAtTop: false,
      ),
    );
  } else if (warnings.isNotEmpty) {
    MonekinSnackbar.warning(
      SnackbarParams(
        warnings.join('\n'),
        duration: const Duration(seconds: 6),
        message: summary,
        showAtTop: false,
      ),
    );
  } else {
    MonekinSnackbar.success(
      SnackbarParams(
        summary,
        message: result.addedRates > 0 ? frankfurterEcbCredit : null,
        showAtTop: false,
      ),
    );
  }
}

class CurrencyManagerPage extends StatefulWidget {
  const CurrencyManagerPage({super.key});

  @override
  State<CurrencyManagerPage> createState() => _CurrencyManagerPageState();
}

class _CurrencyManagerPageState extends State<CurrencyManagerPage> {
  bool _updatingRates = false;
  bool _deletingRates = false;
  bool get _busy => _updatingRates || _deletingRates;

  Future<void> _updateRates() async {
    if (_busy) return;
    final t = Translations.of(context);
    setState(() {
      _updatingRates = true;
    });

    try {
      final preferred = await CurrencyService.instance
          .ensureAndGetPreferredCurrency()
          .first;
      final result = await syncEcbRates(preferredCurrency: preferred.code);
      if (!mounted) return;

      showEcbSyncResultSnackbar(context, result);
    } catch (_) {
      if (!mounted) return;
      MonekinSnackbar.error(
        SnackbarParams(t.currencies.update_rates_error, showAtTop: false),
      );
    } finally {
      if (mounted) setState(() => _updatingRates = false);
    }
  }

  Widget _buildLastUpdate(DateTime date) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final days = DateTime.now().dayDifference(date);
    final isToday = days <= 0;

    return Text(
      isToday
          ? t.currencies.updated_today
          : t.currencies.updated_days_ago(n: days),
      style: theme.textTheme.labelSmall?.copyWith(
        color: isToday
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Future<void> _deleteAllRates() async {
    if (_busy) return;
    final t = Translations.of(context);
    setState(() => _deletingRates = true);
    try {
      await ExchangeRateService.instance.deleteExchangeRates();
      if (!mounted) return;
      MonekinSnackbar.success(
        SnackbarParams(t.currencies.delete_all_success, showAtTop: false),
      );
    } on SqliteException {
      if (!mounted) return;
      MonekinSnackbar.error(
        SnackbarParams(t.currencies.delete_rates_error, showAtTop: false),
      );
    } finally {
      if (mounted) setState(() => _deletingRates = false);
    }
  }

  Widget _buildActions(BuildContext context) {
    return StreamBuilder(
      stream: ExchangeRateService.instance.getExchangeRates(),
      builder: (context, snapshot) {
        if (snapshot.data?.isNotEmpty != true) return const SizedBox.shrink();

        return CurrencyManagerMenu(
          busy: _busy,
          onUpdate: () => unawaited(_updateRates()),
          onDelete: _deleteAllRates,
        );
      },
    );
  }

  void changePreferredCurrency(BuildContext context, Currency newCurrency) {
    final t = Translations.of(context);

    confirmDialog(
      context,
      dialogTitle: t.currencies.change_preferred_currency_title,
      contentParagraphs: [Text(t.currencies.change_preferred_currency_msg)],
    ).then((isConfirmed) async {
      if (isConfirmed != true) return;

      try {
        await ExchangeRateService.instance.changePreferredCurrency(
          newCurrency.code,
        );
      } catch (err) {
        if (!mounted) return;
        MonekinSnackbar.error(SnackbarParams.fromError(err));
      }
    });
  }

  Future<void> addExchangeRate(BuildContext context) async {
    final newRate = await showExchangeRateFormDialog(
      context,
      const ExchangeRateFormDialog(),
    );

    if (newRate != null) {
      await ExchangeRateService.instance.insertOrUpdateExchangeRate(newRate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: Translations.of(context).currencies.currency_manager,
      appBarActions: [_buildActions(context)],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 12).withSafeBottom(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListSeparator(context, t.currencies.preferred_currency),
            StreamBuilder(
              stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
              builder: (context, snapshot) {
                final userCurrency = snapshot.data;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Wrapped in a [Builder] so the popover anchors to *this*
                    // tile's render box instead of the whole StreamBuilder
                    // column (which also contains the "currency settings" tile).
                    Builder(
                      builder: (tileContext) => Skeletonizer(
                        enabled: userCurrency == null,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: userCurrency != null
                                ? userCurrency.displayFlagIcon(size: 42)
                                : Container(
                                    height: 42,
                                    width: 42,
                                    color: Colors.red,
                                  ),
                          ),
                          title: Text(
                            userCurrency == null
                                ? 'PLA - Placeholder'
                                : ('${userCurrency.name} - ${userCurrency.code}'),
                          ),
                          subtitle: Text(
                            t.currencies.tap_to_change_preferred_currency,
                          ),
                          onTap: () {
                            if (userCurrency == null || _busy) return;

                            showCurrencySelectorModal(
                              tileContext,
                              CurrencySelectorModal(
                                preselectedCurrency: userCurrency,
                                onCurrencySelected: (newCurrency) async {
                                  await Future.delayed(
                                    const Duration(milliseconds: 250),
                                  );
                                  changePreferredCurrency(context, newCurrency);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(t.currencies.currency_settings),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      enabled: userCurrency != null,
                      onTap: () {
                        if (userCurrency != null) {
                          RouteUtils.showResponsiveForm(
                            EditCurrencyPage(currency: userCurrency),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            createListSeparator(context, t.currencies.exchange_rates),

            StreamBuilder(
              stream: ExchangeRateService.instance.getExchangeRates(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const LinearProgressIndicator();
                }

                final exchangeRates = snapshot.data!;

                if (exchangeRates.isEmpty) {
                  // Data has loaded but is empty:
                  return NoResults(
                    title: t.general.empty_warn,
                    description: t.currencies.empty,
                    bottom: FilledButton.tonalIcon(
                      onPressed: () => addExchangeRate(context),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(t.currencies.exchange_rate_form.add),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: exchangeRates.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = exchangeRates[index];

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: StreamBuilder(
                          stream: CurrencyService.instance.getCurrencyByCode(
                            item.currencyCode,
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Bone.square(size: 42);
                            }

                            return snapshot.data!.displayFlagIcon(size: 42);
                          },
                        ),
                      ),
                      title: Text(item.currency.code),
                      subtitle: StreamBuilder(
                        stream: CurrencyService.instance.getCurrencyByCode(
                          item.currencyCode,
                        ),
                        builder: (context, snapshot) {
                          return Skeletonizer(
                            enabled: !snapshot.hasData,
                            child: Text(snapshot.data?.name ?? BoneMock.name),
                          );
                        },
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.exchangeRate.toStringAsFixed(
                              max(4, item.currency.decimalPlaces),
                            ),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          _buildLastUpdate(item.date),
                        ],
                      ),
                      onTap: () async {
                        final currency = await CurrencyService.instance
                            .getCurrencyByCode(item.currencyCode)
                            .first;

                        if (currency == null) return;

                        RouteUtils.pushRoute(
                          ExchangeRateDetailsPage(currency: currency),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(indent: 68);
                  },
                );
              },
            ),

            StreamBuilder(
              stream: ExchangeRateService.instance.getExchangeRates(),
              builder: (context, asyncSnapshot) {
                return AnimatedExpanded(
                  expand:
                      asyncSnapshot.hasData && asyncSnapshot.data!.isNotEmpty,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Divider(indent: 68, height: 1, thickness: 1),
                      ListTile(
                        title: Text(t.currencies.exchange_rate_form.add),
                        minVerticalPadding: 16,

                        leading: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.125),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onTap: () => addExchangeRate(context),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
