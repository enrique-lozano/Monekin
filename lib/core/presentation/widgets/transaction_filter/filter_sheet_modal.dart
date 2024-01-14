import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/category_selector.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_field.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/status_filter/transaction_status_filter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/tags_filter/tags_filter_container.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../app_colors.dart';

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
        initialChildSize: 0.6,
        maxChildSize: 1,
        snapSizes: const [0.33, 0.6, 1],
        builder: (context, scrollController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                child: Text(
                  t.general.filters,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
                                  final selectedAccounts = (snapshot.data ?? [])
                                      .where((element) =>
                                          filtersToReturn.accountsIDs
                                              ?.contains(element.id) ??
                                          false);

                                  return selector(
                                      title: t.general.accounts,
                                      inputValue:
                                          filtersToReturn.accountsIDs == null ||
                                                  (snapshot.hasData &&
                                                      filtersToReturn
                                                              .accountsIDs!
                                                              .length ==
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

                                        if (modalRes != null &&
                                            modalRes.isNotEmpty) {
                                          setState(() {
                                            filtersToReturn =
                                                filtersToReturn.copyWith(
                                                    accountsIDs: snapshot
                                                                .hasData &&
                                                            modalRes.length ==
                                                                snapshot.data!
                                                                    .length
                                                        ? null
                                                        : modalRes
                                                            .map((e) => e.id));
                                          });
                                        }
                                      });
                                }),

                            /* ---------------------------------- */
                            /* -------- CATEGORY SELECTOR ------- */
                            /* ---------------------------------- */

                            const SizedBox(height: 16),
                            Text('${t.general.categories}:'),
                            const SizedBox(height: 6),
                            StreamBuilder(
                                stream: CategoryService.instance
                                    .getMainCategories(),
                                builder: (context, snapshot) {
                                  final selectedCategories =
                                      (snapshot.data ?? []).where((element) =>
                                          filtersToReturn.categories
                                              ?.contains(element.id) ??
                                          false);

                                  return CategorySelector(
                                    availableCategories: snapshot.data,
                                    selectedCategories:
                                        selectedCategories.toList(),
                                    onChange: (selection) {
                                      setState(() {
                                        filtersToReturn =
                                            filtersToReturn.copyWith(
                                          categories: selection
                                              ?.map((e) => e.id)
                                              .toList(),
                                        );
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
                                          filtersToReturn = filtersToReturn
                                              .copyWith(minDate: value);
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
                                          filtersToReturn = filtersToReturn
                                              .copyWith(maxDate: value);
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
                                stream: CurrencyService.instance
                                    .getUserPreferredCurrency(),
                                builder: (context, prefCurrencySnapshot) {
                                  return Row(
                                    children: [
                                      Flexible(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText:
                                              t.transaction.filters.from_value,
                                          hintText: 'Ex.: 200',
                                          suffixText:
                                              prefCurrencySnapshot.data?.symbol,
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return null;
                                          }

                                          final defaultNumberValidatorResult =
                                              fieldValidator(value,
                                                  isRequired: false,
                                                  validator:
                                                      ValidatorType.double);

                                          if (defaultNumberValidatorResult !=
                                              null) {
                                            return defaultNumberValidatorResult;
                                          }

                                          final valToNum = double.parse(value);

                                          if (valToNum < 0) {
                                            return t
                                                .general.validations.positive;
                                          } else if (filtersToReturn.maxValue !=
                                                  null &&
                                              valToNum >
                                                  filtersToReturn.maxValue!) {
                                            return t.general.validations
                                                .max_number(
                                                    x: filtersToReturn
                                                        .maxValue!);
                                          }

                                          return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: decimalDigitFormatter,
                                        initialValue:
                                            (filtersToReturn.minValue ?? 0)
                                                .toStringAsFixed(2),
                                        onChanged: (value) {
                                          filtersToReturn =
                                              filtersToReturn.copyWith(
                                            minValue: double.tryParse(value),
                                          );

                                          setState(() {});
                                        },
                                      )),
                                      const SizedBox(width: 16),
                                      Flexible(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText:
                                              t.transaction.filters.to_value,
                                          hintText: 'Ex.: 200',
                                          suffixText:
                                              prefCurrencySnapshot.data?.symbol,
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return null;
                                          }

                                          final defaultNumberValidatorResult =
                                              fieldValidator(value,
                                                  isRequired: false,
                                                  validator:
                                                      ValidatorType.double);

                                          if (defaultNumberValidatorResult !=
                                              null) {
                                            return defaultNumberValidatorResult;
                                          }

                                          final valToNum = double.parse(value);

                                          if (valToNum <
                                              (filtersToReturn.minValue ?? 0)) {
                                            return t.general.validations
                                                .min_number(
                                                    x: filtersToReturn
                                                        .minValue!);
                                          }

                                          return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: decimalDigitFormatter,
                                        initialValue: filtersToReturn.maxValue
                                            ?.toStringAsFixed(2),
                                        onChanged: (value) {
                                          filtersToReturn =
                                              filtersToReturn.copyWith(
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
                                  transactionTypeFilter(
                                      context, TransactionType.income),
                                  const SizedBox(width: 6),
                                  transactionTypeFilter(
                                      context, TransactionType.expense),
                                  const SizedBox(width: 6),
                                  transactionTypeFilter(
                                      context, TransactionType.transfer),
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
                                    newListToAssign = TransactionStatus.notIn(
                                        {statusSelected});
                                  } else {
                                    newListToAssign = TransactionStatus.notIn(
                                        {},
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
                                  filtersToReturn = filtersToReturn.copyWith(
                                      status: newListToAssign);
                                });
                              },
                            ),

                            /* ---------------------------------- */
                            /* -------------- TAGS -------------- */
                            /* ---------------------------------- */

                            const SizedBox(height: 16),
                            TagsFilterContainer(
                              child: StreamBuilder(
                                stream: TagService.instance.getTags(),
                                builder: (context, snapshot) {
                                  return Wrap(
                                    spacing: 6,
                                    runSpacing: 0,
                                    children: [
                                      FilterChip(
                                        label: Text(t.tags.without_tags),
                                        selected: isTagSelected(null),
                                        onSelected: (value) => setState(() {
                                          var newListToAssign =
                                              filtersToReturn.tagsIDs?.toList();

                                          if (newListToAssign == null) {
                                            newListToAssign = snapshot.data!
                                                .map((e) => e.id)
                                                .toList();
                                          } else if (value) {
                                            newListToAssign = [
                                              ...newListToAssign,
                                              null
                                            ];
                                          } else {
                                            newListToAssign.removeWhere(
                                                (element) => element == null);
                                          }

                                          if (newListToAssign.length ==
                                              snapshot.data!.length + 1) {
                                            newListToAssign = null;
                                          }

                                          setState(() {
                                            filtersToReturn =
                                                filtersToReturn.copyWith(
                                              tagsIDs: newListToAssign,
                                            );
                                          });
                                        }),
                                        showCheckmark: false,
                                        avatar: Icon(Icons.label_off_rounded,
                                            color:
                                                AppColors.of(context).primary),
                                      ),
                                      if (snapshot.data != null)
                                        ...List.generate(snapshot.data!.length,
                                            (index) {
                                          final tag = snapshot.data![index];

                                          return FilterChip(
                                            label: Text(tag.name),
                                            selected: isTagSelected(tag.id),
                                            onSelected: (value) {
                                              var newListToAssign =
                                                  filtersToReturn.tagsIDs
                                                      ?.toList();

                                              if (newListToAssign == null) {
                                                newListToAssign = [
                                                  null,
                                                  ...snapshot.data!
                                                      .whereNot((element) =>
                                                          element.id == tag.id)
                                                      .map((e) => e.id)
                                                      .toList()
                                                ];
                                              } else if (value) {
                                                newListToAssign.add(tag.id);
                                              } else {
                                                newListToAssign.removeWhere(
                                                    (element) =>
                                                        element == tag.id);
                                              }

                                              if (newListToAssign.length ==
                                                  snapshot.data!.length + 1) {
                                                newListToAssign = null;
                                              }

                                              setState(() {
                                                filtersToReturn =
                                                    filtersToReturn.copyWith(
                                                  tagsIDs: newListToAssign,
                                                );
                                              });
                                            },
                                            showCheckmark: false,
                                            avatar: tag.displayIcon(),
                                          );
                                        }),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ScrollableWithBottomGradient.buildPositionedGradient(
                        AppColors.of(context).background),
                  ],
                ),
              ),
              BottomSheetFooter(
                  onSaved: !(_formKey.currentState?.validate() ?? true) ||
                          filtersToReturn.tagsIDs != null &&
                              filtersToReturn.tagsIDs!.isEmpty
                      ? null
                      : () => Navigator.of(context).pop(filtersToReturn)),
            ],
          );
        });
  }
}
