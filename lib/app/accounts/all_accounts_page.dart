import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_details.dart';
import 'package:monekin/app/accounts/account_form.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/widgets/empty_indicator.dart';

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
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountFormPage()))
              }),
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

            return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: accounts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Divider(indent: 56);
                },
                itemBuilder: (context, index) {
                  final account = accounts[index];

                  return ListTile(
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
                    subtitle: Text(account.type.title(context)),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AccountDetailsPage(account: account)),
                    ),
                  );
                });
          }),
    );
  }
}
