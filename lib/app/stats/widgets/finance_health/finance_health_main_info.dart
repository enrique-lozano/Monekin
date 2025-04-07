import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/services/finance_health_service.dart';

class FinanceHealthMainInfo extends StatelessWidget {
  const FinanceHealthMainInfo({super.key, required this.financeHealthData});

  final FinanceHealthData financeHealthData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: financeHealthData.healthyScoreString(),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: FinanceHealthData.getHealthyValueColor(
                        financeHealthData.healthyScore),
                  ),
            ),
            TextSpan(
              text: ' / 100',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ]),
        ),
        AnimatedProgressBar(
          value: (financeHealthData.healthyScore ?? 20) / 100,
          direction: Axis.horizontal,
          radius: 24,
          width: 4,
          color: FinanceHealthData.getHealthyValueColor(
              financeHealthData.healthyScore),
        ),
        const SizedBox(height: 4),
        Text(
          financeHealthData.getHealthyScoreReviewTitle(context),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: FinanceHealthData.getHealthyValueColor(
                    financeHealthData.healthyScore),
              ),
        ),
        const SizedBox(height: 12),
        Text(
          financeHealthData.getHealthyScoreReviewDescr(context),
          style: Theme.of(context).textTheme.bodySmall!,
        ),
        const SizedBox(height: 2),
        // Row(
        //   children: [
        //     Icon(
        //       Icons.chair_rounded,
        //       size: 12,
        //     ),
        //     const SizedBox(width: 4),
        //     Text(
        //       "High confidence",
        //       style: Theme.of(context)
        //           .textTheme
        //           .labelMedium!
        //           .copyWith(fontWeight: FontWeight.w300, fontSize: 13.2),
        //     )
        //   ],
        // )
      ],
    );
  }
}
