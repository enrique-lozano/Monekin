import 'package:flutter/material.dart';

import '../app_colors.dart';

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

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.of(context).background,
        border: Border.all(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).shadowColorLight,
            blurRadius: 12,
            offset: const Offset(0, 0),
            spreadRadius: 4,
          ),
        ],
      ),
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.fromLTRB(
                16,
                onHeaderButtonClick != null ? 2 : iconSize - 6,
                2,
                onHeaderButtonClick != null ? 2 : iconSize - 6),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: AppColors.of(context).light,
            ),
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
                    color: AppColors.of(context).primary,
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
