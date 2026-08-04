import 'package:flutter/material.dart';
import 'package:monekin/app/securities/widgets/security_form_sheet.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/taxonomy/taxonomy_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Shows a security's current classification (asset class, region, sector,
/// risk) as chips grouped by taxonomy, with an action to edit them.
class SecurityClassificationCard extends StatelessWidget {
  const SecurityClassificationCard({super.key, required this.security});

  final SecurityInDB security;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return CardWithHeader(
      title: t.assets.securities.classification.title,
      headerAction: CardHeaderAction(
        text: t.ui_actions.edit,
        icon: const Icon(Icons.edit_rounded, size: 15),
        onTap: () => showSecurityFormSheet(
          context,
          securityToEdit: security,
          openClassification: true,
        ),
      ),
      body: StreamBuilder<List<SecurityClassification>>(
        stream: TaxonomyService.instance.getSecurityClassification(security.id),
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <SecurityClassification>[];

          if (items.isEmpty) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                t.assets.securities.classification.empty,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }

          // Group assignments by taxonomy, preserving the query's order.
          final grouped = <String, List<SecurityClassification>>{};
          final taxonomyById = <String, TaxonomyInDB>{};
          for (final item in items) {
            taxonomyById[item.taxonomy.id] = item.taxonomy;
            grouped.putIfAbsent(item.taxonomy.id, () => []).add(item);
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final entry in grouped.entries) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 6),
                    child: Text(
                      taxonomyById[entry.key]!.name,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final item in entry.value) _CategoryChip(item: item),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.item});

  final SecurityClassification item;

  @override
  Widget build(BuildContext context) {
    final color = ColorHex.get(item.category.color);
    final weightPercent = item.assignment.weight / 100;
    final showWeight = item.assignment.weight < 10000;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            item.category.name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (showWeight) ...[
            const SizedBox(width: 6),
            Text(
              '${weightPercent.toStringAsFixed(weightPercent == weightPercent.roundToDouble() ? 0 : 1)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
