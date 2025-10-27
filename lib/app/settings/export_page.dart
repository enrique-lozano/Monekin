import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/settings/widgets/settings_list_separator.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/styles/big_button_style.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/filter_sheet_modal.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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

  bool _isDownloading = false;
  bool _isSharing = false;

  void _showErrorSnackBar(String error) {
    MonekinSnackbar.error(SnackbarParams.fromError(error));
  }

  Future<File> _generateExportFile(String directoryPath) async {
    if (selectedExportFormat == _ExportFormats.db) {
      final dbFile = await BackupDatabaseService().exportDatabaseFile(
        directoryPath,
      );

      return dbFile;
    } else {
      final transactions = await TransactionService.instance
          .getTransactions(filters: filters)
          .first;

      final csvFile = await BackupDatabaseService().exportSpreadsheet(
        directoryPath,
        transactions,
      );

      return csvFile;
    }
  }

  Future<void> _shareFile() async {
    if (_isSharing) return; // Prevent multiple concurrent operations

    setState(() {
      _isSharing = true;
    });

    try {
      final directory = await getTemporaryDirectory();
      final exportedFile = await _generateExportFile(directory.path);

      final xFile = selectedExportFormat == _ExportFormats.csv
          ? XFile(exportedFile.path, mimeType: 'text/csv')
          : XFile(exportedFile.path);

      await SharePlus.instance.share(
        ShareParams(
          title: selectedExportFormat == _ExportFormats.csv
              ? t.backup.export.transactions
              : t.backup.export.all,
          files: [xFile],
        ),
      );

      await File(exportedFile.path)
          .delete()
          .then((v) {
            Logger.printDebug('Temporary file deleted: $exportedFile');
          })
          .catchError((err) {
            Logger.printDebug('Error deleting temporary file: $err');
          });
    } catch (err) {
      _showErrorSnackBar('$err');
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  Future<void> downloadFile() async {
    if (_isDownloading) return; // Prevent multiple concurrent operations

    setState(() {
      _isDownloading = true;
    });

    try {
      String? path;

      try {
        path = await FilePicker.platform.getDirectoryPath();
      } catch (e) {
        // Platform doesn't support directory picker, use documents directory as fallback
        path = (await getApplicationDocumentsDirectory()).path;
      }

      if (path == null) {
        MonekinSnackbar.info(SnackbarParams(t.backup.no_directory_selected));

        return;
      }

      final file = await _generateExportFile(path);

      MonekinSnackbar.success(
        SnackbarParams(t.backup.export.success(x: file.parent.path)),
      );
    } catch (err) {
      _showErrorSnackBar('$err');
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  Widget buttonLoadingIndicator() {
    return const SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final isDownloadingOrSharing = _isDownloading || _isSharing;

    return Scaffold(
      appBar: AppBar(title: Text(t.backup.export.title)),
      persistentFooterButtons: [
        Row(
          children: [
            Flexible(
              child: PersistentFooterButton(
                child: FilledButton.icon(
                  icon: _isDownloading
                      ? buttonLoadingIndicator()
                      : const Icon(Icons.download_rounded),
                  label: Text(t.ui_actions.download),
                  style: getBigButtonStyle(context),
                  onPressed: isDownloadingOrSharing
                      ? null
                      : () => downloadFile(),
                ),
              ),
            ),

            Flexible(
              child: PersistentFooterButton(
                child: FilledButton.icon(
                  icon: _isSharing
                      ? buttonLoadingIndicator()
                      : const Icon(Icons.share_rounded),
                  label: Text(t.backup.export.send_file),
                  style: getBigButtonStyle(context),
                  onPressed: isDownloadingOrSharing ? null : _shareFile,
                ),
              ),
            ),
          ],
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 12, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListSeparator(context, t.backup.export.type_of_export),
            RadioGroup(
              onChanged: (v) {
                if (v == null) return;

                selectedExportFormat = v;

                if (selectedExportFormat == _ExportFormats.db) {
                  filters = const TransactionFilters();
                }

                setState(() {});
              },
              groupValue: selectedExportFormat,
              child: Column(
                children: [
                  RadioListTile(
                    value: _ExportFormats.db,
                    secondary: const Icon(Icons.security),
                    title: Text(t.backup.export.all),
                    subtitle: Text(t.backup.export.all_descr),
                  ),
                  RadioListTile(
                    value: _ExportFormats.csv,
                    secondary: const Icon(Icons.format_quote_rounded),
                    title: Text(t.backup.export.transactions),
                    subtitle: Text(t.backup.export.transactions_descr),
                  ),
                ],
              ),
            ),

            AnimatedExpanded(
              expand: selectedExportFormat == _ExportFormats.csv,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  createListSeparator(context, t.backup.export.other_options),
                  ListTile(
                    leading: Builder(
                      builder: (context) {
                        final icon = const Icon(Icons.filter_alt_outlined);

                        if (!filters.hasFilter) {
                          return icon;
                        }

                        return Badge(child: icon);
                      },
                    ),
                    title: Text(t.home.filter_transactions),
                    subtitle: StreamBuilder(
                      stream: TransactionService.instance.countTransactions(
                        predicate: filters,
                      ),
                      builder: (context, asyncSnapshot) {
                        return Text(
                          !filters.hasFilter
                              ? t.transaction.list.all
                              : t.backup.export.transactions_to_export(
                                  n: asyncSnapshot.data?.numberOfRes ?? 0,
                                ),
                        );
                      },
                    ),
                    onTap: () {
                      openFilterSheetModal(
                        context,
                        FilterSheetModal(preselectedFilter: filters),
                      ).then((newFilters) {
                        if (newFilters != null) {
                          setState(() {
                            filters = newFilters;
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
