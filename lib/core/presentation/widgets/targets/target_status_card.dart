import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/budget/target_progress_status.enum.dart';
import 'package:monekin/core/models/budget/target_timeline_status.enum.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
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
    final dates = target.periodState.getDates();
    final startDate = dates.$1!; // Start date should usually be present
    final endDate = dates.$2;

    final int? daysToTheEnd = endDate?.difference(DateTime.now()).inDays;

    final enableTodayLabel =
        !target.isFuture && target.periodState.toDateTimeRange != null;
    return CardWithHeader(
      title: target is Goal ? t.goals.status : t.budgets.status,
      bodyPadding: const EdgeInsets.all(16),
      body: Column(
        spacing: 4,
        children: [
          if (endDate != null)
            DefaultTextStyle(
              style: Theme.of(context).textTheme.labelMedium!,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat.yMMMd().format(startDate)),
                  Text(DateFormat.yMMMd().format(endDate)),
                ],
              ),
            ),

          StreamBuilder(
            stream: target.percentageAlreadyUsed,
            builder: (context, snapshot) {
              final percentValue = snapshot.data;

              return AnimatedProgressBarWithIndicatorLabel(
                enableLabel: enableTodayLabel,
                indicatorLabelOptions: IndicatorLabelOptions(
                  label: Text(t.general.today),
                  isLabelBeforeBar: false,
                  labelPercent: (target.todayPercent ?? 0) / 100,
                ),
                animatedProgressBar: AnimatedProgressBar(
                  width: 16,
                  radius: 99,
                  showPercentageText: true,
                  animationDuration: 1500,
                  value: percentValue != null && percentValue >= 1
                      ? 1
                      : percentValue ?? 0,
                  color: percentValue != null && percentValue >= 1
                      ? (target.isTargetLimit
                            ? AppColors.of(context).danger
                            : AppColors.of(context).success)
                      : null,
                ),
              );
            },
          ),

          if (!target.isFuture) ...[
            SizedBox(height: enableTodayLabel ? 12 : 0),
            const Divider(height: 24),
            StreamBuilder(
              stream: CurrencyService.instance
                  .ensureAndGetPreferredCurrency()
                  .switchMap((userCurrency) {
                    return target.progressStatus.map((progressStatus) {
                      return (
                        userCurrency: userCurrency,
                        progressStatus: progressStatus,
                      );
                    });
                  }),
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: !snapshot.hasData,
                  child: Row(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 6,
                          children: [
                            Text(
                              (snapshot.data?.progressStatus ??
                                      TargetProgressStatus.success)
                                  .displayName(
                                    context,
                                    isTargetLimit: target.isTargetLimit,
                                  ),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              !snapshot.hasData ||
                                      snapshot.data?.progressStatus == null
                                  ? 'Quis deserunt cupidatat ullamco elit velit quis in exercitation nulla. Consequat fugiat consectetur magna deserunt labore duis. Qui et in labore amet velit quis in ad excepteur.'
                                  : (snapshot.data!.progressStatus!)
                                        .description(
                                          context: context,
                                          isTargetLimit: target.isTargetLimit,
                                          dailyAmountLeft:
                                              ((target.targetAmount -
                                                  (currentValue ?? 0)) /
                                              (daysToTheEnd ?? 1)),
                                          amountLeft:
                                              target.targetAmount -
                                              (currentValue ?? 0),
                                          currency: snapshot.data?.userCurrency,
                                          daysLeft: daysToTheEnd ?? 9999,
                                          failedByAmount:
                                              (target.targetAmount -
                                                      (currentValue ?? 0))
                                                  .abs(),
                                        ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: snapshot.data?.progressStatus == null
                              ? null
                              : snapshot.data!.progressStatus!
                                    .color(target.isTargetLimit)
                                    .lighten(0.2)
                                    .withOpacity(0.2),
                        ),
                        child: Icon(
                          snapshot.data?.progressStatus?.icon(
                                target.isTargetLimit,
                              ) ??
                              Icons.question_mark,
                          size: 20,
                          color: snapshot.data?.progressStatus?.color(
                            target.isTargetLimit,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
