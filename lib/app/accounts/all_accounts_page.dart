import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/monekin_reorderable_list.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/widgets/empty_indicator.dart';

@RoutePage()
class AllAccountsPage extends StatelessWidget {
  const AllAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.home.my_accounts)),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_rounded),
        label: Text(t.account.form.create),
        onPressed: () => context.pushRoute(AccountFormRoute()),
      ),
      body: StreamBuilder(
        stream: AccountService.instance.getAccounts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          }

          final accounts = snapshot.data!;

          if (accounts.isEmpty) {
            return Column(
              children: [
                Expanded(
                    child: EmptyIndicator(
                        title: t.general.empty_warn,
                        description: t.account.no_accounts)),
              ],
            );
          }

          return MonekinReorderableList(
            totalItemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts.elementAt(index);

              return Tappable(
                onTap: () => context.pushRoute(
                  AccountDetailsRoute(account: account),
                ),
                bgColor: AppColors.of(context).light,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                borderRadius: 12,
                child: ListTile(
                  trailing: accounts.length > 1
                      ? ReorderableDragIcon(index: index)
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
                    tag: 'account-icon-${account.id}',
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

              Future.wait(
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
    );
  }
}

class ReorderableDragIcon extends StatelessWidget {
  const ReorderableDragIcon({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      child: Container(
          padding: const EdgeInsets.fromLTRB(14, 4, 2, 4),
          // Padding to increase the dragabble area
          //color: Colors.red,
          child: const Icon(Icons.drag_handle_rounded)),
    );
  }
}
