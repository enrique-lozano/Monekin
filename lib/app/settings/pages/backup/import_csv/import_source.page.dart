import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/pages/backup/import_csv/import_csv.page.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/csv_import/csv_import_templates.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// First step of the CSV import: the user chooses the app (or kind of file)
/// the data comes from, so the columns can be mapped automatically.
class ImportSourcePage extends StatelessWidget {
  const ImportSourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final apps = CsvImportTemplates.all
        .where((e) => e != CsvImportTemplates.spreadsheet)
        .toList();

    return PageFramework(
      title: t.backup.import.manual_import.title,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(
            t.backup.import.source.title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            t.backup.import.source.descr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          _SectionLabel(t.backup.import.source.apps),
          for (final template in apps) _SourceTile(template: template),
          const SizedBox(height: 12),
          _SectionLabel(t.backup.import.source.other),
          _SourceTile(template: CsvImportTemplates.spreadsheet),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({required this.template});

  final CsvImportTemplate template;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withOpacity(0.4),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => RouteUtils.pushRoute(ImportCSVPage(template: template)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                IconDisplayer(
                  mainColor: template.color,
                  icon: template.icon,
                  size: 26,
                  padding: 12,
                  borderRadius: 16,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        template.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        template.exportHint(t),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
