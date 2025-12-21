import 'package:flutter/material.dart';
import 'package:monekin/app/currencies/edit_currency_page.dart';
import 'package:monekin/app/currencies/exchange_rate_details.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/settings_list_separator.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart' hide Skeleton;

import '../../core/presentation/widgets/no_results.dart';

class CurrencyManagerPage extends StatelessWidget {
  const CurrencyManagerPage({super.key});

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
      body: Column(
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
                  Skeletonizer(
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
                          context,
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
                  AnimatedExpanded(
                    expand: userCurrency != null,
                    child: ListTile(
                      title: Text(t.currencies.currency_settings),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        if (userCurrency != null) {
                          RouteUtils.pushRoute(
                            context,
                            EditCurrencyPage(currency: userCurrency),
                          );
                        }
                      },
                    ),
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
                return Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NoResults(
                        title: t.general.empty_warn,
                        description: t.currencies.empty,
                      ),
                      FilledButton.tonalIcon(
                        onPressed: () => addExchangeRate(context),
                        icon: const Icon(Icons.add_rounded),
                        label: Text(t.currencies.exchange_rate_form.add),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: exchangeRates.length,
                shrinkWrap: true,
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
                            return const Skeleton(width: 42, height: 42);
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
                        if (!snapshot.hasData) {
                          return const Skeleton(width: 40, height: 16);
                        }

                        return Text(snapshot.data!.name);
                      },
                    ),
                    trailing: Text(item.exchangeRate.toString()),
                    onTap: () async {
                      final currency = await CurrencyService.instance
                          .getCurrencyByCode(item.currencyCode)
                          .first;

                      if (currency == null) return;

                      RouteUtils.pushRoute(
                        context,
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
                expand: asyncSnapshot.hasData && asyncSnapshot.data!.isNotEmpty,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Divider(indent: 68, height: 10, thickness: 1),
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
    );
  }
}
