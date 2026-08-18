import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Dashboard card showing the user's financial-health score inside an
/// aesthetically-pleasing circular gauge, with a short qualitative review.
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
        ),
        builder: (context, snapshot) {
          final data = snapshot.data;
          final score = data?.healthyScore;
          final color = FinanceHealthData.getHealthyValueColor(score);

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
                        _Badge(
                          text: data.getHealthyScoreReviewTitle(context),
                          color: color,
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

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// A ~270° circular gauge that displays a 0-100 score with a rounded value arc
/// and a centered "value / 100" label.
class FinanceHealthGauge extends StatelessWidget {
  const FinanceHealthGauge({
    super.key,
    required this.score,
    required this.color,
    this.loading = false,
    this.size = 96,
  });

  /// The score from 0 to 100, or null when it can't be computed.
  final double? score;
  final Color color;
  final bool loading;
  final double size;

  @override
  Widget build(BuildContext context) {
    final trackColor = Theme.of(
      context,
    ).colorScheme.outlineVariant.withOpacity(0.35);

    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        tween: Tween(begin: 0, end: loading ? 0 : (score ?? 0) / 100),
        builder: (context, animatedValue, _) {
          return CustomPaint(
            painter: _GaugePainter(
              value: animatedValue,
              color: color,
              trackColor: trackColor,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loading || score == null ? '--' : score!.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                      height: 1,
                    ),
                  ),
                  Text(
                    '/100',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppColors.of(context).textHint,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({
    required this.value,
    required this.color,
    required this.trackColor,
  });

  /// A value between 0 and 1.
  final double value;
  final Color color;
  final Color trackColor;

  static const double _startAngle = pi * 0.75; // 135°
  static const double _sweepAngle = pi * 1.5; // 270°

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 9.0;
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final valuePaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: _startAngle,
        endAngle: _startAngle + _sweepAngle,
        colors: [color.withOpacity(0.65), color],
        transform: GradientRotation(_startAngle),
      ).createShader(rect);

    canvas.drawArc(rect, _startAngle, _sweepAngle, false, trackPaint);

    if (value > 0) {
      canvas.drawArc(
        rect,
        _startAngle,
        _sweepAngle * value.clamp(0, 1),
        false,
        valuePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.color != color ||
        oldDelegate.trackColor != trackColor;
  }
}
