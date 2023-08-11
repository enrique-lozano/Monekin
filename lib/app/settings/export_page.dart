import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/widgets/filter_sheet_modal.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/database/backup/backup_database_service.dart';

enum _ExportFormats { csv, db }

class ExportDataPage extends StatefulWidget {
  const ExportDataPage({super.key});

  @override
  State<ExportDataPage> createState() => _ExportDataPageState();
}

class _ExportDataPageState extends State<ExportDataPage> {
  _ExportFormats selectedExportFormat = _ExportFormats.db;

  final filters = TransactionFilters();

  Widget cardSelector({
    required _ExportFormats exportFormat,
    required String title,
    required String descr,
    required String iconName,
  }) {
    final isSelected = selectedExportFormat == exportFormat;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 1.25,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => setState(() {
            selectedExportFormat = exportFormat;

            if (selectedExportFormat == _ExportFormats.db) {
              filters.clearAll();
            }
          }),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/backup/$iconName.svg',
                  height: 36,
                  width: 36,
                ),
                const SizedBox(height: 18),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                Text(
                  descr,
                  softWrap: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selector({
    required String title,
    required String? inputValue,
    required Function()? onClick,
  }) {
    final t = Translations.of(context);

    return TextField(
        controller:
            TextEditingController(text: inputValue ?? t.general.unspecified),
        readOnly: true,
        onTap: onClick,
        enabled: onClick != null,
        decoration: InputDecoration(
          labelText: title,
          contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 10),
          suffixIcon: const Icon(Icons.arrow_drop_down),
          border: const UnderlineInputBorder(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(t.backup.export.title),
        ),
        persistentFooterButtons: [
          PersistentFooterButton(
              child: FilledButton(
            child: Text(t.backup.export.title),
            onPressed: () async {
              final messeger = ScaffoldMessenger.of(context);

              if (selectedExportFormat == _ExportFormats.db) {
                await BackupDatabaseService()
                    .downloadDatabaseFile(context)
                    .then((value) {
                  print('EEEEEEEEEEE');
                }).catchError((err) {
                  print(err);
                });
              } else {
                await BackupDatabaseService()
                    .exportSpreadsheet(
                        context,
                        await TransactionService.instance
                            .getTransactions()
                            .first)
                    .then((value) {
                  messeger.showSnackBar(SnackBar(
                    content: Text('Fichero descargado con exito en $value'),
                  ));
                }).catchError((err) {
                  messeger.showSnackBar(SnackBar(
                    content: Text('$err'),
                  ));
                });
              }
            },
          ))
        ],
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 12, bottom: 16),
          child: Column(
            children: [
              cardSelector(
                exportFormat: _ExportFormats.db,
                title: t.backup.export.all,
                descr: t.backup.export.all_descr,
                iconName: 'db',
              ),
              cardSelector(
                exportFormat: _ExportFormats.csv,
                title: t.backup.export.transactions,
                descr: t.backup.export.transactions_descr,
                iconName: 'table_file',
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  /* ---------------------------------- */
                  /* -------- ACCOUNT SELECTOR -------- */
                  /* ---------------------------------- */

                  StreamBuilder(
                      stream: AccountService.instance.getAccounts(),
                      builder: (context, snapshot) {
                        return selector(
                            title: t.general.accounts,
                            inputValue: filters.accounts == null ||
                                    (snapshot.hasData &&
                                        filters.accounts!.length ==
                                            snapshot.data!.length)
                                ? t.account.select.all
                                : filters.accounts
                                    ?.map((e) => e.name)
                                    .join(', '),
                            onClick: selectedExportFormat == _ExportFormats.db
                                ? null
                                : () async {
                                    final modalRes =
                                        await showAccountSelectorBottomSheet(
                                            context,
                                            AccountSelector(
                                              allowMultiSelection: true,
                                              filterSavingAccounts: false,
                                              selectedAccounts:
                                                  filters.accounts ??
                                                      (snapshot.hasData
                                                          ? [...snapshot.data!]
                                                          : []),
                                            ));

                                    if (modalRes != null &&
                                        modalRes.isNotEmpty) {
                                      setState(() {
                                        filters.accounts = snapshot.hasData &&
                                                modalRes.length ==
                                                    snapshot.data!.length
                                            ? null
                                            : modalRes;
                                      });
                                    }
                                  });
                      }),

                  /* ---------------------------------- */
                  /* -------- CATEGORY SELECTOR ------- */
                  /* ---------------------------------- */

                  StreamBuilder(
                      stream: CategoryService.instance.getMainCategories(),
                      builder: (context, snapshot) {
                        return selector(
                            title: t.general.categories,
                            inputValue: filters.categories == null ||
                                    (snapshot.hasData &&
                                        filters.categories!.length ==
                                            snapshot.data!.length)
                                ? t.categories.select.all
                                : filters.categories
                                    ?.map((e) => e.name)
                                    .join(', '),
                            onClick: selectedExportFormat == _ExportFormats.db
                                ? null
                                : () async {
                                    final modalRes =
                                        await showCategoryListModal(
                                            context,
                                            CategoriesList(
                                              mode: CategoriesListMode
                                                  .modalSelectMultiCategory,
                                              selectedCategories:
                                                  filters.categories ??
                                                      (snapshot.data ?? []),
                                            ));

                                    if (modalRes != null &&
                                        modalRes.isNotEmpty) {
                                      setState(() {
                                        filters.categories = snapshot.hasData &&
                                                modalRes.length ==
                                                    snapshot.data!.length
                                            ? null
                                            : modalRes;
                                      });
                                    }
                                  });
                      }),
                ],
              )
            ],
          ),
        ));
  }
}
