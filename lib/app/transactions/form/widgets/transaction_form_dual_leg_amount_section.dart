import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_amount_block.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/tappable-text-entry.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:provider/provider.dart';

/// Transfer / asset trade: two bordered cards (source / destination) with
/// amounts, optional FX between them, and insufficient-balance warning.
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

class _DualLegCard extends StatelessWidget {
  const _DualLegCard({required this.borderColor, required this.child});

  final Color borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.all(inputBorderRadius),
        border: Border.all(color: borderColor.withOpacity(0.65), width: 1.2),
      ),
      child: Padding(padding: const EdgeInsets.only(bottom: 12), child: child),
    );
  }
}

class _DualLegBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.watch<TransactionFormController>();
    final isTransfer = c.transactionType.isTransfer;
    final from = c.fromAccount;
    final to = c.transferAccount;
    final asset = c.asset;
    final scheme = Theme.of(context).colorScheme;
    final borderColor = scheme.primary;

    final effectiveFrom = isTransfer ? c.effectiveTransferFromAccount : from;
    final effectiveTo = isTransfer ? c.effectiveTransferToAccount : null;

    final fxFromCode = isTransfer
        ? effectiveFrom?.currency.code
        : from?.currency.code;
    final fxToCode = isTransfer
        ? effectiveTo?.currency.code
        : asset?.currency.code;
    final differentCurrency =
        fxFromCode != null && fxToCode != null && fxFromCode != fxToCode;

    final topOut = c.dualLegTopIsOutflow;
    final reversed = c.dualLegFlowReversed;

    Widget buildLegs({
      required double defaultDest,
      required double destDisplay,
      required bool sourceMismatch,
      required bool destMismatch,
      required double expectedSource,
    }) {
      final topAmount = topOut ? c.transactionValue.abs() : destDisplay;
      final bottomAmount = topOut ? destDisplay : c.transactionValue.abs();
      final topCurrency = from?.currency;
      final bottomCurrency = isTransfer
          ? to?.currency
          : (c.amountDisplayCurrency ?? asset?.currency);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DualLegCard(
            borderColor: borderColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                _AccountLegHeader(
                  account: from,
                  onTapAccount: () => c.pickFromAccount(context),
                  subtitle: from == null
                      ? null
                      : _AccountCurrentBalanceSubtitle(account: from),
                ),
                _LegAmountRow(
                  show: from != null || !isTransfer,
                  isOutflow: topOut,
                  currency: topCurrency,
                  amount: topAmount,
                  onTapAmount: () {
                    if (isTransfer) {
                      if (topOut) {
                        c.openTransferSourceAmountSelector(context);
                      } else {
                        c.openTransferDestinationAmountSelector(
                          context,
                          defaultDestinationAmount: defaultDest,
                        );
                      }
                    } else if (topOut) {
                      c.openInvestmentCashAmountSelector(context);
                    } else {
                      c.openInvestmentValuationAmountSelector(context);
                    }
                  },
                  showReset: isTransfer
                      ? (topOut ? sourceMismatch : destMismatch)
                      : c.investmentValuationUnlinked,
                  onReset: isTransfer
                      ? (topOut
                            ? () => c.alignTransferSourceFromInverseConverted(
                                expectedSource,
                              )
                            : c.clearTransferDestinationOverride)
                      : (topOut
                            ? c.alignCashAmountToInvestmentValuation
                            : c.clearInvestmentValuationOverride),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _DualLegDirectionButton(
                  reversed: reversed,
                  disabled: to == null && isTransfer,
                  onPressed: () => _onDirectionPressed(context, c),
                ),
                if (differentCurrency) ...[
                  const Spacer(),
                  _FxChip(fromCode: fxFromCode, toCode: fxToCode, date: c.date),
                ],
              ],
            ),
          ),
          ShakeWidget(
            duration: const Duration(milliseconds: 200),
            shakeCount: 1,
            shakeOffset: 10,
            key: c.shakeKey,
            child: _DualLegCard(
              borderColor: borderColor,
              child: Builder(
                builder: (context) {
                  final buildAmountRow = isTransfer
                      ? to != null
                      : asset != null && c.updateValuations;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      if (isTransfer)
                        _AccountLegHeader(
                          account: to,
                          onTapAccount: () => c.pickTransferAccount(context),
                          subtitle: to == null
                              ? null
                              : _AccountCurrentBalanceSubtitle(account: to),
                        )
                      else
                        _AssetLegHeader(
                          assetName: asset?.name,
                          showPicker: c.canPickAsset,
                          onTapAsset: c.canPickAsset
                              ? () => c.pickAsset(context)
                              : null,
                          subtitle: asset != null
                              ? _AssetBookedValueSubtitle(
                                  asset: asset,
                                  date: c.date,
                                )
                              : null,
                        ),

                      if (buildAmountRow) const SizedBox(height: 10),

                      _LegAmountRow(
                        show: buildAmountRow,
                        isOutflow: !topOut,
                        currency: bottomCurrency,
                        amount: bottomAmount,
                        onTapAmount: () {
                          if (isTransfer) {
                            if (!topOut) {
                              c.openTransferSourceAmountSelector(context);
                            } else {
                              c.openTransferDestinationAmountSelector(
                                context,
                                defaultDestinationAmount: defaultDest,
                              );
                            }
                          } else if (topOut) {
                            c.openInvestmentValuationAmountSelector(context);
                          } else {
                            c.openInvestmentCashAmountSelector(context);
                          }
                        },
                        showReset: isTransfer
                            ? (topOut ? destMismatch : sourceMismatch)
                            : c.investmentValuationUnlinked,
                        onReset: isTransfer
                            ? (topOut
                                  ? c.clearTransferDestinationOverride
                                  : () => c
                                        .alignTransferSourceFromInverseConverted(
                                          expectedSource,
                                        ))
                            : (topOut
                                  ? c.clearInvestmentValuationOverride
                                  : c.alignCashAmountToInvestmentValuation),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    if (isTransfer && effectiveFrom != null && effectiveTo != null) {
      return StreamBuilder(
        stream: ExchangeRateService.instance.calculateExchangeRate(
          fromCurrency: effectiveFrom.currency.code,
          toCurrency: effectiveTo.currency.code,
          amount: c.transactionValue.abs(),
          date: c.date,
        ),
        builder: (context, snap) {
          final defaultDest = snap.data ?? c.transactionValue.abs();
          final destDisplay = c.valueInDestinyToNumber ?? defaultDest;
          final sAbs = c.transactionValue.abs();
          final expectedSource = defaultDest <= 1e-12
              ? sAbs
              : destDisplay * sAbs / defaultDest;
          final sourceMismatch = !TransactionFormController.nearlyEqualMoney(
            sAbs,
            expectedSource,
          );
          final destMismatch = !TransactionFormController.nearlyEqualMoney(
            destDisplay,
            defaultDest,
          );

          return buildLegs(
            defaultDest: defaultDest,
            destDisplay: destDisplay,
            sourceMismatch: sourceMismatch,
            destMismatch: destMismatch,
            expectedSource: expectedSource,
          );
        },
      );
    }

    final cashAbs = c.transactionValue.abs();
    final valuationDisplay = c.investmentValuationAmount;
    final unlinked = c.investmentValuationUnlinked;

    return buildLegs(
      defaultDest: cashAbs,
      destDisplay: valuationDisplay,
      sourceMismatch: unlinked,
      destMismatch: unlinked,
      expectedSource: valuationDisplay,
    );
  }

  void _onDirectionPressed(BuildContext context, TransactionFormController c) {
    c.toggleDualLegFlowDirection();

    if (!c.isAssetTradeInvestment) return;

    final t = Translations.of(context);
    final buyL = t.assets.details.buy;
    final sellL = t.assets.details.sell;
    final cur = c.titleController.text.trim();
    if (cur.isEmpty || cur == buyL || cur == sellL) {
      c.titleController.text = c.investmentIsBuy ? buyL : sellL;
    }
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
    return IconButton.filledTonal(
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: disabled ? null : onPressed,
      icon: AnimatedRotation(
        turns: reversed ? 0.5 : 0,
        duration: const Duration(milliseconds: 250),
        child: Icon(Icons.arrow_downward_rounded),
      ),
      tooltip: Translations.of(context).transfer.display,
    );
  }
}

class _AccountCurrentBalanceSubtitle extends StatelessWidget {
  const _AccountCurrentBalanceSubtitle({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return StreamBuilder<double>(
      initialData: 0,
      stream: AccountService.instance.getAccountMoney(account: account),
      builder: (context, snap) {
        final bal = snap.data ?? 0;
        final formatted = UINumberFormatter.currency(
          amountToConvert: bal,
          currency: account.currency,
          showDecimals: true,
        ).getFormattedAmount();

        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${t.account.form.current_balance}: $formatted',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: muted,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}

class _AssetBookedValueSubtitle extends StatelessWidget {
  const _AssetBookedValueSubtitle({required this.asset, required this.date});

  final Asset asset;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return StreamBuilder<double>(
      stream: InvestmentService.instance.getAssetValueAtDate(asset, date: date),
      builder: (context, snap) {
        final value = snap.data ?? asset.initialValue;
        final formatted = UINumberFormatter.currency(
          amountToConvert: value,
          currency: asset.currency,
          showDecimals: true,
        ).getFormattedAmount();

        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${t.assets.details.trade_sheet_valuation_current_value_label}: $formatted',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: muted,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}

class _FxChip extends StatelessWidget {
  const _FxChip({
    required this.fromCode,
    required this.toCode,
    required this.date,
  });

  final String fromCode;
  final String toCode;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return StreamBuilder<double>(
      stream: ExchangeRateService.instance.calculateExchangeRate(
        fromCurrency: fromCode,
        toCurrency: toCode,
        amount: 1,
        date: date,
      ),
      builder: (context, snap) {
        final m = snap.data ?? 1;
        final decimals = m == m.roundToDouble() ? 0 : 4;
        final label = m.toStringAsFixed(decimals);

        return Tooltip(
          message: t.currencies.exchange_rate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: scheme.outlineVariant),
              color: scheme.surface,
            ),
            child: Row(
              spacing: 4,
              children: [
                Icon(
                  Icons.swap_horiz_rounded,
                  size: 16,
                  color: scheme.onSurfaceVariant,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AccountLegHeader extends StatelessWidget {
  const _AccountLegHeader({
    required this.account,
    required this.onTapAccount,
    this.subtitle,
  });

  final Account? account;
  final VoidCallback onTapAccount;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Tappable(
      onTap: () {
        unfocusCurrentFocusedItem(context);
        onTapAccount();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      bgColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            account?.displayIcon(context) ??
                IconDisplayer(
                  displayMode: IconDisplayMode.polygon,
                  icon: Icons.question_mark_rounded,
                  mainColor: scheme.primary,
                ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          account?.name ?? t.general.unspecified,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.expand_more_rounded,
                        color: scheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetLegHeader extends StatelessWidget {
  const _AssetLegHeader({
    required this.assetName,
    required this.showPicker,
    this.onTapAsset,
    this.subtitle,
  });

  final String? assetName;
  final bool showPicker;
  final VoidCallback? onTapAsset;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = assetName ?? '…';

    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconDisplayer(
            displayMode: IconDisplayMode.polygon,
            icon: Icons.pie_chart_outline_rounded,
            mainColor: scheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (showPicker)
                      Icon(
                        Icons.expand_more_rounded,
                        color: scheme.onSurfaceVariant,
                        size: 20,
                      ),
                  ],
                ),
                if (subtitle != null) subtitle!,
              ],
            ),
          ),
        ],
      ),
    );

    if (!showPicker || onTapAsset == null) {
      return content;
    }

    return Tappable(
      onTap: () {
        unfocusCurrentFocusedItem(context);
        onTapAsset!();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      bgColor: Colors.transparent,
      child: content,
    );
  }
}

class _LegAmountRow extends StatelessWidget {
  const _LegAmountRow({
    required this.isOutflow,
    required this.amount,
    required this.onTapAmount,
    required this.showReset,
    required this.onReset,
    this.currency,
    this.show = true,
  });

  final bool isOutflow;
  final double amount;
  final CurrencyInDB? currency;
  final VoidCallback onTapAmount;
  final bool showReset;
  final VoidCallback? onReset;

  final bool show;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = isOutflow
        ? AppColors.of(context).danger
        : AppColors.of(context).success;
    final formatted = currency != null
        ? UINumberFormatter.currency(
            amountToConvert: amount,
            currency: currency!,
            showDecimals: true,
          ).getFormattedAmount()
        : amount.toStringAsFixed(2);
    final label = isOutflow ? '- $formatted' : formatted;

    return AnimatedExpanded(
      expand: show,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        alignment: AlignmentDirectional.centerEnd,

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showReset && onReset != null) ...[
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: scheme.primary.withOpacity(0.12),
                  foregroundColor: scheme.onSurfaceVariant,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: const Size(32, 32),
                  padding: EdgeInsets.zero,
                ),
                onPressed: onReset,
                icon: const Icon(Icons.close_rounded, size: 18),
                tooltip: MaterialLocalizations.of(context).cancelButtonLabel,
              ),
              const SizedBox(width: 6),
            ],
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isOutflow
                          ? Icons.arrow_drop_down_rounded
                          : Icons.arrow_drop_up_rounded,
                      color: accent,
                      size: 26,
                    ),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: TappableTextEntry(
                        title: label,
                        placeholder: '0',
                        onTap: () {
                          unfocusCurrentFocusedItem(context);
                          onTapAmount();
                        },
                        enableAnimatedSwitcher: false,
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                        padding: EdgeInsetsDirectional.zero,
                        internalPadding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
