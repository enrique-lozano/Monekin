import 'package:flutter/material.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/presentation/widgets/chart_time_period_selector.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Clamps extreme fractions so [TrendingValue] stays readable in the UI.
double clampAssetPerformanceTrendFraction(double fraction) {
  if (fraction.isNaN || !fraction.isFinite) return 0;
  if (fraction > 10) return 10;
  if (fraction < -10) return -10;
  return fraction;
}

/// Bottom sheet with lifetime and chart-range performance for an asset.
Future<void> showAssetPerformanceBottomSheet({
  required BuildContext context,
  required Asset asset,
  required ChartTimePeriod effectivePeriod,
  required DateTime rangeStartDate,
  required ({double value, double percent}) lifetimeProfit,
  required double periodReturnFraction,
  required double periodBenefitMoney,
  required double netInvestedNow,
}) async {
  final t = Translations.of(context);
  final scheme = Theme.of(context).colorScheme;
  final periodLabel = effectivePeriod.localizedLabel(context);
  final startText = getMMMdDateFormatBasedOnYear(rangeStartDate).text;

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (ctx) {
      return ModalContainer(
        title: t.assets.details.performance_sheet_title,
        subtitle: '$periodLabel · $startText',
        showTitleDivider: true,
        responseToKeyboard: false,
        bodyPadding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        body: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              AssetPerformanceStatTile(
                icon: Icons.trending_up_rounded,
                label: t.assets.details.performance_benefit,
                caption: t.assets.details.performance_benefit_caption,
                value: TrendingValue(
                  percentage: lifetimeProfit.percent,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              AssetPerformanceStatTile(
                icon: Icons.payments_outlined,
                label: t.assets.details.performance_monetary_diff,
                caption: t.assets.details.performance_monetary_diff_caption,
                value: CurrencyDisplayer(
                  amountToConvert: lifetimeProfit.value,
                  currency: asset.currency,
                  integerStyle: Theme.of(ctx).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AssetPerformanceStatTile(
                icon: Icons.savings_outlined,
                label: t.assets.details.performance_invested_value,
                caption: t.assets.details.performance_invested_value_caption,
                value: CurrencyDisplayer(
                  amountToConvert: netInvestedNow,
                  currency: asset.currency,
                  integerStyle: Theme.of(ctx).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AssetPerformanceStatTile(
                icon: Icons.history_rounded,
                label: t.assets.details.performance_value_diff,
                caption: t.assets.details.performance_value_diff_caption,
                value: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TrendingValue(
                      percentage: clampAssetPerformanceTrendFraction(
                        periodReturnFraction,
                      ),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    const SizedBox(height: 6),
                    CurrencyDisplayer(
                      amountToConvert: periodBenefitMoney,
                      currency: asset.currency,
                      integerStyle: Theme.of(ctx).textTheme.bodyMedium!.copyWith(
                        color: scheme.onSurfaceVariant,
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
    },
  );
}

class AssetPerformanceStatTile extends StatelessWidget {
  const AssetPerformanceStatTile({
    super.key,
    required this.icon,
    required this.label,
    required this.caption,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String caption;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: colorScheme.outlineVariant.withValues(alpha: 0.35),
      ),
    );
    return Material(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: border,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(icon, color: colorScheme.onPrimaryContainer, size: 22),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    caption,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              flex: 0,
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.end,
                child: value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
