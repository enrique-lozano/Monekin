import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:monekin/app/budgets/budget_details_page.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key, required this.budget, this.isHeader = false});

  final Budget budget;

  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(14);
    final t = Translations.of(context);

    return Tappable(
      margin: isHeader
          ? const EdgeInsets.all(0)
          : const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      bgColor: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: isHeader
            ? const BorderRadius.only(bottomLeft: radius, bottomRight: radius)
            : const BorderRadius.all(radius),
      ),
      onTap: isHeader
          ? null
          : () => RouteUtils.pushRoute(BudgetDetailsPage(budget: budget)),
      child: Card(
        margin: const EdgeInsets.all(0),
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(budget.name),
                    StreamBuilder(
                      stream: budget.currentValue,
                      builder: (context, snapshot) {
                        return Skeletonizer(
                          enabled: !snapshot.hasData,
                          child: CurrencyDisplayer(
                            amountToConvert:
                                budget.limitAmount - (snapshot.data ?? 0),
                            showDecimals: false,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(fontWeight: FontWeight.w300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      budget.intervalPeriod?.allThePeriodsText(context) ??
                          '${DateFormat.yMMMd().format(budget.currentDateRange.start)} - ${DateFormat.yMMMd().format(budget.currentDateRange.end)}',
                    ),
                    Row(
                      children: [
                        Text(t.budgets.from_budgeted.toLowerCase()),
                        CurrencyDisplayer(
                          amountToConvert: budget.limitAmount,
                          showDecimals: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Builder(
                builder: (context) {
                  const double barWidth = 16;
                  final Color labelColor = Theme.of(
                    context,
                  ).colorScheme.tertiary;

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          StreamBuilder(
                            stream: budget.percentageAlreadyUsed,
                            builder: (context, snapshot) {
                              final budgetValue = snapshot.data;

                              return AnimatedProgressBar(
                                width: barWidth,
                                radius: 24,
                                value: budgetValue != null && budgetValue >= 1
                                    ? 1
                                    : budgetValue ?? 0,
                                color: budgetValue != null && budgetValue >= 1
                                    ? AppColors.of(context).danger
                                    : null,
                              );
                            },
                          ),
                          if (budget.isActiveBudget)
                            Positioned(
                              top: -4,
                              left:
                                  constraints.maxWidth *
                                  budget.todayPercent /
                                  100,
                              child: Stack(
                                children: [
                                  Transform.translate(
                                    offset: const Offset(0, -barWidth),
                                    child: FractionalTranslation(
                                      translation: Offset(
                                        budget.todayPercent < 10
                                            ? 0.8
                                            : budget.todayPercent > 90
                                            ? -0.8
                                            : -0.5,
                                        0,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: labelColor,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: Text(
                                          t.general.today,
                                          softWrap: false,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onTertiary,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width: 2.5,
                                      height: barWidth + 4,
                                      color: labelColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              if (isHeader &&
                  budget.periodState.datePeriod.periodType ==
                      PeriodType.cycle) ...[
                const SizedBox(height: 6),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.labelMedium!,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMMMd().format(
                          budget.currentDateRange.start,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(budget.currentDateRange.end),
                      ),
                    ],
                  ),
                ),
              ],
              if (budget.isPastBudget || budget.isFutureBudget) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.circle, size: 12, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      budget.isPastBudget
                          ? '${budget.daysToTheEnd.abs()} ${t.budgets.since_expiration}'
                          : '${budget.daysToTheStart} ${t.budgets.days_to_start}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
              if (isHeader && budget.isActiveBudget) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder(
                      stream: CurrencyService.instance
                          .ensureAndGetPreferredCurrency(),
                      builder: (context, snapshot) {
                        return StreamBuilder(
                          stream: budget.currentValue,
                          builder: (context, budgetCurrentValue) {
                            return Text(
                              t.budgets.details.expend_diary_left(
                                dailyAmount:
                                    NumberFormat.currency(
                                      symbol: snapshot.data?.symbol ?? '',
                                      decimalDigits: 0,
                                    ).format(
                                      ((budget.limitAmount -
                                                  (budgetCurrentValue.data ??
                                                      0)) >
                                              0)
                                          ? ((budget.limitAmount -
                                                    (budgetCurrentValue.data ??
                                                        0)) /
                                                budget.daysToTheEnd)
                                          : 0,
                                    ),
                                remainingDays: budget.daysToTheEnd,
                              ),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
