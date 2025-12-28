import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_date_separator.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';

class TransactionListComponent extends StatefulWidget {
  const TransactionListComponent({
    super.key,
    required this.filters,
    this.showGroupDivider = true,
    this.orderBy,
    this.limit = 40,
    this.onLoading = const Column(children: [LinearProgressIndicator()]),
    required this.onEmptyList,
    this.isScrollable = false,
    this.scrollController,
    this.tileBuilder,
    this.listPadding = const EdgeInsets.all(0),
  });

  final TransactionFilters filters;

  final TransactionQueryOrderBy? orderBy;
  final int limit;

  /// Widget to display while the transactions are loading
  final Widget onLoading;

  /// Widget to display if there are no transactions to display based on the passed params
  final Widget onEmptyList;

  final bool showGroupDivider;

  final ScrollController? scrollController;

  final bool isScrollable;

  final TransactionListTile Function(MoneyTransaction transaction)? tileBuilder;

  final EdgeInsets? listPadding;

  @override
  State<TransactionListComponent> createState() =>
      TransactionListComponentState();
}

class TransactionListComponentState extends State<TransactionListComponent> {
  late ScrollController listScrollController;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    listScrollController = widget.scrollController ?? ScrollController();

    listScrollController.addListener(() {
      if (listScrollController.offset >=
              listScrollController.position.maxScrollExtent &&
          !listScrollController.position.outOfRange) {
        currentPage += 1;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      listScrollController.dispose();
    }

    super.dispose();
  }

  TransactionListTile buildTile(MoneyTransaction transaction) {
    if (widget.tileBuilder != null) {
      return widget.tileBuilder!(transaction);
    }

    return TransactionListTile(
      transaction: transaction,
      showDate: !widget.showGroupDivider,
      showTime: widget.showGroupDivider,
      heroTag: null,
      applySwipeActions: true,
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

        if (transactions.isEmpty) {
          return widget.onEmptyList;
        }

        if (!widget.isScrollable) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length + 1,
            controller: listScrollController,
            padding: widget.listPadding,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                if (!widget.showGroupDivider) return Container();

                return TransactionListDateSeparator(
                  filters: widget.filters,
                  date: transactions[0].date,
                );
              }

              final transaction = transactions[index - 1];
              return buildTile(transaction);
            },
            separatorBuilder: (context, index) {
              if (index == 0 || index >= transactions.length) {
                return const SizedBox.shrink();
              }

              if (!widget.showGroupDivider ||
                  index >= 1 &&
                      DateUtils.isSameDay(
                        transactions[index - 1].date,
                        transactions[index].date,
                      )) {
                // Separator between transactions in the same group
                return const SizedBox.shrink();
              }

              return TransactionListDateSeparator(
                filters: widget.filters,
                date: transactions[index].date,
              );
            },
          );
        }

        final now = DateTime.now();
        final futureTransactions = transactions
            .where((t) => t.date.isAfter(now))
            .toList();
        final pastTransactions = transactions
            .where((t) => !t.date.isAfter(now))
            .toList();

        // Reverse future transactions so the one closest to now is at the bottom (index 0 of the sliver)
        final reversedFutureTransactions = futureTransactions.reversed.toList();

        const centerKey = ValueKey('center-list');

        return CustomScrollView(
          controller: listScrollController,
          center: centerKey,
          physics: const BouncingScrollPhysics(),
          slivers: [
            if (futureTransactions.isNotEmpty)
              SliverPadding(
                padding: widget.listPadding != null
                    ? widget.listPadding!.copyWith(bottom: 8)
                    : EdgeInsets.zero,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final transaction = reversedFutureTransactions[index];

                    bool showHeader = false;
                    if (widget.showGroupDivider) {
                      if (index == reversedFutureTransactions.length - 1) {
                        showHeader = true;
                      } else {
                        final nextTransaction =
                            reversedFutureTransactions[index + 1];
                        if (!DateUtils.isSameDay(
                          transaction.date,
                          nextTransaction.date,
                        )) {
                          showHeader = true;
                        }
                      }
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (showHeader)
                          TransactionListDateSeparator(
                            filters: widget.filters,
                            date: transaction.date,
                          ),
                        Opacity(opacity: 0.5, child: buildTile(transaction)),
                      ],
                    );
                  }, childCount: reversedFutureTransactions.length),
                ),
              ),
            SliverPadding(
              padding: widget.listPadding != null
                  ? widget.listPadding!.copyWith(top: 0)
                  : EdgeInsets.zero,
              key: centerKey,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (futureTransactions.isNotEmpty) {
                      if (index == 0) {
                        return _FutureTransactionsBanner(
                          count: futureTransactions.length,
                        );
                      }
                      index = index - 1;
                    }

                    if (index >= pastTransactions.length) return null;

                    final transaction = pastTransactions[index];

                    bool showHeader = false;
                    if (widget.showGroupDivider) {
                      if (index == 0) {
                        showHeader = true;
                      } else {
                        final prevTransaction = pastTransactions[index - 1];
                        if (!DateUtils.isSameDay(
                          transaction.date,
                          prevTransaction.date,
                        )) {
                          showHeader = true;
                        }
                      }
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (showHeader)
                          TransactionListDateSeparator(
                            filters: widget.filters,
                            date: transaction.date,
                          ),
                        buildTile(transaction),
                      ],
                    );
                  },
                  childCount:
                      pastTransactions.length +
                      (futureTransactions.isNotEmpty ? 1 : 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FutureTransactionsBanner extends StatelessWidget {
  const _FutureTransactionsBanner({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final arrowUpIcon = Icon(
      Icons.keyboard_arrow_up_rounded,
      size: 16,
      color: Theme.of(context).colorScheme.primary,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 2),
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          arrowUpIcon,
          const Spacer(),
          Text(
            '$count upcoming transactions',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
          arrowUpIcon,
        ],
      ),
    );
  }
}
