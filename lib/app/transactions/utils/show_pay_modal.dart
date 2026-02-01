import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/utils/transaction_details.utils.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void showPayModal(BuildContext pageContext, MoneyTransaction transaction) {
  final t = Translations.of(pageContext);

  showModalBottomSheet(
    context: pageContext,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return ModalContainer(
        title: t.transaction.next_payments.accept_dialog_title,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...(getPayActions(pageContext, transaction).map(
              (e) => ListTile(
                leading: Icon(e.icon),
                title: Text(e.label),
                enabled: e.onClick != null,
                onTap: e.onClick == null
                    ? null
                    : () {
                        RouteUtils.popRoute();
                        e.onClick!();
                      },
              ),
            )),
            if (transaction.recurrentInfo.isRecurrent &&
                transaction.isOnLastPayment)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 14,
                      weight: 200,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        t.recurrent_transactions.details.last_payment_info,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    },
  );
}
