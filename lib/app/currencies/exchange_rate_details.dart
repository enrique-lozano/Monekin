import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/currencies/exchange_rate_form.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/exchange-rate/exchange_rate.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/translations.g.dart';

class ExchangeRateDetailsPage extends StatefulWidget {
  const ExchangeRateDetailsPage({super.key, required this.currency});

  final Currency currency;

  @override
  State<ExchangeRateDetailsPage> createState() =>
      _ExchangeRateDetailsPageState();
}

class _ExchangeRateDetailsPageState extends State<ExchangeRateDetailsPage> {
  List<ExchangeRate>? exchangeRates;

  @override
  void initState() {
    super.initState();

    getExchangeRates();
  }

  getExchangeRates() {
    ExchangeRateService.instance
        .getExchangeRatesOf(widget.currency.code)
        .first
        .then((value) {
      setState(() {
        exchangeRates = value;
      });
    });
  }

  deleteAllRates() {
    ExchangeRateService.instance
        .deleteExchangeRates(currencyCode: widget.currency.code)
        .then((value) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.currencies.delete_all_success)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.currencies.exchange_rate),
        actions: [
          MonekinPopupMenuButton(actionItems: [
            ListTileActionItem(
                label: t.general.delete,
                icon: Icons.delete,
                onClick: () => deleteAllRates())
          ])
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 6),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: widget.currency.displayFlagIcon(size: 50),
              ),
              const SizedBox(width: 22),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.currency.name,
                    style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .fontSize),
                  ),
                  Text(widget.currency.code),
                ],
              )
            ],
          ),
        ),
        const Divider(height: 10),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(t.currencies.historical),
        ),
        if (exchangeRates != null)
          SingleChildScrollView(
              child: ListView.separated(
            shrinkWrap: true,
            itemCount: exchangeRates!.length,
            itemBuilder: (context, index) {
              final item = exchangeRates![index];

              return ListTile(
                title: Text(DateFormat.yMMMMd().format(item.date)),
                trailing: Text(
                    NumberFormat.currency(symbol: '', decimalDigits: 4)
                        .format(item.exchangeRate)),
                onTap: () async {
                  await showExchangeRateFormDialog(
                      context,
                      ExchangeRateFormDialog(
                        preSelectedCurrency: widget.currency,
                        preSelectedDate: item.date,
                        preSelectedRate: item.exchangeRate,
                        idToEdit: item.id,
                      ));

                  getExchangeRates();
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ))
      ]),
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: () async {
              await showExchangeRateFormDialog(
                context,
                ExchangeRateFormDialog(preSelectedCurrency: widget.currency),
              );

              getExchangeRates();
            },
            icon: const Icon(Icons.add),
            label: Text(t.currencies.form.add),
          ),
        )
      ],
    );
  }
}
