import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart' show FileType;
import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/pages/backup/import_csv/csv_import_mapping_form.dart';
import 'package:monekin/app/settings/pages/backup/import_csv/csv_import_review.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/core/database/backup/csv_import_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/csv_file_picker_dropzone.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/loading_overlay.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/store_app_icon.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/csv_import/csv_import_mapping.dart';
import 'package:monekin/core/services/csv_import/csv_import_templates.dart';
import 'package:monekin/core/services/csv_import/csv_transaction_parser.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum _ImportStage { file, columns, review }

/// Wizard to import the transactions of a CSV file. If the file comes from a
/// known app, its [CsvImportTemplate] pre-fills the column mapping.
class ImportCSVPage extends StatefulWidget {
  const ImportCSVPage({super.key});

  @override
  State<ImportCSVPage> createState() => _ImportCSVPageState();
}

class _ImportCSVPageState extends State<ImportCSVPage> {
  _ImportStage stage = _ImportStage.file;

  List<List<String>>? csvData;
  String? fileName;
  List<String> get headers => csvData!.first;
  List<List<String>> get rows => csvData!.sublist(1);

  /// App chosen by the user. When null, it is guessed from the file
  CsvImportTemplate? selectedTemplate;

  /// App whose template was used to fill the mapping, if any
  CsvImportTemplate? appliedTemplate;

  /// The mapping must be rebuilt from the template before showing it
  bool mappingOutdated = true;

  /// The selected app does not match the file
  bool templateMismatch = false;

  CsvImportMapping mapping = const CsvImportMapping();

  Category? defaultCategory;
  Account? defaultAccount;
  List<Tag> defaultTags = [];

  CsvParseResult? parseResult;

  CsvImportDefaults get _defaults => CsvImportDefaults(
    category: defaultCategory!,
    account: defaultAccount,
    tags: defaultTags,
  );

  Future<void> readFile() async {
    try {
      final csvFile = await BackupDatabaseService().pickAndReadSingleFile(
        allowedExtensions: ['csv'],
        type: FileType.custom,
      );

      if (csvFile == null) {
        MonekinSnackbar.info(SnackbarParams(t.backup.no_file_selected));
        return;
      }

      var parsedCSV = await BackupDatabaseService().processCsv(
        await csvFile.readAsString(),
      );

      // Remove blank rows
      parsedCSV = parsedCSV
          .where((list) => list.any((element) => element.trim().isNotEmpty))
          .toList();

      if (parsedCSV.length < 2) {
        MonekinSnackbar.warning(
          SnackbarParams(t.backup.import.manual_import.empty_file),
        );
        return;
      }

      // Add missing values to rows with fewer columns
      final maxColumns = parsedCSV.map((e) => e.length).max;
      parsedCSV = parsedCSV
          .map((row) => row + List.filled(maxColumns - row.length, ''))
          .toList();

      setState(() {
        csvData = parsedCSV;
        fileName = csvFile.uri.pathSegments.last;
        mappingOutdated = true;
      });
    } catch (err) {
      MonekinSnackbar.error(SnackbarParams.fromError(err));
    }
  }

  /// Fills the mapping with the template of the selected app, or of the app
  /// the file looks like it comes from
  void _applyTemplate() {
    final selected = selectedTemplate;
    final detected = CsvImportTemplates.apps.firstWhereOrNull(
      (e) => e.matches(headers),
    );

    final matches = selected?.matches(headers) ?? false;
    final template = matches ? selected : (selected == null ? detected : null);

    appliedTemplate = template;
    templateMismatch = selected != null && !matches;
    mapping = (template ?? CsvImportTemplates.generic).mappingFor(headers);
    mappingOutdated = false;
  }

  bool get _canContinue => switch (stage) {
    _ImportStage.file => csvData != null,
    _ImportStage.columns => mapping.hasValidAmount && defaultCategory != null,
    _ImportStage.review => parseResult?.transactions.isNotEmpty ?? false,
  };

  void _goBack() {
    setState(() => stage = _ImportStage.values[stage.index - 1]);
  }

  void _continue() {
    if (stage == _ImportStage.review) {
      addTransactions();
      return;
    }

    setState(() {
      if (stage == _ImportStage.file && mappingOutdated) _applyTemplate();

      if (stage == _ImportStage.columns) {
        parseResult = CsvTransactionParser(mapping).parse(rows);
      }

      stage = _ImportStage.values[stage.index + 1];
    });
  }

  Future<void> addTransactions() async {
    final loadingOverlay = LoadingOverlay.of(context);
    loadingOverlay.show();

    try {
      final inserted = await CsvImportService.instance.importTransactions(
        parseResult!.transactions,
        _defaults,
      );

      loadingOverlay.hide();

      RouteUtils.popAllRoutesExceptFirst();
      tabsPageKey.currentState!.changePage(AppMenuDestinationsID.dashboard);

      MonekinSnackbar.success(
        SnackbarParams(t.backup.import.manual_import.success(x: inserted)),
      );
    } catch (e) {
      Logger.printDebug(e);
      loadingOverlay.hide();

      MonekinSnackbar.error(SnackbarParams.fromError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isLast = stage == _ImportStage.review;

    return PageFramework(
      persistentFooterButtons: [
        PersistentFooterButton(
          child: Row(
            children: [
              if (stage != _ImportStage.file) ...[
                OutlinedButton(
                  onPressed: _goBack,
                  child: Text(t.ui_actions.back),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: FilledButton.icon(
                  onPressed: _canContinue ? _continue : null,
                  icon: Icon(
                    isLast ? Icons.check_rounded : Icons.arrow_forward_rounded,
                  ),
                  iconAlignment: isLast
                      ? IconAlignment.start
                      : IconAlignment.end,
                  label: Text(
                    isLast ? t.backup.import.title : t.ui_actions.continue_text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      body: Column(
        children: [
          _StageIndicator(stage: stage),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: SingleChildScrollView(
                key: ValueKey(stage),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: switch (stage) {
                  _ImportStage.file => _buildFileStage(context),
                  _ImportStage.columns => _buildColumnsStage(context),
                  _ImportStage.review => CsvImportReview(
                    result: parseResult!,
                    defaults: _defaults,
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileStage(BuildContext context) {
    final t = Translations.of(context).backup.import;
    final selected = selectedTemplate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepTitle(
          title: t.manual_import.file_title,
          subtitle: t.manual_import.file_descr,
        ),
        if (csvData == null)
          CsvFilePickerDropzone(onTap: readFile)
        else
          _PickedFileCard(
            name: fileName ?? '',
            rows: rows.length,
            columns: headers.length,
            onChange: readFile,
          ),
        const SizedBox(height: 28),
        Text(
          t.manual_import.autofill_title,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          t.manual_import.autofill_descr,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final template in CsvImportTemplates.apps)
              _AppChoice(
                template: template,
                isSelected: selected == template,
                onTap: () => setState(() {
                  selectedTemplate = selected == template ? null : template;
                  mappingOutdated = true;
                }),
              ),
          ],
        ),
        if (selected != null) ...[
          const SizedBox(height: 12),
          InlineInfoCard(
            text: selected.exportHint(Translations.of(context)),
            mode: InlineInfoCardMode.info,
          ),
        ],
      ],
    );
  }

  Widget _buildColumnsStage(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepTitle(title: t.columns_title, subtitle: t.columns_descr),
        if (templateMismatch) ...[
          InlineInfoCard(
            text: t.template_mismatch(app: selectedTemplate!.name),
            mode: InlineInfoCardMode.warn,
          ),
          const SizedBox(height: 12),
        ] else if (appliedTemplate != null) ...[
          InlineInfoCard(
            text: t.template_applied(app: appliedTemplate!.name),
            mode: InlineInfoCardMode.info,
          ),
          const SizedBox(height: 12),
        ],
        CsvImportMappingForm(
          headers: headers,
          rows: rows,
          mapping: mapping,
          onMappingChanged: (value) => setState(() => mapping = value),
          defaultAccount: defaultAccount,
          defaultCategory: defaultCategory,
          defaultTags: defaultTags,
          onPickDefaultAccount: _pickDefaultAccount,
          onClearDefaultAccount: () => setState(() => defaultAccount = null),
          onPickDefaultCategory: _pickDefaultCategory,
          onPickDefaultTags: _pickDefaultTags,
        ),
      ],
    );
  }

  Future<void> _pickDefaultAccount() async {
    final modalRes = await showAccountSelectorBottomSheet(
      context,
      AccountSelectorModal(
        allowMultiSelection: false,
        filterSavingAccounts: true,
        selectedAccounts: [?defaultAccount],
      ),
    );

    if (modalRes != null && modalRes.isNotEmpty) {
      setState(() => defaultAccount = modalRes.first);
    }
  }

  Future<void> _pickDefaultCategory() async {
    final modalRes = await showCategoryPickerModal(
      context,
      modal: CategoryPicker(
        selectedCategory: defaultCategory,
        categoryType: const [CategoryType.B],
      ),
    );

    if (modalRes != null) setState(() => defaultCategory = modalRes);
  }

  Future<void> _pickDefaultTags() async {
    final selected = await showTagListModal(
      context,
      modal: TagSelector(
        selectedTags: defaultTags,
        allowEmptySubmit: true,
        includeNullTag: false,
      ),
    );

    if (selected != null) {
      setState(
        () => defaultTags = selected.selectedTags.whereType<Tag>().toList(),
      );
    }
  }
}

class _StepTitle extends StatelessWidget {
  const _StepTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _PickedFileCard extends StatelessWidget {
  const _PickedFileCard({
    required this.name,
    required this.rows,
    required this.columns,
    required this.onChange,
  });

  final String name;
  final int rows;
  final int columns;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).backup.import;
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
      decoration: cardSurfaceDecoration(context),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colors.primaryContainer,
            child: Icon(
              Icons.description_rounded,
              color: colors.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  t.manual_import.file_info(rows: rows, columns: columns),
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          TextButton(onPressed: onChange, child: Text(t.select_other_file)),
        ],
      ),
    );
  }
}

/// A selectable chip with the icon and name of an app
class _AppChoice extends StatelessWidget {
  const _AppChoice({
    required this.template,
    required this.isSelected,
    required this.onTap,
  });

  final CsvImportTemplate template;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final fallback = DecoratedBox(
      decoration: BoxDecoration(
        color: template.color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(template.icon, size: 18, color: template.color),
    );

    return Material(
      color: isSelected
          ? colors.primaryContainer.withOpacity(0.6)
          : colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected
              ? colors.primary
              : colors.outlineVariant.withOpacity(0.5),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              template.playStorePackage == null
                  ? SizedBox.square(dimension: 32, child: fallback)
                  : StoreAppIcon(
                      packageName: template.playStorePackage!,
                      fallback: fallback,
                      size: 32,
                    ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  template.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: colors.primary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact "File · Columns · Review" progress indicator
class _StageIndicator extends StatelessWidget {
  const _StageIndicator({required this.stage});

  final _ImportStage stage;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colors = Theme.of(context).colorScheme;

    final labels = [
      t.backup.import.manual_import.stage_file,
      t.backup.import.manual_import.stage_columns,
      t.backup.import.manual_import.stage_review,
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        children: [
          for (final (i, label) in labels.indexed) ...[
            if (i > 0)
              Expanded(
                child: Divider(
                  height: 1,
                  color: i <= stage.index
                      ? colors.primary
                      : colors.outlineVariant,
                ),
              ),
            _StageDot(
              number: i + 1,
              label: label,
              isDone: i < stage.index,
              isCurrent: i == stage.index,
            ),
          ],
        ],
      ),
    );
  }
}

class _StageDot extends StatelessWidget {
  const _StageDot({
    required this.number,
    required this.label,
    required this.isDone,
    required this.isCurrent,
  });

  final int number;
  final String label;
  final bool isDone;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isActive = isDone || isCurrent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? colors.primary : colors.surfaceContainerHigh,
            ),
            child: isDone
                ? Icon(Icons.check_rounded, size: 16, color: colors.onPrimary)
                : Text(
                    '$number',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isActive
                          ? colors.onPrimary
                          : colors.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: isActive ? colors.onSurface : colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
