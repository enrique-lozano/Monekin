import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/translations.g.dart';

class FilterRowIndicator extends StatefulWidget {
  const FilterRowIndicator(
      {super.key, required this.filters, required this.onChange});

  final TransactionFilters filters;
  final void Function(TransactionFilters newFilters) onChange;

  @override
  State<FilterRowIndicator> createState() => _FilterRowIndicatorState();
}

class _FilterRowIndicatorState extends State<FilterRowIndicator> {
  late TransactionFilters filters;

  @override
  void initState() {
    super.initState();

    filters = widget.filters;
  }

  @override
  void didUpdateWidget(covariant FilterRowIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    filters = widget.filters;
  }

  ResponsiveRowColumnItem buildChip(
    BuildContext context, {
    required String label,
    required void Function()? onDeleted,
  }) {
    return ResponsiveRowColumnItem(
      child: InputChip(
        padding: const EdgeInsets.all(0),
        onDeleted: onDeleted,
        deleteIcon: const Icon(
          Icons.close,
          size: 12,
        ),
        showCheckmark: false,
        selected: true,
        onSelected: (value) => false,
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                '${t.general.filters}:',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: ResponsiveRowColumn.withSymetricSpacing(
                    direction: Axis.horizontal,
                    spacing: 12,
                    children: [
                      if (filters.accountsIDs != null)
                        buildChip(
                          context,
                          label:
                              '${filters.accountsIDs!.length} ${t.general.accounts}',
                          onDeleted: () {
                            filters = filters.copyWithNull(accountsIDs: true);
                            widget.onChange(filters);
                          },
                        ),
                      if (filters.minDate != null)
                        buildChip(
                          context,
                          label: t.transaction.filters.from_date_def(
                              date: DateFormat.yMd().format(filters.minDate!)),
                          onDeleted: () {
                            filters = filters.copyWithNull(minDate: true);
                            widget.onChange(filters);
                          },
                        ),
                      if (filters.maxDate != null)
                        buildChip(
                          context,
                          label: t.transaction.filters.to_date_def(
                              date: DateFormat.yMd().format(filters.maxDate!)),
                          onDeleted: () {
                            filters = filters.copyWithNull(maxDate: true);
                            widget.onChange(filters);
                          },
                        ),
                      if (filters.minValue != null)
                        buildChip(
                          context,
                          label: t.transaction.filters
                              .from_value_def(x: filters.minValue!),
                          onDeleted: () {
                            filters = filters.copyWithNull(minValue: true);
                            widget.onChange(filters);
                          },
                        ),
                      if (filters.maxValue != null)
                        buildChip(
                          context,
                          label: t.transaction.filters
                              .to_value_def(x: filters.maxValue!),
                          onDeleted: () {
                            filters = filters.copyWithNull(maxValue: true);
                            widget.onChange(filters);
                          },
                        ),
                      if (filters.status != null)
                        buildChip(
                          context,
                          label:
                              '${filters.status!.length} ${t.transaction.status.display(n: filters.status!.length)}',
                          onDeleted: () {
                            filters = filters.copyWithNull(status: true);
                            widget.onChange(filters);
                          },
                        ),
                      if (filters.transactionTypes != null)
                        for (final trType in filters.transactionTypes!) ...[
                          buildChip(
                            context,
                            label: trType.displayName(context, plural: true),
                            onDeleted: () {
                              filters = filters.copyWith(
                                  transactionTypes:
                                      filters.transactionTypes!.length == 1
                                          ? null
                                          : filters.transactionTypes!
                                        ?..removeWhere((element) =>
                                            element.index == trType.index));
                              widget.onChange(filters);
                            },
                          ),
                        ],
                      if (filters.categories != null)
                        ResponsiveRowColumnItem(
                          child: StreamBuilder(
                              stream: CategoryService.instance.getCategories(
                                predicate: (catTable, parentCatTable) =>
                                    catTable.id.isIn(filters.categories!),
                              ),
                              initialData: const <Category>[],
                              builder: (context, snapshot) {
                                return buildChip(
                                  context,
                                  label:
                                      '${snapshot.data!.where((cat) => cat.isMainCategory).length} ${t.general.categories}',
                                  onDeleted: () {
                                    filters =
                                        filters.copyWithNull(categories: true);
                                    widget.onChange(filters);
                                  },
                                );
                              }),
                        )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
