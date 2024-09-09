import 'package:flutter/material.dart';
import 'package:parsa/core/presentation/app_colors.dart';

class CountIndicatorWithExpandArrow extends StatelessWidget {
  const CountIndicatorWithExpandArrow({
    super.key,
    required this.countToDisplay,
  });

  final int? countToDisplay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (countToDisplay != null && countToDisplay! > 0) ...[
          CountIndicator(countToDisplay!),
          const SizedBox(width: 8)
        ],
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
        )
      ],
    );
  }
}

class CountIndicator extends StatelessWidget {
  const CountIndicator(
    this.countToDisplay, {
    super.key,
    this.fontWeight = FontWeight.w700,
  });

  final int countToDisplay;

  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.of(context).primary,
      ),
      child: Text(
        countToDisplay.toString(),
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontWeight: fontWeight,
              color: AppColors.of(context).onPrimary,
            ),
      ),
    );
  }
}
