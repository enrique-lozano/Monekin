import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/selectors/draggableScrollableKeyboardAware.mixin.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/count_indicator.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<List<Account>?> showAccountSelectorBottomSheet(
  BuildContext context,
  AccountSelectorModal accountSelector,
) {
  return showModalBottomSheet<List<Account>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return accountSelector;
    },
  );
}

class AccountSelectorModal extends StatefulWidget {
  const AccountSelectorModal({
    super.key,
    required this.allowMultiSelection,
    required this.filterSavingAccounts,
    this.includeArchivedAccounts = true,
    this.selectedAccounts = const [],
  });

  final bool allowMultiSelection;
  final bool filterSavingAccounts;
  final bool includeArchivedAccounts;

  final List<Account> selectedAccounts;

  @override
  State<AccountSelectorModal> createState() => _AccountSelectorModalState();
}

class _AccountSelectorModalState extends State<AccountSelectorModal>
    with DraggableScrollableKeyboardAware {
  late List<Account> selectedAccounts;

  String searchValue = '';

  @override
  void initState() {
    super.initState();

    selectedAccounts = [...widget.selectedAccounts];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return buildDraggableSheet(
      minChildSize: 0.64,
      defaultSize: 0.65,
      builder: (context, scrollController) {
        return ModalContainer(
          title: widget.allowMultiSelection
              ? t.account.select.multiple
              : t.account.select.one,
          titleBuilder: !widget.allowMultiSelection || selectedAccounts.isEmpty
              ? null
              : (title) {
                  return Row(
                    children: [
                      Text(title),
                      const SizedBox(width: 12),
                      CountIndicator(selectedAccounts.length),
                    ],
                  );
                },
          body: StreamBuilder(
            stream: AccountService.instance.getAccounts(
              predicate: (acc, curr) => AppDB.instance.buildExpr([
                acc.name.contains(searchValue),
                if (widget.filterSavingAccounts)
                  acc.type.equalsValue(AccountType.saving).not(),
                if (!widget.includeArchivedAccounts) acc.closingDate.isNull(),
              ]),
            ),
            builder: (context, snapshot) {
              return Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      filled: false,
                      isDense: false,
                      hintText: t.currencies.search,
                      labelText: t.general.tap_to_search,
                      floatingLabelStyle: const TextStyle(height: -0.0005),
                      prefixIcon: const Icon(Icons.search),
                      border: const UnderlineInputBorder(),
                    ),
                    onChanged: (value) {
                      searchValue = value;
                      rebuild();
                    },
                  ),
                  if (widget.allowMultiSelection)
                    buildSelectAllButton(snapshot),
                  buildAccountList(snapshot, scrollController),
                ],
              );
            },
          ),
          footer: !widget.allowMultiSelection
              ? null
              : BottomSheetFooter(
                  onSaved: selectedAccounts.isNotEmpty
                      ? () => Navigator.of(context).pop(selectedAccounts)
                      : null,
                ),
        );
      },
    );
  }

  Widget buildSelectAllButton(AsyncSnapshot<List<Account>> snapshot) {
    final filteredSelectedAccounts = snapshot.data == null
        ? <Account>[]
        : selectedAccounts
              .where(
                (selAcc) => snapshot.data!.map((e) => e.id).contains(selAcc.id),
              )
              .toList();

    return CheckboxListTile(
      value:
          snapshot.data == null ||
              snapshot.data!.isEmpty ||
              filteredSelectedAccounts.isEmpty
          ? false
          : filteredSelectedAccounts.length == snapshot.data!.length
          ? true
          : null,
      tristate: true,
      title: Text(
        t.ui_actions.select_all,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      enabled: snapshot.hasData && snapshot.data!.isNotEmpty,
      onChanged: (value) {
        if (value == true && snapshot.data != null) {
          selectedAccounts.addAll(
            snapshot.data!.whereNot(
              (e) => selectedAccounts.map((selAcc) => selAcc.id).contains(e.id),
            ),
          );
        } else {
          selectedAccounts.removeWhere(
            (selAcc) => snapshot.data!.map((e) => e.id).contains(selAcc.id),
          );
        }

        rebuild();
      },
    );
  }

  Widget buildAccountList(
    AsyncSnapshot<List<Account>> snapshot,
    ScrollController scrollController,
  ) {
    if (!snapshot.hasData) {
      return const LinearProgressIndicator();
    }

    final allAccounts = snapshot.data!;

    if (allAccounts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(t.account.no_accounts, textAlign: TextAlign.center),
      );
    }

    return Expanded(
      child: Stack(
        children: [
          ListView.separated(
            controller: scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: allAccounts.length,
            padding: const EdgeInsets.only(bottom: 16, top: 4),
            separatorBuilder: (context, i) {
              return const Divider(height: 0);
            },
            itemBuilder: (context, index) {
              final account = allAccounts[index];

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
                  value: selectedAccounts.map((e) => e.id).contains(account.id),
                  title: Text(account.name),
                  secondary: account.displayIcon(context),
                  onChanged: (value) {
                    if (value == true) {
                      selectedAccounts.add(account);
                    } else {
                      selectedAccounts.removeWhere(
                        (element) => element.id == account.id,
                      );
                    }

                    rebuild();
                  },
                );
              }
            },
          ),
          if (widget.allowMultiSelection)
            ScrollableWithBottomGradient.buildPositionedGradient(
              AppColors.of(context).modalBackground,
            ),
        ],
      ),
    );
  }
}
