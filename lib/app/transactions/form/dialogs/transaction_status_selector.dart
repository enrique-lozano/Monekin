import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<ModalResult<TransactionStatus>?> showTransactioStatusModal(
  BuildContext context, {
  required TransactionStatus? initialStatus,
}) {
  return showModalBottomSheet<ModalResult<TransactionStatus>>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return TransactionStatusSelector(initialTransactionStatus: initialStatus);
    },
  );
}

class TransactionStatusSelector extends StatelessWidget {
  const TransactionStatusSelector({
    super.key,
    required this.initialTransactionStatus,
  });

  final TransactionStatus? initialTransactionStatus;

  Widget buildTransactionButton(BuildContext context, TransactionStatus? e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: _TransactionStatusButtonSelector(
        status: e,
        isSelected: e?.index == initialTransactionStatus?.index,
        onClick: () {
          RouteUtils.popRoute(ModalResult(e));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.85,
      minChildSize: 0.65,
      initialChildSize: 0.85,
      builder: (context, sc) => ModalContainer(
        title: t.transaction.status.display_long,
        responseToKeyboard: false,
        body: SingleChildScrollView(
          controller: sc,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              buildTransactionButton(context, null),
              ...TransactionStatus.values.map(
                (e) => buildTransactionButton(context, e),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionStatusButtonSelector extends StatelessWidget {
  const _TransactionStatusButtonSelector({
    super.key,
    required this.status,
    required this.onClick,
    required this.isSelected,
  });

  final TransactionStatus? status;

  final bool isSelected;

  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return OutlinedButtonStacked(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      text: status.displayName(context),
      onTap: onClick,
      afterWidget: Text(status.description(context)),
      color: status?.color,
      iconData: status.icon,
      filled: isSelected,
      alignLeft: true,
      alignBeside: true,
    );
  }
}
