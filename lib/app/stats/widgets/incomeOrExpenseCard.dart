import 'package:finlytics/core/database/services/account/account_service.dart';
import 'package:finlytics/core/presentation/widgets/currency_displayer.dart';
import 'package:finlytics/core/presentation/widgets/filter_sheet_modal.dart';
import 'package:finlytics/core/presentation/widgets/skeleton.dart';
import 'package:finlytics/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class IncomeOrExpenseCard extends StatelessWidget {
  const IncomeOrExpenseCard(
      {super.key,
      required this.type,
      required this.startDate,
      required this.endDate,
      this.filters});

  final AccountDataFilter type;
  final DateTime? startDate;
  final DateTime? endDate;

  final TransactionFilters? filters;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final isIncome = type == AccountDataFilter.income;

    final Color color = isIncome ? Colors.green : Colors.red;
    final String text = isIncome ? t.general.income : t.general.expense;

    return Flexible(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isIncome ? Icons.south_east : Icons.north_east,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text),
                  StreamBuilder(
                      stream: filters?.accounts != null
                          ? Stream.value(filters?.accounts)
                          : AccountService.instance.getAccounts(),
                      builder: (context, accounts) {
                        if (!accounts.hasData) {
                          return const Skeleton(width: 26, height: 18);
                        }

                        return StreamBuilder(
                            stream: AccountService.instance.getAccountsData(
                              accountIds: accounts.data!.map((e) => e.id),
                              categoriesIds:
                                  filters?.categories?.map((e) => e.id),
                              startDate: startDate,
                              endDate: endDate,
                              accountDataFilter: type,
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Skeleton(width: 26, height: 18);
                              }

                              return CurrencyDisplayer(
                                amountToConvert: snapshot.data!,
                                textStyle: const TextStyle(fontSize: 18),
                              );
                            });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
