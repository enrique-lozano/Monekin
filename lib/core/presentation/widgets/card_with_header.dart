import 'package:flutter/material.dart';

import '../app_colors.dart';

/// The radius of the `CardWithHeader` widget, a very useful widget through the app
const cardWithHeaderRadius = 12.0;

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
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.circular(cardWithHeaderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).shadowColorLight,
            blurRadius: cardWithHeaderRadius,
            offset: const Offset(0, 0),
            spreadRadius: 4,
          ),
        ],
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardWithHeaderRadius),
        border: Border.all(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
      ),
      margin: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Material(
            type: MaterialType.transparency,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: bodyPadding,
              child: body,
            ),
          )
        ],
      ),
    );
  }
}
