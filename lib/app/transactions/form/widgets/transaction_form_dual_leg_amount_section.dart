import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_amount_block.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

String _formatMoney(double amount, CurrencyInDB? currency) {
  if (currency == null) return amount.toStringAsFixed(2);

  return UINumberFormatter.currency(
    amountToConvert: amount,
    currency: currency,
    showDecimals: true,
  ).getFormattedAmount();
}

/// Transfer: two cards (source / destination) with amounts, the controls
/// between them (direction, custom amounts, FX) and insufficient-balance warning.
class TransactionFormDualLegAmountSection extends StatelessWidget {
  const TransactionFormDualLegAmountSection({
    super.key,
    this.padding = EdgeInsets.zero,
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DualLegBody(),
          TransactionFormAmountBlock.insufficientBalanceWarning(context),
        ],
      ),
    );
  }
}

class _DualLegBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final t = Translations.of(context);
    final from = c.fromAccount;
    final to = c.transferAccount;

    final effectiveFrom = c.effectiveTransferFromAccount;
    final effectiveTo = c.effectiveTransferToAccount;

    final differentCurrency =
        effectiveFrom != null &&
        effectiveTo != null &&
        effectiveFrom.currency.code != effectiveTo.currency.code;

    final topOut = c.dualLegTopIsOutflow;
    final custom = c.customTransferAmounts;

    Widget buildLegs(double rate) {
      final sourceAmount = c.transactionValue.abs();
      final defaultDest = sourceAmount * rate;
      final destAmount = c.valueInDestinyToNumber ?? defaultDest;

      void openAmount({required bool isSource}) {
        if (isSource) {
          c.openTransferSourceAmountSelector(context);
        } else {
          c.openTransferDestinationAmountSelector(
            context,
            defaultDestinationAmount: defaultDest,
            linkedRate: custom ? null : rate,
          );
        }
      }

      final topAmount = topOut ? sourceAmount : destAmount;
      final bottomAmount = topOut ? destAmount : sourceAmount;

      final diff = destAmount - sourceAmount;
      final showDifference =
          custom &&
          !differentCurrency &&
          effectiveTo != null &&
          !TransactionFormController.nearlyEqualMoney(destAmount, sourceAmount);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DualLegCard(
            label: topOut
                ? t.transfer.form.label_from
                : t.transfer.form.label_to,
            account: from,
            isOutflow: topOut,
            amount: topAmount,
            balanceDelta: topOut ? -sourceAmount : destAmount,
            onTapAccount: () => c.pickFromAccount(context),
            onTapAmount: () => openAmount(isSource: topOut),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _DualLegDirectionButton(
                  reversed: c.dualLegFlowReversed,
                  disabled: to == null,
                  onPressed: c.toggleDualLegFlowDirection,
                ),
                _CustomAmountsChip(
                  active: custom,
                  onPressed: () => c.setCustomTransferAmounts(!custom),
                ),
                if (differentCurrency) _FxChip(rate: rate),
                if (showDifference)
                  _InfoChip(
                    label:
                        '${diff.isNegative ? '-' : '+'}'
                        '${_formatMoney(diff.abs(), effectiveTo.currency)} '
                        '${t.transfer.form.difference}',
                  ),
              ],
            ),
          ),
          ShakeWidget(
            duration: const Duration(milliseconds: 200),
            shakeCount: 1,
            shakeOffset: 10,
            key: c.shakeKey,
            child: _DualLegCard(
              label: topOut
                  ? t.transfer.form.label_to
                  : t.transfer.form.label_from,
              account: to,
              isOutflow: !topOut,
              amount: bottomAmount,
              balanceDelta: topOut ? destAmount : -sourceAmount,
              onTapAccount: () => c.pickTransferAccount(context),
              onTapAmount: () => openAmount(isSource: !topOut),
            ),
          ),
        ],
      );
    }

    if (differentCurrency) {
      return StreamBuilder<double>(
        stream: ExchangeRateService.instance.calculateExchangeRate(
          fromCurrency: effectiveFrom.currency.code,
          toCurrency: effectiveTo.currency.code,
          date: c.date,
        ),
        builder: (context, snap) => buildLegs(snap.data ?? 1),
      );
    }

    return buildLegs(1);
  }
}

class _DualLegCard extends StatelessWidget {
  const _DualLegCard({
    required this.label,
    required this.account,
    required this.isOutflow,
    required this.amount,
    required this.balanceDelta,
    required this.onTapAccount,
    required this.onTapAmount,
  });

  final String label;
  final Account? account;
  final bool isOutflow;
  final double amount;

  /// Signed change this transfer causes on [account]'s balance.
  final double balanceDelta;
  final VoidCallback onTapAccount;
  final VoidCallback onTapAmount;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final account = this.account;

    return Material(
      color: scheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(inputBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: InkWell(
              borderRadius: BorderRadius.all(
                inputBorderRadius - const Radius.circular(2),
              ),
              onTap: () {
                unfocusCurrentFocusedItem(context);
                onTapAccount();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
                child: Row(
                  children: [
                    account?.displayIcon(context) ??
                        IconDisplayer(
                          displayMode: IconDisplayMode.polygon,
                          icon: Icons.question_mark_rounded,
                          mainColor: scheme.primary,
                        ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium,
                          ),
                          Text(
                            account?.name ?? t.general.unspecified,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.expand_more_rounded,
                      color: scheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedExpanded(
            expand: account != null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: account == null
                        ? const SizedBox.shrink()
                        : _BalancePreview(
                            account: account,
                            delta: balanceDelta,
                          ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 3,
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: _AmountPill(
                        isOutflow: isOutflow,
                        amount: amount,
                        currency: account?.currency,
                        onTap: () {
                          unfocusCurrentFocusedItem(context);
                          onTapAmount();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalancePreview extends StatelessWidget {
  const _BalancePreview({required this.account, required this.delta});

  final Account account;
  final double delta;

  @override
  Widget build(BuildContext context) {
    final c = context.read<TransactionFormController>();
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium;

    return StreamBuilder<double>(
      stream: AccountService.instance.getAccountMoney(account: account),
      builder: (context, snap) {
        final balance = snap.data;
        if (balance == null) return const SizedBox.shrink();

        final after = balance + delta - c.oldTransferEffectOn(account.id);

        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              Text(
                _formatMoney(balance, account.currency),
                maxLines: 1,
                style: style,
              ),
              Icon(Icons.arrow_forward_rounded, size: 12, color: style?.color),
              Text(
                _formatMoney(after, account.currency),
                maxLines: 1,
                style: style,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AmountPill extends StatelessWidget {
  const _AmountPill({
    required this.isOutflow,
    required this.amount,
    required this.currency,
    required this.onTap,
  });

  final bool isOutflow;
  final double amount;
  final CurrencyInDB? currency;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = isOutflow
        ? AppColors.of(context).danger
        : AppColors.of(context).success;
    final label = '${isOutflow ? '−' : '+'}${_formatMoney(amount, currency)}';

    return Material(
      color: scheme.surface,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                Icon(
                  Icons.calculate_outlined,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DualLegDirectionButton extends StatelessWidget {
  const _DualLegDirectionButton({
    required this.reversed,
    required this.onPressed,
    this.disabled = false,
  });

  final bool reversed;
  final VoidCallback onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      onPressed: disabled ? null : onPressed,
      icon: AnimatedRotation(
        turns: reversed ? 0.5 : 0,
        duration: const Duration(milliseconds: 250),
        child: const Icon(Icons.swap_vert_rounded),
      ),
      tooltip: Translations.of(context).transfer.display,
    );
  }
}

class _CustomAmountsChip extends StatelessWidget {
  const _CustomAmountsChip({required this.active, required this.onPressed});

  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? scheme.primary : scheme.onSurfaceVariant;

    return Material(
      color: active
          ? scheme.primary.withValues(alpha: 0.12)
          : Colors.transparent,
      shape: StadiumBorder(
        side: BorderSide(
          color: active ? scheme.primary : scheme.outlineVariant,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Icon(
                active ? Icons.link_off_rounded : Icons.link_rounded,
                size: 16,
                color: color,
              ),
              Text(
                Translations.of(context).transfer.form.custom_amounts,
                maxLines: 1,
                softWrap: false,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            if (icon != null)
              Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
            Text(
              label,
              maxLines: 1,
              softWrap: false,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FxChip extends StatelessWidget {
  const _FxChip({required this.rate});

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: Translations.of(context).currencies.exchange_rate,
      child: _InfoChip(
        icon: Icons.swap_horiz_rounded,
        label: rate.toStringAsFixed(rate == rate.roundToDouble() ? 0 : 4),
      ),
    );
  }
}
