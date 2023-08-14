import 'package:flutter/material.dart';

class CardWithHeader extends StatelessWidget {
  const CardWithHeader(
      {super.key,
      required this.title,
      required this.body,
      this.onHeaderButtonClick,
      this.headerButtonIcon = Icons.arrow_forward_ios_rounded});

  final Widget body;

  final String title;

  final IconData headerButtonIcon;

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
          Padding(
            padding: EdgeInsets.fromLTRB(
                16,
                onHeaderButtonClick != null ? 2 : iconSize,
                2,
                onHeaderButtonClick != null ? 2 : iconSize),
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
                    color: Theme.of(context).primaryColor,
                    icon: Icon(headerButtonIcon),
                  )
              ],
            ),
          ),
          const Divider(),
          body
        ],
      ),
    );
  }
}
