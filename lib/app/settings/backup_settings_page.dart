import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/core/utils/number_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

@RoutePage()
class BackupSettingsPage extends StatelessWidget {
  const BackupSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.data.display)),
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
                confirmDialog(context,
                    icon: Icons.warning_rounded,
                    dialogTitle: t.backup.import.restore_backup_warn_title,
                    contentParagraphs: [
                      Text(t.backup.import.restore_backup_warn_description)
                    ]).then((value) {
                  if (value == null || !value) {
                    return;
                  }

                  BackupDatabaseService().importDatabase().then((value) {
                    if (!value) {
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(t.backup.import.cancelled)),
                      );

                      return;
                    }

                    context.router.replaceAll([const MainLayoutRoute()]);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(t.backup.import.success)),
                    );
                  }).catchError((err) {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(err.toString())));
                  });
                });
              },
            ),
            ListTile(
              title: Text(t.backup.import.manual_import.title),
              subtitle: Text(t.backup.import.manual_import.descr),
              minVerticalPadding: 16,
              onTap: () {
                context.pushRoute(const ImportCSVRoute());
              },
            ),
            createListSeparator(context, t.backup.export.title_short),
            ListTile(
              title: Text(t.backup.export.title),
              subtitle: Text(t.backup.export.description),
              minVerticalPadding: 16,
              onTap: () {
                context.pushRoute(const ExportDataRoute());
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
                      DateFormat.yMMMd()
                          .add_Hm()
                          .format(File(path).lastModifiedSync()),
                    );
                  }),
            ),
            ListTile(
              title: Text(t.backup.about.size),
              trailing: FutureBuilder(
                  future: AppDB.instance.databasePath
                      .then((value) => File(value).stat()),
                  builder: (context, snapshot) {
                    final fileStats = snapshot.data;

                    if (fileStats == null) {
                      return const Text('----');
                    }

                    return Text(fileStats.size.readableFileSize());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
