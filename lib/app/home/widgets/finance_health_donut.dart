import 'package:flutter/material.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/finance_health_gauge.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Dashboard card with the financial-health score of the selected range.
class FinanceHealthCard extends StatelessWidget {
  const FinanceHealthCard({super.key, required this.dateRangeService});

  final DatePeriodState dateRangeService;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return CardWithHeader(
      title: t.financial_health.display,
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      headerAction: CardHeaderAction(
        onTap: () => RouteUtils.pushRoute(
          StatsPage(
            dateRangeService: dateRangeService,
            initialIndex: StatsTab.financialHealth,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FinanceHealthService().getHealthyValue(
          filters: TransactionFilterSet(
            minDate: dateRangeService.startDate,
            maxDate: dateRangeService.endDate,
          ),
          dateRange: dateRangeService,
        ),
        builder: (context, snapshot) {
          final data = snapshot.data;
          final score = data?.healthyScore;
          final color =
              data?.getHealthyScoreColor() ??
              FinanceHealthData.getHealthyValueColor(null);

          return Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FinanceHealthGauge(
                  score: score,
                  color: color,
                  loading: data == null,
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data != null) ...[
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            FinanceHealthScoreBadge(
                              text: data.getHealthyScoreReviewTitle(context),
                              color: color,
                            ),
                            // There is no room here for the explanatory banner
                            // of the stats tab, so the caveat travels as a chip
                            if (score != null && data.hasLowReliability)
                              FinanceHealthScoreBadge(
                                text: t.financial_health.unreliable_short,
                                color: AppColors.of(context).textHint,
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          data.getHealthyScoreReviewDescr(context),
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ] else
                        Skeletonizer.zone(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Bone.text(width: 90),
                              const SizedBox(height: 8),
                              Bone.multiText(lines: 3),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
