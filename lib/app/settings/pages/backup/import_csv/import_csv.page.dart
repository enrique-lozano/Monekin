import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart' show FileType;
import 'package:flutter/material.dart';
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
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/csv_file_picker_dropzone.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/loading_overlay.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/csv_import/csv_import_mapping.dart';
import 'package:monekin/core/services/csv_import/csv_import_templates.dart';
import 'package:monekin/core/services/csv_import/csv_transaction_parser.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum _ImportStage { file, columns, review }

/// Wizard to import the transactions of a CSV file, following the mapping
/// proposed by a [CsvImportTemplate].
class ImportCSVPage extends StatefulWidget {
  const ImportCSVPage({super.key, required this.template});

  final CsvImportTemplate template;

  @override
  State<ImportCSVPage> createState() => _ImportCSVPageState();
}

class _ImportCSVPageState extends State<ImportCSVPage> {
  _ImportStage stage = _ImportStage.file;

  List<List<String>>? csvData;
  List<String> get headers => csvData!.first;
  List<List<String>> get rows => csvData!.sublist(1);

  CsvImportMapping mapping = const CsvImportMapping();

  /// The file does not look like an export of the selected app
  bool templateMismatch = false;

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

      final template = widget.template;
      final fileHeaders = parsedCSV.first;

      // Unknown files are mapped with the generic guesses
      final matches =
          template.requiredHeaders.isEmpty || template.matches(fileHeaders);

      setState(() {
        csvData = parsedCSV;
        templateMismatch = !matches;
        mapping = (matches ? template : CsvImportTemplates.spreadsheet)
            .mappingFor(fileHeaders);
        stage = _ImportStage.columns;
      });
    } catch (err) {
      MonekinSnackbar.error(SnackbarParams.fromError(err));
    }
  }

  bool get _canContinue => switch (stage) {
    _ImportStage.file => false,
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
      title: widget.template.name,
      persistentFooterButtons: stage == _ImportStage.file
          ? null
          : [
              PersistentFooterButton(
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: _goBack,
                      child: Text(t.ui_actions.back),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _canContinue ? _continue : null,
                        icon: Icon(
                          isLast
                              ? Icons.check_rounded
                              : Icons.arrow_forward_rounded,
                        ),
                        iconAlignment: isLast
                            ? IconAlignment.start
                            : IconAlignment.end,
                        label: Text(
                          isLast
                              ? t.backup.import.title
                              : t.ui_actions.continue_text,
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
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconDisplayer(
              mainColor: widget.template.color,
              icon: widget.template.icon,
              size: 26,
              padding: 12,
              borderRadius: 16,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                t.backup.import.manual_import.file_title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        InlineInfoCard(
          text: widget.template.exportHint(t),
          mode: InlineInfoCardMode.info,
        ),
        const SizedBox(height: 16),
        CsvFilePickerDropzone(onTap: readFile),
      ],
    );
  }

  Widget _buildColumnsStage(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (templateMismatch) ...[
          InlineInfoCard(
            text: t.backup.import.manual_import.template_mismatch(
              app: widget.template.name,
            ),
            mode: InlineInfoCardMode.warn,
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

/// Compact "File · Columns · Review" progress indicator
class _StageIndicator extends StatelessWidget {
  const _StageIndicator({required this.stage});

  final _ImportStage stage;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colors = Theme.of(context).colorScheme;

    final labels = {
      _ImportStage.file: t.backup.import.manual_import.stage_file,
      _ImportStage.columns: t.backup.import.manual_import.stage_columns,
      _ImportStage.review: t.backup.import.manual_import.stage_review,
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          for (final (i, entry) in labels.entries.indexed) ...[
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
              label: entry.value,
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
