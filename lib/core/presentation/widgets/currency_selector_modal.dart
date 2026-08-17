import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/presentation/widgets/sheet_or_fixed.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

void showCurrencySelectorModal(
  BuildContext context,
  CurrencySelectorModal modalData,
) {
  RouteUtils.showResponsiveModal(context, builder: (context) => modalData);
}

class CurrencySelectorModal extends StatefulWidget {
  const CurrencySelectorModal({
    super.key,
    this.preselectedCurrency,
    required this.onCurrencySelected,
  });

  final ValueChanged<Currency> onCurrencySelected;

  final Currency? preselectedCurrency;

  @override
  State<CurrencySelectorModal> createState() => _CurrencySelectorModalState();
}

class _CurrencySelectorModalState extends State<CurrencySelectorModal> {
  CurrencyService? _currencyService;

  List<Currency>? _filteredCurrencies;

  Currency? _selectedCurrency;

  final FocusNode _searchFocus = createPopoverSearchFocusNode();
  int _searchGeneration = 0;

  @override
  void initState() {
    super.initState();

    _currencyService = CurrencyService.instance;
    _selectedCurrency = widget.preselectedCurrency;

    unawaited(_loadCurrencies());
  }

  Future<void> _loadCurrencies() async {
    final generation = ++_searchGeneration;
    final currencies = await _currencyService!.getAllCurrencies().first;
    if (!mounted || generation != _searchGeneration) return;

    setState(() => _filteredCurrencies = currencies);
  }

  Future<void> _searchCurrencies(String query) async {
    final generation = ++_searchGeneration;
    final currencies = await CurrencyService.instance
        .searchCurrencies(query)
        .first;

    if (!mounted || generation != _searchGeneration) return;
    setState(() => _filteredCurrencies = currencies);
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final t = Translations.of(context);

    return SheetOrFixed(
      maxChildSize: 0.85,
      minChildSize: 0.625,
      initialChildSize: 0.85,
      builder: (context, scrollController) {
        return ModalContainer(
          title: t.currencies.select_a_currency,
          endWidget: Chip(
            side: BorderSide(color: colors.primary, width: 2),
            // backgroundColor: Theme.of(context).colorScheme.primaryLight,
            avatar: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: _selectedCurrency != null
                  ? _selectedCurrency!.displayFlagIcon(size: 22)
                  : Bone.circle(size: 22),
            ),
            label: Text(_selectedCurrency?.code ?? '???'),
          ),
          body: Column(
            children: [
              TextField(
                focusNode: _searchFocus,
                autofocus: ModalPresentation.isPopover(context),
                decoration: InputDecoration(
                  filled: false,
                  isDense: false,
                  hintText: t.currencies.search,
                  labelText: t.general.tap_to_search,
                  floatingLabelStyle: const TextStyle(height: -0.0005),
                  prefixIcon: const Icon(Icons.search),
                  border: const UnderlineInputBorder(),
                ),
                onChanged: (value) => unawaited(_searchCurrencies(value)),
              ),
              Expanded(
                child: Material(
                  color: AppColors.of(context).modalBackground,
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
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
                            selected:
                                currencyItem.code == _selectedCurrency?.code,
                            // selectedTileColor: colors.primaryContainer,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Stack(
                                children: [
                                  currencyItem.displayFlagIcon(size: 35),
                                  if (currencyItem.code ==
                                      _selectedCurrency?.code)
                                    Container(
                                      height: 35,
                                      width: 35,
                                      color: const Color.fromARGB(92, 0, 0, 0),
                                      child: const Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            onTap: () {
                              // In a popover single-select applies + closes on
                              // tap (no save button).
                              if (ModalPresentation.isPopover(context)) {
                                widget.onCurrencySelected(currencyItem);
                                RouteUtils.popRoute();
                                return;
                              }

                              setState(() {
                                _selectedCurrency = currencyItem;
                              });
                            },
                          );
                        },
                      ),
                      ScrollableWithBottomGradient.buildPositionedGradient(
                        AppColors.of(context).modalBackground,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          footer: ModalPresentation.isPopover(context)
              ? null
              : BottomSheetFooter(
                  onSaved: _selectedCurrency != null
                      ? () {
                          RouteUtils.popRoute();

                          widget.onCurrencySelected(_selectedCurrency!);
                        }
                      : null,
                ),
        );
      },
    );
  }
}
