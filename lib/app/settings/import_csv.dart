import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/app/layout/tabs.dart';
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
import 'package:monekin/core/presentation/widgets/loading_overlay.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/app_colors.dart';

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

  final TextEditingController _dateFormatController =
      TextEditingController(text: 'yyyy-MM-dd HH:mm:ss');

  int? categoryColumn;
  Category? defaultCategory;
  Account? defaultAccount;

  int? notesColumn;
  int? titleColumn;

  void readFile() {
    BackupDatabaseService().readFile().then((csv) async {
      if (csv == null) {
        return;
      }

      await BackupDatabaseService()
          .processCsv(await csv.readAsString())
          .then((parsedCSV) {
        final columnsLenght = parsedCSV.map((e) => e.length).toList();

        if (parsedCSV.length >= 2 &&
            columnsLenght.elementAt(0) == columnsLenght.elementAt(1) + 1) {
          parsedCSV[0].removeLast();
        }

        if (parsedCSV.every((e) => e == parsedCSV.first)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'All the rows of the csv file must have the same number of columns')));
        }

        setState(() {
          csvData = parsedCSV;
        });
      });
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    });
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
    iconColor ??= AppColors.of(context).primary;

    return TextFormField(
        controller:
            TextEditingController(text: inputValue ?? t.general.unspecified),
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
        ));
  }

  DropdownButtonFormField<int> buildColumnSelector(
      {required int? value,
      required Iterable<String> headersToSelect,
      String? labelText,
      bool isNullable = true,
      required void Function(int? value) onChanged}) {
    labelText ??= t.backup.import.manual_import.select_a_column;

    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(labelText: labelText),
      items: [
        if (isNullable)
          DropdownMenuItem(
            value: null,
            child: Text(t.general.unspecified),
          ),
        ...List.generate(
            headersToSelect.length,
            (index) => DropdownMenuItem(
                  value: csvHeaders!.toList().indexWhere(
                      (element) => element == headersToSelect.toList()[index]),
                  child: Text(headersToSelect.toList()[index]),
                ))
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
    final snackbarDisplayer = ScaffoldMessenger.of(context).showSnackBar;

    if (amountColumn == null) {
      snackbarDisplayer(
        const SnackBar(content: Text('Amount column can not be null')),
      );

      return;
    }

    final loadingOverlay = LoadingOverlay.of(context);

    onSuccess() {
      RouteUtils.pushRoute(context, const TabsPage());

      snackbarDisplayer(
        SnackBar(
          content: Text(t.backup.import.manual_import
              .success(x: csvData!.slice(1).length)),
        ),
      );
    }

    loadingOverlay.show();

    try {
      final csvRows = csvData!.slice(1).toList();
      final db = AppDB.instance;

      const unknownAccountName = 'Account imported';

      for (final row in csvRows) {
        final account = await (db.select(db.accounts)
              ..where((tbl) => tbl.name.lower().isValue(accountColumn == null
                  ? unknownAccountName.toLowerCase()
                  : row[accountColumn!].toString().toLowerCase())))
            .getSingleOrNull();

        final accountID = account != null
            ? account.id
            : defaultAccount != null
                ? defaultAccount!.id
                : generateUUID();

        if (account == null && defaultAccount == null) {
          await AccountService.instance.insertAccount(AccountInDB(
              id: accountID,
              name: accountColumn == null
                  ? unknownAccountName
                  : row[accountColumn!].toString(),
              iniValue: 0,
              displayOrder: 10,
              date: DateTime.now(),
              type: AccountType.normal,
              iconId: SupportedIconService.instance.defaultSupportedIcon.id,
              currencyId: (await CurrencyService.instance
                      .getUserPreferredCurrency()
                      .first)
                  .code));
        }

        final categoryToFind = categoryColumn == null
            ? null
            : row[categoryColumn!].toString().toLowerCase().trim();

        final String categoryID = categoryToFind == null
            ? defaultCategory!.id
            : (await CategoryService.instance
                        .getCategories(
                          limit: 1,
                          predicate: (catTable, pCatTable) =>
                              catTable.name
                                  .lower()
                                  .trim()
                                  .isValue(categoryToFind) |
                              pCatTable.name
                                  .lower()
                                  .trim()
                                  .isValue(categoryToFind),
                        )
                        .first)
                    .firstOrNull
                    ?.id ??
                defaultCategory!.id;

        await TransactionService.instance.insertTransaction(TransactionInDB(
          id: generateUUID(),
          date: dateColumn == null
              ? DateTime.now()
              : DateFormat(_dateFormatController.text, 'en_US')
                  .parse(row[dateColumn!].toString()),
          accountID: accountID,
          value: double.parse(row[amountColumn!].toString()),
          isHidden: false,
          categoryID: categoryID,
          notes: notesColumn == null || row[notesColumn!].toString().isEmpty
              ? null
              : row[notesColumn!].toString(),
          title: titleColumn == null || row[titleColumn!].toString().isEmpty
              ? null
              : row[titleColumn!].toString(),
        ));
      }

      loadingOverlay.hide();
      onSuccess();
    } catch (e) {
      print(e);
      loadingOverlay.hide();
      snackbarDisplayer(SnackBar(content: Text(e.toString())));
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
          ...content
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
        appBar: AppBar(title: Text(t.backup.import.manual_import.title)),
        body: Stepper(
          type: StepperType.vertical,
          currentStep: currentStep,
          onStepTapped: (value) {
            setState(() {
              currentStep = value;
            });
          },
          controlsBuilder: (context, details) {
            bool nextButtonDisabled = currentStep == 0 && csvData == null ||
                currentStep == 3 && defaultCategory == null ||
                currentStep == 1 && amountColumn == null ||
                currentStep == 4 && _dateFormatController.text.isEmpty;

            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: currentStep == 5
                  ? SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed:
                            nextButtonDisabled ? null : () => addTransactions(),
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
                          child: Text(t.general.continue_text),
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
                            label: Text(t.backup.import.manual_import
                                .remove_default_account),
                          ),
                        ]
                      ],
                    ),
            );
          },
          onStepContinue: () {
            setState(() => currentStep++);
          },
          steps: [
            buildStep(index: 0, content: [
              if (csvData == null)
                InkWell(
                  onTap: () => readFile(),
                  child: DottedBorder(
                    color: Colors.grey.withOpacity(0.5),
                    strokeWidth: 3,
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.RRect,
                    dashPattern: const [6, 8],
                    radius: const Radius.circular(12),
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 68),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,
                                size: 48,
                                weight: 10,
                                color: Colors.grey.withOpacity(0.95)),
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
                ),
              if (csvData != null) ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) => Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.18),
                    ),
                    headingTextStyle:
                        const TextStyle(fontWeight: FontWeight.w600),
                    columns: csvHeaders!
                        .map((item) => DataColumn(label: Text(item)))
                        .toList(),
                    rows: csvData!
                        .sublist(
                            1,
                            _rowsToPreview > csvData!.length
                                ? null
                                : _rowsToPreview)
                        .map(
                          (csvrow) => DataRow(
                            cells: csvrow
                                .map((csvItem) =>
                                    DataCell(Text(csvItem.toString())))
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
                ),
                if (csvData!.length - _rowsToPreview >= 1)
                  Text(
                    '+${csvData!.length - _rowsToPreview} rows',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                const SizedBox(height: 12),
              ]
            ]),
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
                        (index, element) => index != amountColumn),
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
                              if (defaultAccount != null) defaultAccount!
                            ],
                          ));

                      if (modalRes != null && modalRes.isNotEmpty) {
                        setState(() {
                          defaultAccount = modalRes.first;
                        });
                      }
                    }),
              ],
            ),
            buildStep(
              index: 3,
              content: [
                if (csvHeaders != null)
                  Builder(builder: (context) {
                    final headersToSelect = csvHeaders!.whereIndexed(
                        (index, element) =>
                            index != amountColumn && index != accountColumn);

                    return buildColumnSelector(
                      value: categoryColumn,
                      headersToSelect: headersToSelect,
                      onChanged: (value) {
                        setState(() {
                          categoryColumn = value;
                        });
                      },
                    );
                  }),
                const SizedBox(height: 12),
                selector(
                    title:
                        '${t.backup.import.manual_import.default_category} *',
                    inputValue: defaultCategory?.name,
                    icon: defaultCategory?.icon,
                    isRequired: true,
                    iconColor: defaultCategory != null
                        ? ColorHex.get(defaultCategory!.color)
                        : null,
                    onClick: () async {
                      final modalRes = await showCategoryListModal(
                          context,
                          const CategoriesList(
                            mode: CategoriesListMode.modalSelectSubcategory,
                          ));

                      if (modalRes != null && modalRes.isNotEmpty) {
                        setState(() {
                          defaultCategory = modalRes.first;
                        });
                      }
                    }),
              ],
            ),
            buildStep(
              index: 4,
              content: [
                if (csvHeaders != null)
                  buildColumnSelector(
                    value: dateColumn,
                    headersToSelect: csvHeaders!.whereIndexed((index,
                            element) =>
                        index != amountColumn &&
                        index != accountColumn &&
                        (categoryColumn == null || index != categoryColumn)),
                    onChanged: (value) {
                      setState(() {
                        dateColumn = value;
                      });
                    },
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateFormatController,
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
                  Builder(builder: (context) {
                    final headersToSelect = csvHeaders!.whereIndexed((index,
                            element) =>
                        index != amountColumn &&
                        index != accountColumn &&
                        index != dateColumn &&
                        (categoryColumn == null || index != categoryColumn));

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
                  }),
              ],
            ),
          ],
        ));
  }
}
