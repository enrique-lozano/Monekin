import 'package:material_ui/material_ui.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/form_fields/read_only_form_field.dart';
import 'package:monekin/core/services/csv_import/csv_import_mapping.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

const _rowsToPreview = 3;

/// Max number of different values of a column shown as options
const _maxDistinctValues = 12;

enum _Section { preview, amount, category, date, account, transfers, details }

enum _TransferMode { none, twoRows, oneRow }

enum _ValueRole { income, expense, skip }

/// Lets the user review (and change) which CSV column feeds each attribute of
/// the transactions. Each group of options is a card that expands on tap, so
/// only the one being edited takes space. Everything is edited through the
/// immutable [mapping], that the parent receives in [onMappingChanged].
class CsvImportMappingForm extends StatefulWidget {
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

  final ValueChanged<BuildContext> onPickDefaultAccount;
  final VoidCallback onClearDefaultAccount;
  final ValueChanged<BuildContext> onPickDefaultCategory;
  final ValueChanged<BuildContext> onPickDefaultTags;

  @override
  State<CsvImportMappingForm> createState() => _CsvImportMappingFormState();
}

class _CsvImportMappingFormState extends State<CsvImportMappingForm> {
  /// Section opened at first: the first one with something required to fill
  late final _Section _initiallyExpanded = widget.mapping.hasValidAmount
      ? _Section.category
      : _Section.amount;

  final _controllers = {
    for (final section in _Section.values) section: ExpansibleController(),
  };

  /// First non-empty value of each column
  late final List<String> _samples = List.generate(
    widget.headers.length,
    (col) => widget.rows
        .map((r) => r[col])
        .firstWhere((v) => v.trim().isNotEmpty, orElse: () => ''),
  );

  final _distinctCache = <int, List<String>>{};

  CsvImportMapping get mapping => widget.mapping;

  void _update(CsvImportMapping value) => widget.onMappingChanged(value);

  /// Most frequent values of a column. Has more than [_maxDistinctValues]
  /// items when the column has too many different values to be listed
  List<String> _distinctValues(int column) {
    return _distinctCache.putIfAbsent(column, () {
      final counts = <String, int>{};

      for (final row in widget.rows) {
        final value = row[column].trim();
        if (value.isNotEmpty) counts[value] = (counts[value] ?? 0) + 1;
      }

      final sorted = counts.keys.toList()
        ..sort((a, b) => counts[b]!.compareTo(counts[a]!));

      return sorted.take(_maxDistinctValues + 1).toList();
    });
  }

  String? _name(int? column) => column == null ? null : widget.headers[column];

  /// Kept apart from the mapping because a mode can have no column yet
  late _TransferMode _transferMode = mapping.destinationAccountColumn != null
      ? _TransferMode.oneRow
      : mapping.transferColumn != null
      ? _TransferMode.twoRows
      : _TransferMode.none;

  /// Only one section is open at a time
  void _onExpansionChanged(_Section section, bool isExpanded) {
    if (!isExpanded) return;

    for (final entry in _controllers.entries) {
      if (entry.key != section && entry.value.isExpanded) {
        entry.value.collapse();
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;
    final notSet = t.not_set;

    final transferSummary = switch (_transferMode) {
      _TransferMode.none => t.transfer_mode_none,
      _TransferMode.twoRows => t.transfer_mode_two,
      _TransferMode.oneRow => t.transfer_mode_one,
    };

    final detailColumns = [
      mapping.titleColumn,
      mapping.notesColumn,
      mapping.tagsColumn,
    ].map(_name).nonNulls;

    Widget section({
      required _Section id,
      required IconData icon,
      required String title,
      required String summary,
      required Widget child,
      bool? isComplete,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: _SectionCard(
          key: ValueKey(id),
          controller: _controllers[id]!,
          icon: icon,
          title: title,
          summary: summary,
          initiallyExpanded: id == _initiallyExpanded,
          isComplete: isComplete,
          onExpansionChanged: (isExpanded) =>
              _onExpansionChanged(id, isExpanded),
          child: child,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section(
          id: _Section.preview,
          icon: Icons.table_rows_rounded,
          title: t.file_preview,
          summary: t.rows_detected(n: widget.rows.length),
          child: _buildPreview(context),
        ),
        section(
          id: _Section.amount,
          icon: Icons.payments_rounded,
          title: t.amount_title,
          summary: mapping.hasValidAmount ? _amountSummary() : notSet,
          isComplete: mapping.hasValidAmount,
          child: _buildAmount(context),
        ),
        section(
          id: _Section.category,
          icon: Icons.category_rounded,
          title: t.category_title,
          summary: widget.defaultCategory == null
              ? t.default_category_missing
              : '${_name(mapping.categoryColumn) ?? notSet} · '
                    '${widget.defaultCategory!.name}',
          isComplete: widget.defaultCategory != null,
          child: _buildCategory(context),
        ),
        section(
          id: _Section.date,
          icon: Icons.event_rounded,
          title: t.date_title,
          summary: _name(mapping.dateColumn) ?? notSet,
          isComplete: mapping.dateColumn == null ? null : true,
          child: _buildDate(context),
        ),
        section(
          id: _Section.account,
          icon: Icons.account_balance_wallet_rounded,
          title: t.account_title,
          summary: [
            _name(mapping.accountColumn) ?? notSet,
            ?widget.defaultAccount?.name,
          ].join(' · '),
          isComplete:
              mapping.accountColumn != null || widget.defaultAccount != null
              ? true
              : null,
          child: _buildAccount(context),
        ),
        section(
          id: _Section.transfers,
          icon: Icons.swap_horiz_rounded,
          title: t.transfers_title,
          summary: transferSummary,
          isComplete: _transferMode == _TransferMode.none ? null : true,
          child: _buildTransfers(context),
        ),
        section(
          id: _Section.details,
          icon: Icons.notes_rounded,
          title: t.details_title,
          summary: detailColumns.isEmpty ? notSet : detailColumns.join(' · '),
          isComplete: detailColumns.isNotEmpty || widget.defaultTags.isNotEmpty
              ? true
              : null,
          child: _buildDetails(context),
        ),
      ],
    );
  }

  String _amountSummary() => switch (mapping.amountMode) {
    CsvAmountMode.signed => _name(mapping.amountColumn)!,
    CsvAmountMode.separateColumns => [
      mapping.incomeColumn,
      mapping.expenseColumn,
    ].map(_name).nonNulls.join(' · '),
    CsvAmountMode.typeColumn =>
      '${_name(mapping.amountColumn)} · ${_name(mapping.typeColumn) ?? ''}',
  };

  Widget _hint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }

  Widget _column({
    required String label,
    required int? value,
    required ValueChanged<int?> onChanged,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _ColumnDropdown(
        label: label,
        headers: widget.headers,
        samples: _samples,
        value: value,
        isRequired: required,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
        ),
        headingRowHeight: 36,
        headingTextStyle: Theme.of(context).textTheme.labelLarge,
        dataRowMinHeight: 32,
        dataRowMaxHeight: 32,
        dataTextStyle: Theme.of(context).textTheme.bodySmall,
        columns: [for (final h in widget.headers) DataColumn(label: Text(h))],
        rows: [
          for (final row in widget.rows.take(_rowsToPreview))
            DataRow(cells: [for (final c in row) DataCell(Text(c))]),
        ],
      ),
    );
  }

  Widget _buildAmount(BuildContext context) {
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
          onSelected: (mode) => _update(mapping.copyWith(amountMode: mode)),
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
        _hint(description),
        ...switch (mapping.amountMode) {
          CsvAmountMode.signed => [
            _column(
              label: '${t.amount_column} *',
              value: mapping.amountColumn,
              required: true,
              onChanged: (v) => _update(mapping.copyWith(amountColumn: v)),
            ),
          ],
          CsvAmountMode.separateColumns => [
            _column(
              label: t.income_column,
              value: mapping.incomeColumn,
              onChanged: (v) => _update(mapping.copyWith(incomeColumn: v)),
            ),
            _column(
              label: t.expense_column,
              value: mapping.expenseColumn,
              onChanged: (v) => _update(mapping.copyWith(expenseColumn: v)),
            ),
          ],
          CsvAmountMode.typeColumn => [
            _column(
              label: '${t.amount_column} *',
              value: mapping.amountColumn,
              required: true,
              onChanged: (v) => _update(mapping.copyWith(amountColumn: v)),
            ),
            _column(
              label: '${t.type_column} *',
              value: mapping.typeColumn,
              required: true,
              onChanged: _onTypeColumnChanged,
            ),
            if (mapping.typeColumn != null) _buildTypeRoles(context),
          ],
        },
      ],
    );
  }

  /// Guesses what the values of the new type column mean
  void _onTypeColumnChanged(int? column) {
    final income = <String>[];
    final expense = <String>[];

    if (column != null) {
      for (final value in _distinctValues(column).take(_maxDistinctValues)) {
        final lower = value.toLowerCase();

        if ([
          'income',
          'credit',
          'deposit',
          'revenue',
          'salary',
          'in',
          '+',
        ].any((k) => k.length > 2 ? lower.contains(k) : lower == k)) {
          income.add(value);
        } else if ([
          'expense',
          'debit',
          'withdraw',
          'spend',
          'out',
          '-',
        ].any((k) => k.length > 3 ? lower.contains(k) : lower == k)) {
          expense.add(value);
        }
      }
    }

    _update(
      mapping.copyWith(
        typeColumn: column,
        incomeTypeValues: income,
        expenseTypeValues: expense,
      ),
    );
  }

  Widget _buildTypeRoles(BuildContext context) {
    final t = Translations.of(context);
    final values = _distinctValues(mapping.typeColumn!);

    if (values.length > _maxDistinctValues) {
      return _hint(t.backup.import.manual_import.too_many_values);
    }

    bool contains(List<String> list, String v) =>
        list.any((e) => e.toLowerCase() == v.toLowerCase());

    _ValueRole roleOf(String v) => contains(mapping.incomeTypeValues, v)
        ? _ValueRole.income
        : contains(mapping.expenseTypeValues, v)
        ? _ValueRole.expense
        : _ValueRole.skip;

    void setRole(String value, _ValueRole role) {
      bool other(String e) => e.toLowerCase() != value.toLowerCase();

      _update(
        mapping.copyWith(
          incomeTypeValues: [
            ...mapping.incomeTypeValues.where(other),
            if (role == _ValueRole.income) value,
          ],
          expenseTypeValues: [
            ...mapping.expenseTypeValues.where(other),
            if (role == _ValueRole.expense) value,
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.backup.import.manual_import.type_values_title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 2),
        _hint(t.backup.import.manual_import.type_values_help),
        for (final value in values)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ExpandingSegmentedTabs<_ValueRole>(
                    fullWidth: false,
                    height: 36,
                    selected: roleOf(value),
                    onSelected: (role) => setRole(value, role),
                    items: [
                      SegmentedTabItem(
                        value: _ValueRole.income,
                        icon: Icons.south_east_rounded,
                        label: t.transaction.types.income(n: 1),
                      ),
                      SegmentedTabItem(
                        value: _ValueRole.expense,
                        icon: Icons.north_east_rounded,
                        label: t.transaction.types.expense(n: 1),
                      ),
                      SegmentedTabItem(
                        value: _ValueRole.skip,
                        icon: Icons.block_rounded,
                        label: t.backup.import.manual_import.skip,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCategory(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hint(t.category_descr),
        _column(
          label: t.category_column,
          value: mapping.categoryColumn,
          onChanged: (v) => _update(mapping.copyWith(categoryColumn: v)),
        ),
        _DefaultValueSelector(
          title: '${t.default_category} *',
          value: widget.defaultCategory?.name,
          supportedIcon: widget.defaultCategory?.icon,
          iconColor: widget.defaultCategory == null
              ? null
              : ColorHex.get(widget.defaultCategory!.color),
          onTap: widget.onPickDefaultCategory,
          isRequired: true,
        ),
      ],
    );
  }

  Widget _buildDate(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;
    final sample = mapping.dateColumn == null
        ? ''
        : _samples[mapping.dateColumn!];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hint(t.date_descr),
        _column(
          label: t.date_column,
          value: mapping.dateColumn,
          onChanged: (v) => _update(mapping.copyWith(dateColumn: v)),
        ),
        if (mapping.dateColumn != null) ...[
          _column(
            label: t.time_column,
            value: mapping.timeColumn,
            onChanged: (v) => _update(mapping.copyWith(timeColumn: v)),
          ),
          TextFormField(
            initialValue: mapping.dateFormat,
            decoration: InputDecoration(
              labelText: t.date_format,
              helperText: [
                if (sample.isNotEmpty) t.date_sample(value: sample),
                t.date_format_help,
              ].join('\n'),
              helperMaxLines: 6,
            ),
            onChanged: (v) => _update(mapping.copyWith(dateFormat: v.trim())),
          ),
        ],
      ],
    );
  }

  Widget _buildAccount(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hint(t.account_descr),
        _column(
          label: t.account_column,
          value: mapping.accountColumn,
          onChanged: (v) => _update(mapping.copyWith(accountColumn: v)),
        ),
        _DefaultValueSelector(
          title: t.default_account,
          value: widget.defaultAccount?.name,
          supportedIcon: widget.defaultAccount?.icon,
          onTap: widget.onPickDefaultAccount,
          onClear: widget.defaultAccount == null
              ? null
              : widget.onClearDefaultAccount,
        ),
      ],
    );
  }

  Widget _buildTransfers(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    final description = switch (_transferMode) {
      _TransferMode.none => t.transfer_mode_none_descr,
      _TransferMode.twoRows => t.transfer_mode_two_descr,
      _TransferMode.oneRow => t.transfer_mode_one_descr,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandingSegmentedTabs<_TransferMode>(
          selected: _transferMode,
          onSelected: (mode) {
            setState(() => _transferMode = mode);

            _update(switch (mode) {
              _TransferMode.none => mapping.copyWith(
                transferColumn: null,
                transferValues: [],
                transferPattern: '',
                destinationAccountColumn: null,
              ),
              _TransferMode.twoRows => mapping.copyWith(
                destinationAccountColumn: null,
              ),
              _TransferMode.oneRow => mapping.copyWith(
                transferColumn: null,
                transferValues: [],
                transferPattern: '',
              ),
            });
          },
          items: [
            SegmentedTabItem(
              value: _TransferMode.none,
              icon: Icons.block_rounded,
              label: t.transfer_mode_none,
            ),
            SegmentedTabItem(
              value: _TransferMode.twoRows,
              icon: Icons.table_rows_rounded,
              label: t.transfer_mode_two,
            ),
            SegmentedTabItem(
              value: _TransferMode.oneRow,
              icon: Icons.horizontal_rule_rounded,
              label: t.transfer_mode_one,
            ),
          ],
        ),
        const SizedBox(height: 10),
        _hint(description),
        if (_transferMode == _TransferMode.twoRows) ...[
          _column(
            label: t.transfer_column,
            value: mapping.transferColumn,
            onChanged: (v) => _update(
              mapping.copyWith(
                transferColumn: v,
                transferValues: [],
                transferPattern: '',
              ),
            ),
          ),
          _buildTransferValues(context),
        ],
        if (_transferMode == _TransferMode.oneRow)
          _column(
            label: t.destination_column,
            value: mapping.destinationAccountColumn,
            onChanged: (v) =>
                _update(mapping.copyWith(destinationAccountColumn: v)),
          ),
      ],
    );
  }

  Widget _buildTransferValues(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    if (mapping.transferColumn == null) return const SizedBox.shrink();

    if (mapping.transferPattern.isNotEmpty) {
      return _hint(t.transfer_auto);
    }

    final values = _distinctValues(mapping.transferColumn!);

    if (values.length > _maxDistinctValues) {
      return TextFormField(
        initialValue: mapping.transferValues.join('; '),
        decoration: InputDecoration(
          labelText: t.transfer_values,
          helperText: t.transfer_values_text_help,
          helperMaxLines: 3,
        ),
        onChanged: (text) => _update(
          mapping.copyWith(
            transferValues: text
                .split(';')
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList(),
          ),
        ),
      );
    }

    bool isSelected(String v) =>
        mapping.transferValues.any((e) => e.toLowerCase() == v.toLowerCase());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.transfer_values, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final value in values)
              FilterChip(
                label: Text(value),
                selected: isSelected(value),
                onSelected: (selected) => _update(
                  mapping.copyWith(
                    transferValues: [
                      ...mapping.transferValues.where(
                        (e) => e.toLowerCase() != value.toLowerCase(),
                      ),
                      if (selected) value,
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hint(t.details_descr),
        _column(
          label: t.title_column,
          value: mapping.titleColumn,
          onChanged: (v) => _update(mapping.copyWith(titleColumn: v)),
        ),
        _column(
          label: t.note_column,
          value: mapping.notesColumn,
          onChanged: (v) => _update(mapping.copyWith(notesColumn: v)),
        ),
        _column(
          label: t.tags_column,
          value: mapping.tagsColumn,
          onChanged: (v) => _update(mapping.copyWith(tagsColumn: v)),
        ),
        if (mapping.tagsColumn != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextFormField(
              initialValue: mapping.tagSeparator,
              decoration: InputDecoration(labelText: t.tag_separator),
              onChanged: (v) =>
                  _update(mapping.copyWith(tagSeparator: v.trim())),
            ),
          ),
        _DefaultValueSelector(
          title: t.default_tags,
          value: widget.defaultTags.isEmpty
              ? Translations.of(context).tags.without_tags
              : widget.defaultTags.map((e) => e.name).join(', '),
          onTap: widget.onPickDefaultTags,
        ),
      ],
    );
  }
}

/// A card that shows only its title and a [summary] until it is expanded
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    super.key,
    required this.controller,
    required this.icon,
    required this.title,
    required this.summary,
    required this.initiallyExpanded,
    required this.onExpansionChanged,
    required this.child,
    this.isComplete,
  });

  final ExpansibleController controller;
  final IconData icon;
  final String title;
  final String summary;
  final bool initiallyExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final Widget child;

  /// Only for the sections with required fields
  final bool? isComplete;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.4)),
    );

    return ExpansionTile(
      controller: controller,
      initiallyExpanded: initiallyExpanded,
      onExpansionChanged: onExpansionChanged,
      shape: shape,
      collapsedShape: shape,
      clipBehavior: Clip.antiAlias,
      backgroundColor: colors.surfaceContainerLow,
      collapsedBackgroundColor: colors.surfaceContainerLow,
      childrenPadding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: colors.primaryContainer,
        child: Icon(icon, size: 20, color: colors.onPrimaryContainer),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  summary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isComplete == false
                        ? colors.error
                        : colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (isComplete != null)
            Icon(
              isComplete!
                  ? Icons.check_circle_rounded
                  : Icons.error_outline_rounded,
              size: 20,
              color: isComplete! ? colors.primary : colors.error,
            ),
        ],
      ),
      children: [child],
    );
  }
}

class _ColumnDropdown extends StatelessWidget {
  const _ColumnDropdown({
    required this.label,
    required this.headers,
    required this.samples,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
  });

  final String label;
  final List<String> headers;

  /// An example value of each column, displayed next to its name
  final List<String> samples;
  final int? value;
  final bool isRequired;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final hintStyle = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return DropdownButtonFormField<int?>(
      key: ValueKey('$label-$value'),
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      selectedItemBuilder: (context) => [
        if (!isRequired) Text(Translations.of(context).general.unspecified),
        for (final header in headers)
          Text(header, overflow: TextOverflow.ellipsis),
      ],
      items: [
        if (!isRequired)
          DropdownMenuItem(
            value: null,
            child: Text(Translations.of(context).general.unspecified),
          ),
        for (final (index, header) in headers.indexed)
          DropdownMenuItem(
            value: index,
            child: Row(
              children: [
                Flexible(child: Text(header, overflow: TextOverflow.ellipsis)),
                if (samples[index].isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      samples[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: hintStyle,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
      onChanged: onChanged,
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

  /// Receives the context of the field, to anchor the picker popover to it
  final ValueChanged<BuildContext> onTap;
  final VoidCallback? onClear;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Builder(
      builder: (fieldContext) => ReadOnlyTextFormField(
        displayValue: value ?? t.general.unspecified,
        onTap: () => onTap(fieldContext),
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
                    mainColor:
                        iconColor ?? Theme.of(context).colorScheme.primary,
                    supportedIcon: supportedIcon,
                  ),
                ),
        ),
      ),
    );
  }
}
