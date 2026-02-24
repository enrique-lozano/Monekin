import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/models/debt/debt.dart';

class DebtList extends StatelessWidget {
  const DebtList({
    super.key,
    required this.debts,
    this.shrinkWrap = false,
    this.physics,
  });

  final List<Debt> debts;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: debts.length,
      itemBuilder: (context, index) {
        final debt = debts[index];

        return ListTile(
          title: Text(debt.name),
          subtitle: debt.endDate != null
              ? Text("Ends: ${debt.endDate.toString().split(' ')[0]}")
              : null,
          trailing: FutureBuilder<double>(
            future: DebtServive.instance.getDebtCurrentAmount(debt),
            // We use the initial amount as a placeholder while loading the real updated amount
            initialData: debt.initialAmount,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  "${snapshot.data!.toStringAsFixed(2)} ${debt.currency.symbol}",
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              }

              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
