import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';

class ListTileField extends StatelessWidget {
  const ListTileField({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String subtitle;

  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      bgColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(inputBorderRadius),
      ),
      onTap: onTap,
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        minVerticalPadding: 8,
        title: Text(title),
        subtitle: Text(
          subtitle,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        leading: leading,
        trailing: trailing,
      ),
    );
  }
}
