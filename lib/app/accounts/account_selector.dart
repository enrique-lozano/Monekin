import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/widgets/icon_displayer_widgets.dart';

Future<List<Account>?> showAccountSelectorBottomSheet(
    BuildContext context, AccountSelectorModal accountSelector) {
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

class _AccountSelectorModalState extends State<AccountSelectorModal> {
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

          return SingleChildScrollView(
            child: Column(
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
                      value: selectedAccounts
                          .map((e) => e.id)
                          .contains(account.id),
                      title: Text(account.name),
                      secondary: account.displayIcon(context),
                      onChanged: (value) {
                        if (value == true) {
                          selectedAccounts.add(account);
                        } else {
                          selectedAccounts.removeWhere(
                              (element) => element.id == account.id);
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
            ),
          );
        } else {
          return const LinearProgressIndicator();
        }
      }),
    );
  }
}

class AccountSelector extends StatefulWidget {
  const AccountSelector(
    this.params, {
    super.key,
  });

  final IconDisplayerSelectorData<Account> params;

  @override
  State<AccountSelector> createState() => _AccountSelectorState();
}

class _AccountSelectorState extends State<AccountSelector> {
  List<CategoryButtonSelector> buildAccountsOptions({
    required List<Account>? selectedItems,
  }) {
    return widget.params.availableItems!.map((accountToDisplay) {
      final isAccountSelected = selectedItems == null ||
          selectedItems!.any((cat) => cat.id == accountToDisplay.id);

      return CategoryButtonSelector(
        maxTextSize: widget.params.iconSize + widget.params.iconPadding * 2,
        iconWidget: accountToDisplay.displayIcon(
          context,
          size: widget.params.iconSize,
          padding: widget.params.iconPadding,
          isOutline: isAccountSelected,
          onTap: () {
            HapticFeedback.lightImpact();

            if (!widget.params.multiSelection) {
              selectedItems = [accountToDisplay];

              setState(() {});

              if (widget.params.onChange != null) {
                widget.params.onChange!(selectedItems);
              }
              return;
            }

            if (!isAccountSelected) {
              if (selectedItems == null) {
                selectedItems = [accountToDisplay];
              } else {
                selectedItems!.add(accountToDisplay);

                if (selectedItems!.length ==
                    widget.params.availableItems!.length) {
                  selectedItems = null;
                }
              }
            } else {
              selectedItems ??= [...widget.params.availableItems!];

              selectedItems!
                  .removeWhere((element) => element.id == accountToDisplay.id);
            }

            setState(() {});

            if (widget.params.onChange != null) {
              widget.params.onChange!(selectedItems);
            }
          },
        ),
        label: accountToDisplay.name,
      );
    }).toList();
  }

  CategoryButtonSelector buildSelectAllButton(
    BuildContext context, {
    required List<Account>? selectedAccounts,
  }) {
    final t = Translations.of(context);

    return CategoryButtonSelector(
      maxTextSize: widget.params.iconSize + widget.params.iconPadding * 2,
      iconWidget: IconDisplayer(
        icon: Icons.select_all,
        displayMode: IconDisplayMode.polygon,
        size: widget.params.iconSize,
        padding: widget.params.iconPadding,
        isOutline: selectedAccounts == null,
        secondaryColor: AppColors.of(context).surface.darken(
              isAppInDarkBrightness(context) ? 0.6 : 0.1,
            ),
        mainColor: AppColors.of(context).onSurface,
        onTap: () {
          if (selectedAccounts == null) {
            selectedAccounts = [];
          } else {
            selectedAccounts = null;
          }

          setState(() {});

          HapticFeedback.lightImpact();

          if (widget.params.onChange != null) {
            widget.params.onChange!(selectedAccounts);
          }
        },
      ),
      label: t.categories.select.all_short,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Account>? selectedAccounts = widget.params.selectedItems;

    final extraHeaderButtonsWithSameSize = widget.params.extraHeaderButtons
        ?.map(
          (e) => e.copyWith(
            iconWidget: e.iconWidget.copyWith(
              size: widget.params.iconSize,
              padding: widget.params.iconPadding,
            ),
          ),
        )
        .toList();

    return Builder(builder: (context) {
      if (widget.params.availableItems == null) {
        return Container();
      }

      return IconDisplayerSelectorRow(
        direction: widget.params.direction,
        extraHeaderButtons: [
          if (widget.params.direction == Axis.horizontal)
            buildSelectAllButton(context, selectedAccounts: selectedAccounts),
          if (extraHeaderButtonsWithSameSize != null)
            ...extraHeaderButtonsWithSameSize
        ],
        scrollableOptions:
            buildAccountsOptions(selectedItems: selectedAccounts),
      );
    });
  }
}
