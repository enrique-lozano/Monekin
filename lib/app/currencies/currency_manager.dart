import 'package:flutter/material.dart';
import 'package:monekin/app/currencies/exchange_rate_details.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/widgets/no_results.dart';

class CurrencyManagerPage extends StatefulWidget {
  const CurrencyManagerPage({super.key});

  @override
  State<CurrencyManagerPage> createState() => _CurrencyManagerPageState();
}

class _CurrencyManagerPageState extends State<CurrencyManagerPage> {
  Currency? _userCurrency;

  @override
  void initState() {
    super.initState();

    CurrencyService.instance.getUserPreferredCurrency().first.then((value) {
      setState(() {
        _userCurrency = value;
      });
    });
  }

  changePreferredCurrency(Currency newCurrency) {
    final t = Translations.of(context);

    confirmDialog(
      context,
      dialogTitle: t.currencies.change_preferred_currency_title,
      contentParagraphs: [Text(t.currencies.change_preferred_currency_msg)],
    ).then((isConfirmed) {
      if (isConfirmed != true) return;

      UserSettingService.instance
          .setSetting(SettingKey.preferredCurrency, newCurrency.code)
          .then(
        (value) {
          setState(() {
            _userCurrency = newCurrency;
          });

          ExchangeRateService.instance.deleteExchangeRates();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.currencies.currency_manager)),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: _userCurrency != null
                  ? _userCurrency!.displayFlagIcon(size: 42)
                  : const Skeleton(height: 42, width: 42),
            ),
            title: Text(t.currencies.preferred_currency),
            subtitle: _userCurrency != null
                ? Text(_userCurrency!.name)
                : const Skeleton(height: 12, width: 50),
            onTap: () {
              if (_userCurrency == null) return;

              showCurrencySelectorModal(
                context,
                CurrencySelectorModal(
                    preselectedCurrency: _userCurrency!,
                    onCurrencySelected: (newCurrency) async {
                      await Future.delayed(const Duration(milliseconds: 250));
                      changePreferredCurrency(newCurrency);
                    }),
              );
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t.currencies.exchange_rates),
                TextButton(
                    onPressed: () async {
                      await showExchangeRateFormDialog(
                          context, const ExchangeRateFormDialog());
                    },
                    child: Text(t.general.add))
              ],
            ),
          ),
          StreamBuilder(
            stream: ExchangeRateService.instance.getExchangeRates(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }

              if (snapshot.data!.isEmpty) {
                // Data has loaded but is empty:
                return Expanded(
                    child: NoResults(
                        title: t.general.empty_warn,
                        description: t.currencies.empty));
              }

              final exchangeRates = snapshot.data!;

              return SingleChildScrollView(
                child: ListView.separated(
                  itemCount: exchangeRates.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = exchangeRates[index];

                    return ListTile(
                      leading: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: StreamBuilder(
                            stream: CurrencyService.instance
                                .getCurrencyByCode(item.currencyCode),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Skeleton(width: 42, height: 42);
                              }

                              return snapshot.data!.displayFlagIcon(size: 42);
                            },
                          )),
                      title: Text(item.currency.code),
                      subtitle: StreamBuilder(
                          stream: CurrencyService.instance
                              .getCurrencyByCode(item.currencyCode),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Skeleton(width: 40, height: 16);
                            }

                            return Text(snapshot.data!.name);
                          }),
                      trailing: Text(item.exchangeRate.toString()),
                      onTap: () async {
                        final currency = await CurrencyService.instance
                            .getCurrencyByCode(item.currencyCode)
                            .first;

                        if (currency == null) return;

                        RouteUtils.pushRoute(context,
                            ExchangeRateDetailsPage(currency: currency));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(indent: 68);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
