import 'package:flutter/material.dart';

class ListTileField extends StatelessWidget {
  const ListTileField(
      {super.key,
      required this.title,
      required this.subtitle,
      this.leading,
      this.trailing,
      this.onTap});

  final String title;
  final String subtitle;

  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
      leading: leading,
      trailing: trailing,
      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}
