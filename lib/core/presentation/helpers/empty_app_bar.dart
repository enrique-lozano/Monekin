import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;

  const EmptyAppBar({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(color: color ?? Colors.transparent);
  }

  @override
  Size get preferredSize => const Size(0, 0);
}
