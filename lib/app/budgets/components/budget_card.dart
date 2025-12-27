import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:monekin/app/budgets/budget_details_page.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key, required this.budget});

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    final Radius radius = Radius.circular(getCardBorderRadius());
    final t = Translations.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: boxShadowGeneral(context)),
      child: Tappable(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        bgColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),

        onTap: () => RouteUtils.pushRoute(BudgetDetailsPage(budget: budget)),
        child: Card(
          margin: const EdgeInsets.all(0),
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BudgetMainHeaderInfo(budget: budget),
                const SizedBox(height: 12),
                Builder(
                  builder: (context) {
                    return StreamBuilder(
                      stream: budget.percentageAlreadyUsed,
                      builder: (context, snapshot) {
                        final budgetValue = snapshot.data;

                        return AnimatedProgressBarWithIndicatorLabel(
                          indicatorLabelOptions: IndicatorLabelOptions(
                            label: Text(t.general.today),
                            isLabelBeforeBar: false,
                            labelPercent: budget.todayPercent / 100,
                          ),
                          enableLabel: budget.isActiveBudget,
                          animatedProgressBar: AnimatedProgressBar(
                            width: 16,
                            radius: 99,
                            showPercentageText: true,
                            animationDuration: 1500,
                            value: budgetValue != null && budgetValue >= 1
                                ? 1
                                : budgetValue ?? 0,
                            color: budgetValue != null && budgetValue >= 1
                                ? AppColors.of(context).danger
                                : null,
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: budget.isActiveBudget ? 24 : 8),
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        budget.timelineStatus.icon(size: 16),
                        Text(budget.timelineStatus.displayName(context)),
                      ],
                    ),

                    StreamBuilder(
                      stream: budget.progressStatus,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
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
                                color: progressStatus.color
                                    .lighten(0.2)
                                    .withOpacity(0.2),
                              ),
                              child: Icon(
                                progressStatus.iconData,
                                size: 12,
                                color: progressStatus.color,
                              ),
                            ),
                            Text(progressStatus.displayName(context)),
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

class BudgetMainHeaderInfo extends StatelessWidget {
  const BudgetMainHeaderInfo({super.key, required this.budget});

  final Budget budget;

  @override
  Widget build(BuildContext context) {
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
              tag: 'budget_card_${budget.id}_header_info',

              child: Text(
                budget.name,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            buildMoneyValueLine(),
          ],
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Builder(
                builder: (context) {
                  String datePeriodText =
                      budget.intervalPeriod?.allThePeriodsText(context) ?? '';

                  if (datePeriodText.isEmpty) {
                    final startDate = budget.currentDateRange.start;
                    final endDate = budget.currentDateRange.end;

                    final startDateLabel = startDate.year == currentYear
                        ? DateFormat.MMMd().format(startDate)
                        : DateFormat.yMMMd().format(startDate);

                    final endDateLabel = endDate.year == currentYear
                        ? DateFormat.MMMd().format(endDate)
                        : DateFormat.yMMMd().format(endDate);

                    datePeriodText = '$startDateLabel - $endDateLabel';
                  }

                  return Text(datePeriodText);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  StreamBuilder<double> buildMoneyValueLine() {
    return StreamBuilder(
      stream: budget.currentValue,
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
                  amountToConvert: budget.limitAmount - (snapshot.data ?? 0),
                  showDecimals: false,
                  integerStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(' / '),
                CurrencyDisplayer(
                  amountToConvert: budget.limitAmount,
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
