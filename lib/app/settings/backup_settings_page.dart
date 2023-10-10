import 'package:flutter/material.dart';
import 'package:monekin/app/home/home.page.dart';
import 'package:monekin/app/settings/export_page.dart';
import 'package:monekin/app/settings/import_csv.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/i18n/translations.g.dart';

class BackupSettings extends StatelessWidget {
  const BackupSettings({super.key});

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
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(t.general.attention),
                    content: Text(t.backup.import.restore_backup_warn),
                    actions: [
                      TextButton(
                          onPressed: () {
                            BackupDatabaseService()
                                .importDatabase()
                                .then((value) {
                              if (!value) {
                                Navigator.pop(context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(t.backup.import.cancelled)),
                                );

                                return;
                              }

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(t.backup.import.success)),
                              );
                            }).catchError((err) {
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(err.toString())));
                            });
                          },
                          child: Text(t.general.confirm))
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Text(t.backup.import.manual_import.title),
              subtitle: Text(t.backup.import.manual_import.descr),
              minVerticalPadding: 16,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImportCSVPage()));
              },
            ),
            createListSeparator(context, t.backup.export.title_sort),
            ListTile(
              title: Text(t.backup.export.title),
              subtitle: Text(t.backup.export.description),
              minVerticalPadding: 16,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExportDataPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
