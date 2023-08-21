import 'package:flutter/material.dart';
import 'package:monekin/app/home/home.page.dart';
import 'package:monekin/app/settings/import_csv.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/i18n/translations.g.dart';

class ImportPage extends StatelessWidget {
  const ImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.backup.import.title)),
      body: Column(
        children: [
          ListTile(
            title: Text(t.backup.import.restore_backup),
            subtitle: Text(t.backup.import.restore_backup_descr),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
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
                              SnackBar(content: Text(t.backup.import.success)),
                            );
                          }).catchError((err) {
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
          const Divider(),
          ListTile(
            title: Text(t.backup.import.manual_import.title),
            subtitle: Text(t.backup.import.manual_import.descr),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
            minVerticalPadding: 16,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImportCSVPage()));
            },
          ),
        ],
      ),
    );
  }
}
