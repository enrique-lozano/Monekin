import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/form_fields/read_only_form_field.dart';
import 'package:monekin/core/services/csv_import/csv_import_mapping.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

const _rowsToPreview = 3;
const _sectionBodyPadding = EdgeInsets.fromLTRB(16, 4, 16, 16);

/// Lets the user review (and change) which CSV column feeds each attribute of
/// the transactions. Everything is edited through the immutable [mapping],
/// that the parent receives in [onMappingChanged].
class CsvImportMappingForm extends StatelessWidget {
  const CsvImportMappingForm({
    super.key,
    required this.headers,
    required this.rows,
    required this.mapping,
    required this.onMappingChanged,
    required this.defaultAccount,
    required this.defaultCategory,
    required this.defaultTags,
    required this.onPickDefaultAccount,
    required this.onClearDefaultAccount,
    required this.onPickDefaultCategory,
    required this.onPickDefaultTags,
  });

  final List<String> headers;

  /// Data rows, without the header
  final List<List<String>> rows;

  final CsvImportMapping mapping;
  final ValueChanged<CsvImportMapping> onMappingChanged;

  final Account? defaultAccount;
  final Category? defaultCategory;
  final List<Tag> defaultTags;

  final VoidCallback onPickDefaultAccount;
  final VoidCallback onClearDefaultAccount;
  final VoidCallback onPickDefaultCategory;
  final VoidCallback onPickDefaultTags;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    Widget gap() => const SizedBox(height: 12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PreviewCard(headers: headers, rows: rows),
        gap(),
        CardWithHeader(
          title: t.amount_title,
          bodyPadding: _sectionBodyPadding,
          body: _buildAmountSection(context),
        ),
        gap(),
        CardWithHeader(
          title: t.account_title,
          bodyPadding: _sectionBodyPadding,
          body: Column(
            children: [
              _columnSelector(
                label: t.account_column,
                value: mapping.accountColumn,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(accountColumn: v)),
              ),
              gap(),
              _DefaultValueSelector(
                title: t.default_account,
                value: defaultAccount?.name,
                supportedIcon: defaultAccount?.icon,
                onTap: onPickDefaultAccount,
                onClear: defaultAccount == null ? null : onClearDefaultAccount,
              ),
            ],
          ),
        ),
        gap(),
        CardWithHeader(
          title: t.category_title,
          bodyPadding: _sectionBodyPadding,
          body: Column(
            children: [
              _columnSelector(
                label: t.category_column,
                value: mapping.categoryColumn,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(categoryColumn: v)),
              ),
              gap(),
              _DefaultValueSelector(
                title: '${t.default_category} *',
                value: defaultCategory?.name,
                supportedIcon: defaultCategory?.icon,
                iconColor: defaultCategory == null
                    ? null
                    : ColorHex.get(defaultCategory!.color),
                onTap: onPickDefaultCategory,
                isRequired: true,
              ),
            ],
          ),
        ),
        gap(),
        CardWithHeader(
          title: t.transfers_title,
          subtitle: t.transfers_descr,
          bodyPadding: _sectionBodyPadding,
          body: _buildTransfersSection(context),
        ),
        gap(),
        CardWithHeader(
          title: t.date_title,
          bodyPadding: _sectionBodyPadding,
          body: Column(
            children: [
              _columnSelector(
                label: t.date_column,
                value: mapping.dateColumn,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(dateColumn: v)),
              ),
              if (mapping.dateColumn != null) ...[
                gap(),
                _columnSelector(
                  label: t.time_column,
                  value: mapping.timeColumn,
                  onChanged: (v) =>
                      onMappingChanged(mapping.copyWith(timeColumn: v)),
                ),
                gap(),
                TextFormField(
                  initialValue: mapping.dateFormat,
                  decoration: InputDecoration(
                    labelText: t.date_format,
                    helperText: t.date_format_help,
                    helperMaxLines: 3,
                  ),
                  onChanged: (v) =>
                      onMappingChanged(mapping.copyWith(dateFormat: v.trim())),
                ),
              ],
            ],
          ),
        ),
        gap(),
        CardWithHeader(
          title: t.details_title,
          bodyPadding: _sectionBodyPadding,
          body: Column(
            children: [
              _columnSelector(
                label: t.title_column,
                value: mapping.titleColumn,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(titleColumn: v)),
              ),
              gap(),
              _columnSelector(
                label: t.note_column,
                value: mapping.notesColumn,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(notesColumn: v)),
              ),
              gap(),
              _columnSelector(
                label: t.tags_column,
                value: mapping.tagsColumn,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(tagsColumn: v)),
              ),
              if (mapping.tagsColumn != null) ...[
                gap(),
                TextFormField(
                  initialValue: mapping.tagSeparator,
                  decoration: InputDecoration(labelText: t.tag_separator),
                  onChanged: (v) => onMappingChanged(
                    mapping.copyWith(tagSeparator: v.trim()),
                  ),
                ),
              ],
              gap(),
              _DefaultValueSelector(
                title: t.default_tags,
                value: defaultTags.isEmpty
                    ? Translations.of(context).tags.without_tags
                    : defaultTags.map((e) => e.name).join(', '),
                onTap: onPickDefaultTags,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountSection(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    final description = switch (mapping.amountMode) {
      CsvAmountMode.signed => t.amount_mode_signed_descr,
      CsvAmountMode.separateColumns => t.amount_mode_separate_descr,
      CsvAmountMode.typeColumn => t.amount_mode_type_descr,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandingSegmentedTabs<CsvAmountMode>(
          selected: mapping.amountMode,
          onSelected: (mode) =>
              onMappingChanged(mapping.copyWith(amountMode: mode)),
          items: [
            SegmentedTabItem(
              value: CsvAmountMode.signed,
              icon: Icons.exposure_rounded,
              label: t.amount_mode_signed,
            ),
            SegmentedTabItem(
              value: CsvAmountMode.separateColumns,
              icon: Icons.view_column_rounded,
              label: t.amount_mode_separate,
            ),
            SegmentedTabItem(
              value: CsvAmountMode.typeColumn,
              icon: Icons.label_rounded,
              label: t.amount_mode_type,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 14),
        switch (mapping.amountMode) {
          CsvAmountMode.signed => _columnSelector(
            label: '${t.amount_column} *',
            value: mapping.amountColumn,
            required: true,
            onChanged: (v) =>
                onMappingChanged(mapping.copyWith(amountColumn: v)),
          ),
          CsvAmountMode.separateColumns => Column(
            children: [
              _columnSelector(
                label: t.income_column,
                value: mapping.incomeColumn,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(incomeColumn: v)),
              ),
              const SizedBox(height: 12),
              _columnSelector(
                label: t.expense_column,
                value: mapping.expenseColumn,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(expenseColumn: v)),
              ),
            ],
          ),
          CsvAmountMode.typeColumn => Column(
            children: [
              _columnSelector(
                label: '${t.amount_column} *',
                value: mapping.amountColumn,
                required: true,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(amountColumn: v)),
              ),
              const SizedBox(height: 12),
              _columnSelector(
                label: '${t.type_column} *',
                value: mapping.typeColumn,
                required: true,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(typeColumn: v)),
              ),
              const SizedBox(height: 12),
              _ValuesField(
                label: t.income_values,
                values: mapping.incomeTypeValues,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(incomeTypeValues: v)),
              ),
              const SizedBox(height: 12),
              _ValuesField(
                label: t.expense_values,
                values: mapping.expenseTypeValues,
                onChanged: (v) =>
                    onMappingChanged(mapping.copyWith(expenseTypeValues: v)),
              ),
            ],
          ),
        },
      ],
    );
  }

  Widget _buildTransfersSection(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    return Column(
      children: [
        _columnSelector(
          label: t.transfer_column,
          value: mapping.transferColumn,
          onChanged: (v) =>
              onMappingChanged(mapping.copyWith(transferColumn: v)),
        ),
        if (mapping.transferColumn != null) ...[
          const SizedBox(height: 12),
          _ValuesField(
            label: t.transfer_values,
            values: mapping.transferValues,
            onChanged: (v) =>
                onMappingChanged(mapping.copyWith(transferValues: v)),
          ),
        ],
        const SizedBox(height: 12),
        _columnSelector(
          label: t.destination_column,
          value: mapping.destinationAccountColumn,
          onChanged: (v) =>
              onMappingChanged(mapping.copyWith(destinationAccountColumn: v)),
        ),
      ],
    );
  }

  Widget _columnSelector({
    required String label,
    required int? value,
    required ValueChanged<int?> onChanged,
    bool required = false,
  }) {
    return _ColumnDropdown(
      label: label,
      headers: headers,
      value: value,
      isRequired: required,
      onChanged: onChanged,
    );
  }
}

class _ColumnDropdown extends StatelessWidget {
  const _ColumnDropdown({
    required this.label,
    required this.headers,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
  });

  final String label;
  final List<String> headers;
  final int? value;
  final bool isRequired;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      key: ValueKey('$label-$value'),
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        if (!isRequired)
          DropdownMenuItem(
            value: null,
            child: Text(Translations.of(context).general.unspecified),
          ),
        for (final (index, header) in headers.indexed)
          DropdownMenuItem(
            value: index,
            child: Text(header, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

/// Edits a list of case-insensitive values, written separated by commas
class _ValuesField extends StatelessWidget {
  const _ValuesField({
    required this.label,
    required this.values,
    required this.onChanged,
  });

  final String label;
  final List<String> values;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: values.join(', '),
      decoration: InputDecoration(labelText: label),
      onChanged: (text) => onChanged(
        text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
      ),
    );
  }
}

class _DefaultValueSelector extends StatelessWidget {
  const _DefaultValueSelector({
    required this.title,
    required this.value,
    required this.onTap,
    this.supportedIcon,
    this.iconColor,
    this.onClear,
    this.isRequired = false,
  });

  final String title;
  final String? value;
  final SupportedIcon? supportedIcon;
  final Color? iconColor;
  final VoidCallback onTap;
  final VoidCallback? onClear;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ReadOnlyTextFormField(
      displayValue: value ?? t.general.unspecified,
      onTap: onTap,
      validator: (_) =>
          isRequired && value == null ? t.general.validations.required : null,
      decoration: InputDecoration(
        labelText: title,
        suffixIcon: onClear == null
            ? const Icon(Icons.arrow_drop_down)
            : IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: onClear,
              ),
        prefixIcon: supportedIcon == null
            ? null
            : Container(
                margin: const EdgeInsets.fromLTRB(14, 8, 8, 8),
                child: IconDisplayer(
                  mainColor: iconColor ?? Theme.of(context).colorScheme.primary,
                  supportedIcon: supportedIcon,
                ),
              ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.headers, required this.rows});

  final List<String> headers;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;
    final colors = Theme.of(context).colorScheme;

    return CardWithHeader(
      title: t.file_preview,
      subtitle: t.rows_detected(n: rows.length),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStatePropertyAll(
            colors.primary.withOpacity(0.15),
          ),
          headingRowHeight: 36,
          headingTextStyle: Theme.of(context).textTheme.labelLarge,
          dataRowMinHeight: 32,
          dataRowMaxHeight: 32,
          dataTextStyle: Theme.of(context).textTheme.bodySmall,
          columns: [for (final h in headers) DataColumn(label: Text(h))],
          rows: [
            for (final row in rows.take(_rowsToPreview))
              DataRow(cells: [for (final c in row) DataCell(Text(c))]),
          ],
        ),
      ),
    );
  }
}
