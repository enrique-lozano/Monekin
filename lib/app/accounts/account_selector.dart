import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/categories/category_selector.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

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

class AccountSelector extends StatefulWidget {
  const AccountSelector({
    super.key,
    required this.selectedAccounts,
    this.onChange,
    this.direction = Axis.horizontal,
    required this.availableAccounts,
    this.extraHeaderButtons,
    this.multiSelection = true,
    this.iconSize = 48,
    this.iconPadding = 8,
  });

  final List<Account>? selectedAccounts;
  final void Function(List<Account>? selectedAccounts)? onChange;
  final Axis direction;

  /// Extra options to add before the categories options. The size and padding of
  /// the `IconDisplayer` attribute here will be ignored to match the rest of the
  /// options
  final List<CategoryButtonSelector>? extraHeaderButtons;

  /// Wheter the user can select multiple categories
  final bool multiSelection;

  /// Size of all the icon options of the Widget
  final double iconSize;

  /// Padding of all the icon options of the Widget
  final double iconPadding;

  /// List of the available categories to choose. If null, the component will
  /// display an empty container
  final List<Account>? availableAccounts;

  @override
  State<AccountSelector> createState() => _AccountSelectorState();
}

class _AccountSelectorState extends State<AccountSelector> {
  buildAccountsOptions({
    required List<Account>? selectedAccounts,
  }) {
    return [
      for (final (index, categoryToDisplay)
          in widget.availableAccounts!.indexed) ...[
        Builder(builder: (context) {
          final isAccountSelected = selectedAccounts == null ||
              selectedAccounts!.any((cat) => cat.id == categoryToDisplay.id);

          return CategoryButtonSelector(
            maxTextSize: widget.iconSize * 1.2,
            iconWidget: categoryToDisplay.displayIcon(
              context,
              size: widget.iconSize,
              padding: widget.iconPadding,
              isOutline: isAccountSelected,
              onTap: () {
                HapticFeedback.lightImpact();

                if (!widget.multiSelection) {
                  selectedAccounts = [categoryToDisplay];

                  setState(() {});

                  if (widget.onChange != null) {
                    widget.onChange!(selectedAccounts);
                  }
                  return;
                }

                if (!isAccountSelected) {
                  if (selectedAccounts == null) {
                    selectedAccounts = [categoryToDisplay];
                  } else {
                    selectedAccounts!.add(categoryToDisplay);

                    if (selectedAccounts!.length ==
                        widget.availableAccounts!.length) {
                      selectedAccounts = null;
                    }
                  }
                } else {
                  selectedAccounts ??= [...widget.availableAccounts!];

                  selectedAccounts!.removeWhere(
                      (element) => element.id == categoryToDisplay.id);
                }

                setState(() {});

                if (widget.onChange != null) {
                  widget.onChange!(selectedAccounts);
                }
              },
            ),
            label: categoryToDisplay.name,
          );
        }),
        if (index < widget.availableAccounts!.length - 1 &&
            widget.direction == Axis.horizontal)
          const SizedBox(width: 12)
      ]
    ];
  }

  Widget buildSelectAllButton(
    BuildContext context, {
    required List<Account>? selectedAccounts,
  }) {
    final t = Translations.of(context);

    return CategoryButtonSelector(
      maxTextSize: widget.iconSize * 1.2,
      iconWidget: IconDisplayer(
        icon: Icons.select_all,
        size: widget.iconSize,
        padding: widget.iconPadding,
        isOutline: selectedAccounts == null,
        secondaryColor: AppColors.of(context).background.darken(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.1,
            ),
        mainColor: AppColors.of(context).onBackground,
        onTap: () {
          if (selectedAccounts == null) {
            selectedAccounts = [];
          } else {
            selectedAccounts = null;
          }

          setState(() {});

          HapticFeedback.lightImpact();

          if (widget.onChange != null) {
            widget.onChange!(selectedAccounts);
          }
        },
      ),
      label: t.categories.select.all_short,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Account>? selectedAccounts = widget.selectedAccounts;

    final extraHeaderButtonsWithSameSize = widget.extraHeaderButtons
        ?.map(
          (e) => e.copyWith(
            iconWidget: e.iconWidget.copyWith(
              size: widget.iconSize,
              padding: widget.iconPadding,
            ),
          ),
        )
        .toList();

    return Builder(builder: (context) {
      if (widget.availableAccounts == null) {
        return Container();
      }

      if (widget.direction == Axis.vertical) {
        return Align(
          alignment: Alignment.center,
          heightFactor: 1,
          child: Wrap(
            runAlignment: WrapAlignment.center,
            runSpacing: 12,
            spacing: 24,
            children: [
              if (extraHeaderButtonsWithSameSize != null)
                ...extraHeaderButtonsWithSameSize,
              ...buildAccountsOptions(
                selectedAccounts: selectedAccounts,
              )
            ],
          ),
        );
      }

      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSelectAllButton(context, selectedAccounts: selectedAccounts),
          const SizedBox(width: 6),
          if (extraHeaderButtonsWithSameSize != null)
            for (final button in extraHeaderButtonsWithSameSize) ...[
              const SizedBox(width: 6),
              button,
              const SizedBox(width: 6)
            ],
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(right: 16),
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      buildAccountsOptions(selectedAccounts: selectedAccounts),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
