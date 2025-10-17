import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';

class TransactionListComponent extends StatefulWidget {
  const TransactionListComponent({
    super.key,
    required this.filters,
    this.showGroupDivider = true,
    this.periodicityInfo,
    required this.prevPage,
    this.orderBy,
    this.limit = 40,
    this.onLoading = const Column(children: [LinearProgressIndicator()]),
    required this.onEmptyList,
    required this.heroTagBuilder,
    this.onLongPress,
    this.onTap,
    this.selectedTransactions = const [],
    this.onTransactionsLoaded,
    this.onScrollChange,
  });

  final TransactionFilters filters;

  final TransactionQueryOrderBy? orderBy;
  final int limit;

  /// Widget to display while the transactions are loading
  final Widget onLoading;

  /// Widget to display if there are no transactions to display based on the passed params
  final Widget onEmptyList;

  final bool showGroupDivider;

  /// If defined, display info about the periodicity of the recurrent transactions, and the days to the next payment. Will show the amount of the recurrency based on the specified periodicity
  final Periodicity? periodicityInfo;

  final Widget prevPage;

  final Object? Function(MoneyTransaction tr)? heroTagBuilder;

  final void Function(ScrollController controller)? onScrollChange;

  /// Action to trigger when a transaction tile is long pressed. If `null`,
  /// the tile will display a modal with some quick actions for
  /// this transaction
  final void Function(MoneyTransaction tr)? onLongPress;

  /// Action to trigger when a transaction tile is pressed. If `null`,
  /// the tile will redirect to the `transaction-details-page`
  final void Function(MoneyTransaction tr)? onTap;

  final void Function({List<MoneyTransaction> allTransactions})?
  onTransactionsLoaded;

  final List<MoneyTransaction> selectedTransactions;

  @override
  State<TransactionListComponent> createState() =>
      _TransactionListComponentState();
}

class _TransactionListComponentState extends State<TransactionListComponent> {
  ScrollController listScrollController = ScrollController();

  int currentPage = 1;
  bool isEnabled = true;

  @override
  void initState() {
    super.initState();

    listScrollController.addListener(() {
      if (listScrollController.offset >=
              listScrollController.position.maxScrollExtent &&
          !listScrollController.position.outOfRange) {
        currentPage += 1;
        setState(() {});
      }

      widget.onScrollChange?.call(listScrollController);
    });
  }

  Widget dateSeparator(BuildContext context, DateTime date) {
    return Container(
      padding: const EdgeInsets.only(right: 12),
      margin: const EdgeInsets.only(top: 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 12, 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(120),
            topRight: Radius.circular(120),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat.yMMMMd().format(date)),
            StreamBuilder(
              initialData: 0.0,
              stream: AccountService.instance.getAccountsBalance(
                filters: widget.filters.copyWith(
                  minDate: DateTime(date.year, date.month, date.day),
                  maxDate: DateTime(date.year, date.month, date.day + 1),
                ),
              ),
              builder: (context, snapshot) {
                final partialBalance = snapshot.data!;

                return CurrencyDisplayer(
                  amountToConvert: partialBalance,
                  integerStyle: Theme.of(context).textTheme.labelMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TransactionService.instance.getTransactions(
        filters: widget.filters,
        limit: widget.limit * currentPage,
        orderBy: widget.orderBy,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return widget.onLoading;
        }

        final transactions = snapshot.data!;

        if (widget.onTransactionsLoaded != null) {
          widget.onTransactionsLoaded!(allTransactions: transactions);
        }

        if (transactions.isEmpty) {
          return widget.onEmptyList;
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: transactions.length + 1,
          controller: listScrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (transactions.isEmpty) return Container();

            if (index == 0) {
              if (!widget.showGroupDivider) return Container();
              return dateSeparator(context, transactions[0].date);
            }

            final transaction = transactions[index - 1];

            final heroTag = widget.heroTagBuilder != null
                ? widget.heroTagBuilder!(transaction)
                : null;

            return TransactionListTile(
              transaction: transaction,
              prevPage: widget.prevPage,
              periodicityInfo: widget.periodicityInfo,
              showDate: !widget.showGroupDivider,
              showTime: widget.showGroupDivider,
              heroTag: heroTag,
              onTap: widget.onTap == null
                  ? null
                  : (() => widget.onTap!(transaction)),
              onLongPress: widget.onLongPress == null
                  ? null
                  : (() => widget.onLongPress!(transaction)),
              isSelected: widget.selectedTransactions.any(
                (element) => element.id == transaction.id,
              ),
              applySwipeActions: true,
            );
          },
          separatorBuilder: (context, index) {
            if (index == 0 ||
                transactions.isEmpty ||
                index >= transactions.length) {
              return Container();
            }

            if (!widget.showGroupDivider ||
                index >= 1 &&
                    DateUtils.isSameDay(
                      transactions[index - 1].date,
                      transactions[index].date,
                    )) {
              // Separator between transactions in the same group
              return Container();
            }

            // Group separator
            return dateSeparator(context, transactions[index].date);
          },
        );
      },
    );
  }
}
