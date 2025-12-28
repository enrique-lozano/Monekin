import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/models/transaction/transaction_type.enum.dart';
import '../../../core/presentation/app_colors.dart';

class IncomeOrExpenseCard extends StatelessWidget {
  const IncomeOrExpenseCard({
    super.key,
    required this.type,
    required this.periodState,
    required this.labelStyle,
    this.filters,
  });

  final TransactionType type;

  final DatePeriodState periodState;

  final TransactionFilters? filters;

  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: type.color(context),
              borderRadius: BorderRadius.circular(80),
            ),
            child: Icon(
              type.icon,
              color: Theme.of(context).colorScheme.surface,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type.displayName(context), style: labelStyle),
              StreamBuilder(
                stream: TransactionService.instance.getTransactionsValueBalance(
                  filters: TransactionFilters(
                    accountsIDs: filters?.accountsIDs,
                    categoriesIds: filters?.categoriesIds,
                    minDate: periodState.startDate,
                    maxDate: periodState.endDate,
                    transactionTypes: [type],
                  ),
                ),
                builder: (context, snapshot) {
                  return Skeletonizer(
                    enabled: !snapshot.hasData,
                    child: CurrencyDisplayer(
                      amountToConvert: snapshot.data?.abs() ?? 9999,
                      compactView: true,
                      showDecimals: false,
                      integerStyle: TextStyle(
                        fontSize: 18,
                        color: AppColors.of(context).onConsistentPrimary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
