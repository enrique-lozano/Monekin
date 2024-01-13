import 'package:flutter/material.dart';

import '../presentation/app_colors.dart';

enum ListTileActionRole { delete, warn }

class ListTileActionItem {
  final String label;
  final IconData icon;

  final ListTileActionRole? role;

  final void Function()? onClick;

  ListTileActionItem({
    required this.label,
    required this.icon,
    required this.onClick,
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

    return AppColors.of(context).primary;
  }
}
