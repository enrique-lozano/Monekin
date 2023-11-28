import 'package:flutter/material.dart';

class CardWithHeader extends StatelessWidget {
  const CardWithHeader({
    super.key,
    required this.title,
    required this.body,
    this.onHeaderButtonClick,
    this.headerButtonIcon = Icons.arrow_forward_ios_rounded,
    this.bodyPadding = const EdgeInsets.all(0),
  });

  final Widget body;

  final String title;

  final IconData headerButtonIcon;

  final EdgeInsets bodyPadding;

  final void Function()? onHeaderButtonClick;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 16;

    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                16,
                onHeaderButtonClick != null ? 2 : iconSize - 6,
                2,
                onHeaderButtonClick != null ? 2 : iconSize - 6),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                if (onHeaderButtonClick != null)
                  IconButton(
                    onPressed: onHeaderButtonClick,
                    iconSize: iconSize,
                    color: Theme.of(context).colorScheme.primary,
                    icon: Icon(headerButtonIcon),
                  )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: bodyPadding,
            child: body,
          )
        ],
      ),
    );
  }
}
