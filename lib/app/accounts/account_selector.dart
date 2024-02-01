import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<List<Account>?> showAccountSelectorBottomSheet(
    BuildContext context, AccountSelector accountSelector) {
  return showModalBottomSheet<List<Account>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return accountSelector;
    },
  );
}

class AccountSelector extends StatefulWidget {
  const AccountSelector(
      {super.key,
      required this.allowMultiSelection,
      required this.filterSavingAccounts,
      this.includeArchivedAccounts = true,
      this.selectedAccounts = const []});

  final bool allowMultiSelection;
  final bool filterSavingAccounts;
  final bool includeArchivedAccounts;

  final List<Account> selectedAccounts;

  @override
  State<AccountSelector> createState() => _AccountSelectorState();
}

class _AccountSelectorState extends State<AccountSelector> {
  List<Account>? allAccounts;

  late List<Account> selectedAccounts;

  @override
  void initState() {
    super.initState();

    selectedAccounts = widget.selectedAccounts;

    AccountService.instance
        .getAccounts(
          predicate: (acc, curr) => AppDB.instance.buildExpr([
            if (widget.filterSavingAccounts)
              acc.type.equalsValue(AccountType.saving).not(),
            if (!widget.includeArchivedAccounts) acc.closingDate.isNull()
          ]),
        )
        .first
        .then((acc) {
      setState(() {
        allAccounts = acc;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: widget.allowMultiSelection
          ? t.account.select.multiple
          : t.account.select.one,
      responseToKeyboard: false,
      body: Builder(builder: (context) {
        if (allAccounts != null) {
          if (allAccounts!.isEmpty) {
            return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  t.account.no_accounts,
                  textAlign: TextAlign.center,
                ));
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(allAccounts!.length, (index) {
                final account = allAccounts![index];

                if (!widget.allowMultiSelection) {
                  return RadioListTile(
                    value: account.id,
                    title: Text(account.name),
                    secondary: account.displayIcon(context),
                    groupValue: selectedAccounts.firstOrNull?.id,
                    onChanged: (value) {
                      setState(() {
                        selectedAccounts = [account];

                        Navigator.of(context).pop(selectedAccounts);
                      });
                    },
                  );
                } else {
                  return CheckboxListTile(
                    value:
                        selectedAccounts.map((e) => e.id).contains(account.id),
                    title: Text(account.name),
                    secondary: account.displayIcon(context),
                    onChanged: (value) {
                      if (value == true) {
                        selectedAccounts.add(account);
                      } else {
                        selectedAccounts
                            .removeWhere((element) => element.id == account.id);
                      }

                      setState(() {});
                    },
                  );
                }
              }),
              if (widget.allowMultiSelection) ...[
                const SizedBox(height: 14),
                BottomSheetFooter(
                    onSaved: selectedAccounts.isNotEmpty
                        ? () => Navigator.of(context).pop(selectedAccounts)
                        : null)
              ]
            ],
          );
        } else {
          return const LinearProgressIndicator();
        }
      }),
    );
  }
}
