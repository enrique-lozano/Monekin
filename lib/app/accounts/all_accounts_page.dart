import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/details/account_details.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/presentation/animations/animated_floating_button.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/column_with_reorderable_list_and_search.dart';
import 'package:monekin/core/presentation/widgets/monekin_reorderable_list.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:monekin/page_framework.dart';

import '../../core/presentation/widgets/no_results.dart';
import '../../core/presentation/widgets/reorderable_drag_icon.dart';

class AllAccountsPage extends StatefulWidget {
  const AllAccountsPage({super.key});

  @override
  State<AllAccountsPage> createState() => _AllAccountsPageState();
}

class _AllAccountsPageState extends State<AllAccountsPage> {
  String searchQuery = '';

  final ScrollController _scrollController = ScrollController();

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void _onAddPressed() {
    RouteUtils.pushRoute(context, const AccountFormPage());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final floatingActionButton = BreakPoint.of(context).isLargerThan(BreakpointID.sm)
        ? null
        : AnimatedFloatingButtonBasedOnScroll(
            onPressed: _onAddPressed,
            icon: const Icon(Icons.add_rounded),
            scrollController: _scrollController,
            text: t.account.form.create,
          );

    return PageFramework(
      title: t.home.my_accounts,
      floatingActionButton: floatingActionButton,
      body: ColumnWithReorderableListAndSearch(
        onSearchChanged: _onSearchChanged,
        onAddPressed: _onAddPressed,
        addText: t.account.form.create,
        child: StreamBuilder(
          stream: AccountService.instance.getAccounts(
            predicate: (acc, curr) => acc.name.contains(searchQuery),
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LinearProgressIndicator();
            }

            final accounts = snapshot.data!;

            if (accounts.isEmpty) {
              return NoResults(
                title: t.general.empty_warn,
                description: searchQuery.isNotEmpty
                    ? t.general.search_no_results
                    : t.account.no_accounts,
              );
            }

            final isOrderEnabled =
                accounts.length > 1 && searchQuery.isNullOrEmpty;

            return MonekinReorderableList(
              totalItemCount: accounts.length,
              isOrderEnabled: isOrderEnabled,
              padding: ColumnWithReorderableListAndSearch.listPadding(context),
              scrollController: _scrollController,
              spaceBetween: 8,
              itemBuilder: (context, index, isOrdering) {
                final account = accounts.elementAt(index);

                return ReorderableListTileStyling(
                  child: ListTile(
                    onTap: () => RouteUtils.pushRoute(
                      context,
                      AccountDetailsPage(
                        account: account,
                        accountIconHeroTag:
                            'all-accounts-page__account-icon-${account.id}',
                      ),
                    ),
                    trailing: accounts.length > 1
                        ? ReorderableDragIcon(
                            index: index,
                            enabled: isOrderEnabled,
                          )
                        : null,
                    title: Row(
                      children: [
                        Flexible(
                          child: Text(
                            account.name,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (account.isClosed)
                          const Icon(
                            Icons.archive_outlined,
                            color: Colors.amber,
                            size: 16,
                          ),
                      ],
                    ),
                    leading: Hero(
                      tag: 'all-accounts-page__account-icon-${account.id}',
                      child: account.displayIcon(context),
                    ),
                    subtitle: Text(account.type.title(context)),
                  ),
                );
              },
              onReorder: (from, to) async {
                if (to > from) to--;

                final item = accounts.removeAt(from);
                accounts.insert(to, item);

                await Future.wait(
                  accounts.mapIndexed(
                    (index, element) => AccountService.instance.updateAccount(
                      element.copyWith(displayOrder: index),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
