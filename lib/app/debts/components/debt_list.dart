import 'package:flutter/material.dart';
import 'package:monekin/app/debts/debt_details_page.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class DebtList extends StatelessWidget {
  const DebtList({
    super.key,
    required this.debts,
    this.shrinkWrap = false,
    this.physics,
    this.showOverdueWarning = true,
  });

  final List<Debt> debts;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  /// Whether to show a warning subtitle when the debt's end date has passed.
  final bool showOverdueWarning;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: debts.length,
      itemBuilder: (context, index) {
        final t = Translations.of(context);
        final debt = debts[index];

        Widget? subtitleWidget;

        if (debt.endDate != null) {
          final now = DateTime.now();
          if (showOverdueWarning && debt.endDate!.isBefore(now)) {
            final daysOverdue = now.difference(debt.endDate!).inDays;
            subtitleWidget = Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 12,
                  color: Theme.of(context).colorScheme.error,
                ),
                Text(
                  daysOverdue == 0
                      ? t.debts.details.due_today
                      : t.debts.details.overdue_by(x: daysOverdue),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            );
          } else {
            subtitleWidget = Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                Icon(
                  Icons.event_rounded,
                  size: 12,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
                Text(
                  debt.endDate.toString().split(' ')[0],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            );
          }
        }

        return ListTile(
          onTap: () =>
              RouteUtils.pushRoute(DebtDetailsPage(debtInitialData: debt)),
          leading: IconDisplayer(
            supportedIcon: SupportedIconService.instance.getIconByID(
              debt.iconId,
            ),
            mainColor: debt.type.color(context),
            borderRadius: 8,
          ),
          title: Text(debt.name),
          subtitle: subtitleWidget,
          trailing: StreamBuilder(
            stream: DebtServive.instance.getDebtRemainingAmount(debt),
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
