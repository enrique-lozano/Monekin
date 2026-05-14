import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

enum _CardPosition { single, left, right }

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
    this.investmentAssetColumnTitle,
    this.investmentAssetName,
    this.investmentAssetLeading,
    this.onSwapTransferAccounts,
  });

  final TransactionType transactionType;
  final Account? fromAccount;
  final Account? transferAccount;
  final Category? selectedCategory;
  final VoidCallback onFromAccountTap;
  final VoidCallback onTransferAccountTap;
  final VoidCallback onCategoryTap;
  final GlobalKey<ShakeWidgetState> shakeKey;

  final String? investmentAssetColumnTitle;
  final String? investmentAssetName;
  final Widget? investmentAssetLeading;

  /// When [transactionType] is transfer, swaps origin and destination accounts.
  final VoidCallback? onSwapTransferAccounts;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(inputBorderRadius),
    );

    if (transactionType.isTransfer) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AccountCard(
            position: _CardPosition.single,
            title: t.transfer.form.from,
            value: fromAccount?.name,
            subtitle: _buildAccountSubtitle(fromAccount),
            leading:
                fromAccount?.displayIcon(context) ??
                IconDisplayer(
                  displayMode: IconDisplayMode.polygon,
                  icon: Icons.question_mark_rounded,
                  mainColor: theme.colorScheme.primary,
                ),
            onTap: onFromAccountTap,
          ),
          Center(
            child: IconButton.filledTonal(
              onPressed: onSwapTransferAccounts,
              icon: const Icon(Icons.swap_vert_rounded),
              tooltip: t.transfer.display,
            ),
          ),
          ShakeWidget(
            duration: const Duration(milliseconds: 200),
            shakeCount: 1,
            shakeOffset: 10,
            key: shakeKey,
            child: _AccountCard(
              position: _CardPosition.single,
              title: t.transfer.form.to,
              value: transferAccount?.name,
              subtitle: _buildAccountSubtitle(transferAccount),
              leading:
                  transferAccount?.displayIcon(context) ??
                  IconDisplayer(
                    displayMode: IconDisplayMode.polygon,
                    icon: Icons.question_mark_rounded,
                    mainColor: theme.colorScheme.primary,
                  ),
              onTap: onTransferAccountTap,
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _AccountCard(
            position: _CardPosition.left,
            title: t.general.account,
            value: fromAccount?.name,
            subtitle: _buildAccountSubtitle(fromAccount),
            leading:
                fromAccount?.displayIcon(context) ??
                IconDisplayer(
                  displayMode: IconDisplayMode.polygon,
                  icon: Icons.question_mark_rounded,
                  mainColor: theme.colorScheme.primary,
                ),
            onTap: onFromAccountTap,
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: transactionType.isInvestment && investmentAssetName != null
              ? _AccountCard(
                  position: _CardPosition.right,
                  title:
                      investmentAssetColumnTitle ??
                      t.assets.details.trade_form_asset_column,
                  value: investmentAssetName,
                  subtitle: Text("Ujkdjkdskj"),
                  leading: investmentAssetLeading,
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
                    subtitle: Text("Ujkdjkdskj"),
                    leading: IconDisplayer.fromCategory(
                      context,
                      category:
                          selectedCategory ??
                          Category.fromDB(Category.unkown(), null),
                      size: 24,
                    ),
                    onTap: onCategoryTap,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildAccountSubtitle(Account? account) {
    if (account == null) return const SizedBox.shrink();

    return StreamBuilder<double>(
      initialData: 0,
      stream: AccountService.instance.getAccountMoney(account: account),
      builder: (context, snapshot) {
        return CurrencyDisplayer(
          amountToConvert: snapshot.data ?? 0,
          currency: account.currency,
          compactView: (snapshot.data ?? 0).abs() >= 10000000,
        );
      },
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

    return Material(
      color: theme.colorScheme.surfaceContainerHigh,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: _borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          unfocusCurrentFocusedItem(context);
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
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
                    const SizedBox(height: 2),
                    Text(
                      value ?? t.general.unspecified,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 6),
                      DefaultTextStyle(
                        style: theme.textTheme.bodySmall!,
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
