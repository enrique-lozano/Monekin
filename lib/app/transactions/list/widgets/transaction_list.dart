import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list_date_separator.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

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
    this.separateUpcoming = true,
    this.scrollController,
    this.tileBuilder,
    this.listPadding = const EdgeInsets.all(0),
  });

  final TransactionFilterSet filters;

  final TransactionQueryOrderBy? orderBy;
  final int limit;

  /// Widget to display while the transactions are loading
  final Widget onLoading;

  /// Widget to display if there are no transactions to display based on the passed params
  final Widget onEmptyList;

  final bool showGroupDivider;

  final ScrollController? scrollController;

  final bool isScrollable;

  /// Whether to pull the transactions that are not settled yet (future ones,
  /// recurrency rules and the pending ones) into their own section above the
  /// list. Only takes effect when [isScrollable] is `true`. Defaults to `true`
  final bool separateUpcoming;

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
      final scrollPosition = listScrollController.position;

      if (listScrollController.offset >= scrollPosition.maxScrollExtent &&
          !scrollPosition.outOfRange) {
        currentPage += 1;

        if (mounted) {
          setState(() {});
        }
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
      showDateTime: !widget.showGroupDivider,
      heroTag: null,
      applySwipeActions: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isScrollable || !widget.separateUpcoming) {
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

          if (snapshot.data!.isEmpty) {
            return widget.onEmptyList;
          }

          return buildFlatList(snapshot.data!);
        },
      );
    }

    return StreamBuilder(
      stream: Rx.combineLatest2(
        TransactionService.instance.getTransactionsBySettlement(
          settled: false,
          filters: widget.filters,
        ),
        TransactionService.instance.getTransactionsBySettlement(
          settled: true,
          filters: widget.filters,
          orderBy: widget.orderBy,
          limit: widget.limit * currentPage,
        ),
        (upcoming, settled) => (upcoming: upcoming, settled: settled),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return widget.onLoading;
        }

        final (:upcoming, :settled) = snapshot.data!;

        if (upcoming.isEmpty && settled.isEmpty) {
          return widget.onEmptyList;
        }

        return buildSplittedList(upcoming: upcoming, settled: settled);
      },
    );
  }

  Widget buildFlatList(List<MoneyTransaction> transactions) {
    return ListView.separated(
      physics: widget.isScrollable
          ? null
          : const NeverScrollableScrollPhysics(),
      itemCount: transactions.length + 1,
      controller: listScrollController,
      padding: widget.listPadding,
      shrinkWrap: !widget.isScrollable,
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

  /// Renders the [settled] transactions below the viewport anchor and the
  /// [upcoming] ones above it, so that the user can scroll up to reach the
  /// payments that are still to be made.
  ///
  /// [upcoming] must be sorted oldest-first: within a sliver placed before the
  /// anchor, the child at index 0 is the one laid out closest to it.
  Widget buildSplittedList({
    required List<MoneyTransaction> upcoming,
    required List<MoneyTransaction> settled,
  }) {
    const centerKey = ValueKey('center-list');

    return CustomScrollView(
      controller: listScrollController,
      center: centerKey,
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (upcoming.isNotEmpty)
          SliverPadding(
            padding: widget.listPadding != null
                ? widget.listPadding!.copyWith(bottom: 8)
                : EdgeInsets.zero,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final transaction = upcoming[index];

                bool showHeader = false;
                if (widget.showGroupDivider) {
                  if (index == upcoming.length - 1) {
                    showHeader = true;
                  } else {
                    final nextTransaction = upcoming[index + 1];
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
              }, childCount: upcoming.length),
            ),
          ),
        SliverPadding(
          padding: widget.listPadding != null
              ? widget.listPadding!.copyWith(top: 0)
              : EdgeInsets.zero,
          key: centerKey,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (upcoming.isNotEmpty) {
                if (index == 0) {
                  return _UpcomingTransactionsBanner(count: upcoming.length);
                }
                index = index - 1;
              }

              if (index >= settled.length) return null;

              final transaction = settled[index];

              bool showHeader = false;
              if (widget.showGroupDivider) {
                if (index == 0) {
                  showHeader = true;
                } else {
                  final prevTransaction = settled[index - 1];
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
            }, childCount: settled.length + (upcoming.isNotEmpty ? 1 : 0)),
          ),
        ),
      ],
    );
  }
}

class _UpcomingTransactionsBanner extends StatelessWidget {
  const _UpcomingTransactionsBanner({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

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
            t.transaction.list.upcoming(n: count),
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
