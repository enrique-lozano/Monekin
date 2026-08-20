import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/finance_health_gauge.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Score, review and trend against the previous period, as shown on top of the
/// financial-health tab.
class FinanceHealthSummary extends StatelessWidget {
  const FinanceHealthSummary({
    super.key,
    required this.current,
    required this.previous,
  });

  final FinanceHealthData current;

  /// The same data for the previous period, or null when there is none to
  /// compare against (e.g. "all time" is selected).
  final FinanceHealthData? previous;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final score = current.healthyScore;
    final previousScore = previous?.healthyScore;
    final color = current.getHealthyScoreColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FinanceHealthGauge(score: score, color: color),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FinanceHealthScoreBadge(
                    text: current.getHealthyScoreReviewTitle(context),
                    color: color,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    current.getHealthyScoreReviewDescr(context),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (score != null && previousScore != null) ...[
          const SizedBox(height: 16),
          TrendingValue(
            value: score - previousScore,
            dataTypes: const [TrendingValueDataType.value],
            showValueDecimals: false,
            style: TrendingValueStyle.chip,
            afterText: t.stats.compared_to_previous_period,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ],
      ],
    );
  }
}
