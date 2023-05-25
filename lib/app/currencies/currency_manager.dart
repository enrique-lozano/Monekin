import 'package:finlytics/app/currencies/exchange_rate_details.dart';
import 'package:finlytics/app/currencies/exchange_rate_form.dart';
import 'package:finlytics/core/database/services/currency/currency_service.dart';
import 'package:finlytics/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:finlytics/core/database/services/user-setting/user_setting_service.dart';
import 'package:finlytics/core/models/currency/currency.dart';
import 'package:finlytics/core/presentation/widgets/currency_selector_modal.dart';
import 'package:finlytics/core/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

import '../../core/presentation/widgets/empty_indicator.dart';

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

    CurrencyService.instance.getUserPreferredCurrency().then((value) {
      setState(() {
        _userCurrency = value;
      });
    });
  }

  changePreferredCurrency(Currency newCurrency) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change the base currency'),
          content: const SingleChildScrollView(
              child: Text(
                  'All the saved exchange rates will be deleted if you perform this action')),
          actions: [
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
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

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency manager'),
      ),
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
            title: const Text('Divisa base'),
            subtitle: _userCurrency != null
                ? Text(_userCurrency!.name)
                : const Skeleton(height: 12, width: 50),
            onTap: () {
              if (_userCurrency == null) return;

              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return CurrencySelectorModal(
                        preselectedCurrency: _userCurrency!,
                        onCurrencySelected: (newCurrency) async {
                          await Future.delayed(
                              const Duration(milliseconds: 250));
                          changePreferredCurrency(newCurrency);
                        });
                  });
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tipos de cambio'),
                TextButton(
                    onPressed: () async {
                      await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const ExchangeRateFormDialog();
                          });
                    },
                    child: const Text('Añadir'))
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
                return const Expanded(
                    child: EmptyIndicator(
                        title: 'No hay registros',
                        description:
                            'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos'));
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
                        final onTapContext = context;

                        final currency = await CurrencyService.instance
                            .getCurrencyByCode(item.currencyCode)
                            .first;

                        if (currency == null) return;

                        Navigator.push(
                            onTapContext,
                            MaterialPageRoute(
                                builder: (context) => ExchangeRateDetailsPage(
                                      currency: currency,
                                    )));
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