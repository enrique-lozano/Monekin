import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_amount_block.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/tappable-text-entry.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/utils/focus.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Transfer / asset trade: two bordered legs with per-leg amount entry.
class TransactionFormDualLegAmountSection extends StatelessWidget {
  const TransactionFormDualLegAmountSection({
    super.key,
    required this.controller,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 12),
  });

  final TransactionFormController controller;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Padding(
      padding: padding,
      child: ListenableBuilder(
        listenable: Listenable.merge([
          c,
          c.amountTextController,
          c.valueInDestinyController,
        ]),
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (c.transactionType.isTransfer)
                _TransferDualLegBody(controller: c)
              else
                _InvestmentDualLegBody(controller: c),
              TransactionFormAmountBlock.preferredCurrencyHint(context, c),
              TransactionFormAmountBlock.insufficientBalanceWarning(
                context,
                c,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TransferDualLegBody extends StatelessWidget {
  const _TransferDualLegBody({required this.controller});

  final TransactionFormController controller;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final from = c.fromAccount;
    final to = c.transferAccount;
    final scheme = Theme.of(context).colorScheme;

    if (from == null || to == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _LegCard(
            borderColor: scheme.primary,
            child: _AccountLegHeader(
              account: from,
              onTapAccount: () => c.pickFromAccount(context),
            ),
          ),
          const SizedBox(height: 8),
          ShakeWidget(
            duration: const Duration(milliseconds: 200),
            shakeCount: 1,
            shakeOffset: 10,
            key: c.shakeKey,
            child: _LegCard(
              borderColor: scheme.primary,
              child: _AccountLegHeader(
                account: to,
                onTapAccount: () => c.pickTransferAccount(context),
              ),
            ),
          ),
        ],
      );
    }

    return StreamBuilder<double>(
      stream: ExchangeRateService.instance.calculateExchangeRate(
        fromCurrency: from.currency.code,
        toCurrency: to.currency.code,
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _LegCard(
              borderColor: scheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AccountLegHeader(
                    account: from,
                    onTapAccount: () => c.pickFromAccount(context),
                  ),
                  const SizedBox(height: 10),
                  _LegAmountRow(
                    isOutflow: true,
                    currency: from.currency,
                    amount: c.transactionValue.abs(),
                    onTapAmount: () =>
                        c.openTransferSourceAmountSelector(context),
                    showReset: sourceMismatch,
                    onReset: sourceMismatch
                        ? () => c.alignTransferSourceFromInverseConverted(
                            expectedSource,
                          )
                        : null,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
              child: Row(
                children: [
                  IconButton.filledTonal(
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: c.swapTransferAccounts,
                    icon: const Icon(Icons.arrow_downward_rounded),
                    tooltip: Translations.of(context).transfer.display,
                  ),
                  const Spacer(),
                  _FxChip(
                    fromCode: from.currency.code,
                    toCode: to.currency.code,
                    date: c.date,
                  ),
                ],
              ),
            ),
            ShakeWidget(
              duration: const Duration(milliseconds: 200),
              shakeCount: 1,
              shakeOffset: 10,
              key: c.shakeKey,
              child: _LegCard(
                borderColor: scheme.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _AccountLegHeader(
                      account: to,
                      onTapAccount: () => c.pickTransferAccount(context),
                    ),
                    const SizedBox(height: 10),
                    _LegAmountRow(
                      isOutflow: false,
                      currency: to.currency,
                      amount: destDisplay,
                      onTapAmount: () =>
                          c.openTransferDestinationAmountSelector(
                            context,
                            defaultDestinationAmount: defaultDest,
                          ),
                      showReset: destMismatch,
                      onReset: destMismatch
                          ? c.clearTransferDestinationOverride
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InvestmentDualLegBody extends StatelessWidget {
  const _InvestmentDualLegBody({required this.controller});

  final TransactionFormController controller;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final from = c.fromAccount;
    final asset = c.asset;
    final scheme = Theme.of(context).colorScheme;
    final topOut = c.investmentIsBuy;
    final displayCurrency =
        c.amountDisplayCurrency ?? from?.currency ?? asset?.currency;

    final middle = (from != null &&
            asset != null &&
            from.currency.code != asset.currency.code)
        ? Padding(
            padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_downward_rounded,
                  color: scheme.onSurfaceVariant,
                ),
                const Spacer(),
                _FxChip(
                  fromCode: from.currency.code,
                  toCode: asset.currency.code,
                  date: c.date,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Icon(
                Icons.arrow_downward_rounded,
                color: scheme.onSurfaceVariant,
              ),
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LegCard(
          borderColor: c.investmentAccent(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AccountLegHeader(
                account: from,
                onTapAccount: () => c.pickFromAccount(context),
              ),
              const SizedBox(height: 10),
              _LegAmountRow(
                isOutflow: topOut,
                currency: from?.currency,
                amount: c.transactionValue.abs(),
                onTapAmount: () => c.openInvestmentAmountSelector(context),
                showReset: false,
                onReset: null,
              ),
            ],
          ),
        ),
        middle,
        _LegCard(
          borderColor: c.investmentAccent(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AssetLegHeader(
                assetName: asset?.name,
                currency: asset?.currency,
              ),
              const SizedBox(height: 10),
              _LegAmountRow(
                isOutflow: !topOut,
                currency: displayCurrency,
                amount: c.transactionValue.abs(),
                onTapAmount: () => c.openInvestmentAmountSelector(context),
                showReset: false,
                onReset: null,
              ),
            ],
          ),
        ),
      ],
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
        final label = '× ${m.toStringAsFixed(decimals)}';
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: scheme.outlineVariant),
            color: scheme.surface,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        );
      },
    );
  }
}

class _LegCard extends StatelessWidget {
  const _LegCard({
    required this.borderColor,
    required this.child,
  });

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: child,
      ),
    );
  }
}

class _AccountLegHeader extends StatelessWidget {
  const _AccountLegHeader({
    required this.account,
    required this.onTapAccount,
  });

  final Account? account;
  final VoidCallback onTapAccount;

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
      bgColor: scheme.surfaceContainerHigh.withOpacity(0.35),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
              child: Text(
                account != null
                    ? '${account!.name} • ${account!.currency.symbol}'
                    : t.general.unspecified,
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
      ),
    );
  }
}

class _AssetLegHeader extends StatelessWidget {
  const _AssetLegHeader({
    required this.assetName,
    required this.currency,
  });

  final String? assetName;
  final CurrencyInDB? currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = assetName ?? '…';
    final curLabel = currency?.symbol ?? '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconDisplayer(
            displayMode: IconDisplayMode.polygon,
            icon: Icons.pie_chart_outline_rounded,
            mainColor: scheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              curLabel.isEmpty ? name : '$name • $curLabel',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
  });

  final bool isOutflow;
  final double amount;
  final CurrencyInDB? currency;
  final VoidCallback onTapAmount;
  final bool showReset;
  final VoidCallback? onReset;

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

    return Align(
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
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
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
                      internalPadding:
                          const EdgeInsetsDirectional.symmetric(
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
    );
  }
}
