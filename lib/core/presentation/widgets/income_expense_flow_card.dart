import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Income or expense summary for a period, with a trend chip vs the previous
/// period. Used on the dashboard and on account details.
class IncomeExpenseFlowCard extends StatelessWidget {
  const IncomeExpenseFlowCard({
    super.key,
    required this.type,
    required this.periodState,
    this.filters,
    this.currency,
  });

  final TransactionType type;
  final DatePeriodState periodState;
  final TransactionFilterSet? filters;

  /// When set, amounts are shown in this currency without conversion.
  /// Otherwise they are converted to the user's preferred currency.
  final CurrencyInDB? currency;

  TransactionFilterSet _filtersForDates(DateTime? min, DateTime? max) {
    return TransactionFilterSet(
      accountsIDs: filters?.accountsIDs,
      categoriesIds: filters?.categoriesIds,
      minDate: min,
      maxDate: max,
      transactionTypes: [type],
    );
  }

  Stream<double> _balanceStream(TransactionFilterSet filters) {
    return TransactionService.instance.getTransactionsValueBalance(
      filters: filters,
      convertToPreferredCurrency: currency == null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final color = type.color(context);

    // Expenses are "inverse" metrics: a drop is a good trend and should be
    // painted as such (green), not as a bad one.
    final inverse = type == TransactionType.expense;

    final isWide = BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md);

    final currentStream = _balanceStream(
      _filtersForDates(periodState.startDate, periodState.endDate),
    );

    final (prevStart, prevEnd) = periodState.getPrevDates();
    final canCompare = prevStart != null && prevEnd != null;

    final prevStream = canCompare
        ? _balanceStream(_filtersForDates(prevStart, prevEnd))
        : Stream.value(0.0);

    return DecoratedBox(
      decoration: cardSurfaceDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: Rx.combineLatest2(
            currentStream,
            prevStream,
            (double current, double prev) => (current, prev),
          ),
          builder: (context, snapshot) {
            final hasData = snapshot.hasData;
            final current = snapshot.data?.$1 ?? 0;
            final prev = snapshot.data?.$2 ?? 0;
            final currentAbs = current.abs();
            final trendPercentage = prev.abs() == 0
                ? double.nan
                : (currentAbs - prev.abs()) / prev.abs();

            final trend = hasData && canCompare
                ? TrendingValue(
                    percentage: trendPercentage,
                    inverse: inverse,
                    style: TrendingValueStyle.chip,
                    afterText: t.home.vs_previous_period,
                    showPercentageDecimals: false,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  )
                : null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(type.icon, color: color, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        type.displayName(context).toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              color: AppColors.of(context).textHint,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isWide && trend != null) trend,
                  ],
                ),
                const SizedBox(height: 12),
                Skeletonizer(
                  enabled: !hasData,
                  child: CurrencyDisplayer(
                    amountToConvert: hasData ? currentAbs : 9999,
                    currency: currency,
                    compactView: currentAbs >= 100000,
                    showDecimals: false,
                    integerStyle: Theme.of(context).textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                if (!isWide && trend != null) ...[
                  const SizedBox(height: 6),
                  trend,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
