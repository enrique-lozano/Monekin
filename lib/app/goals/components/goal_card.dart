import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/goals/goal_details_page.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/models/mixins/financial_target_direction.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final Radius radius = Radius.circular(getCardBorderRadius());

    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: boxShadowGeneral(context)),
      child: Tappable(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        bgColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
        onTap: () => RouteUtils.pushRoute(GoalDetailsPage(goal: goal)),
        child: Card(
          margin: const EdgeInsets.all(0),
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GoalMainHeaderInfo(goal: goal),
                const SizedBox(height: 12),
                StreamBuilder(
                  stream: goal.percentageAlreadyUsed,
                  builder: (context, snapshot) {
                    final goalPercent = snapshot.data;

                    return AnimatedProgressBar(
                      width: 16,
                      radius: 99,
                      showPercentageText: true,
                      animationDuration: 1500,
                      value: goalPercent != null && goalPercent >= 1
                          ? 1
                          : goalPercent ?? 0,
                      color: goalPercent != null && goalPercent >= 1
                          ? AppColors.of(context).success
                          : (goal.targetDirection ==
                                    FinancialTargetDirection.toExpense
                                ? AppColors.of(context).danger
                                : AppColors.of(context).success),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoalMainHeaderInfo extends StatelessWidget {
  const GoalMainHeaderInfo({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'goal_card_${goal.id}_header_info',
              child: Text(
                goal.name,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            _buildMoneyValueLine(context),
          ],
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Builder(
                builder: (context) {
                  final startDate = goal.startDate;
                  final endDate = goal.endDate;

                  final startDateLabel = startDate.year == currentYear
                      ? DateFormat.MMMd().format(startDate)
                      : DateFormat.yMMMd().format(startDate);

                  String dateText = startDateLabel;
                  if (endDate != null) {
                    final endDateLabel = endDate.year == currentYear
                        ? DateFormat.MMMd().format(endDate)
                        : DateFormat.yMMMd().format(endDate);
                    dateText = '$startDateLabel - $endDateLabel';
                  } else {
                    dateText = 'From $startDateLabel';
                  }

                  return Text(dateText);
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
      stream: goal.currentValue,
      builder: (context, snapshot) {
        return Skeletonizer(
          enabled: !snapshot.hasData,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.labelMedium!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                CurrencyDisplayer(
                  amountToConvert: snapshot.data ?? 0,
                  showDecimals: false,
                  integerStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(' / '),
                CurrencyDisplayer(
                  amountToConvert: goal.targetAmount,
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
