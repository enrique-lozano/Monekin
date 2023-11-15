import 'package:flutter/material.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';

class MonekinPopupMenuButton extends StatelessWidget {
  const MonekinPopupMenuButton({super.key, required this.actionItems});

  final List<ListTileActionItem> actionItems;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return List.generate(actionItems.length, (index) {
          final actionItem = actionItems[index];

          return PopupMenuItem(
              value: index,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  actionItem.icon,
                  color: actionItem.role != null
                      ? actionItem.getColorBasedOnRole(context)
                      : null,
                ),
                minLeadingWidth: 26,
                title: Text(actionItem.label,
                    style: TextStyle(
                      color: actionItem.role != null
                          ? actionItem.getColorBasedOnRole(context)
                          : null,
                    )),
              ));
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
