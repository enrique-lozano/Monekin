import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/i18n/translations.g.dart';

showCurrencySelectorModal(
  BuildContext context,
  CurrencySelectorModal modalData,
) {
  showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => modalData);
}

class CurrencySelectorModal extends StatefulWidget {
  const CurrencySelectorModal(
      {super.key, this.preselectedCurrency, this.onCurrencySelected});

  final void Function(Currency selectedCurrency)? onCurrencySelected;

  final Currency? preselectedCurrency;

  @override
  State<CurrencySelectorModal> createState() => _CurrencySelectorModalState();
}

class _CurrencySelectorModalState extends State<CurrencySelectorModal> {
  CurrencyService? _currencyService;

  List<Currency>? _filteredCurrencies;

  Currency? _selectedCurrency;

  @override
  void initState() {
    super.initState();

    _currencyService = CurrencyService.instance;
    _selectedCurrency = widget.preselectedCurrency;

    _currencyService!.getCurrencies().first.then((value) {
      setState(() {
        _filteredCurrencies = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final t = Translations.of(context);

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.85,
      minChildSize: 0.625,
      initialChildSize: 0.85,
      builder: (context, scrollController) {
        return ModalContainer(
          title: t.currencies.select_a_currency,
          endWidget: Chip(
            side: BorderSide(color: colors.primary, width: 2),
            // backgroundColor: AppColors.of(context).primaryLight,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text(_selectedCurrency?.code ?? '???')),
                Container(
                  margin: const EdgeInsets.only(left: 6),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: _selectedCurrency != null
                      ? _selectedCurrency!.displayFlagIcon(size: 20)
                      : const Skeleton(width: 22, height: 22),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  filled: false,
                  isDense: false,
                  hintText: t.currencies.search,
                  labelText: t.general.tap_to_search,
                  floatingLabelStyle: const TextStyle(height: -0.0005),
                  prefixIcon: const Icon(Icons.search),
                  border: const UnderlineInputBorder(),
                ),
                onChanged: (value) {
                  CurrencyService.instance
                      .searchCurrencies(value)
                      .first
                      .then((curr) {
                    setState(() {
                      _filteredCurrencies = curr;
                    });
                  });
                  (() {});
                },
              ),
              Expanded(
                child: Stack(children: [
                  ListView.separated(
                    controller: scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: _filteredCurrencies?.length ?? 0,
                    separatorBuilder: (context, i) {
                      return const Divider(height: 0);
                    },
                    itemBuilder: (context, index) {
                      final currencyItem = _filteredCurrencies![index];

                      return ListTile(
                        title: Text(
                          currencyItem.name,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                        trailing: Text(
                          currencyItem.code,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        selected: currencyItem.code == _selectedCurrency?.code,
                        // selectedTileColor: colors.primaryContainer,
                        leading: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                currencyItem.currencyIconPath,
                                height: 35,
                                width: 35,
                              ),
                              if (currencyItem.code == _selectedCurrency?.code)
                                Container(
                                    height: 35,
                                    width: 35,
                                    color: const Color.fromARGB(92, 0, 0, 0),
                                    child: const Center(
                                        child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )))
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCurrency = currencyItem;
                          });
                        },
                      );
                    },
                  ),
                  ScrollableWithBottomGradient.buildPositionedGradient(
                      AppColors.of(context).modalBackground),
                ]),
              ),
            ],
          ),
          footer: BottomSheetFooter(
            onSaved: _selectedCurrency != null
                ? () {
                    Navigator.pop(context);

                    widget.onCurrencySelected!(_selectedCurrency!);
                  }
                : null,
          ),
        );
      },
    );
  }
}
