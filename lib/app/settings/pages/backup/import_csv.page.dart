import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/layout/page_switcher.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/loading_overlay.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class ImportCSVPage extends StatefulWidget {
  const ImportCSVPage({super.key});

  @override
  State<ImportCSVPage> createState() => _ImportCSVPageState();
}

const _rowsToPreview = 5;

class _ImportCSVPageState extends State<ImportCSVPage> {
  int currentStep = 0;

  List<List<dynamic>>? csvData;
  Iterable<String>? get csvHeaders =>
      csvData?[0].map((item) => item.toString());

  int? amountColumn;
  int? accountColumn;
  int? dateColumn;

  final TextEditingController _dateFormatController = TextEditingController(
    text: 'yyyy-MM-dd HH:mm:ss',
  );

  int? categoryColumn;
  Category? defaultCategory;
  Account? defaultAccount;

  int? notesColumn;
  int? titleColumn;

  Future<void> readFile() async {
    try {
      final csvFile = await BackupDatabaseService().readFile();
      if (csvFile == null) return;

      final csvString = await csvFile.readAsString();
      final parsedCSV = await BackupDatabaseService().processCsv(csvString);

      final firstRowLength = parsedCSV.first.length;

      if (parsedCSV.length >= 2 && firstRowLength == parsedCSV[1].length + 1) {
        // Remove trailing column in header row if it has one more than the second row
        parsedCSV[0].removeLast();
      }

      if (parsedCSV.length > 2 &&
          parsedCSV.last.every((cell) => cell.trim().isEmpty)) {
        // Remove last row if it's effectively empty
        parsedCSV.removeLast();
      }

      final allRowsSameLength = parsedCSV.every(
        (row) => row.length == firstRowLength,
      );

      if (!allRowsSameLength) {
        MonekinSnackbar.error(
          SnackbarParams(
            'All rows in the CSV must have the same number of columns.',
          ),
        );

        return;
      }

      setState(() {
        csvData = parsedCSV;
      });
    } catch (err) {
      MonekinSnackbar.error(SnackbarParams.fromError(err));
    }
  }

  Widget selector({
    required String title,
    required String? inputValue,
    required SupportedIcon? icon,
    required Color? iconColor,
    required Function onClick,
    bool isRequired = false,
  }) {
    final t = Translations.of(context);

    icon ??= SupportedIconService.instance.defaultSupportedIcon;
    iconColor ??= Theme.of(context).colorScheme.primary;

    return TextFormField(
      controller: TextEditingController(
        text: inputValue ?? t.general.unspecified,
      ),
      readOnly: true,
      validator: (_) => fieldValidator(inputValue, isRequired: isRequired),
      onTap: () => onClick(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: title,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        prefixIcon: Container(
          margin: const EdgeInsets.fromLTRB(14, 8, 8, 8),
          child: IconDisplayer(mainColor: iconColor, supportedIcon: icon),
        ),
      ),
    );
  }

  DropdownButtonFormField<int> buildColumnSelector({
    required int? value,
    required Iterable<String> headersToSelect,
    String? labelText,
    bool isNullable = true,
    required void Function(int? value) onChanged,
  }) {
    labelText ??= t.backup.import.manual_import.select_a_column;

    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(labelText: labelText),
      items: [
        if (isNullable)
          DropdownMenuItem(value: null, child: Text(t.general.unspecified)),
        ...List.generate(
          headersToSelect.length,
          (index) => DropdownMenuItem(
            value: csvHeaders!.toList().indexWhere(
              (element) => element == headersToSelect.toList()[index],
            ),
            child: Text(headersToSelect.toList()[index]),
          ),
        ),
      ],
      onChanged: (value) {
        if (dateColumn == value) dateColumn = null;
        if (notesColumn == value) notesColumn = null;
        if (titleColumn == value) titleColumn = null;
        if (amountColumn == value) amountColumn = null;
        if (accountColumn == value) accountColumn = null;
        if (categoryColumn == value) categoryColumn = null;

        onChanged(value);
      },
    );
  }

  Future<void> addTransactions() async {
    onSuccess() {
      RouteUtils.popAllRoutesExceptFirst();
      RouteUtils.pushRoute(const PageSwitcher());

      MonekinSnackbar.success(
        SnackbarParams(
          t.backup.import.manual_import.success(x: csvData!.slice(1).length),
        ),
      );
    }

    if (amountColumn == null) {
      MonekinSnackbar.warning(SnackbarParams('Amount column can not be null'));
      return;
    }

    final loadingOverlay = LoadingOverlay.of(context);
    loadingOverlay.show();

    try {
      final csvRows = csvData!.slice(1).toList();
      final db = AppDB.instance;
      const unknownAccountName = 'Account imported';

      // Cache of known accounts by lowercase name
      final existingAccounts = {
        for (final acc in await db.select(db.accounts).get())
          acc.name.toLowerCase(): acc,
      };

      // Cache preferred currency once
      final preferredCurrency = await CurrencyService.instance
          .ensureAndGetPreferredCurrency()
          .first;

      final List<TransactionInDB> transactionsToInsert = [];

      for (final row in csvRows) {
        // Resolve account
        final accountName = accountColumn == null
            ? unknownAccountName
            : row[accountColumn!].toString();
        final lowerAccountName = accountName.toLowerCase();

        AccountInDB? account = existingAccounts[lowerAccountName];

        // If not found, insert and add to cache (unless default is used)
        String accountID;
        if (account != null) {
          accountID = account.id;
        } else if (defaultAccount != null) {
          accountID = defaultAccount!.id;
        } else {
          accountID = generateUUID();
          account = AccountInDB(
            id: accountID,
            name: accountName,
            iniValue: 0,
            displayOrder: 10,
            date: DateTime.now(),
            type: AccountType.normal,
            iconId: SupportedIconService.instance.defaultSupportedIcon.id,
            currencyId: preferredCurrency.code,
          );
          await AccountService.instance.insertAccount(account);
          existingAccounts[lowerAccountName] = account;
        }

        // Resolve category
        final categoryToFind = categoryColumn == null
            ? null
            : row[categoryColumn!].toString().toLowerCase().trim();

        String categoryID;

        if (categoryToFind == null) {
          categoryID = defaultCategory!.id;
        } else {
          final category =
              (await CategoryService.instance
                      .getCategories(
                        limit: 1,
                        predicate: (catTable, pCatTable) =>
                            catTable.name.lower().trim().isValue(
                              categoryToFind,
                            ) |
                            pCatTable.name.lower().trim().isValue(
                              categoryToFind,
                            ),
                      )
                      .first)
                  .firstOrNull;
          categoryID = category?.id ?? defaultCategory!.id;
        }

        final trValue = double.parse(row[amountColumn!].toString());

        transactionsToInsert.add(
          TransactionInDB(
            id: generateUUID(),
            date: dateColumn == null
                ? DateTime.now()
                : DateFormat(
                    _dateFormatController.text,
                    'en_US',
                  ).parse(row[dateColumn!].toString()),
            type: trValue < 0
                ? TransactionType.expense
                : TransactionType.income,
            accountID: accountID,
            value: trValue,
            isHidden: false,
            categoryID: categoryID,
            notes: notesColumn == null || row[notesColumn!].toString().isEmpty
                ? null
                : row[notesColumn!].toString(),
            title: titleColumn == null || row[titleColumn!].toString().isEmpty
                ? null
                : row[titleColumn!].toString(),
          ),
        );
      }

      // Batch insert
      const batchSize = 10;

      for (var i = 0; i < transactionsToInsert.length; i += batchSize) {
        final batch = transactionsToInsert.skip(i).take(batchSize);
        await Future.wait(
          batch.map((e) => TransactionService.instance.insertTransaction(e)),
        );
      }

      loadingOverlay.hide();
      onSuccess();
    } catch (e) {
      Logger.printDebug(e);
      loadingOverlay.hide();

      MonekinSnackbar.error(SnackbarParams.fromError(e));
    }
  }

  Step buildStep({required int index, required List<Widget> content}) {
    return Step(
      title: Text(t.backup.import.manual_import.steps[index]),
      isActive: currentStep >= index,
      state: currentStep > index
          ? StepState.complete
          : currentStep == index
          ? StepState.editing
          : StepState.disabled,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.backup.import.manual_import.steps_descr[index]),
          const SizedBox(height: 24),
          ...content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.backup.import.manual_import.title,
      body: Stepper(
        type: StepperType.vertical,
        currentStep: currentStep,
        onStepTapped: (value) {
          setState(() {
            currentStep = value;
          });
        },
        controlsBuilder: (context, details) {
          bool nextButtonDisabled =
              currentStep == 0 && csvData == null ||
              currentStep == 3 && defaultCategory == null ||
              currentStep == 1 && amountColumn == null ||
              currentStep == 4 && _dateFormatController.text.isEmpty;

          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: currentStep == 5
                ? SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: nextButtonDisabled
                          ? null
                          : () => addTransactions(),
                      label: Text(t.backup.import.title),
                      icon: const Icon(Icons.check_rounded),
                    ),
                  )
                : Row(
                    children: [
                      FilledButton(
                        onPressed: nextButtonDisabled
                            ? null
                            : details.onStepContinue,
                        child: Text(t.ui_actions.continue_text),
                      ),
                      if (currentStep == 0 && csvData != null) ...[
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: () => readFile(),
                          icon: const Icon(Icons.upload_file_rounded),
                          label: Text(t.backup.import.select_other_file),
                        ),
                      ],
                      if (currentStep == 2) ...[
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              defaultAccount = null;
                            });
                          },
                          icon: const Icon(Icons.delete_outline_rounded),
                          label: Text(
                            t
                                .backup
                                .import
                                .manual_import
                                .remove_default_account,
                          ),
                        ),
                      ],
                    ],
                  ),
          );
        },
        onStepContinue: () {
          setState(() => currentStep++);
        },
        steps: [
          buildStep(
            index: 0,
            content: [
              if (csvData == null) selectCsvButton(t, context),
              if (csvData != null) ...[
                csvPreviewTable(context),
                if (csvData!.length - _rowsToPreview >= 1)
                  Text(
                    '+${csvData!.length - _rowsToPreview} rows',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                const SizedBox(height: 12),
              ],
            ],
          ),
          buildStep(
            index: 1,
            content: [
              if (csvHeaders != null)
                buildColumnSelector(
                  value: amountColumn,
                  headersToSelect: csvHeaders!,
                  onChanged: (value) {
                    setState(() {
                      amountColumn = value;
                    });
                  },
                ),
            ],
          ),
          buildStep(
            index: 2,
            content: [
              if (csvHeaders != null)
                buildColumnSelector(
                  value: accountColumn,
                  headersToSelect: csvHeaders!.whereIndexed(
                    (index, element) => index != amountColumn,
                  ),
                  onChanged: (value) {
                    setState(() {
                      accountColumn = value;
                    });
                  },
                ),
              const SizedBox(height: 12),
              selector(
                title: t.backup.import.manual_import.default_account,
                inputValue: defaultAccount?.name,
                icon: defaultAccount?.icon,
                iconColor: null,
                onClick: () async {
                  final modalRes = await showAccountSelectorBottomSheet(
                    context,
                    AccountSelectorModal(
                      allowMultiSelection: false,
                      filterSavingAccounts: true,
                      selectedAccounts: [
                        if (defaultAccount != null) defaultAccount!,
                      ],
                    ),
                  );

                  if (modalRes != null && modalRes.isNotEmpty) {
                    setState(() {
                      defaultAccount = modalRes.first;
                    });
                  }
                },
              ),
            ],
          ),
          buildStep(
            index: 3,
            content: [
              if (csvHeaders != null)
                Builder(
                  builder: (context) {
                    final headersToSelect = csvHeaders!.whereIndexed(
                      (index, element) =>
                          index != amountColumn && index != accountColumn,
                    );

                    return buildColumnSelector(
                      value: categoryColumn,
                      headersToSelect: headersToSelect,
                      onChanged: (value) {
                        setState(() {
                          categoryColumn = value;
                        });
                      },
                    );
                  },
                ),
              const SizedBox(height: 12),
              selector(
                title: '${t.backup.import.manual_import.default_category} *',
                inputValue: defaultCategory?.name,
                icon: defaultCategory?.icon,
                isRequired: true,
                iconColor: defaultCategory != null
                    ? ColorHex.get(defaultCategory!.color)
                    : null,
                onClick: () async {
                  final modalRes = await showCategoryPickerModal(
                    context,
                    modal: CategoryPicker(
                      selectedCategory: null,
                      categoryType: const [CategoryType.B],
                    ),
                  );

                  if (modalRes != null) {
                    setState(() {
                      defaultCategory = modalRes;
                    });
                  }
                },
              ),
            ],
          ),
          buildStep(
            index: 4,
            content: [
              if (csvHeaders != null)
                buildColumnSelector(
                  value: dateColumn,
                  headersToSelect: csvHeaders!.whereIndexed(
                    (index, element) =>
                        index != amountColumn &&
                        index != accountColumn &&
                        (categoryColumn == null || index != categoryColumn),
                  ),
                  onChanged: (value) {
                    setState(() {
                      dateColumn = value;
                    });
                  },
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateFormatController,
                enabled: dateColumn != null,
                decoration: const InputDecoration(labelText: 'Date format'),
                validator: (value) => fieldValidator(value),
                autovalidateMode: AutovalidateMode.always,
              ),
            ],
          ),
          buildStep(
            index: 5,
            content: [
              if (csvHeaders != null)
                Builder(
                  builder: (context) {
                    final headersToSelect = csvHeaders!.whereIndexed(
                      (index, element) =>
                          index != amountColumn &&
                          index != accountColumn &&
                          index != dateColumn &&
                          (categoryColumn == null || index != categoryColumn),
                    );

                    return Column(
                      children: [
                        buildColumnSelector(
                          value: notesColumn,
                          labelText: 'Note column',
                          headersToSelect: headersToSelect,
                          onChanged: (value) {
                            setState(() {
                              notesColumn = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        buildColumnSelector(
                          value: titleColumn,
                          labelText: 'Title column',
                          headersToSelect: headersToSelect,
                          onChanged: (value) {
                            setState(() {
                              titleColumn = value;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  SingleChildScrollView csvPreviewTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => Theme.of(context).colorScheme.primary.withOpacity(0.18),
        ),
        clipBehavior: Clip.hardEdge,
        headingTextStyle: Theme.of(context).textTheme.labelLarge,
        dataTextStyle: Theme.of(context).textTheme.bodySmall,
        columns: csvHeaders!
            .map((item) => DataColumn(label: Text(item)))
            .toList(),
        rows: [
          ...csvData!
              .sublist(
                1,
                _rowsToPreview > csvData!.length ? null : _rowsToPreview,
              )
              .map(
                (csvrow) => DataRow(
                  cells: csvrow
                      .map((csvItem) => DataCell(Text(csvItem.toString())))
                      .toList(),
                ),
              ),
        ],
      ),
    );
  }

  InkWell selectCsvButton(Translations t, BuildContext context) {
    return InkWell(
      onTap: () => readFile(),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 3,
          strokeCap: StrokeCap.round,
          dashPattern: const [6, 8],
          radius: const Radius.circular(12),
        ),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 68),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 48,
                  weight: 10,
                  color: Colors.grey.withOpacity(0.95),
                ),
                const SizedBox(height: 4),
                Text(
                  t.backup.import.tap_to_select_file,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
