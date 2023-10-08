import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/filter_sheet_modal.dart';
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
  late final TransactionFilters filters;

  @override
  void initState() {
    super.initState();

    filters = widget.filters;
  }

  InputChip buildChip(
    BuildContext context, {
    required String label,
    required void Function()? onDeleted,
  }) {
    return InputChip(
        padding: const EdgeInsets.all(0),
        onDeleted: onDeleted,
        deleteIcon: const Icon(Icons.close, size: 12),
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Text(
            '${t.general.filters.toUpperCase()}:',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          if (filters.accounts != null) ...[
            const SizedBox(width: 8),
            buildChip(
              context,
              label: '${filters.accounts!.length} ${t.general.accounts}',
              onDeleted: () {
                filters.accounts = null;
                widget.onChange(filters);
              },
            ),
          ],
          if (filters.categories != null) ...[
            const SizedBox(width: 8),
            buildChip(
              context,
              label:
                  '${filters.categories!.where((cat) => cat.isMainCategory).length} ${t.general.categories}',
              onDeleted: () {
                filters.categories = null;
                widget.onChange(filters);
              },
            )
          ]
        ],
      ),
    );
  }
}
