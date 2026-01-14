import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/budgets/budget_details_page.dart';
import 'package:monekin/app/goals/goal_details_page.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/models/mixins/financial_target_direction.enum.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FinancialTargetCard extends StatelessWidget {
  const FinancialTargetCard({super.key, required this.target});

  final FinancialTarget target;

  @override
  Widget build(BuildContext context) {
    final Radius radius = Radius.circular(getCardBorderRadius());
    final t = Translations.of(context);

    final todayLabelEnabled = target.isActive && target.todayPercent != null;

    void onTap() {
      if (target is Budget) {
        RouteUtils.pushRoute(BudgetDetailsPage(budget: target as Budget));
      } else if (target is Goal) {
        RouteUtils.pushRoute(GoalDetailsPage(goal: target as Goal));
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: boxShadowGeneral(context)),
      child: Tappable(
        margin: const EdgeInsets.symmetric(vertical: 6),
        bgColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.all(0),
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TargetHeader(target: target),
                const SizedBox(height: 12),

                // Progress Bar
                StreamBuilder(
                  stream: target.percentageAlreadyUsed,
                  builder: (context, snapshot) {
                    final percent = snapshot.data;
                    final safePercent = percent != null && percent >= 1
                        ? 1.0
                        : (percent ?? 0.0);

                    return AnimatedProgressBarWithIndicatorLabel(
                      indicatorLabelOptions: IndicatorLabelOptions(
                        label: Text(t.general.today),
                        isLabelBeforeBar: false,
                        labelPercent: (target.todayPercent ?? 100) / 100,
                      ),
                      enableLabel: todayLabelEnabled,
                      animatedProgressBar: AnimatedProgressBar(
                        width: 16,
                        radius: 99,
                        showPercentageText: true,
                        animationDuration: 1500,
                        value: safePercent,
                        color: safePercent >= 1
                            ? (target.isTargetLimit
                                  ? AppColors.of(context).danger
                                  : AppColors.of(context).success)
                            : null,
                      ),
                    );
                  },
                ),

                SizedBox(height: todayLabelEnabled ? 20 : 8),

                // Footer (Status & Icons)
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Timeline Status (Active/Past/Future)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 4,
                      children: [
                        target.timelineStatus.icon(size: 14),
                        Text(
                          target.timelineStatus.displayName(context),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),

                    // Progress Status (On Track/Overspending etc)
                    StreamBuilder(
                      stream: target.progressStatus,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const SizedBox.shrink();
                        }

                        final progressStatus = snapshot.data!;

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: progressStatus
                                    .color(target.isTargetLimit)
                                    .lighten(0.2)
                                    .withOpacity(0.2),
                              ),
                              child: Icon(
                                progressStatus.icon(target.isTargetLimit),
                                size: 12,
                                color: progressStatus.color(
                                  target.isTargetLimit,
                                ),
                              ),
                            ),
                            Text(
                              progressStatus.displayName(
                                context,
                                isTargetLimit: target.isTargetLimit,
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TargetHeader extends StatelessWidget {
  const TargetHeader({required this.target});

  final FinancialTarget target;

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'target_card_${target.id}_header_info',
              child: Row(
                spacing: 8,
                children: [
                  if (target is Goal)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: (target as Goal).type
                            .color(context)
                            .lightenPastel(amount: .25),
                      ),
                      child: Icon(
                        Goal.icon,
                        size: 20,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  Text(
                    target.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildMoneyValueLine(context),
          ],
        ),
        if (target.periodState.toDateTimeRange != null)
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 4,
              children: [
                Builder(
                  builder: (context) {
                    // If it's a Budget with periodicity, use existing logic
                    if (target is Budget) {
                      final b = target as Budget;
                      final periodText =
                          b.intervalPeriod?.allThePeriodsText(context) ?? '';
                      if (periodText.isNotEmpty) {
                        return Text(periodText, textAlign: TextAlign.end);
                      }
                    }

                    final range = target.periodState.toDateTimeRange!;
                    final startDate = range.start;
                    final endDate = range.end;

                    final startDateLabel = startDate.year == currentYear
                        ? DateFormat.MMMd().format(startDate)
                        : DateFormat.yMMMd().format(startDate);

                    final endDateLabel = endDate.year == currentYear
                        ? DateFormat.MMMd().format(endDate)
                        : DateFormat.yMMMd().format(endDate);

                    return Text(
                      '$startDateLabel - $endDateLabel',
                      textAlign: TextAlign.end,
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildMoneyValueLine(BuildContext context) {
    return StreamBuilder(
      stream: target.currentValue,
      builder: (context, snapshot) {
        return Skeletonizer(
          enabled: !snapshot.hasData,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.labelMedium!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (target.targetDirection ==
                    FinancialTargetDirection.toExpense) ...[
                  // For Budgets/Expense: Show remaining or spent?
                  // BudgetCard showed "Remaining from Total"
                  // GoalCard showed "Current / Total"

                  // Let's unify or check type.
                  // The prompt asked to create a reusable widget, assuming unification.
                  // Goals usually show progress (Current / Target).
                  // Budgets usually show Remaining.

                  // Let's stick to "Current / Target" as generic financial target visualization
                  // OR keep Budget specific display "Remaining" if `toExpense`?
                  // BudgetCard code: `amountToConvert: budget.limitAmount - (snapshot.data ?? 0)` -> Remaining

                  // But for Expense GOALs, do we want Remaining or Spent?
                  // Usually spending limit goals --> "Spent X of Y".
                  // Budget --> "Left X of Y".

                  // Let's use "Spent X / Y" for all for consistency in this generic card?
                  // Or keep "Remaining" for Expenses?

                  // Let's implement "Current / Total" for now as it's cleaner for a generic card.
                  // Money Spent / Limit
                ] else ...[
                  // Income Goal: "Saved X / Y"
                ],

                // If we want to mimic BudgetCard exactly:
                /*
                  CurrencyDisplayer(
                    amountToConvert: budget.limitAmount - (snapshot.data ?? 0),
                    ...
                  )
                 */

                // Let's standardize on: "Current / Total"
                CurrencyDisplayer(
                  amountToConvert: snapshot.data ?? 0,
                  showDecimals: false,
                  integerStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(' / '),
                CurrencyDisplayer(
                  amountToConvert: target.targetAmount,
                  showDecimals: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
