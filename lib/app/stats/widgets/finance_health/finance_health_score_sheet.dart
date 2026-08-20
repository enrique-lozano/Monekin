import 'package:flutter/material.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_pillar_meta.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_sheet_widgets.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Opens a sheet (or a right-side drawer on wide layouts) that explains how
/// the overall financial-health score is calculated.
void showFinanceHealthScoreSheet(
  BuildContext context, {
  required FinanceHealthData current,
  required FinanceHealthData? previous,
  required List<FinanceHealthPillarMeta> pillars,
}) {
  RouteUtils.showResponsiveSheet(
    context: context,
    builder: (context) => FinanceHealthScoreSheet(
      current: current,
      previous: previous,
      pillars: pillars,
    ),
  );
}

class FinanceHealthScoreSheet extends StatelessWidget {
  const FinanceHealthScoreSheet({
    super.key,
    required this.current,
    required this.previous,
    required this.pillars,
  });

  final FinanceHealthData current;
  final FinanceHealthData? previous;
  final List<FinanceHealthPillarMeta> pillars;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final pausedPillars = pillars.where((pillar) => pillar.isPaused).toList();
    final scoreColor = current.getHealthyScoreColor();
    final hintColor = AppColors.of(context).textHint;

    final pendingColor = scoreColor.withOpacity(0.28);
    final pausedColor = hintColor.withOpacity(0.22);

    return ModalContainer(
      title: t.financial_health.how_calculated.action,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CompositionBar(
              earned: current.earnedPoints,
              pending: current.pendingPoints,
              paused: current.pausedWeight.toDouble(),
              earnedColor: scoreColor,
              pendingColor: pendingColor,
              pausedColor: pausedColor,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 18,
              runSpacing: 10,
              children: [
                if (current.measurableWeight > 0) ...[
                  _LegendItem(
                    color: scoreColor,
                    pointsText: FinanceHealthData.pointsString(
                      current.earnedPoints,
                    ),
                    title: t.financial_health.composition.earned,
                    description: t.financial_health.composition.earned_descr,
                  ),
                  _LegendItem(
                    color: pendingColor,
                    pointsText: FinanceHealthData.pointsString(
                      current.pendingPoints,
                    ),
                    title: t.financial_health.composition.pending,
                    description: t.financial_health.composition.pending_descr,
                  ),
                ],
                if (pausedPillars.isNotEmpty)
                  _LegendItem(
                    color: pausedColor,
                    striped: true,
                    pointsText: current.pausedWeight.toString(),
                    title: t.financial_health.composition.paused,
                    description: t.financial_health.composition.paused_descr(
                      indicators: pausedPillars
                          .map((pillar) => pillar.title)
                          .join(', '),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              current.healthyScore == null
                  ? t.financial_health.review.descr.insufficient_data
                  : pausedPillars.isEmpty
                  ? t.financial_health.how_calculated.intro
                  : t.financial_health.composition.score_explanation(
                      score: current.healthyScoreString(),
                      measurable: current.measurableWeight.toString(),
                    ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 16),
            FinanceHealthSectionLabel(t.financial_health.indicators_label),
            const SizedBox(height: 12),
            for (var i = 0; i < pillars.length; i++) ...[
              if (i > 0) const SizedBox(height: 14),
              _ScorePillarRow(
                pillar: pillars[i],
                totalWeight: current.totalWeight,
              ),
            ],
            if (current.measurableWeight > 0)
              _TotalRow(data: current, color: scoreColor),
            if (previous != null) ...[
              const SizedBox(height: 20),
              const Divider(height: 1),
              const SizedBox(height: 16),
              FinanceHealthSectionLabel(t.financial_health.your_own_past),
              const SizedBox(height: 12),
              FinanceHealthPeriodScoreRow(
                label: t.financial_health.previous_period_label,
                score: previous!.healthyScore,
                pointsText: previous!.healthyScore == null
                    ? null
                    : t.financial_health.points_short(
                        value: previous!.healthyScoreString(decimalPlaces: 1),
                      ),
              ),
              const SizedBox(height: 10),
              FinanceHealthPeriodScoreRow(
                label: t.financial_health.now_label,
                score: current.healthyScore,
                pointsText: current.healthyScore == null
                    ? null
                    : t.financial_health.points_short(
                        value: current.healthyScoreString(decimalPlaces: 1),
                      ),
              ),
              const SizedBox(height: 12),
              Text(
                t.financial_health.no_comparison_note,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: hintColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Single bar splitting the 100 possible points into the ones already earned,
/// the ones still within reach, and the ones on hold (striped).
class _CompositionBar extends StatelessWidget {
  const _CompositionBar({
    required this.earned,
    required this.pending,
    required this.paused,
    required this.earnedColor,
    required this.pendingColor,
    required this.pausedColor,
  });

  final double earned;
  final double pending;
  final double paused;
  final Color earnedColor;
  final Color pendingColor;
  final Color pausedColor;

  @override
  Widget build(BuildContext context) {
    int flexOf(double points) => (points * 10).round();

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 12,
        child: Row(
          // Without tight constraints the segments collapse to a zero height
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (flexOf(earned) > 0)
              Expanded(
                flex: flexOf(earned),
                child: ColoredBox(color: earnedColor),
              ),
            if (flexOf(pending) > 0)
              Expanded(
                flex: flexOf(pending),
                child: ColoredBox(color: pendingColor),
              ),
            if (flexOf(paused) > 0)
              Expanded(
                flex: flexOf(paused),
                child: CustomPaint(
                  foregroundPainter: _StripesPainter(
                    color: AppColors.of(context).textHint.withOpacity(0.45),
                  ),
                  child: ColoredBox(color: pausedColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StripesPainter extends CustomPainter {
  const _StripesPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // CustomPaint does not clip to its child
    canvas.clipRect(Offset.zero & size);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;

    for (double x = -size.height; x < size.width + size.height; x += 5) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x - size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StripesPainter oldDelegate) => oldDelegate.color != color;
}

/// Sum of what every measurable indicator earns, which is the same amount the
/// bar at the top of the sheet paints as earned.
class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.data, required this.color});

  final FinanceHealthData data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: cardSurfaceDecoration(context, radius: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              t.financial_health.composition.total,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            t.financial_health.points_of_total(
              earned: FinanceHealthData.pointsString(data.earnedPoints),
              total: data.measurableWeight.toString(),
            ),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Legend entry of the [_CompositionBar]. What each group means is explained in
/// a tooltip, hinted by the dotted underline of the title.
class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.pointsText,
    required this.title,
    required this.description,
    this.striped = false,
  });

  final Color color;
  final String pointsText;
  final String title;
  final String description;
  final bool striped;

  @override
  Widget build(BuildContext context) {
    final hintColor = AppColors.of(context).textHint;

    final swatch = Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );

    return Tooltip(
      message: description,
      triggerMode: TooltipTriggerMode.tap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          striped
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: CustomPaint(
                    foregroundPainter: _StripesPainter(
                      color: hintColor.withOpacity(0.45),
                    ),
                    child: swatch,
                  ),
                )
              : swatch,
          const SizedBox(width: 8),
          Text(
            pointsText,
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: hintColor,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationColor: hintColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// One indicator of the score. Its bar spans the points the indicator can give
/// ([FinanceHealthAttrScore.weight] out of [totalWeight]), so the filled parts
/// of every row add up to the earned points.
class _ScorePillarRow extends StatelessWidget {
  const _ScorePillarRow({required this.pillar, required this.totalWeight});

  final FinanceHealthPillarMeta pillar;
  final int totalWeight;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final attrScore = pillar.attrScore;
    final isPaused = pillar.isPaused;
    final hintColor = AppColors.of(context).textHint;
    final color = isPaused
        ? hintColor
        : FinanceHealthData.getHealthyValueColor(attrScore.score);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(pillar.icon, size: 18, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                pillar.title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isPaused ? hintColor : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isPaused
                  ? t.financial_health.paused_points(
                      total: attrScore.weight.toString(),
                    )
                  : t.financial_health.points_of_total(
                      earned: attrScore.weightedValueString(),
                      total: attrScore.weight.toString(),
                    ),
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        if (!isPaused) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                flex: attrScore.weight,
                child: AnimatedProgressBar(
                  value: (attrScore.score ?? 0) / 100,
                  color: color,
                  width: 6,
                  radius: 12,
                ),
              ),
              if (totalWeight > attrScore.weight)
                Spacer(flex: totalWeight - attrScore.weight),
            ],
          ),
        ],
      ],
    );
  }
}
