import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';

void showTransactionSelectorModal(
  BuildContext context, {
  required void Function(MoneyTransaction) onTransactionSelected,
  TransactionFilterSet initialFilters = const TransactionFilterSet(),
}) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => TransactionSelectorModal(
      onTransactionSelected: onTransactionSelected,
      initialFilters: initialFilters,
    ),
  );
}

class TransactionSelectorModal extends StatefulWidget {
  const TransactionSelectorModal({
    super.key,
    required this.onTransactionSelected,
    this.initialFilters = const TransactionFilterSet(),
  });

  final void Function(MoneyTransaction) onTransactionSelected;
  final TransactionFilterSet initialFilters;

  @override
  State<TransactionSelectorModal> createState() =>
      _TransactionSelectorModalState();
}

class _TransactionSelectorModalState extends State<TransactionSelectorModal> {
  late TransactionFilterSet _filters;

  @override
  void initState() {
    super.initState();
    _filters = widget.initialFilters;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.9,
      minChildSize: 0.6,
      initialChildSize: 0.85,
      builder: (context, scrollController) {
        return ModalContainer(
          title: 'Select a transaction',
          body: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  filled: false,
                  isDense: false,
                  hintText: 'Search for a transaction...',
                  labelText: 'Tap to search',
                  floatingLabelStyle: TextStyle(height: -0.0005),
                  prefixIcon: Icon(Icons.search),
                  border: UnderlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _filters = _filters.copyWith(searchValue: value);
                  });
                },
              ),
              Expanded(
                child: TransactionListComponent(
                  filters: _filters,
                  isScrollable: true,
                  scrollController: scrollController,
                  showGroupDivider: false,
                  listPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 20,
                  ),
                  onEmptyList: const Center(
                    child: Text('No transactions found'),
                  ),
                  tileBuilder: (transaction) {
                    return TransactionListTile(
                      transaction: transaction,
                      heroTag: null,
                      onTap: () {
                        RouteUtils.popRoute();
                        widget.onTransactionSelected(transaction);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
