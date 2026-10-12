import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/app_colors.dart';

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
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

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

/// A small pill-shaped badge used to show a qualitative review (e.g.
/// "GOOD") next to a [FinanceHealthGauge], colored to match the score.
class FinanceHealthScoreBadge extends StatelessWidget {
  const FinanceHealthScoreBadge({
    super.key,
    required this.text,
    required this.color,
  });

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
