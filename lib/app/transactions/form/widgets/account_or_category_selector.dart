import 'package:flutter/material.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class AccountOrCategorySelector extends StatelessWidget {
  const AccountOrCategorySelector({
    super.key,
    required this.title,
    required this.inputValue,
    required this.icon,
    required this.onClick,
  });

  final String title;
  final String? inputValue;
  final Widget icon;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return InkWell(
      onTap: () => onClick(),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    inputValue ?? t.general.unspecified,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
