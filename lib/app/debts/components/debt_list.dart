import 'package:flutter/material.dart';
import 'package:monekin/app/debts/debt_details_page.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';

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
          onTap: () => RouteUtils.pushRoute(DebtDetailsPage(debt: debt)),
          leading: IconDisplayer(
            supportedIcon: SupportedIconService.instance.getIconByID(
              debt.iconId,
            ),
            mainColor: debt.type.color(context),
            borderRadius: 8,
          ),
          title: Text(debt.name),
          subtitle: debt.endDate != null
              ? Text("Ends: ${debt.endDate.toString().split(' ')[0]}")
              : null,
          trailing: StreamBuilder(
            stream: DebtServive.instance.getDebtRemainingAmount(debt),
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
