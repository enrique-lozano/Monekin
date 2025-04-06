import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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
              String? path = await FilePicker.platform.getDirectoryPath();

              if (path == null) {
                // TODO: Maybe we should also add a snackbar here
                return;
              }

              if (selectedExportFormat == _ExportFormats.db) {
                await BackupDatabaseService()
                    .exportDatabaseFile(path)
                    .then((value) {
                  messeger.showSnackBar(SnackBar(
                    content: Text(t.backup.export.success(x: path)),
                  ));
                }).catchError((err) {
                  messeger.showSnackBar(SnackBar(
                    content: Text('$err'),
                  ));
                });
              } else {
                await BackupDatabaseService()
                    .exportSpreadsheet(
                        path,
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

              // * -----------------------------------
              // * -----------------------------------
              // * -----------------------------------
              // TODO: --------- ADD FILTERS ---------
              // * -----------------------------------
              // * -----------------------------------
              // * -----------------------------------
            ],
          ),
        ));
  }
}
