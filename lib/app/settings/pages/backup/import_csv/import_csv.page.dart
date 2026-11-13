import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart' show FileType;
import 'package:intl/intl.dart';
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
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
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
import 'package:monekin/core/utils/open_external_url.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum _ImportStage { file, columns, review }

Widget _sourceIcon(BuildContext context, CsvImportTemplate? template) {
  final colors = Theme.of(context).colorScheme;
  final fallback = CircleAvatar(
    radius: 18,
    backgroundColor: template?.color ?? colors.primaryContainer,
    child: Icon(
      template?.icon ?? Icons.table_rows_rounded,
      color: template == null ? colors.onPrimaryContainer : Colors.white,
    ),
  );

  final packageName = template?.playStorePackage;
  if (packageName == null) return fallback;

  return StoreAppIcon(packageName: packageName, fallback: fallback, size: 36);
}

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
  int? fileSize;
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

      final selectedFileSize = await csvFile.length();
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
        fileSize = selectedFileSize;
        mappingOutdated = true;
      });
    } catch (err) {
      MonekinSnackbar.error(SnackbarParams.fromError(err));
    }
  }

  Future<void> _pickSource(BuildContext anchorContext) async {
    final t = Translations.of(context).backup.import.manual_import;
    final result =
        await showDynamicSelectorBottomSheet<CsvImportTemplate?, String?>(
          anchorContext,
          selectorWidget: DynamicSelectorModal<CsvImportTemplate?, String?>(
            title: t.source_picker_title,
            subtitle: t.autofill_descr,
            items: [null, ...CsvImportTemplates.apps],
            selectedValue: selectedTemplate?.id,
            displayNameGetter: (template) => template?.name ?? t.source_auto,
            valueGetter: (template) => template?.id,
            elementTitleBuilder: (title, template) {
              return Row(
                children: [
                  _sourceIcon(context, template),
                  const SizedBox(width: 12),
                  Expanded(child: Text(title)),
                ],
              );
            },
          ),
        );

    if (result == null) return;

    setState(() {
      selectedTemplate = CsvImportTemplates.apps.firstWhereOrNull(
        (template) => template.id == result.result,
      );
      mappingOutdated = true;
      templateMismatch =
          csvData != null &&
          selectedTemplate != null &&
          !selectedTemplate!.matches(headers);
    });
  }

  int _matchedColumnCount(CsvImportMapping mapping) {
    final amountColumns = switch (mapping.amountMode) {
      CsvAmountMode.signed => [mapping.amountColumn],
      CsvAmountMode.separateColumns => [
        mapping.incomeColumn,
        mapping.expenseColumn,
      ],
      CsvAmountMode.typeColumn => [mapping.amountColumn, mapping.typeColumn],
    };

    return <int?>[
      ...amountColumns,
      mapping.transferColumn,
      mapping.accountColumn,
      mapping.destinationAccountColumn,
      mapping.categoryColumn,
      mapping.tagsColumn,
      mapping.dateColumn,
      mapping.timeColumn,
      mapping.notesColumn,
      mapping.titleColumn,
    ].nonNulls.toSet().length;
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
    final manualImport = t.backup.import.manual_import;
    final indicatorCount = _ImportStage.values.length;
    final stageLabel = switch (stage) {
      _ImportStage.file => manualImport.stage_file,
      _ImportStage.columns => manualImport.stage_columns,
      _ImportStage.review => manualImport.stage_review,
    };

    return PageFramework(
      title: t.backup.import.title,
      persistentFooterButtons: [
        PersistentFooterButton(
          child: Row(
            children: [
              if (stage != _ImportStage.file) ...[
                OutlinedButton.icon(
                  onPressed: _goBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text(t.ui_actions.back),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const expansionFactor = 4;
                const spacing = 4.0;
                final colors = Theme.of(context).colorScheme;

                return AnimatedSmoothIndicator(
                  activeIndex: stage.index,
                  count: indicatorCount,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    radius: 4,
                    dotColor: colors.surfaceContainerHighest,
                    activeDotColor: colors.primary,
                    spacing: spacing,
                    dotWidth:
                        constraints.maxWidth /
                            (indicatorCount + expansionFactor - 1) -
                        spacing / indicatorCount,
                    expansionFactor: expansionFactor.toDouble(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                manualImport
                    .stage_indicator(
                      step: stage.index + 1,
                      total: indicatorCount,
                      label: stageLabel,
                    )
                    .toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              layoutBuilder: (currentChild, previousChildren) => Stack(
                alignment: Alignment.topCenter,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
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
    final detectedTemplate = csvData == null
        ? null
        : CsvImportTemplates.apps.firstWhereOrNull(
            (template) => template.matches(headers),
          );
    final source = selectedTemplate ?? detectedTemplate;
    final matchingSource = csvData != null && source?.matches(headers) == true
        ? source
        : null;
    final matchedColumnCount = matchingSource == null
        ? null
        : _matchedColumnCount(matchingSource.mappingFor(headers));
    final String sourceSubtitle;

    if (selectedTemplate != null) {
      sourceSubtitle = t.manual_import.source_selected;
    } else if (detectedTemplate != null) {
      sourceSubtitle = t.manual_import.source_detected;
    } else {
      sourceSubtitle = t.manual_import.source_auto_descr;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SourceSelector(
          title: t.manual_import.source_title,
          source: source,
          subtitle: sourceSubtitle,
          onTap: _pickSource,
        ),
        if (selectedTemplate != null) ...[
          const SizedBox(height: 12),
          InlineInfoCard(
            text: selectedTemplate!.exportHint(Translations.of(context)),
            mode: InlineInfoCardMode.info,
          ),
          if (selectedTemplate!.guideUrl != null)
            TextButton.icon(
              onPressed: () =>
                  openExternalURL(context, selectedTemplate!.guideUrl!),
              icon: const Icon(Icons.open_in_new_rounded, size: 18),
              label: Text(t.manual_import.open_guide),
            ),
        ],
        const SizedBox(height: 20),
        _StepTitle(
          title: t.manual_import.file_title,
          subtitle: t.manual_import.file_descr,
        ),
        if (csvData == null)
          CsvFilePickerDropzone(onTap: readFile)
        else
          _PickedFileCard(
            name: fileName ?? '',
            size: fileSize ?? 0,
            rows: rows.length,
            columns: headers.length,
            matchedColumns: matchedColumnCount,
            onChange: readFile,
          ),
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

  Future<void> _pickDefaultAccount(BuildContext anchorContext) async {
    final modalRes = await showAccountSelectorBottomSheet(
      anchorContext,
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

  Future<void> _pickDefaultCategory(BuildContext anchorContext) async {
    final modalRes = await showCategoryPickerModal(
      anchorContext,
      modal: CategoryPicker(
        selectedCategory: defaultCategory,
        categoryType: const [CategoryType.B],
      ),
    );

    if (modalRes != null) setState(() => defaultCategory = modalRes);
  }

  Future<void> _pickDefaultTags(BuildContext anchorContext) async {
    final selected = await showTagListModal(
      anchorContext,
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

class _SourceSelector extends StatelessWidget {
  const _SourceSelector({
    required this.title,
    required this.source,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final CsvImportTemplate? source;
  final String subtitle;

  /// Receives the context of the card, to anchor the picker popover to it
  final ValueChanged<BuildContext> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final sourceName =
        source?.name ??
        Translations.of(context).backup.import.manual_import.source_auto;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.5)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Builder(
          builder: (cardContext) => Material(
            color: colors.surfaceContainerLow,
            shape: shape,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => onTap(cardContext),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _sourceIcon(context, source),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sourceName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.expand_more_rounded),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PickedFileCard extends StatelessWidget {
  const _PickedFileCard({
    required this.name,
    required this.size,
    required this.rows,
    required this.columns,
    required this.matchedColumns,
    required this.onChange,
  });

  final String name;
  final int size;
  final int rows;
  final int columns;
  final int? matchedColumns;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).backup.import;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                      t.manual_import.file_info(
                        size: _formatFileSize(size),
                        rows: rows,
                        columns: columns,
                      ),
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: onChange, child: Text(t.select_other_file)),
            ],
          ),
        ),
        if (matchedColumns != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.tertiaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 14,
                      color: colors.onTertiaryContainer,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      t.manual_import.columns_matched(
                        matched: matchedColumns!,
                        total: columns,
                      ),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.onTertiaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

String _formatFileSize(int bytes) {
  const units = ['B', 'KB', 'MB', 'GB'];
  var size = bytes.toDouble();
  var unit = 0;

  while (size >= 1024 && unit < units.length - 1) {
    size /= 1024;
    unit++;
  }

  return '${NumberFormat('0.#').format(size)} ${units[unit]}';
}
