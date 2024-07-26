import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/app/accounts/details/account_details.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/monekin_reorderable_list.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/widgets/no_results.dart';

class AllAccountsPage extends StatefulWidget {
  const AllAccountsPage({super.key});

  @override
  State<AllAccountsPage> createState() => _AllAccountsPageState();
}

class _AllAccountsPageState extends State<AllAccountsPage> {
  Timer? _debounce;

  String searchQuery = '';

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 225), () {
      setState(() {
        searchQuery = query;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.home.my_accounts)),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey(),
        icon: const Icon(Icons.add_rounded),
        label: Text(t.account.form.create),
        onPressed: () => RouteUtils.pushRoute(context, const AccountFormPage()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: t.general.tap_to_search,
                prefixIcon: const Icon(Icons.search_rounded),
              ),
              onChanged: (q) => _onSearchChanged(q),
            ),
          ),
          Expanded(
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
                    description: t.account.no_accounts,
                  );
                }

                final isOrderEnabled =
                    accounts.length > 1 && searchQuery.isNullOrEmpty;

                return MonekinReorderableList(
                  totalItemCount: accounts.length,
                  isOrderEnabled: isOrderEnabled,
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                  itemBuilder: (context, index) {
                    final account = accounts.elementAt(index);

                    return Tappable(
                      onTap: () => RouteUtils.pushRoute(
                        context,
                        AccountDetailsPage(
                            account: account,
                            accountIconHeroTag:
                                'all-accounts-page__account-icon-${account.id}'),
                      ),
                      bgColor: AppColors.of(context).light,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 4),
                      borderRadius: 12,
                      child: ListTile(
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
                              const Icon(Icons.archive_outlined,
                                  color: Colors.amber, size: 16)
                          ],
                        ),
                        leading: Hero(
                          tag: 'all-accounts-page__account-icon-${account.id}',
                          child: account.displayIcon(context),
                        ),
                        subtitle: Text(
                          account.type.title(context),
                        ),
                      ),
                    );
                  },
                  onReorder: (from, to) async {
                    if (to > from) to--;

                    final item = accounts.removeAt(from);
                    accounts.insert(to, item);

                    await Future.wait(
                      accounts.mapIndexed(
                        (index, element) =>
                            AccountService.instance.updateAccount(
                          element.copyWith(displayOrder: index),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReorderableDragIcon extends StatelessWidget {
  const ReorderableDragIcon(
      {super.key, required this.index, this.enabled = true});

  final int index;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: Container(
          // Padding to increase the dragabble area:
          padding: const EdgeInsets.fromLTRB(14, 4, 2, 4),

          // color: Colors.red,
          child: const Icon(Icons.drag_handle_rounded),
        ),
      ),
    );
  }
}
