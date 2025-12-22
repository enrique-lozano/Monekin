// ignore_for_file: unnecessary_string_interpolations, prefer_single_quotes

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/layout/page_context.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/widgets/bulk_edit_transaction_modal.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/filter_row_indicator.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/filter_sheet_modal.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key, this.filters});

  final TransactionFilters? filters;

  @override
  State<TransactionsPage> createState() => TransactionsPageState();
}

class TransactionsPageState extends State<TransactionsPage> {
  late TransactionFilters filters;

  FocusNode searchFocusNode = FocusNode();
  final searchController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  List<MoneyTransaction> selectedTransactions = [];

  @override
  void initState() {
    super.initState();

    filters = widget.filters ?? const TransactionFilters();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  bool get searchActive =>
      searchController.text.isNotEmpty || searchFocusNode.hasFocus;

  bool get canPop => !searchActive && selectedTransactions.isEmpty;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        print("POP SCOPE FROM TRANSACTIONS PAGE");

        if (selectedTransactions.isNotEmpty) {
          cleanSelectedTransactions();
          return;
        }

        if (searchActive) {
          if (searchFocusNode.hasFocus) {
            searchFocusNode.unfocus();
          }

          closeSearch();

          return;
        }
      },
      child: PageFramework(
        title: t.transaction.display(n: 10),
        appBarBuilder: (_, _, _) => selectedTransactions.isNotEmpty
            ? selectedTransactionsAppbar()
            : transactionsPageDefaultAppBar(t, context),
        floatingActionButton: ifIsInTabs(context)
            ? null
            : NewTransactionButton(scrollController: listScrollController),
        body: Column(
          children: [
            if (filters.hasFilter) ...[
              FilterRowIndicator(
                filters: filters.copyWith(searchValue: searchController.text),
                onChange: (newFilters) {
                  setState(() {
                    filters = newFilters;
                  });
                },
              ),
            ],
            StreamBuilder(
              stream: Rx.combineLatest2(
                TransactionService.instance.countTransactions(
                  filters: filters.copyWith(searchValue: searchController.text),
                ),
                TransactionService.instance.getTransactionsValueBalance(
                  filters: filters.copyWith(searchValue: searchController.text),
                ),
                (a, b) => (count: a, value: b),
              ),
              builder: (context, snapshot) {
                final trCountAndBalance = snapshot.data;

                const smallerTextStyle = TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                );

                return Skeletonizer(
                  enabled: trCountAndBalance == null,
                  child: Card(
                    elevation: 2,
                    //color: Theme.of(context).colorScheme.primary,
                    margin: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 14,
                      ),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.titleMedium!,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (trCountAndBalance == null)
                              Text("XX Transactions"),
                            if (trCountAndBalance != null)
                              Text.rich(
                                TextSpan(
                                  text: selectedTransactions.isNotEmpty
                                      ? ('${selectedTransactions.length.toStringAsFixed(0)}')
                                      : '',
                                  children: [
                                    TextSpan(
                                      text:
                                          '${selectedTransactions.isNotEmpty ? ' / ' : ''}${trCountAndBalance.count} ',
                                      style: selectedTransactions.isNotEmpty
                                          ? smallerTextStyle
                                          : null,
                                    ),

                                    if (selectedTransactions.isNotEmpty)
                                      const TextSpan(text: " "),

                                    TextSpan(
                                      text: t.transaction
                                          .display(n: trCountAndBalance.count)
                                          .toLowerCase(),
                                    ),
                                  ],
                                ),
                              ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (selectedTransactions.isNotEmpty) ...[
                                  CurrencyDisplayer(
                                    amountToConvert: selectedTransactions
                                        .map(
                                          (e) => e
                                              .getCurrentBalanceInPreferredCurrency(),
                                        )
                                        .sum,
                                    showDecimals: false,
                                  ),
                                  const Text(" / ", style: smallerTextStyle),
                                ],
                                CurrencyDisplayer(
                                  amountToConvert:
                                      trCountAndBalance?.value ?? 0,
                                  showDecimals: selectedTransactions.isEmpty,
                                  integerStyle: selectedTransactions.isEmpty
                                      ? const TextStyle(inherit: true)
                                      : smallerTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: TransactionListComponent(
                scrollController: listScrollController,
                heroTagBuilder: (tr) => 'transactions-page__tr-icon-${tr.id}',
                filters: filters.copyWith(searchValue: searchController.text),
                selectedTransactions: selectedTransactions,
                onLongPress: (tr) {
                  if (selectedTransactions.isNotEmpty) {
                    return;
                  }

                  toggleTransaction(tr);
                },
                onTap: selectedTransactions.isEmpty ? null : toggleTransaction,
                onEmptyList: NoResults(
                  title: filters.hasFilter ? null : t.general.empty_warn,
                  description: filters.hasFilter
                      ? t.transaction.list.searcher_no_results
                      : t.transaction.list.empty,
                  noSearchResultsVariation: filters.hasFilter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void closeSearch() {
    setState(() {
      searchController.text = "";
      searchFocusNode.unfocus();
    });
  }

  AppBar transactionsPageDefaultAppBar(Translations t, BuildContext context) {
    return AppBar(
      leading: searchActive
          ? IconButton(onPressed: closeSearch, icon: const Icon(Icons.close))
          : null,
      title: searchActive
          ? TextField(
              controller: searchController,
              focusNode: searchFocusNode,
              decoration: InputDecoration(
                hintText: t.transaction.list.searcher_placeholder,
                border: const UnderlineInputBorder(),
              ),
            )
          : Text(t.transaction.display(n: 10)),
      actions: [
        if (!searchActive)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
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
              setState(() {
                filters = modalRes;
              });
            }
          },
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ],
    );
  }

  AppBar selectedTransactionsAppbar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      leading: IconButton(
        onPressed: () {
          cleanSelectedTransactions();
        },
        icon: const Icon(Icons.close),
      ),
      title: Text(
        t.transaction.list.selected_short(n: selectedTransactions.length),
      ),
      actions: [
        MonekinPopupMenuButton(
          actionItems: [
            ListTileActionItem(
              label: t.ui_actions.edit,
              icon: Icons.edit_rounded,
              onClick: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (context) {
                    return BulkEditTransactionModal(
                      transactionsToEdit: selectedTransactions,
                      onSuccess: () {
                        selectedTransactions = [];
                      },
                    );
                  },
                );
              },
            ),
            ListTileActionItem(
              label: t.ui_actions.delete,
              icon: Icons.delete_rounded,
              onClick: () {
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
              },
              role: ListTileActionRole.delete,
            ),
          ],
        ),
      ],
    );
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
