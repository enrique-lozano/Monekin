import 'package:flutter/material.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_pillar_meta.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_pillar_sheet.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_reliability_banner.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_score_sheet.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_summary.dart';
import 'package:monekin/app/stats/widgets/stats_cards_layout.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

class FinanceHealthDetails extends StatefulWidget {
  const FinanceHealthDetails({
    super.key,
    required this.filters,
    required this.dateRangeService,
  });

  final TransactionFilterSet filters;
  final DatePeriodState dateRangeService;

  @override
  State<FinanceHealthDetails> createState() => _FinanceHealthDetailsState();
}

class _FinanceHealthDetailsState extends State<FinanceHealthDetails> {
  @override
  Widget build(BuildContext context) {
    final (prevStart, prevEnd) = widget.dateRangeService.getPrevDates();
    final canCompare = prevStart != null && prevEnd != null;

    final currentStream = FinanceHealthService().getHealthyValue(
      filters: widget.filters,
      dateRange: widget.dateRangeService,
    );
    final previousStream = canCompare
        ? FinanceHealthService().getHealthyValue(
            filters: widget.filters.copyWith(
              minDate: prevStart,
              maxDate: prevEnd,
            ),
            dateRange: widget.dateRangeService.copyWith(
              periodModifier: widget.dateRangeService.periodModifier - 1,
            ),
          )
        : Stream<FinanceHealthData?>.value(null);

    return StreamBuilder(
      stream: Rx.combineLatest2(
        currentStream,
        previousStream,
        (FinanceHealthData current, FinanceHealthData? previous) =>
            (current, previous),
      ),
      builder: (context, snapshot) {
        final data = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FinanceHealthReliabilityBanner(
              text: data == null ? null : _reliabilityWarning(context, data.$1),
            ),
            if (data == null)
              const LinearProgressIndicator()
            else
              _cards(context, current: data.$1, previous: data.$2),
          ],
        );
      },
    );
  }

  Widget _cards(
    BuildContext context, {
    required FinanceHealthData current,
    required FinanceHealthData? previous,
  }) {
    final t = Translations.of(context);

    final pillars = buildFinanceHealthPillars(
      context,
      data: current,
      previous: previous,
    );

    return StatsCardsLayout(
      cards: [
        CardWithHeader(
          title: t.stats.finance_health_resume,
          bodyPadding: const EdgeInsets.all(16),
          body: FinanceHealthSummary(current: current, previous: previous),
          footer: CardFooterWithSingleButton(
            text: t.financial_health.how_calculated.action,
            icon: const Icon(Icons.info_outline_rounded, size: 18),
            onButtonClick: () => showFinanceHealthScoreSheet(
              context,
              current: current,
              previous: previous,
              pillars: pillars,
            ),
          ),
        ),
        CardWithHeader(
          title: t.stats.finance_health_breakdown,
          body: Column(
            children: [
              for (var i = 0; i < pillars.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    color: Theme.of(
                      context,
                    ).colorScheme.outlineVariant.withOpacity(0.35),
                  ),
                _FinanceHealthPillarRow(pillar: pillars[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// The most relevant reason why the score of this range should not be read at
  /// face value, or null when there is nothing to warn about. A short range is
  /// the first suspect: widening it often unlocks indicators too
  String? _reliabilityWarning(BuildContext context, FinanceHealthData data) {
    final t = Translations.of(context);

    final minDate = widget.filters.minDate;
    final maxDate = widget.filters.maxDate ?? DateTime.now();

    if (minDate != null &&
        maxDate.difference(minDate).inDays < _minReliableRangeInDays) {
      return t.financial_health.short_range;
    }

    if (data.healthyScore != null && data.hasLowReliability) {
      return t.financial_health.low_reliability(
        measurable: data.measurableScoresCount.toString(),
        total: data.allScores.length.toString(),
      );
    }

    return null;
  }
}

/// Shorter ranges leave out whole paydays and bills, which distorts the
/// indicators that average money in and out.
const _minReliableRangeInDays = 32;

class _FinanceHealthPillarRow extends StatelessWidget {
  const _FinanceHealthPillarRow({required this.pillar});

  final FinanceHealthPillarMeta pillar;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final attrScore = pillar.attrScore;
    final isPaused = pillar.isPaused;
    final hintColor = AppColors.of(context).textHint;
    final color = isPaused
        ? hintColor
        : FinanceHealthData.getHealthyValueColor(attrScore.score);

    return Tappable(
      bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
      onTap: () => showFinanceHealthPillarSheet(context, pillar: pillar),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(pillar.icon, color: color, size: 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    pillar.title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isPaused ? hintColor : null,
                    ),
                  ),
                ),
                Text(
                  isPaused ? t.financial_health.paused_short : pillar.valueText,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isPaused ? hintColor : null,
                  ),
                ),
                Icon(Icons.chevron_right_rounded, size: 18, color: hintColor),
              ],
            ),
            const SizedBox(height: 8),
            if (isPaused)
              Text(
                pillar.unlockText,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: hintColor),
              )
            else
              AnimatedProgressBar(
                value: (attrScore.score ?? 0) / 100,
                color: color,
                width: 6,
                radius: 12,
              ),
          ],
        ),
      ),
    );
  }
}
