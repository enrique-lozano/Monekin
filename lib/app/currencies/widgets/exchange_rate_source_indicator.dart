import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/services/exchange-rate/frankfurter_ecb.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class ExchangeRateSourceIndicator extends StatelessWidget {
  const ExchangeRateSourceIndicator({
    super.key,
    required this.loading,
    required this.rate,
    required this.matchesRate,
    required this.onUseValue,
  });

  final bool loading;
  final double? rate;
  final bool matchesRate;
  final VoidCallback onUseValue;

  @override
  Widget build(BuildContext context) {
    if (!loading && rate == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final form = Translations.of(context).currencies.exchange_rate_form;
    final colors = theme.colorScheme;
    final secondaryStyle = theme.textTheme.bodySmall?.copyWith(
      color: colors.onSurfaceVariant,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: colors.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getCardBorderRadius()),
          side: BorderSide(color: colors.primary.withValues(alpha: 0.35)),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 12, 8),
          child: Row(
            spacing: 12,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colors.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.account_balance_rounded,
                  size: 20,
                  color: colors.onSecondaryContainer,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loading
                          ? form.ecb_loading
                          : matchesRate
                          ? form.ecb_filled
                          : form.ecb_value(rate: rate.toString()),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                    Text(frankfurterEcbCredit, style: secondaryStyle),
                  ],
                ),
              ),
              SizedBox(
                width: 42,
                height: 42,
                child: loading
                    ? Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.primary,
                          ),
                        ),
                      )
                    : matchesRate
                    ? null
                    : IconButton.filledTonal(
                        onPressed: onUseValue,
                        tooltip: form.ecb_use_value,
                        icon: const Icon(Icons.sync_rounded),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
