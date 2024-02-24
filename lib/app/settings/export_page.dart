import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/category_selector.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/widgets/dates/outlinedButtonStacked.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
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

  TransactionFilters filters = const TransactionFilters();

  Widget cardSelector({
    required _ExportFormats exportFormat,
    required String title,
    required String descr,
  }) {
    final isSelected = selectedExportFormat == exportFormat;

    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      child: OutlinedButtonStacked(
        text: title,
        filled: isSelected,
        fontSize: 20,
        alignLeft: true,
        alignBeside: true,
        padding: const EdgeInsets.all(10),
        onTap: () {
          selectedExportFormat = exportFormat;

          if (selectedExportFormat == _ExportFormats.db) {
            filters = const TransactionFilters();
          }

          setState(() {});
        },
        iconData: exportFormat == _ExportFormats.csv
            ? Icons.format_quote
            : Icons.security,
        afterWidget: Text(descr),
      ),
    );
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
                            .getTransactions(filters: filters)
                            .first)
                    .then((value) {
                  messeger.showSnackBar(SnackBar(
                    content: Text(t.backup.export.success(x: value)),
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
          padding: const EdgeInsets.only(bottom: 12, top: 16),
          child: Column(
            children: [
              cardSelector(
                exportFormat: _ExportFormats.db,
                title: t.backup.export.all,
                descr: t.backup.export.all_descr,
              ),
              cardSelector(
                exportFormat: _ExportFormats.csv,
                title: t.backup.export.transactions,
                descr: t.backup.export.transactions_descr,
              ),
              const SizedBox(height: 8),
              IgnorePointer(
                ignoring: selectedExportFormat == _ExportFormats.db,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: selectedExportFormat == _ExportFormats.db ? 0.3 : 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* ---------------------------------- */
                        /* -------- ACCOUNT SELECTOR -------- */
                        /* ---------------------------------- */

                        Text('${t.general.accounts}:'),
                        const SizedBox(height: 6),
                        StreamBuilder(
                          stream: AccountService.instance.getAccounts(),
                          builder: (context, snapshot) {
                            return AccountSelector(
                              availableAccounts: snapshot.data,
                              iconPadding: 12,
                              iconSize: 40,
                              selectedAccounts: filters.accountsIDs == null
                                  ? null
                                  : (snapshot.data ?? [])
                                      .where(
                                        (element) => filters.accountsIDs!
                                            .contains(element.id),
                                      )
                                      .toList(),
                              onChange: (selection) {
                                filters = filters.copyWith(
                                  accountsIDs:
                                      selection?.map((e) => e.id).toList(),
                                );

                                setState(() {});
                              },
                            );
                          },
                        ),

                        /* ---------------------------------- */
                        /* -------- CATEGORY SELECTOR ------- */
                        /* ---------------------------------- */

                        const SizedBox(height: 2),
                        Text('${t.general.categories}:'),
                        const SizedBox(height: 6),
                        StreamBuilder(
                            stream:
                                CategoryService.instance.getMainCategories(),
                            builder: (context, snapshot) {
                              return CategorySelector(
                                availableCategories: snapshot.data,
                                selectedCategories: filters.categories == null
                                    ? null
                                    : (snapshot.data ?? [])
                                        .where(
                                          (element) => filters.categories!
                                              .contains(element.id),
                                        )
                                        .toList(),
                                onChange: (selection) {
                                  setState(() {
                                    filters = filters.copyWith(
                                      categories:
                                          selection?.map((e) => e.id).toList(),
                                    );
                                  });
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
