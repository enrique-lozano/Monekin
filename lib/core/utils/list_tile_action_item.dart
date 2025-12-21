import 'package:flutter/material.dart';

import '../presentation/app_colors.dart';

enum ListTileActionRole { delete, warn, checkbox }

class ListTileActionItem {
  final String label;
  final IconData? icon;

  final ListTileActionRole? role;

  final bool selected;

  final void Function()? onClick;

  ListTileActionItem({
    required this.label,
    required this.onClick,
    this.icon,
    this.selected = false,
    this.role,
  });

  Color getColorBasedOnRole(BuildContext context) {
    if (role != null) {
      if (role == ListTileActionRole.delete) {
        return AppColors.of(context).danger;
      } else if (role == ListTileActionRole.warn) {
        return Colors.amber.shade400;
      }
    }

    return Theme.of(context).colorScheme.onSurface;
  }
}
