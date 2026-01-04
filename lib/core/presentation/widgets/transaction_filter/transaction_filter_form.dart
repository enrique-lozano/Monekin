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
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/status_filter/transaction_status_filter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../../models/transaction/transaction_type.enum.dart';
import '../count_indicator.dart';
import '../form_fields/list_tile_field.dart';

class TransactionFilterForm extends StatefulWidget {
  const TransactionFilterForm({
    super.key,
    required this.filter,
    required this.onChanged,
    this.showDateFilter = true,
  });

  final TransactionFilterSet filter;
  final ValueChanged<TransactionFilterSet> onChanged;
  final bool showDateFilter;

  @override
  State<TransactionFilterForm> createState() => _TransactionFilterFormState();
}

class _TransactionFilterFormState extends State<TransactionFilterForm> {
  late TextEditingController _minAmountController;
  late TextEditingController _maxAmountController;

  @override
  void initState() {
    super.initState();
    _minAmountController = TextEditingController(
      text: widget.filter.minValue?.toStringAsFixed(2) ?? '',
    );
    _maxAmountController = TextEditingController(
      text: widget.filter.maxValue?.toStringAsFixed(2) ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant TransactionFilterForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filter.minValue != oldWidget.filter.minValue) {
      final text = widget.filter.minValue?.toStringAsFixed(2) ?? '';
      final currentVal = double.tryParse(_minAmountController.text);
      if (currentVal != widget.filter.minValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _minAmountController.text = text;
          }
        });
      }
    }
    if (widget.filter.maxValue != oldWidget.filter.maxValue) {
      final text = widget.filter.maxValue?.toStringAsFixed(2) ?? '';
      final currentVal = double.tryParse(_maxAmountController.text);
      if (currentVal != widget.filter.maxValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _maxAmountController.text = text;
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _minAmountController.dispose();
    _maxAmountController.dispose();
    super.dispose();
  }

  FilterChip _transactionTypeFilter(
    BuildContext context,
    TransactionType type,
  ) {
    bool isSelected =
        widget.filter.transactionTypes == null ||
        widget.filter.transactionTypes!
            .map((e) => e.index)
            .contains(type.index);

    return FilterChip(
      label: Text(type.displayName(context, plural: true)),
      selected: isSelected,
      showCheckmark: false,
      avatar: Icon(type.icon, color: type.color(context)),
      onSelected: (value) {
        final newFilter = widget.filter.copyWith(
          transactionTypes: !isSelected
              ? (widget.filter.transactionTypes?.length ==
                          TransactionType.values.length - 1
                      ? null
                      : widget.filter.transactionTypes ?? [type]
                  ?..add(type))
              : (widget.filter.transactionTypes ?? TransactionType.values)
                    .where((element) => element.index != type.index)
                    .toList(),
        );
        widget.onChanged(newFilter);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final filtersToReturn = widget.filter;

    return Column(
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
                        (element) =>
                            filtersToReturn.accountsIDs!.contains(element.id),
                      )
                      .toList();

            return ListTileField(
              title: t.general.accounts,
              leading: const Icon(Icons.account_balance_rounded),
              trailing: CountIndicatorWithExpandArrow(
                countToDisplay: filtersToReturn.accountsIDs?.length,
              ),
              subtitle: filtersToReturn.accountsIDs != null
                  ? selectedAccounts!.map((e) => e.name).printFormatted()
                  : t.account.select.all,
              onTap: () =>
                  showAccountSelectorBottomSheet(
                    context,
                    AccountSelectorModal(
                      allowMultiSelection: true,
                      filterSavingAccounts: false,
                      selectedAccounts: selectedAccounts ?? [],
                    ),
                  ).then((selection) {
                    if (selection == null) return;

                    widget.onChanged(
                      filtersToReturn.copyWith(
                        accountsIDs: selection.length == snapshot.data!.length
                            ? null
                            : selection.map((e) => e.id).toList(),
                      ),
                    );
                  }),
            );
          },
        ),

        /* ---------------------------------- */
        /* ---------- TAGS SELECTOR -------- */
        /* ---------------------------------- */
        const SizedBox(height: 8),
        StreamBuilder(
          stream: TagService.instance.getTags(),
          builder: (context, snapshot) {
            List<Tag?> selectedTags = filtersToReturn.tagsIDs == null
                ? [null, ...(snapshot.data ?? [])]
                : [
                    if (filtersToReturn.tagsIDs!.contains(null)) null,
                    ...(snapshot.data ?? []).where(
                      (element) =>
                          filtersToReturn.tagsIDs!.contains(element.id),
                    ),
                  ];

            return ListTileField(
              title: t.tags.display(n: 2),
              leading: Icon(Tag.icon),
              trailing: CountIndicatorWithExpandArrow(
                countToDisplay: filtersToReturn.tagsIDs?.length,
              ),
              subtitle: filtersToReturn.tagsIDs != null
                  ? selectedTags
                        .map((e) => e == null ? t.tags.without_tags : e.name)
                        .printFormatted()
                  : t.tags.select.all,
              onTap: () =>
                  showTagListModal(
                    context,
                    modal: TagSelector(
                      selectedTags: selectedTags,
                      allowEmptySubmit: false,
                      includeNullTag: true,
                    ),
                  ).then((selection) {
                    if (selection == null) return;

                    widget.onChanged(
                      filtersToReturn.copyWith(
                        tagsIDs: selection.length == snapshot.data!.length + 1
                            ? null
                            : selection.map((e) => e?.id).toList(),
                      ),
                    );
                  }),
            );
          },
        ),

        /* ---------------------------------- */
        /* -------- CATEGORY SELECTOR ------- */
        /* ---------------------------------- */
        const SizedBox(height: 8),
        StreamBuilder(
          stream: CategoryService.instance.getCategories(),
          builder: (context, snapshot) {
            List<Category>? selectedCategories =
                filtersToReturn.categoriesIds == null
                ? snapshot.data
                : (snapshot.data ?? [])
                      .where(
                        (element) =>
                            filtersToReturn.categoriesIds!.contains(element.id),
                      )
                      .toList();

            return ListTileField(
              title: t.general.categories,
              leading: const Icon(Icons.category_rounded),
              trailing: CountIndicatorWithExpandArrow(
                countToDisplay: filtersToReturn.categoriesIds?.length,
              ),
              subtitle: filtersToReturn.categoriesIds != null
                  ? selectedCategories!.map((e) => e.name).printFormatted()
                  : t.categories.select.all,
              onTap: () {
                showMultiCategoryListModal(
                  context,
                  CategoryMultiSelectorModal(
                    selectedCategories: selectedCategories ?? [],
                  ),
                ).then((selection) {
                  if (selection == null) return;

                  widget.onChanged(
                    filtersToReturn.copyWith(
                      categoriesIds: selection.length == snapshot.data!.length
                          ? null
                          : selection.map((e) => e.id),
                    ),
                  );
                });
              },
            );
          },
        ),
        const SizedBox(height: 24),

        /* ---------------------------------- */
        /* -------- TRANSACTION DATE -------- */
        /* ---------------------------------- */
        if (widget.showDateFilter) ...[
          Row(
            children: [
              Flexible(
                child: DateTimeFormField(
                  key: ValueKey(filtersToReturn.minDate),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.event),
                    labelText: t.general.time.from_date,
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  initialDate: filtersToReturn.minDate,
                  lastDate: filtersToReturn.maxDate,
                  dateFormat: DateFormat.yMMMd(),
                  onDateSelected: (DateTime value) {
                    widget.onChanged(filtersToReturn.copyWith(minDate: value));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: DateTimeFormField(
                  key: ValueKey(filtersToReturn.maxDate),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.event),
                    labelText: t.general.time.until_date,
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  initialDate: filtersToReturn.maxDate,
                  firstDate: filtersToReturn.minDate,
                  dateFormat: DateFormat.yMMMd(),
                  onDateSelected: (DateTime value) {
                    widget.onChanged(filtersToReturn.copyWith(maxDate: value));
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
          stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
          builder: (context, prefCurrencySnapshot) {
            return Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: _minAmountController,
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

                      final defaultNumberValidatorResult = fieldValidator(
                        value,
                        isRequired: false,
                        validator: ValidatorType.double,
                      );

                      if (defaultNumberValidatorResult != null) {
                        return defaultNumberValidatorResult;
                      }

                      final valToNum = double.parse(value);

                      if (valToNum < 0) {
                        return t.general.validations.positive;
                      } else if (filtersToReturn.maxValue != null &&
                          valToNum > filtersToReturn.maxValue!) {
                        return t.general.validations.max_number(
                          x: filtersToReturn.maxValue!,
                        );
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    inputFormatters: twoDecimalDigitFormatter,
                    onChanged: (value) {
                      widget.onChanged(
                        filtersToReturn.copyWith(
                          minValue: double.tryParse(value),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TextFormField(
                    controller: _maxAmountController,
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

                      final defaultNumberValidatorResult = fieldValidator(
                        value,
                        isRequired: false,
                        validator: ValidatorType.double,
                      );

                      if (defaultNumberValidatorResult != null) {
                        return defaultNumberValidatorResult;
                      }

                      final valToNum = double.parse(value);

                      if (valToNum < (filtersToReturn.minValue ?? 0)) {
                        return t.general.validations.min_number(
                          x: filtersToReturn.minValue!,
                        );
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    inputFormatters: twoDecimalDigitFormatter,
                    onChanged: (value) {
                      widget.onChanged(
                        filtersToReturn.copyWith(
                          maxValue: double.tryParse(value),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
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
              _transactionTypeFilter(context, TransactionType.income),
              const SizedBox(width: 6),
              _transactionTypeFilter(context, TransactionType.expense),
              const SizedBox(width: 6),
              _transactionTypeFilter(context, TransactionType.transfer),
            ],
          ),
        ),

        /* ---------------------------------- */
        /* ------------- STATUS ------------- */
        /* ---------------------------------- */
        const SizedBox(height: 16),
        TransactionStatusFilter(
          selectedStatuses:
              filtersToReturn.status ?? [null, ...TransactionStatus.values],
          allowMultipleSelection: true,
          onSelected: (statusSelected, value) {
            var newListToAssign = filtersToReturn.status;

            if (newListToAssign == null) {
              if (statusSelected != null) {
                newListToAssign = TransactionStatus.notIn({statusSelected});
              } else {
                newListToAssign = TransactionStatus.notIn(
                  {},
                  includeNullStatus: value,
                );
              }
            } else if (value) {
              newListToAssign.add(statusSelected);
            } else {
              newListToAssign.removeWhere(
                (element) => element?.index == statusSelected?.index,
              );
            }

            if (newListToAssign.length == TransactionStatus.values.length + 1) {
              newListToAssign = null;
            }

            widget.onChanged(filtersToReturn.copyWith(status: newListToAssign));
          },
        ),
      ],
    );
  }
}
