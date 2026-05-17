import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

enum _CardPosition { single, left, right }

/// Account and category selector for the transaction form.
/// Displays differently for transfer vs other transaction types.
class TransactionAccountCategorySelector extends StatelessWidget {
  const TransactionAccountCategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.watch<TransactionFormController>();

    if (form.usesDualLegAmountLayout) {
      return const SizedBox.shrink();
    }

    final t = Translations.of(context);
    final theme = Theme.of(context);
    final transactionType = form.transactionType;
    final fromAccount = form.fromAccount;
    final transferAccount = form.transferAccount;
    final selectedCategory = form.selectedCategory;
    final shakeKey = form.shakeKey;
    final investmentAssetName = form.isAssetTradeInvestment
        ? (form.asset?.name ?? '…')
        : null;

    if (transactionType.isTransfer) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              _buildFromAccountCard(
                context,
                form,
                fromAccount,
                _CardPosition.single,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ShakeWidget(
                  duration: const Duration(milliseconds: 200),
                  shakeCount: 1,
                  shakeOffset: 10,
                  key: shakeKey,
                  child: _AccountCard(
                    position: _CardPosition.single,
                    title: t.transfer.form.to,
                    value: transferAccount?.name,
                    leading:
                        transferAccount?.displayIcon(context) ??
                        IconDisplayer(
                          displayMode: IconDisplayMode.polygon,
                          icon: Icons.question_mark_rounded,
                          mainColor: theme.colorScheme.primary,
                        ),
                    onTap: () => form.pickTransferAccount(context),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: IconButton.filledTonal(
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: transactionType.isTransfer
                  ? form.toggleDualLegFlowDirection
                  : null,
              icon: const Icon(Icons.arrow_downward_rounded),
              tooltip: t.transfer.display,
            ),
          ),
        ],
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildFromAccountCard(
              context,
              form,
              fromAccount,
              _CardPosition.left,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: transactionType.isInvestment && investmentAssetName != null
                ? _AccountCard(
                    position: _CardPosition.right,
                    title: t.assets.details.trade_form_asset_column,
                    value: investmentAssetName,
                    onTap: () {},
                    showChevron: false,
                  )
                : ShakeWidget(
                    duration: const Duration(milliseconds: 200),
                    shakeCount: 1,
                    shakeOffset: 10,
                    key: shakeKey,
                    child: _AccountCard(
                      position: _CardPosition.right,
                      title: t.general.category,
                      value: selectedCategory?.name,
                      leading: IconDisplayer.fromCategory(
                        context,
                        category:
                            selectedCategory ??
                            Category.fromDB(Category.unkown(), null),
                        size: 24,
                      ),
                      onTap: () => form.selectCategory(context),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _AccountCard _buildFromAccountCard(
    BuildContext context,
    TransactionFormController form,
    Account? fromAccount,
    _CardPosition position,
  ) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return _AccountCard(
      position: position,
      title: t.general.account,
      value: fromAccount?.name,
      leading:
          fromAccount?.displayIcon(context) ??
          IconDisplayer(
            displayMode: IconDisplayMode.polygon,
            icon: Icons.question_mark_rounded,
            mainColor: theme.colorScheme.primary,
          ),
      onTap: () => form.pickFromAccount(context),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.title,
    required this.value,
    required this.onTap,
    this.subtitle,
    this.leading,
    this.showChevron = true,
    this.position = _CardPosition.single,
  });

  final String title;
  final String? value;
  final Widget? subtitle;
  final Widget? leading;
  final VoidCallback onTap;
  final bool showChevron;
  final _CardPosition position;

  BorderRadius get _borderRadius {
    switch (position) {
      case _CardPosition.left:
        return BorderRadius.only(
          topLeft: inputBorderRadius,
          bottomLeft: inputBorderRadius,
        );

      case _CardPosition.right:
        return BorderRadius.only(
          topRight: inputBorderRadius,
          bottomRight: inputBorderRadius,
        );

      case _CardPosition.single:
        return BorderRadius.all(inputBorderRadius);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final onSurfaceVariant = theme.colorScheme.onSurfaceVariant;

    return Tappable(
      onTap: () {
        unfocusCurrentFocusedItem(context);
        onTap();
      },
      shape: RoundedRectangleBorder(borderRadius: _borderRadius),
      bgColor: theme.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 10)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      if (showChevron)
                        Icon(
                          Icons.expand_more_rounded,
                          color: onSurfaceVariant,
                          size: 16,
                        ),
                    ],
                  ),
                  Text(
                    value ?? t.general.unspecified,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: subtitle != null ? 2 : 8),
                  if (subtitle != null)
                    SizedBox(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: subtitle != null
                            ? DefaultTextStyle(
                                style: theme.textTheme.bodySmall!,
                                child: subtitle!,
                              )
                            : const SizedBox.shrink(),
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
