import 'package:flutter/material.dart';
import 'package:monekin/core/models/account/account.dart';

import '../../core/presentation/app_colors.dart';

class AccountTypeSelector extends StatefulWidget {
  const AccountTypeSelector(
      {super.key,
      required this.onSelected,
      this.selectedType = AccountType.normal});

  final AccountType selectedType;

  final Function(AccountType) onSelected;

  @override
  State<AccountTypeSelector> createState() => _AccountTypeSelectorState();
}

class _AccountTypeSelectorState extends State<AccountTypeSelector> {
  late AccountType selectedItem;

  @override
  void initState() {
    super.initState();

    selectedItem = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: List.generate(
          AccountType.values.length,
          (index) {
            final AccountType item = AccountType.values[index];

            return Flexible(
              child: MonekinFilterChip(
                accountType: item,
                onPressed: () {
                  setState(() {
                    selectedItem = item;
                    widget.onSelected(item);
                  });
                },
                isSelected: item == selectedItem,
              ),
            );
          },
        ),
      ),
    );
  }
}

class MonekinFilterChip extends StatelessWidget {
  const MonekinFilterChip({
    super.key,
    required this.accountType,
    required this.onPressed,
    required this.isSelected,
  });

  final VoidCallback onPressed;
  final bool isSelected;

  final AccountType accountType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 1.25,
            color:
                isSelected ? AppColors.of(context).primary : Colors.transparent,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onPressed.call,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  accountType.icon,
                  size: 28,
                  color: isSelected
                      ? AppColors.of(context).primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 18),
                Text(
                  accountType.title(context),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected
                          ? AppColors.of(context).primary
                          : Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                Text(accountType.description(context),
                    softWrap: true,
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
