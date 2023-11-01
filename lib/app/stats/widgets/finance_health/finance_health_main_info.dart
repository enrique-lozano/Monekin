import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/services/finance_health_service.dart';

class FinanceHealthMainInfo extends StatelessWidget {
  const FinanceHealthMainInfo({super.key, required this.financeHealthData});

  final FinanceHealthData financeHealthData;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight:
              BreakPoint.of(context).isLargerThan(BreakpointID.md) ? 265 : 180),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedProgressBar(
            value: (financeHealthData.healthyScore ?? 20) / 100,
            direction: Axis.vertical,
            width: 16,
            color: FinanceHealthData.getHealthyValueColor(
                financeHealthData.healthyScore),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: financeHealthData.healthyScoreString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: FinanceHealthData.getHealthyValueColor(
                                    financeHealthData.healthyScore),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const TextSpan(text: ' / 100'),
                      ]),
                    ),
                    Text(
                      financeHealthData.getHealthyScoreReviewTitle(context),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: FinanceHealthData.getHealthyValueColor(
                                financeHealthData.healthyScore),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                Text(
                  financeHealthData.getHealthyScoreReviewDescr(context),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
