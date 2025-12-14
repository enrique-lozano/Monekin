import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/settings/export_page.dart';
import 'package:monekin/app/settings/import_csv.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/core/extensions/numbers.extensions.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:monekin/page_framework.dart';

import 'widgets/settings_list_separator.dart';

class BackupSettingsPage extends StatefulWidget {
  const BackupSettingsPage({super.key});

  @override
  State<BackupSettingsPage> createState() => _BackupSettingsPageState();
}

class _BackupSettingsPageState extends State<BackupSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.more.data.display,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListSeparator(context, t.backup.import.title),
            ListTile(
              title: Text(t.backup.import.restore_backup),
              subtitle: Text(t.backup.import.restore_backup_descr),
              minVerticalPadding: 16,
              onTap: () {
                confirmDialog(
                  context,
                  icon: Icons.warning_rounded,
                  dialogTitle: t.backup.import.restore_backup_warn_title,
                  contentParagraphs: [
                    Text(t.backup.import.restore_backup_warn_description),
                  ],
                ).then((value) {
                  if (value == null || !value) {
                    return;
                  }

                  BackupDatabaseService()
                      .importDatabase()
                      .then((value) {
                        if (!value) {
                          RouteUtils.popRoute();

                          MonekinSnackbar.info(
                            SnackbarParams(t.backup.no_file_selected),
                          );

                          return;
                        }

                        RouteUtils.popAllRoutesExceptFirst();

                        tabsPageKey.currentState!.changePage(
                          AppMenuDestinationsID.dashboard,
                        );

                        MonekinSnackbar.success(
                          SnackbarParams(t.backup.import.success),
                        );
                      })
                      .catchError((err) {
                        RouteUtils.popRoute();

                        MonekinSnackbar.error(SnackbarParams.fromError(err));
                      });
                });
              },
            ),
            ListTile(
              title: Text(t.backup.import.manual_import.title),
              subtitle: Text(t.backup.import.manual_import.descr),
              minVerticalPadding: 16,
              onTap: () {
                RouteUtils.pushRoute(context, const ImportCSVPage());
              },
            ),
            createListSeparator(context, t.backup.export.title_short),
            ListTile(
              title: Text(t.backup.export.title),
              subtitle: Text(t.backup.export.description),
              minVerticalPadding: 16,
              onTap: () {
                RouteUtils.pushRoute(context, const ExportDataPage());
              },
            ),
            createListSeparator(context, t.backup.about.title),
            ListTile(
              title: Text(t.backup.about.modify_date),
              trailing: FutureBuilder(
                future: AppDB.instance.databasePath,
                builder: (context, snapshot) {
                  final path = snapshot.data;

                  if (path == null || path.isEmpty) {
                    return const Text('----');
                  }

                  return Text(
                    DateFormat.yMMMd().add_Hm().format(
                      File(path).lastModifiedSync(),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: Text(t.backup.about.size),
              trailing: FutureBuilder(
                future: AppDB.instance.databasePath.then(
                  (value) => File(value).stat(),
                ),
                builder: (context, snapshot) {
                  final fileStats = snapshot.data;

                  if (fileStats == null) {
                    return const Text('----');
                  }

                  return Text(fileStats.size.readableFileSize());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
