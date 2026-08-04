import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Shared visual building blocks for lists of items with a monetary value.
class ValuedItemSummaryCard extends StatelessWidget {
  const ValuedItemSummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.backgroundIcon,
  });

  final String label;
  final Widget value;
  final IconData icon;
  final IconData backgroundIcon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primaryContainer, scheme.tertiaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -28,
            child: Icon(
              backgroundIcon,
              size: 132,
              color: scheme.onPrimaryContainer.withAlpha(18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: scheme.surface.withAlpha(190),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: scheme.primary, size: 25),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: scheme.onPrimaryContainer.withAlpha(190),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      value,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ValuedItemListToolbar extends StatelessWidget {
  const ValuedItemListToolbar({
    super.key,
    required this.searchQuery,
    required this.searchHint,
    required this.onSearchChanged,
    required this.sortActionItems,
    required this.displayActionItems,
  });

  final String searchQuery;
  final String searchHint;
  final ValueChanged<String> onSearchChanged;
  final List<ListTileActionItem> sortActionItems;
  final List<ListTileActionItem> displayActionItems;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: SearchBar(
            elevation: const WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(
              scheme.surfaceContainerHigh,
            ),
            side: WidgetStatePropertyAll(
              BorderSide(color: scheme.outlineVariant),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            leading: const Icon(Icons.search_rounded),
            onChanged: onSearchChanged,
            hintText: searchHint,
            trailing: [
              AnimatedExpanded(
                expand: searchQuery.isNotEmpty,
                axis: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => onSearchChanged(''),
                  ),
                ),
              ),
            ],
          ),
        ),
        _ToolbarMenuButton(
          icon: Icons.sort_rounded,
          tooltip: t.ui_actions.sort,
          actionItems: sortActionItems,
        ),
        _ToolbarMenuButton(
          icon: Icons.more_vert_rounded,
          tooltip: t.ui_actions.display_options,
          actionItems: displayActionItems,
        ),
      ],
    );
  }
}

class _ToolbarMenuButton extends StatelessWidget {
  const _ToolbarMenuButton({
    required this.icon,
    required this.tooltip,
    required this.actionItems,
  });

  final IconData icon;
  final String tooltip;
  final List<ListTileActionItem> actionItems;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: MonekinPopupMenuButton(
        icon: Icon(icon),
        tooltip: tooltip,
        actionItems: actionItems,
      ),
    );
  }
}

class ValuedItemListTile extends StatelessWidget {
  const ValuedItemListTile({
    super.key,
    required this.accentColor,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  final Color accentColor;
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(18);

    return Tappable(
      onTap: onTap,
      borderRadius: radius,
      bgColor: scheme.surfaceContainerLow,
      child: ClipRRect(
        borderRadius: radius,
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border.all(color: scheme.outlineVariant.withAlpha(150)),
            borderRadius: radius,
          ),
          child: Row(
            children: [
              ColoredBox(
                color: accentColor,
                child: const SizedBox(width: 5, height: 76),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(14, 4, 10, 4),
                  leading: leading,
                  title: title,
                  subtitle: subtitle,
                  trailing: trailing,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValuedItemSectionHeader extends StatelessWidget {
  const ValuedItemSectionHeader({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.count,
  });

  final String label;
  final IconData icon;
  final Color color;
  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 6, 4, 10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withAlpha(28),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              count.toString(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
