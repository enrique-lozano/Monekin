import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/services/finance_health_service.dart';

/// Small caps header used to separate the sections of the financial-health
/// sheets.
class FinanceHealthSectionLabel extends StatelessWidget {
  const FinanceHealthSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: AppColors.of(context).textHint,
      ),
    );
  }
}

/// One row of a "compared with your own past" section: a label, a bar sized
/// (and colored) by the score of that period, and the points it earned.
class FinanceHealthPeriodScoreRow extends StatelessWidget {
  const FinanceHealthPeriodScoreRow({
    super.key,
    required this.label,
    required this.score,
    required this.pointsText,
  });

  final String label;

  /// Score of the period, from 0 to 100. Null when it could not be calculated.
  final double? score;

  /// Points earned in that period, already formatted. Null when there are none.
  final String? pointsText;

  @override
  Widget build(BuildContext context) {
    final score = this.score;
    final color = score == null
        ? AppColors.of(context).textHint
        : FinanceHealthData.getHealthyValueColor(score);

    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          child: AnimatedProgressBar(
            value: (score ?? 0) / 100,
            color: color,
            width: 6,
            radius: 12,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 68,
          child: Text(
            pointsText ?? '—',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

/// Rounded pill with a short, colored piece of text (a score, a state...).
class FinanceHealthPill extends StatelessWidget {
  const FinanceHealthPill({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}
