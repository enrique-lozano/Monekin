import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/transaction_list.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/presentation/widgets/empty_indicator.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/i18n/translations.g.dart';

class RecurrentTransactionPage extends StatefulWidget {
  const RecurrentTransactionPage({super.key});

  @override
  State<RecurrentTransactionPage> createState() =>
      _RecurrentTransactionPageState();
}

class _RecurrentTransactionPageState extends State<RecurrentTransactionPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.recurrent_transactions.title)),
      body: StreamBuilder(
          stream: TransactionService.instance.getTransactions(
            filters: const TransactionFilters(isRecurrent: true),
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LinearProgressIndicator();
            }

            final transactions = snapshot.data!;

            if (transactions.isEmpty) {
              return Column(
                children: [
                  Expanded(
                      child: EmptyIndicator(
                          title: 'Ops! Esto esta muy vacio',
                          description: t.recurrent_transactions.empty)),
                ],
              );
            }

            return TransactionListComponent(
                transactions: transactions,
                showRecurrentInfo: true,
                showGroupDivider: false,
                prevPage: const RecurrentTransactionPage());
          }),
    );
  }
}
