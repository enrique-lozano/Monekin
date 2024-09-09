import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parsa/core/presentation/widgets/skeleton.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.avatar, this.size = 36, this.border});

  final String? avatar;

  final Border? border;

  final double size;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: colors.primaryContainer,
        border: border,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: colors.primaryContainer),
        child: Builder(builder: (context) {
          if (avatar == null) {
            return const Skeleton(width: 36, height: 36, applyMarging: false);
          }

          return SvgPicture.asset(
            'assets/icons/avatars/$avatar.svg',
            height: size,
            width: size,
          );
        }),
      ),
    );
  }
}
