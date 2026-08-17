// ignore_for_file: unnecessary_string_interpolations, prefer_single_quotes

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/pages/backup/export_page.dart';
import 'package:monekin/app/transactions/list/widgets/bulk_edit_transaction_modal.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/filter_row_indicator.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/filter_side_pane.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_sheet_modal.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key, this.filters});

  final TransactionFilterSet? filters;

  @override
  State<TransactionsPage> createState() => TransactionsPageState();
}

class TransactionsPageState extends State<TransactionsPage> {
  late TransactionFilterSet filters;

  bool searchActive = false;

  FocusNode searchFocusNode = FocusNode();
  final searchController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  List<MoneyTransaction> selectedTransactions = [];

  bool filterPaneExpanded = false;

  void resetScroll() {
    if (listScrollController.hasClients) {
      listScrollController.jumpTo(0);
    }
  }

  @override
  void initState() {
    super.initState();

    filters = widget.filters ?? const TransactionFilterSet();

    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus && searchController.text.isEmpty) {
        setState(() {
          searchActive = false;
        });
      }
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  bool get canPop => !searchActive && selectedTransactions.isEmpty;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDesktop = BreakPoint.of(context).isLargerThan(BreakpointID.md);

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (selectedTransactions.isNotEmpty) {
          cleanSelectedTransactions();
          return;
        }

        if (searchActive ||
            searchController.text.isNotEmpty ||
            searchFocusNode.hasFocus) {
          if (searchFocusNode.hasFocus) {
            searchFocusNode.unfocus();
          }

          closeSearch();

          return;
        }
      },
      child: PageFramework(
        title: !isDesktop && selectedTransactions.isNotEmpty
            ? t.transaction.list.selected_short(n: selectedTransactions.length)
            : t.transaction.display(n: 10),
        leading: !isDesktop && (selectedTransactions.isNotEmpty || searchActive)
            ? IconButton(
                onPressed: selectedTransactions.isNotEmpty
                    ? cleanSelectedTransactions
                    : closeSearch,
                icon: const Icon(Icons.close),
              )
            : null,
        appBarActions: _buildAppBarActions(t, isDesktop),
        appBarBackgroundColor: !isDesktop && selectedTransactions.isNotEmpty
            ? Theme.of(context).colorScheme.primary
            : null,
        appBarForegroundColor: !isDesktop && selectedTransactions.isNotEmpty
            ? Theme.of(context).colorScheme.onPrimary
            : null,
        floatingActionButton: ifIsInTabs(context)
            ? null
            : NewTransactionButton(scrollController: listScrollController),
        body: Row(
          children: [
            Expanded(child: _buildListArea(t, context, isDesktop)),
            if (isDesktop)
              FilterSidePane(
                filters: filters,
                onChanged: (newFilters) {
                  setState(() {
                    filters = newFilters;
                  });
                },
                expanded: filterPaneExpanded,
                onToggle: () {
                  setState(() {
                    filterPaneExpanded = !filterPaneExpanded;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildListArea(Translations t, BuildContext context, bool isDesktop) {
    return Column(
      children: [
        AnimatedExpanded(
          expand: filters.hasFilter && !isDesktop,
          duration: const Duration(milliseconds: 250),
          child: FilterRowIndicator(
            filters: filters.copyWith(searchValue: searchController.text),
            onChange: (newFilters) {
              setState(() {
                filters = newFilters;
              });
            },
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            // A bulk selection turns the summary bar into the selection
            // indicator (with actions on desktop), keeping the page app bar
            // untouched on desktop.
            if (selectedTransactions.isNotEmpty) {
              return _buildSelectionSummary(t, context);
            }

            // The income/expense breakdown only appears when there's plenty of
            // horizontal room (very wide layouts).
            final showBreakdown = constraints.maxWidth >= 720;

            return showBreakdown
                ? _buildBreakdownSummary(t, context)
                : _buildCompactSummary(t, context);
          },
        ),
        Expanded(
          child: TransactionListComponent(
            scrollController: listScrollController,
            isScrollable: true,
            listPadding: const EdgeInsets.only(
              bottom: 64,
            ).withSafeBottom(context),
            tileBuilder: (tr) {
              final isWideLayout = !AppUtils.isMobileLayout(context);
              // The checkbox is a pointer-first affordance: only offer it
              // when there's a mouse/trackpad. Touch devices keep the
              // long-press-to-select gesture (even in the table layout).
              final useCheckbox = isWideLayout && AppUtils.hasPointerInput;
              final isSelected = selectedTransactions.any(
                (element) => element.id == tr.id,
              );

              return TransactionListTile(
                transaction: tr,
                heroTag: 'transactions-page__tr-icon-${tr.id}',
                tableLayout: isWideLayout,
                selectionActive: selectedTransactions.isNotEmpty,
                onSelectedChanged: useCheckbox
                    ? (_) => toggleTransaction(tr)
                    : null,
                onLongPress: useCheckbox || selectedTransactions.isNotEmpty
                    ? null
                    : () => toggleTransaction(tr),
                onTap: useCheckbox || selectedTransactions.isEmpty
                    ? null
                    : () => toggleTransaction(tr),
                isSelected: isSelected,
                showDateTime: false,
                applySwipeActions: !isWideLayout,
              );
            },
            filters: filters.copyWith(searchValue: searchController.text),
            onEmptyList: _buildEmptyState(t, context),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(Translations t, BuildContext context) {
    final effectiveFilters = filters.copyWith(
      searchValue: searchController.text,
    );

    if (!effectiveFilters.hasFilter) {
      return NoResults(
        title: t.general.empty_warn,
        description: t.transaction.list.empty,
      );
    }

    final filterCount = effectiveFilters.activeFilterCount;
    final hasDateFilter =
        effectiveFilters.minDate != null || effectiveFilters.maxDate != null;

    return StreamBuilder<int>(
      stream: TransactionService.instance.countTransactions(
        filters: const TransactionFilterSet(),
      ),
      builder: (context, snapshot) {
        final totalWithoutFilters = snapshot.data ?? 0;

        return NoResults(
          title: t.transaction.list.filtered_empty.title,
          padding: EdgeInsets.only(
            bottom: MediaQuery.sizeOf(context).height * 0.4 > 400 ? 80 : 40,
            right: MediaQuery.sizeOf(context).width * 0.4 > 400 ? 80 : 40,
            left: MediaQuery.sizeOf(context).width * 0.4 > 400 ? 80 : 40,
          ),
          description: totalWithoutFilters > 0
              ? t.transaction.list.filtered_empty.description(
                  n: totalWithoutFilters,
                )
              : t.transaction.list.searcher_no_results,
          bottom: Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: _clearAllFilters,
                icon: const Icon(Icons.close_rounded, size: 18),
                label: Text(
                  t.transaction.list.filtered_empty.clear(n: filterCount),
                ),
              ),
              if (hasDateFilter)
                OutlinedButton.icon(
                  onPressed: _expandDateRange,
                  icon: const Icon(Icons.event_rounded, size: 18),
                  label: Text(t.transaction.list.filtered_empty.expand_dates),
                ),
            ],
          ),
        );
      },
    );
  }

  void _clearAllFilters() {
    setState(() {
      filters = const TransactionFilterSet();
      searchController.text = '';
    });
  }

  void _expandDateRange() {
    setState(() {
      filters = filters.copyWithNull(minDate: true, maxDate: true);
    });
  }

  Color _summaryLineColor(BuildContext context) =>
      Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5);

  Widget _summaryCardShell({
    required bool loading,
    required Widget child,
    required bool flat,
    bool selected = false,
  }) {
    final colors = Theme.of(context).colorScheme;

    if (flat) {
      // Desktop: a flat, square-cornered bar integrated into the page, with a
      // bottom border acting as the separator (no elevated/rounded card).
      // While a selection is active it takes a light primary tone.
      return Skeletonizer(
        enabled: loading,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected ? colors.primary.withValues(alpha: 0.08) : null,
            border: Border(
              bottom: BorderSide(
                color: selected
                    ? colors.primary.withValues(alpha: 0.4)
                    : _summaryLineColor(context),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: child,
          ),
        ),
      );
    }

    return Skeletonizer(
      enabled: loading,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            width: 1,
            color: selected ? colors.primary : Colors.transparent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
          child: child,
        ),
      ),
    );
  }

  Widget _summaryColumnDivider() {
    return Container(
      width: 1,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: _summaryLineColor(context),
    );
  }

  Widget _summaryColumn(
    BuildContext context, {
    required String label,
    required Widget value,
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        value,
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }

  Widget _summaryAmount(
    BuildContext context, {
    required double amount,
    Color? color,
    TextStyle? style,
  }) {
    return DefaultTextStyle(
      style:
          style ??
          Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
      child: CurrencyDisplayer(amountToConvert: amount),
    );
  }

  /// The default summary bar: a "showing N movements" column on the left and
  /// the filter balance on the right.
  Widget _buildCompactSummary(Translations t, BuildContext context) {
    final f = filters.copyWith(searchValue: searchController.text);

    return StreamBuilder(
      stream: Rx.combineLatest2(
        TransactionService.instance.countTransactions(filters: f),
        TransactionService.instance.getTransactionsValueBalance(filters: f),
        (int a, double b) => (count: a, value: b),
      ),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final theme = Theme.of(context);
        final count = data?.count ?? 0;
        final balance = data?.value ?? 0;

        return _summaryCardShell(
          loading: data == null,
          flat: !AppUtils.isMobileLayout(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _summaryColumn(
                context,
                label: t.transaction.display(n: count),
                value: Text(
                  count.toStringAsFixed(0),
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _summaryColumn(
                context,
                alignment: CrossAxisAlignment.end,
                label: t.general.balance,
                value: _summaryAmount(
                  context,
                  amount: balance,
                  color:
                      (balance >= 0
                              ? TransactionType.income
                              : TransactionType.expense)
                          .color(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Replaces the summary bar while a bulk selection is active: it shows how
  /// many transactions are selected (and their balance vs the shown total). On
  /// desktop it also carries the bulk actions and keeps the page app bar put;
  /// on mobile the actions stay in the selection app bar.
  Widget _buildSelectionSummary(Translations t, BuildContext context) {
    final f = filters.copyWith(searchValue: searchController.text);
    final isMobile = AppUtils.isMobileLayout(context);
    final selCount = selectedTransactions.length;
    final selSum = selectedTransactions
        .map((e) => e.getCurrentBalanceInPreferredCurrency())
        .sum;

    return StreamBuilder(
      stream: Rx.combineLatest2(
        TransactionService.instance.countTransactions(filters: f),
        TransactionService.instance.getTransactionsValueBalance(filters: f),
        (int a, double b) => (count: a, value: b),
      ),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final theme = Theme.of(context);

        return _summaryCardShell(
          loading: false,
          flat: !isMobile,
          selected: true,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.transaction.list.selected_of(
                        n: selCount,
                        total: data?.count ?? 0,
                      ),
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    DefaultTextStyle(
                      style: theme.textTheme.labelMedium!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultTextStyle.merge(
                            style: TextStyle(
                              color:
                                  (selSum >= 0
                                          ? TransactionType.income
                                          : TransactionType.expense)
                                      .color(context),
                              fontWeight: FontWeight.bold,
                            ),
                            child: CurrencyDisplayer(
                              amountToConvert: selSum,
                              showDecimals: false,
                            ),
                          ),
                          Text(' ${t.general.of} '),
                          CurrencyDisplayer(
                            amountToConvert: data?.value ?? 0,
                            showDecimals: false,
                          ),
                          Text(' ${t.transaction.list.shown}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _bulkEditSelected,
                  icon: const Icon(Icons.edit_rounded, size: 18),
                  label: Text(t.ui_actions.edit),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _bulkDeleteSelected,
                  icon: const Icon(Icons.delete_rounded, size: 18),
                  label: Text(t.ui_actions.delete),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: t.ui_actions.close,
                  onPressed: cleanSelectedTransactions,
                  icon: const Icon(Icons.close),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildBreakdownSummary(Translations t, BuildContext context) {
    final f = filters.copyWith(searchValue: searchController.text);

    return StreamBuilder(
      stream: Rx.combineLatest4(
        TransactionService.instance.countTransactions(filters: f),
        TransactionService.instance.getTransactionsValueBalance(filters: f),
        TransactionService.instance.getTransactionsValueBalance(
          filters: f.copyWith(transactionTypes: [TransactionType.income]),
        ),
        TransactionService.instance.getTransactionsValueBalance(
          filters: f.copyWith(transactionTypes: [TransactionType.expense]),
        ),
        (int count, double balance, double income, double expense) =>
            (count: count, balance: balance, income: income, expense: expense),
      ),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final textTheme = Theme.of(context).textTheme;

        return _summaryCardShell(
          loading: data == null,
          flat: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _summaryColumn(
                  context,
                  label: t.transaction.display(n: data?.count ?? 0),
                  value: Text(
                    '${data?.count ?? 0}',
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _summaryColumnDivider(),
              _summaryColumn(
                context,
                label: TransactionType.income.displayName(
                  context,
                  plural: true,
                ),
                value: _summaryAmount(
                  context,
                  amount: data?.income ?? 0,
                  color: TransactionType.income.color(context),
                ),
              ),
              _summaryColumnDivider(),
              _summaryColumn(
                context,
                label: TransactionType.expense.displayName(
                  context,
                  plural: true,
                ),
                value: _summaryAmount(
                  context,
                  amount: data?.expense ?? 0,
                  color: TransactionType.expense.color(context),
                ),
              ),
              _summaryColumnDivider(),
              _summaryColumn(
                context,
                label: t.general.balance,
                value: _summaryAmount(
                  context,
                  amount: data?.balance ?? 0,
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void closeSearch() {
    setState(() {
      searchController.text = "";
      searchFocusNode.unfocus();
    });
  }

  List<Widget> _buildAppBarActions(Translations t, bool isDesktop) {
    if (!isDesktop && selectedTransactions.isNotEmpty) {
      return [
        IconButton(
          tooltip: t.ui_actions.edit,
          onPressed: _bulkEditSelected,
          icon: const Icon(Icons.edit_rounded),
        ),
        IconButton(
          tooltip: t.ui_actions.delete,
          onPressed: _bulkDeleteSelected,
          icon: const Icon(Icons.delete_rounded),
        ),
      ];
    }

    if (!isDesktop) {
      if (searchActive) {
        return [
          SizedBox(
            width: MediaQuery.sizeOf(context).width - 72,
            child: TextField(
              controller: searchController,
              focusNode: searchFocusNode,
              decoration: InputDecoration(
                hintText: t.transaction.list.searcher_placeholder,
                border: const UnderlineInputBorder(),
                filled: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ];
      }

      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            searchActive = true;
            searchFocusNode.requestFocus();
            setState(() {});
          },
        ),
        IconButton(
          onPressed: () async {
            final modalRes = await openFilterSheetModal(
              context,
              FilterSheetModal(preselectedFilter: filters),
            );

            if (modalRes != null) {
              setState(() => filters = modalRes);
            }
          },
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ];
    }

    final theme = Theme.of(context);

    return [
      SizedBox(
        width: 260,
        height: 40,
        child: TextField(
          controller: searchController,
          onChanged: (_) => setState(() {}),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: t.transaction.list.searcher_placeholder,
            prefixIcon: const Icon(Icons.search_rounded, size: 20),
            isDense: true,
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHigh,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(499),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      FilledButton.tonalIcon(
        onPressed: () =>
            setState(() => filterPaneExpanded = !filterPaneExpanded),
        icon: Badge(
          isLabelVisible: filters.hasFilter,
          child: const Icon(Icons.filter_alt_outlined, size: 20),
        ),
        label: Text(t.general.filters),
      ),
      const SizedBox(width: 8),
      IconButton(
        tooltip: t.backup.export.title,
        onPressed: () => RouteUtils.showResponsiveForm(const ExportDataPage()),
        icon: const Icon(Icons.file_download_outlined),
      ),
      const SizedBox(width: 8),
    ];
  }

  void _bulkEditSelected() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => BulkEditTransactionModal(
        transactionsToEdit: selectedTransactions,
        onSuccess: cleanSelectedTransactions,
      ),
    );
  }

  void _bulkDeleteSelected() {
    confirmDialog(
      context,
      dialogTitle: selectedTransactions.length <= 1
          ? t.transaction.delete
          : t.transaction.delete_multiple,
      confirmationText: t.ui_actions.confirm,
      showCancelButton: true,
      icon: Icons.delete_rounded,
      contentParagraphs: [
        Text(
          selectedTransactions.length <= 1
              ? t.transaction.delete_warning_message
              : t.transaction.delete_multiple_warning_message(
                  x: selectedTransactions.length,
                ),
        ),
      ],
    ).then((value) {
      if (value != true) {
        return;
      }

      final futures = selectedTransactions.map(
        (e) => TransactionService.instance.deleteTransaction(e.id),
      );

      Future.wait(futures)
          .then((value) {
            MonekinSnackbar.success(
              SnackbarParams(
                selectedTransactions.length <= 1
                    ? t.transaction.delete_success
                    : t.transaction.delete_multiple_success(
                        x: selectedTransactions.length,
                      ),
              ),
            );

            cleanSelectedTransactions();
          })
          .catchError((err) {
            MonekinSnackbar.error(SnackbarParams.fromError(err));
          });
    });
  }

  /// Clear all the selected transactions (remove the selection)
  void cleanSelectedTransactions() {
    setState(() {
      selectedTransactions = [];
    });
  }

  void toggleTransaction(MoneyTransaction tr) {
    HapticFeedback.lightImpact();

    if (selectedTransactions.any((element) => element.id == tr.id)) {
      selectedTransactions.removeWhere((element) => element.id == tr.id);
    } else {
      selectedTransactions.add(tr);
    }

    setState(() {});
  }
}
