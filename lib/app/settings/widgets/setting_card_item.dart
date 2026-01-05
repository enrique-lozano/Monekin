import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';

class SettingCardItem extends StatelessWidget {
  const SettingCardItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.mainAxis = Axis.vertical,
    this.isPrimary = false,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Function() onTap;
  final Axis mainAxis;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      bgColor: isPrimary
          ? isAppInLightBrightness(context)
                ? Theme.of(context).colorScheme.primary.lighten(0.8)
                : Theme.of(context).colorScheme.primary.darken(0.8)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: 2,
          color: isPrimary
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).dividerColor,
        ),
      ),
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: mainAxis == Axis.horizontal ? 12 : 12,
          horizontal: mainAxis == Axis.horizontal ? 16 : 16,
        ),
        child: Flex(
          direction: mainAxis,
          spacing: mainAxis == Axis.horizontal ? 12 : 8,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isPrimary ? Theme.of(context).colorScheme.primary : null,
              size: mainAxis == Axis.horizontal ? 24 : 28,
              // color: Theme.of(context).colorScheme.primary,
            ),
            Builder(
              builder: (context) {
                final toReturn = Column(
                  crossAxisAlignment: mainAxis == Axis.vertical
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      textAlign: mainAxis == Axis.vertical
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: mainAxis == Axis.vertical
                            ? TextAlign.center
                            : TextAlign.start,
                      ),
                  ],
                );

                return mainAxis == Axis.vertical
                    ? toReturn
                    : Expanded(child: toReturn);
              },
            ),
          ],
        ),
      ),
    );
  }
}
