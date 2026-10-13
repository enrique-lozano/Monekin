import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/budget/target_progress_status.enum.dart';
import 'package:monekin/core/models/budget/target_timeline_status.enum.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/models/goal/goal_type.enum.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/models/mixins/target_pace.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FinancialTargetTimelineCard extends StatelessWidget {
  const FinancialTargetTimelineCard({super.key, required this.target});

  final FinancialTarget target;

  String _timelineStatusLabel(BuildContext context) {
    if (target is Budget) {
      final t = Translations.of(context).budgets.target_timeline_statuses;
      switch (target.timelineStatus) {
        case TargetTimelineStatus.active:
          return t.active;
        case TargetTimelineStatus.past:
          return t.past;
        case TargetTimelineStatus.future:
          return t.future;
      }
    }

    final t = Translations.of(context).goals.target_timeline_statuses;
    switch (target.timelineStatus) {
      case TargetTimelineStatus.active:
        return t.active;
      case TargetTimelineStatus.past:
        return t.past;
      case TargetTimelineStatus.future:
        return t.future;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final dates = target.periodState.getDates();
    final startDate = dates.$1!; // Start date should usually be present
    final endDate = dates.$2;

    final int? daysToTheEnd = endDate?.difference(DateTime.now()).inDays;
    final int daysToTheStart = startDate.difference(DateTime.now()).inDays;

    return CardWithHeader(
      title: _timelineStatusLabel(context),
      titleBuilder: (title) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [target.timelineStatus.icon(size: 16), Text(title)],
        ),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
      body: Text(
        (target.isPast
            ? '${(daysToTheEnd ?? 0).abs()} ${t.budgets.since_expiration}'
            : target.isFuture
            ? '$daysToTheStart ${t.budgets.days_to_start}'
            : ""),
      ),
    );
  }
}

class FinancialTargetStatusCard extends StatelessWidget {
  const FinancialTargetStatusCard({
    super.key,
    required this.target,
    required this.currentValue,
  });

  final FinancialTarget target;
  final double? currentValue;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final appColors = AppColors.of(context);
    final hintColor = appColors.textHint;

    final value = currentValue ?? 0;
    final amountLeft = target.targetAmount - value;
    final percent = target.targetAmount == 0
        ? 0.0
        : value / target.targetAmount;
    final pace = TargetPace.of(target, currentValue: value);

    final range = target.periodState.toDateTimeRange;
    final startDate = target.periodState.startDate!;
    final periodicity = target is Budget
        ? (target as Budget).intervalPeriod
        : null;

    final isIncomeGoal =
        target is Goal && (target as Goal).type == GoalType.income;

    final enableTodayLabel = target.isActive && range != null;

    return CardWithHeader(
      title: target is Goal ? t.goals.status : t.budgets.status,
      bodyPadding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      body: Skeletonizer(
        enabled: currentValue == null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      spacing: 6,
                      children: [
                        CurrencyDisplayer(
                          amountToConvert: amountLeft.abs(),
                          showDecimals: false,
                          integerStyle: textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: amountLeft < 0
                                ? (target.isTargetLimit
                                      ? appColors.danger
                                      : appColors.success)
                                : null,
                          ),
                        ),
                        Text(
                          amountLeft < 0 ? t.targets.over : t.targets.left,
                          style: textTheme.titleMedium!.copyWith(
                            color: hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: target.progressStatus,
                  builder: (context, snapshot) {
                    final status = snapshot.data;
                    if (status == null) return const SizedBox.shrink();

                    return Flexible(
                      child: _TargetProgressStatusChip(
                        status: status,
                        isTargetLimit: target.isTargetLimit,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: textTheme.bodyMedium!.copyWith(color: hintColor),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          _currencySpan(value),
                          TextSpan(
                            text:
                                ' ${isIncomeGoal ? t.targets.saved : t.targets.spent} · ',
                          ),
                          TextSpan(
                            text: UINumberFormatter.percentage(
                              amountToConvert: percent,
                              showDecimals: false,
                            ).getFormattedAmount(),
                          ),
                          TextSpan(text: ' ${t.general.of} '),
                          _currencySpan(target.targetAmount),
                        ],
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
                if (periodicity != null)
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4,
                      children: [
                        Icon(Icons.repeat_rounded, size: 18, color: hintColor),
                        Flexible(
                          child: Text(
                            periodicity.allThePeriodsText(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium!.copyWith(
                              color: hintColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: enableTodayLabel ? 34 : 16),
            AnimatedProgressBarWithIndicatorLabel(
              enableLabel: enableTodayLabel,
              indicatorLabelOptions: IndicatorLabelOptions(
                label: Text(t.general.today),
                isLabelBeforeBar: true,
                labelPercent: ((target.todayPercent ?? 0) / 100).clamp(0, 1),
              ),
              animatedProgressBar: AnimatedProgressBar(
                width: 16,
                radius: 99,
                animationDuration: 1500,
                value: percent.clamp(0, 1),
                color: percent >= 1
                    ? (target.isTargetLimit
                          ? appColors.danger
                          : appColors.success)
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            DefaultTextStyle(
              style: textTheme.labelMedium!.copyWith(color: hintColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getShortDateLabel(startDate)),
                  if (range != null) Text(getShortDateLabel(range.end)),
                ],
              ),
            ),
            if (pace != null) ...[
              const Divider(height: 32),
              _TargetPaceStats(target: target, pace: pace),
            ],
          ],
        ),
      ),
    );
  }

  InlineSpan _currencySpan(double amount) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: CurrencyDisplayer(amountToConvert: amount, showDecimals: false),
    );
  }
}

class _TargetProgressStatusChip extends StatelessWidget {
  const _TargetProgressStatusChip({
    required this.status,
    required this.isTargetLimit,
  });

  final TargetProgressStatus status;
  final bool isTargetLimit;

  @override
  Widget build(BuildContext context) {
    final color = status.color(isTargetLimit);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.lighten(0.2).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(status.icon(isTargetLimit), size: 18, color: color),
          Flexible(
            child: Text(
              status.displayName(context, isTargetLimit: isTargetLimit),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _TargetPaceStats extends StatelessWidget {
  const _TargetPaceStats({required this.target, required this.pace});

  final FinancialTarget target;
  final TargetPace pace;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).targets.stats;
    final appColors = AppColors.of(context);

    final paceDiff = pace.currentValue - pace.expectedValue;
    // Being below the pace is good for limits, and bad for goals
    final isPaceGood = target.isTargetLimit ? paceDiff <= 0 : paceDiff >= 0;
    final isProjectionGood = target.isTargetLimit
        ? pace.projectedValue <= target.targetAmount
        : pace.projectedValue >= target.targetAmount;

    const divider = VerticalDivider(width: 1);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TargetStat(
            icon: Icons.calendar_today_rounded,
            amount: pace.dailyAmountLeft,
            showDecimals: true,
            label: t.per_day_short,
            helpText: '${t.per_day_help}\n${t.per_day(n: pace.remainingDays)}',
          ),
          divider,
          _TargetStat(
            icon: paceDiff > 0
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            color: isPaceGood ? appColors.success : Colors.orange,
            amount: paceDiff.abs(),
            label: paceDiff > 0 ? t.above_pace : t.below_pace,
            helpText: t.pace_help,
          ),
          divider,
          _TargetStat(
            icon: Icons.show_chart_rounded,
            color: isProjectionGood ? null : Colors.orange,
            amount: pace.projectedValue,
            label: t.projected,
            helpText: t.projected_help,
          ),
        ],
      ),
    );
  }
}

class _TargetStat extends StatelessWidget {
  const _TargetStat({
    required this.icon,
    required this.amount,
    required this.label,
    required this.helpText,
    this.color,
    this.showDecimals = false,
  });

  final IconData icon;
  final double amount;
  final String label;
  final String helpText;
  final Color? color;
  final bool showDecimals;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hintColor = AppColors.of(context).textHint;

    final accent = color ?? hintColor;

    return Expanded(
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(icon, size: 18, color: accent),
            ),
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CurrencyDisplayer(
              amountToConvert: amount,
              showDecimals: showDecimals,
              integerStyle: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text.rich(
            TextSpan(
              text: '$label ',
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Tooltip(
                    message: helpText,
                    triggerMode: TooltipTriggerMode.tap,
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 13,
                      color: hintColor,
                    ),
                  ),
                ),
              ],
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium!.copyWith(color: hintColor),
          ),
        ],
      ),
    );
  }
}
