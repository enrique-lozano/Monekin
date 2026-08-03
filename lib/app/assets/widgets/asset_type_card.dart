import 'package:flutter/material.dart';
import 'package:monekin/core/models/asset/asset_type.enum.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';

/// A selectable card representing an [AssetType], with its icon, color, name and
/// description. Used in the first step of the asset creation flow.
class AssetTypeCard extends StatelessWidget {
  const AssetTypeCard({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final AssetType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = type.color();
    final scheme = Theme.of(context).colorScheme;

    return Tappable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? color.withAlpha(28) : Colors.transparent,
          border: Border.all(
            color: selected ? color : scheme.outlineVariant,
            width: selected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withAlpha(38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(type.icon(), color: color, size: 22),
                ),
                const Spacer(),
                if (selected)
                  Icon(Icons.check_circle_rounded, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              type.displayName(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                type.description(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
