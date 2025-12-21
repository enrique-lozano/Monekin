import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/app_colors.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    required this.width,
    required this.height,
    this.applyMarging = true,
    this.color,
  });

  final double width, height;
  final bool applyMarging;

  /// The base color of this skeleton
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: height,
              width: min(width * 0.9, constraints.maxWidth),
              margin: applyMarging
                  ? const EdgeInsets.symmetric(vertical: 2, horizontal: 0)
                  : null,
              decoration: BoxDecoration(
                color:
                    color ??
                    AppColors.of(context).shadowColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
      ],
    );
  }
}
