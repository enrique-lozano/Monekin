// ignore_for_file: unnecessary_string_interpolations, prefer_single_quotes

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/home/widgets/new_transaction_fl_button.dart';
import 'package:monekin/app/layout/tabs.dart';
import 'package:monekin/app/transactions/widgets/bulk_edit_transaction_modal.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/filter_row_indicator.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/filter_sheet_modal.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key, this.filters});

  final TransactionFilters? filters;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late TransactionFilters filters;

  bool searchActive = false;
  FocusNode searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  bool isFloatingButtonExtended = true;

  List<MoneyTransaction> selectedTransactions = [];

  @override
  void initState() {
    super.initState();

    filters = widget.filters ?? const TransactionFilters();

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

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PopScope(
      canPop: !searchActive && selectedTransactions.isEmpty,
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

        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: selectedTransactions.isNotEmpty
            ? selectedTransactionsAppbar()
            : transactionsPageDefaultAppBar(t, context),
        floatingActionButton: NewTransactionButton(
          isExtended: isFloatingButtonExtended,
        ),
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
                final res = snapshot.data;

                const smallerTextStyle = TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                );

                return Card(
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
                          if (res != null) ...[
                            Text.rich(
                              TextSpan(
                                text: selectedTransactions.isNotEmpty
                                    ? ('${selectedTransactions.length.toStringAsFixed(0)}')
                                    : '',
                                children: [
                                  TextSpan(
                                    text:
                                        '${selectedTransactions.isNotEmpty ? ' / ' : ''}${res.count} ',
                                    style: selectedTransactions.isNotEmpty
                                        ? smallerTextStyle
                                        : null,
                                  ),
                                  TextSpan(
                                    text: t.transaction
                                        .display(n: res.count)
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
                                  const Text("/ ", style: smallerTextStyle),
                                ],
                                CurrencyDisplayer(
                                  amountToConvert: res.value,
                                  showDecimals: selectedTransactions.isEmpty,
                                  integerStyle: selectedTransactions.isEmpty
                                      ? const TextStyle(inherit: true)
                                      : smallerTextStyle,
                                ),
                              ],
                            ),
                          ],
                          if (res == null) ...[
                            const Skeleton(width: 38, height: 18),
                            const Skeleton(width: 28, height: 18),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: TransactionListComponent(
                heroTagBuilder: (tr) => 'transactions-page__tr-icon-${tr.id}',
                filters: filters.copyWith(searchValue: searchController.text),
                prevPage: const TabsPage(),
                selectedTransactions: selectedTransactions,
                onLongPress: (tr) {
                  if (selectedTransactions.isNotEmpty) {
                    return;
                  }

                  setState(() {
                    selectedTransactions = [tr];
                  });
                },
                onScrollChange: (controller) {
                  bool shouldExtendButton =
                      BreakPoint.of(context).isLargerThan(BreakpointID.md) ||
                      controller.offset <= 10 ||
                      controller.position.userScrollDirection !=
                          ScrollDirection.reverse;

                  if (isFloatingButtonExtended != shouldExtendButton) {
                    setState(() {
                      isFloatingButtonExtended = shouldExtendButton;
                    });
                  }
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
      searchActive = false;
      searchController.text = "";
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
              onChanged: (text) {
                setState(() {});
              },
            )
          : Text(t.transaction.display(n: 10)),
      actions: [
        if (!searchActive)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                searchActive = true;
              });

              searchFocusNode.requestFocus();
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
                        setState(() {});
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

                        setState(() {
                          selectedTransactions = [];
                        });
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
