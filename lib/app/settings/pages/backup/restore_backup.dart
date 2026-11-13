import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Lets the user select a Monekin database file and restores it, showing the
/// feedback of the failure cases. Returns `true` only if the backup was restored.
Future<bool> pickAndRestoreBackup() async {
  try {
    final restored = await BackupDatabaseService().importDatabase();

    if (!restored) {
      MonekinSnackbar.info(SnackbarParams(t.backup.no_file_selected));
    }

    return restored;
  } catch (err) {
    if (err is MigrationFailedException) {
      MonekinSnackbar.error(
        SnackbarParams(
          'Failed to migrate the database to version ${err.targetVersion}',
          message: 'A backup was kept at ${err.backupPath}',
          duration: const Duration(seconds: 8),
          actions: [
            MonekinSnackbarAction(
              label: 'Copy full error',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: err.cause.toString()));
              },
            ),
          ],
        ),
      );
    } else {
      MonekinSnackbar.error(SnackbarParams.fromError(err));
    }

    return false;
  }
}
