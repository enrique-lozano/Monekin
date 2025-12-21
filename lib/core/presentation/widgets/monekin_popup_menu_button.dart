import 'package:flutter/material.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';

class MonekinPopupMenuButton extends StatelessWidget {
  const MonekinPopupMenuButton({
    super.key,
    required this.actionItems,
    this.icon,
    this.tooltip,
  });

  final List<ListTileActionItem> actionItems;

  final Widget? icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: icon,
      tooltip: tooltip,
      itemBuilder: (context) {
        return List.generate(actionItems.length, (index) {
          final actionItem = actionItems[index];

          return PopupMenuItem(
            value: index,
            padding: EdgeInsets.zero,
            enabled: actionItem.onClick != null,
            child: Builder(
              builder: (context) {
                final tileIcon = actionItem.icon == null
                    ? null
                    : Icon(
                        actionItem.icon,
                        color: actionItem.role != null
                            ? actionItem.getColorBasedOnRole(context)
                            : null,
                      );

                if (actionItem.role == ListTileActionRole.checkbox) {
                  return CheckboxListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    value: actionItem.selected,
                    title: Text(actionItem.label),
                    secondary: tileIcon,
                    onChanged: (boolValue) async {
                      if (actionItems[index].onClick != null) {
                        actionItems[index].onClick!();
                      }

                      Navigator.pop(context);
                    },
                  );
                }

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  selected: actionItem.selected,
                  leading: tileIcon,
                  minLeadingWidth: 26,
                  title: Text(
                    actionItem.label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: actionItem.role != null
                          ? actionItem
                                .getColorBasedOnRole(context)
                                .withOpacity(
                                  actionItem.onClick != null ? 1 : 0.6,
                                )
                          : null,
                    ),
                  ),
                );
              },
            ),
          );
        });
      },
      onSelected: (int value) {
        if (actionItems[value].onClick != null) {
          actionItems[value].onClick!();
        }
      },
    );
  }
}
