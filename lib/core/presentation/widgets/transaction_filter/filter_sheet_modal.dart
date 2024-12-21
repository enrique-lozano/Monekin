import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/selectors/category_multi_selector.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/status_filter/transaction_status_filter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../../models/transaction/transaction_type.enum.dart';
import '../count_indicator.dart';
import '../form_fields/list_tile_field.dart';

Future<TransactionFilters?> openFilterSheetModal(
    BuildContext context, FilterSheetModal modalData) {
  return showModalBottomSheet<TransactionFilters>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => modalData);
}

class FilterSheetModal extends StatefulWidget {
  const FilterSheetModal({
    super.key,
    required this.preselectedFilter,
    this.showDateFilter = true,
  });

  final TransactionFilters preselectedFilter;

  final bool showDateFilter;

  @override
  State<FilterSheetModal> createState() => _FilterSheetModalState();
}

class _FilterSheetModalState extends State<FilterSheetModal> {
  late TransactionFilters filtersToReturn;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    filtersToReturn = widget.preselectedFilter;
  }

  bool isTagSelected(String? tagId) {
    return filtersToReturn.tagsIDs == null ||
        filtersToReturn.tagsIDs!.any((element) => element == tagId);
  }

  FilterChip transactionTypeFilter(BuildContext context, TransactionType type) {
    bool isSelected = filtersToReturn.transactionTypes == null ||
        filtersToReturn.transactionTypes!
            .map((e) => e.index)
            .contains(type.index);

    return FilterChip(
        label: Text(type.displayName(context, plural: true)),
        selected: isSelected,
        showCheckmark: false,
        avatar: Icon(
          type.icon,
          color: type.color(context),
        ),
        onSelected: (value) {
          filtersToReturn = filtersToReturn.copyWith(
            transactionTypes: !isSelected
                ? (filtersToReturn.transactionTypes?.length ==
                        TransactionType.values.length - 1
                    ? null
                    : filtersToReturn.transactionTypes ?? [type]
                  ?..add(type))
                : (filtersToReturn.transactionTypes ?? TransactionType.values)
                    .where((element) => element.index != type.index)
                    .toList(),
          );

          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.85,
      minChildSize: 0.65,
      builder: (context, scrollController) {
        return ModalContainer(
          title: t.general.filters,
          footer: BottomSheetFooter(
              onSaved: !(_formKey.currentState?.validate() ?? true) ||
                      filtersToReturn.tagsIDs != null &&
                          filtersToReturn.tagsIDs!.isEmpty ||
                      filtersToReturn.accountsIDs != null &&
                          filtersToReturn.accountsIDs!.isEmpty ||
                      filtersToReturn.categories != null &&
                          filtersToReturn.categories!.isEmpty
                  ? null
                  : () => Navigator.of(context).pop(filtersToReturn)),
          body: ScrollableWithBottomGradient(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 24),
            gradientColor:
                Theme.of(context).colorSchemeExtended.modalBackground,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* ---------------------------------- */
                  /* -------- ACCOUNT SELECTOR -------- */
                  /* ---------------------------------- */

                  StreamBuilder(
                      stream: AccountService.instance.getAccounts(),
                      builder: (context, snapshot) {
                        List<Account>? selectedAccounts =
                            filtersToReturn.accountsIDs == null
                                ? snapshot.data
                                : (snapshot.data ?? [])
                                    .where(
                                      (element) => filtersToReturn.accountsIDs!
                                          .contains(element.id),
                                    )
                                    .toList();

                        return ListTileField(
                          title: t.general.accounts,
                          leading: const Icon(Icons.account_balance_rounded),
                          trailing: CountIndicatorWithExpandArrow(
                            countToDisplay: filtersToReturn.accountsIDs?.length,
                          ),
                          subtitle: filtersToReturn.accountsIDs != null
                              ? selectedAccounts!
                                  .map((e) => e.name)
                                  .printFormatted()
                              : t.account.select.all,
                          onTap: () => showAccountSelectorBottomSheet(
                              context,
                              AccountSelectorModal(
                                allowMultiSelection: true,
                                filterSavingAccounts: false,
                                selectedAccounts: selectedAccounts ?? [],
                              )).then((selection) {
                            if (selection == null) return;

                            filtersToReturn = filtersToReturn.copyWith(
                              accountsIDs:
                                  selection.length == snapshot.data!.length
                                      ? null
                                      : selection.map((e) => e.id).toList(),
                            );

                            setState(() {});
                          }),
                        );
                      }),

                  /* ---------------------------------- */
                  /* ---------- TAGS SELECTOR -------- */
                  /* ---------------------------------- */

                  const SizedBox(height: 8),
                  StreamBuilder(
                      stream: TagService.instance.getTags(),
                      builder: (context, snapshot) {
                        List<Tag?> selectedTags =
                            filtersToReturn.tagsIDs == null
                                ? [null, ...(snapshot.data ?? [])]
                                : [
                                    if (filtersToReturn.tagsIDs!.contains(null))
                                      null,
                                    ...(snapshot.data ?? []).where(
                                      (element) => filtersToReturn.tagsIDs!
                                          .contains(element.id),
                                    )
                                  ];

                        return ListTileField(
                          title: t.tags.display(n: 2),
                          leading: Icon(Tag.icon),
                          trailing: CountIndicatorWithExpandArrow(
                            countToDisplay: filtersToReturn.tagsIDs?.length,
                          ),
                          subtitle: filtersToReturn.tagsIDs != null
                              ? selectedTags
                                  .map((e) =>
                                      e == null ? t.tags.without_tags : e.name)
                                  .printFormatted()
                              : t.tags.select.all,
                          onTap: () => showTagListModal(
                            context,
                            modal: TagSelector(
                              selectedTags: selectedTags,
                              allowEmptySubmit: false,
                              includeNullTag: true,
                            ),
                          ).then((selection) {
                            if (selection == null) return;

                            filtersToReturn = filtersToReturn.copyWith(
                              tagsIDs:
                                  selection.length == snapshot.data!.length + 1
                                      ? null
                                      : selection.map((e) => e?.id).toList(),
                            );

                            setState(() {});
                          }),
                        );
                      }),

                  /* ---------------------------------- */
                  /* -------- CATEGORY SELECTOR ------- */
                  /* ---------------------------------- */

                  const SizedBox(height: 8),
                  StreamBuilder(
                      stream: CategoryService.instance.getCategories(),
                      builder: (context, snapshot) {
                        List<Category>? selectedCategories =
                            filtersToReturn.categories == null
                                ? snapshot.data
                                : (snapshot.data ?? [])
                                    .where(
                                      (element) => filtersToReturn.categories!
                                          .contains(element.id),
                                    )
                                    .toList();

                        return ListTileField(
                          title: t.general.categories,
                          leading: const Icon(Icons.category_rounded),
                          trailing: CountIndicatorWithExpandArrow(
                            countToDisplay: filtersToReturn.categories?.length,
                          ),
                          subtitle: filtersToReturn.categories != null
                              ? selectedCategories!
                                  .map((e) => e.name)
                                  .printFormatted()
                              : t.categories.select.all,
                          onTap: () {
                            showMultiCategoryListModal(
                              context,
                              CategoryMultiSelectorModal(
                                selectedCategories: selectedCategories ?? [],
                              ),
                            ).then((selection) {
                              if (selection == null) return;

                              filtersToReturn = filtersToReturn.copyWith(
                                categories:
                                    selection.length == snapshot.data!.length
                                        ? null
                                        : selection.map((e) => e.id),
                              );

                              setState(() {});
                            });
                          },
                        );
                      }),
                  const SizedBox(height: 24),

                  /* ---------------------------------- */
                  /* -------- TRANSACTION DATE -------- */
                  /* ---------------------------------- */

                  if (widget.showDateFilter) ...[
                    Row(
                      children: [
                        Flexible(
                          child: DateTimeFormField(
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.event),
                              labelText: t.general.time.from_date,
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            initialDate: filtersToReturn.minDate,
                            lastDate: filtersToReturn.maxDate,
                            dateFormat: DateFormat.yMMMd(),
                            onDateSelected: (DateTime value) {
                              setState(() {
                                filtersToReturn =
                                    filtersToReturn.copyWith(minDate: value);
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: DateTimeFormField(
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.event),
                              labelText: t.general.time.until_date,
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            initialDate: filtersToReturn.maxDate,
                            firstDate: filtersToReturn.minDate,
                            dateFormat: DateFormat.yMMMd(),
                            onDateSelected: (DateTime value) {
                              setState(() {
                                filtersToReturn =
                                    filtersToReturn.copyWith(maxDate: value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  /* ---------------------------------- */
                  /* ------- TRANSACTION AMOUNT ------- */
                  /* ---------------------------------- */

                  StreamBuilder(
                      stream:
                          CurrencyService.instance.getUserPreferredCurrency(),
                      builder: (context, prefCurrencySnapshot) {
                        return Row(
                          children: [
                            Flexible(
                                child: TextFormField(
                              decoration: InputDecoration(
                                labelText: t.transaction.filters.from_value,
                                hintText: 'Ex.: 200',
                                suffixText: prefCurrencySnapshot.data?.symbol,
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }

                                final defaultNumberValidatorResult =
                                    fieldValidator(value,
                                        isRequired: false,
                                        validator: ValidatorType.double);

                                if (defaultNumberValidatorResult != null) {
                                  return defaultNumberValidatorResult;
                                }

                                final valToNum = double.parse(value);

                                if (valToNum < 0) {
                                  return t.general.validations.positive;
                                } else if (filtersToReturn.maxValue != null &&
                                    valToNum > filtersToReturn.maxValue!) {
                                  return t.general.validations
                                      .max_number(x: filtersToReturn.maxValue!);
                                }

                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              inputFormatters: twoDecimalDigitFormatter,
                              initialValue: (filtersToReturn.minValue ?? 0)
                                  .toStringAsFixed(2),
                              onChanged: (value) {
                                filtersToReturn = filtersToReturn.copyWith(
                                  minValue: double.tryParse(value),
                                );

                                setState(() {});
                              },
                            )),
                            const SizedBox(width: 16),
                            Flexible(
                                child: TextFormField(
                              decoration: InputDecoration(
                                labelText: t.transaction.filters.to_value,
                                hintText: 'Ex.: 200',
                                suffixText: prefCurrencySnapshot.data?.symbol,
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }

                                final defaultNumberValidatorResult =
                                    fieldValidator(value,
                                        isRequired: false,
                                        validator: ValidatorType.double);

                                if (defaultNumberValidatorResult != null) {
                                  return defaultNumberValidatorResult;
                                }

                                final valToNum = double.parse(value);

                                if (valToNum <
                                    (filtersToReturn.minValue ?? 0)) {
                                  return t.general.validations
                                      .min_number(x: filtersToReturn.minValue!);
                                }

                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              inputFormatters: twoDecimalDigitFormatter,
                              initialValue:
                                  filtersToReturn.maxValue?.toStringAsFixed(2),
                              onChanged: (value) {
                                filtersToReturn = filtersToReturn.copyWith(
                                  maxValue: double.tryParse(value),
                                );

                                setState(() {});
                              },
                            )),
                          ],
                        );
                      }),
                  const SizedBox(height: 16),

                  /* ---------------------------------- */
                  /* -------- TRANSACTION TYPE -------- */
                  /* ---------------------------------- */

                  Text('${t.transaction.types.display(n: 10)}:'),
                  const SizedBox(height: 4),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        transactionTypeFilter(context, TransactionType.I),
                        const SizedBox(width: 6),
                        transactionTypeFilter(context, TransactionType.E),
                        const SizedBox(width: 6),
                        transactionTypeFilter(context, TransactionType.T),
                      ],
                    ),
                  ),

                  /* ---------------------------------- */
                  /* ------------- STATUS ------------- */
                  /* ---------------------------------- */

                  const SizedBox(height: 16),
                  TransactionStatusFilter(
                    selectedStatuses: filtersToReturn.status ??
                        [null, ...TransactionStatus.values],
                    allowMultipleSelection: true,
                    onSelected: (statusSelected, value) {
                      var newListToAssign = filtersToReturn.status;

                      if (newListToAssign == null) {
                        if (statusSelected != null) {
                          newListToAssign =
                              TransactionStatus.notIn({statusSelected});
                        } else {
                          newListToAssign = TransactionStatus.notIn({},
                              includeNullStatus: value);
                        }
                      } else if (value) {
                        newListToAssign.add(statusSelected);
                      } else {
                        newListToAssign.removeWhere((element) =>
                            element?.index == statusSelected?.index);
                      }

                      if (newListToAssign.length ==
                          TransactionStatus.values.length + 1) {
                        newListToAssign = null;
                      }

                      setState(() {
                        filtersToReturn =
                            filtersToReturn.copyWith(status: newListToAssign);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
