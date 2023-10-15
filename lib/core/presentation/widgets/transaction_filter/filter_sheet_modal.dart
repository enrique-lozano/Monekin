import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/translations.g.dart';

class FilterSheetModal extends StatefulWidget {
  const FilterSheetModal(
      {super.key,
      required this.preselectedFilter,
      this.showCategoryFilter = true});

  final TransactionFilters preselectedFilter;

  final bool showCategoryFilter;

  @override
  State<FilterSheetModal> createState() => _FilterSheetModalState();
}

class _FilterSheetModalState extends State<FilterSheetModal> {
  late TransactionFilters filtersToReturn;

  @override
  void initState() {
    super.initState();

    filtersToReturn = widget.preselectedFilter;
  }

  Widget selector({
    required String title,
    required String? inputValue,
    required Function onClick,
  }) {
    final t = Translations.of(context);

    return TextField(
        controller:
            TextEditingController(text: inputValue ?? t.general.unspecified),
        readOnly: true,
        onTap: () => onClick(),
        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 22),
          child: Text(
            t.general.filters,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                children: [
                  /* ---------------------------------- */
                  /* -------- ACCOUNT SELECTOR -------- */
                  /* ---------------------------------- */

                  StreamBuilder(
                      stream: AccountService.instance.getAccounts(),
                      builder: (context, snapshot) {
                        final selectedAccounts = (snapshot.data ?? []).where(
                            (element) =>
                                filtersToReturn.accountsIDs
                                    ?.contains(element.id) ??
                                false);

                        return selector(
                            title: t.general.accounts,
                            inputValue: filtersToReturn.accountsIDs == null ||
                                    (snapshot.hasData &&
                                        filtersToReturn.accountsIDs!.length ==
                                            snapshot.data!.length)
                                ? t.account.select.all
                                : selectedAccounts
                                    .map((e) => e.name)
                                    .join(', '),
                            onClick: () async {
                              final modalRes =
                                  await showAccountSelectorBottomSheet(
                                      context,
                                      AccountSelector(
                                        allowMultiSelection: true,
                                        filterSavingAccounts: false,
                                        selectedAccounts:
                                            selectedAccounts.toList(),
                                      ));

                              if (modalRes != null && modalRes.isNotEmpty) {
                                setState(() {
                                  filtersToReturn = filtersToReturn.copyWith(
                                      accountsIDs: snapshot.hasData &&
                                              modalRes.length ==
                                                  snapshot.data!.length
                                          ? null
                                          : modalRes.map((e) => e.id));
                                });
                              }
                            });
                      }),

                  /* ---------------------------------- */
                  /* -------- CATEGORY SELECTOR ------- */
                  /* ---------------------------------- */

                  if (widget.showCategoryFilter) ...[
                    const SizedBox(height: 16),
                    StreamBuilder(
                        stream: CategoryService.instance.getCategories(),
                        builder: (context, snapshot) {
                          final selectedCategories = (snapshot.data ?? [])
                              .where((element) =>
                                  filtersToReturn.categories
                                      ?.contains(element.id) ??
                                  false);

                          return selector(
                              title: t.general.categories,
                              inputValue: filtersToReturn.categories == null ||
                                      (snapshot.hasData &&
                                          filtersToReturn.categories!.length ==
                                              snapshot.data!.length)
                                  ? t.categories.select.all
                                  : selectedCategories
                                      .where(
                                          (element) => element.isMainCategory)
                                      .map((e) => e.name)
                                      .join(', '),
                              onClick: () async {
                                final modalRes = await showCategoryListModal(
                                  context,
                                  CategoriesList(
                                    mode: CategoriesListMode
                                        .modalSelectMultiCategory,
                                    selectedCategories:
                                        selectedCategories.toList(),
                                  ),
                                );

                                if (modalRes != null && modalRes.isNotEmpty) {
                                  setState(() {
                                    filtersToReturn = filtersToReturn.copyWith(
                                        categories: snapshot.hasData &&
                                                modalRes.length ==
                                                    snapshot.data!.length
                                            ? null
                                            : modalRes.map((e) => e.id));
                                  });
                                }
                              });
                        }),
                  ]
                ],
              ),
            ),
            BottomSheetFooter(
                onSaved: () => Navigator.of(context).pop(filtersToReturn))
          ],
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}
