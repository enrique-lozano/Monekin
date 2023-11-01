import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';

class IncomeOrExpenseCard extends StatelessWidget {
  const IncomeOrExpenseCard(
      {super.key,
      required this.type,
      required this.startDate,
      required this.endDate,
      this.filters});

  final TransactionType type;
  final DateTime? startDate;
  final DateTime? endDate;

  final TransactionFilters? filters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              type.icon,
              color: type.color(context),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type.displayName(context)),
              StreamBuilder(
                  stream: AccountService.instance.getAccountsBalance(
                    filters: TransactionFilters(
                      accountsIDs: filters?.accountsIDs,
                      categories: filters?.categories,
                      minDate: startDate,
                      maxDate: endDate,
                      transactionTypes: [type],
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Skeleton(width: 26, height: 18);
                    }

                    return CurrencyDisplayer(
                      amountToConvert: snapshot.data!,
                      textStyle: const TextStyle(fontSize: 18),
                    );
                  })
            ],
          )
        ],
      ),
    );
  }
}
