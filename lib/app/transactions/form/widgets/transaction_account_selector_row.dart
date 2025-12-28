import 'package:flutter/material.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TransactionAccountSelectorRow extends StatelessWidget {
  const TransactionAccountSelectorRow({
    super.key,
    required this.transactionType,
    required this.fromAccount,
    required this.transferAccount,
    required this.selectedCategory,
    required this.onFromAccountTap,
    required this.onTransferAccountTap,
    required this.onCategoryTap,
    required this.shakeKey,
    this.mainContainerRadius = 12.0,
  });

  final TransactionType transactionType;
  final Account? fromAccount;
  final Account? transferAccount;
  final Category? selectedCategory;
  final VoidCallback onFromAccountTap;
  final VoidCallback onTransferAccountTap;
  final VoidCallback onCategoryTap;
  final GlobalKey<ShakeWidgetState> shakeKey;
  final double mainContainerRadius;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final borderRadius = Radius.circular(mainContainerRadius);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: transactionType.color(context).withOpacity(0.35),
        borderRadius: BorderRadius.only(
          bottomLeft: borderRadius,
          bottomRight: borderRadius,
        ),
      ),
      child: SizedBox(
        height: 74,
        child: Row(
          children: [
            ...[
              Expanded(
                flex: 1,
                child: _Selector(
                  title: t.general.account,
                  inputValue: fromAccount?.name,
                  borderRadius: BorderRadius.only(bottomLeft: borderRadius),
                  icon:
                      fromAccount?.displayIcon(context) ??
                      IconDisplayer(
                        displayMode: IconDisplayMode.polygon,
                        icon: Icons.question_mark_rounded,
                        mainColor: Theme.of(context).colorScheme.primary,
                      ),
                  onClick: onFromAccountTap,
                ),
              ),
              VerticalDivider(
                color: transactionType.color(context).withOpacity(0.85),
                thickness: 2,
              ),
            ],
            if (transactionType.isTransfer)
              Expanded(
                flex: 1,
                child: ShakeWidget(
                  duration: const Duration(milliseconds: 200),
                  shakeCount: 1,
                  shakeOffset: 10,
                  key: shakeKey,
                  child: _Selector(
                    title: t.transfer.form.to,
                    inputValue: transferAccount?.name,
                    borderRadius: BorderRadius.only(bottomRight: borderRadius),
                    icon:
                        transferAccount?.displayIcon(context) ??
                        IconDisplayer(
                          displayMode: IconDisplayMode.polygon,
                          icon: Icons.question_mark_rounded,
                          mainColor: Theme.of(context).colorScheme.primary,
                        ),
                    onClick: onTransferAccountTap,
                  ),
                ),
              ),
            if (!transactionType.isTransfer)
              Expanded(
                flex: 1,
                child: ShakeWidget(
                  duration: const Duration(milliseconds: 200),
                  shakeCount: 1,
                  shakeOffset: 10,
                  key: shakeKey,
                  child: _Selector(
                    title: t.general.category,
                    inputValue: selectedCategory?.name,
                    borderRadius: BorderRadius.only(bottomRight: borderRadius),
                    icon: IconDisplayer.fromCategory(
                      context,
                      category:
                          selectedCategory ??
                          Category.fromDB(Category.unkown(), null),
                      size: 24,
                    ),
                    onClick: onCategoryTap,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Selector extends StatelessWidget {
  const _Selector({
    required this.title,
    required this.inputValue,
    required this.icon,
    required this.onClick,
    required this.borderRadius,
  });

  final String title;
  final String? inputValue;
  final Widget icon;
  final VoidCallback onClick;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return InkWell(
      onTap: () {
        unfocusCurrentFocusedItem(context);
        onClick();
      },
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    inputValue ?? t.general.unspecified,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
