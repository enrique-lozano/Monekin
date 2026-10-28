import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/app/currencies/edit_currency_page.dart';
import 'package:monekin/app/currencies/exchange_rate_details.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/settings_list_utils.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/exchange-rate/ecb_rate_sync.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart' hide Skeleton;

import '../../core/presentation/widgets/no_results.dart';

class CurrencyManagerPage extends StatefulWidget {
  const CurrencyManagerPage({super.key});

  @override
  State<CurrencyManagerPage> createState() => _CurrencyManagerPageState();
}

class _CurrencyManagerPageState extends State<CurrencyManagerPage> {
  bool _updatingRates = false;
  List<String> _failedCurrencies = [];

  Future<void> _updateRates() async {
    final t = Translations.of(context);
    final preferred = await CurrencyService.instance
        .ensureAndGetPreferredCurrency()
        .first;

    setState(() {
      _updatingRates = true;
      _failedCurrencies = [];
    });
    MonekinSnackbar.info(
      SnackbarParams(t.currencies.update_rates_loading, showAtTop: false),
    );

    try {
      final result = await syncEcbRates(preferredCurrency: preferred.code);
      if (!mounted) return;

      setState(() => _failedCurrencies = result.failedCurrencies);

      MonekinSnackbar.success(
        SnackbarParams(
          result.addedRates == 0
              ? t.currencies.update_rates_up_to_date
              : t.currencies.update_rates_success(
                  added: result.addedRates,
                  currencies: result.updatedCurrencies,
                ),
          showAtTop: false,
        ),
      );
    } finally {
      if (mounted) setState(() => _updatingRates = false);
    }
  }

  Widget _buildUpdateAction(BuildContext context) {
    final t = Translations.of(context);
    final isWide = BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.lg);

    return StreamBuilder(
      stream: ExchangeRateService.instance.getExchangeRates(),
      builder: (context, snapshot) {
        if (snapshot.data?.isNotEmpty != true) return const SizedBox.shrink();

        final onPressed = _updatingRates ? null : _updateRates;
        final icon = _updatingRates
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.sync_rounded);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: isWide
              ? FilledButton.tonalIcon(
                  onPressed: onPressed,
                  icon: icon,
                  label: Text(t.currencies.update_rates),
                )
              : IconButton.filledTonal(
                  tooltip: t.currencies.update_rates,
                  onPressed: onPressed,
                  icon: icon,
                ),
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
    ).then((isConfirmed) {
      if (isConfirmed != true) return;

      UserSettingService.instance
          .setItem(SettingKey.preferredCurrency, newCurrency.code)
          .then((value) {
            ExchangeRateService.instance.deleteExchangeRates();
          });
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
      appBarActions: [_buildUpdateAction(context)],
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
                            if (userCurrency == null) return;

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

            for (final code in _failedCurrencies)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: InlineInfoCard(
                  text: t.currencies.update_rates_failure(currency: code),
                  mode: InlineInfoCardMode.warn,
                ),
              ),

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
                      trailing: Text(
                        item.exchangeRate.toStringAsFixed(
                          max(4, item.currency.decimalPlaces),
                        ),
                        style: Theme.of(context).textTheme.labelLarge,
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
