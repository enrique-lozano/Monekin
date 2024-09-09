import 'package:flutter/material.dart';
import 'package:parsa/core/extensions/color.extensions.dart';
import 'package:parsa/core/presentation/app_colors.dart';
import 'package:parsa/core/presentation/theme.dart';
import 'package:parsa/core/presentation/widgets/tappable.dart';

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
              ? AppColors.of(context).primary.lighten(0.8)
              : AppColors.of(context).primary.darken(0.8)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: 2,
          color: isPrimary
              ? AppColors.of(context).primary
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
          //mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isPrimary ? AppColors.of(context).primary : null,
              size: mainAxis == Axis.horizontal ? 24 : 28,
              // color: AppColors.of(context).primary,
            ),
            if (mainAxis == Axis.horizontal) const SizedBox(width: 12),
            if (mainAxis == Axis.vertical) const SizedBox(height: 8),
            Builder(builder: (context) {
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
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: mainAxis == Axis.vertical
                          ? TextAlign.center
                          : TextAlign.start,
                    )
                ],
              );

              return mainAxis == Axis.vertical
                  ? toReturn
                  : Expanded(child: toReturn);
            })
          ],
        ),
      ),
    );
  }
}
