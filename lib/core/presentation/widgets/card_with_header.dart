import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// The radius of the `CardWithHeader` widget, a very useful widget through the app
const cardWithHeaderRadius = 12.0;

class CardWithHeader extends StatelessWidget {
  const CardWithHeader({
    super.key,
    required this.title,
    this.subtitle,
    required this.body,
    this.bodyPadding = const EdgeInsets.all(0),
    this.footer,
    this.titleBuilder,
  });

  final Widget body;
  final Widget? footer;

  final String title;
  final Widget Function(String title)? titleBuilder;
  final String? subtitle;

  final EdgeInsets bodyPadding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: boxShadowGeneral(context)),
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(0),
        elevation: 0,
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.fromLTRB(16, 12, 2, 4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                // color: AppColors.of(context).light,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(fontSize: 18),
                        child: titleBuilder != null
                            ? titleBuilder!(title)
                            : Text(title),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Material(
              type: MaterialType.transparency,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(padding: bodyPadding, child: body),
            ),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}

/// A card footer with a single button, used in the `CardWithHeader` widget.
/// By default, the button has a "see more" text and icon, but both can be customized.
class CardFooterWithSingleButton extends StatelessWidget {
  const CardFooterWithSingleButton({
    super.key,
    this.text,
    this.onButtonClick,
    this.icon,
  });

  final String? text;
  final Widget? icon;
  final VoidCallback? onButtonClick;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    const double indent = 16;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, 1),
          child: Divider(
            thickness: 2,
            indent: indent,
            endIndent: indent,
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: indent,
              vertical: 8,
            ),
            shape: RoundedRectangleBorder(),
          ),
          onPressed: onButtonClick,
          icon:
              icon ??
              Transform.rotate(
                angle: -180 * 3.14 / 180,
                child: const Icon(Icons.menu_open),
              ),
          label: Text(text ?? t.ui_actions.see_more),
        ),
      ],
    );
  }
}
