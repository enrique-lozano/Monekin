import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/string.extension.dart';
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

/// Bottom sheet with period return, invested amount, and raw valuation change.
Future<void> showAssetPerformanceBottomSheet({
  required BuildContext context,
  required Asset asset,
  required ChartTimePeriod effectivePeriod,
  required DateTime rangeStartDate,
  required double performanceReturnMoney,
  required double performanceReturnFraction,
  required double valueDiffMoney,
  required double valueDiffFraction,
  required double netInvestedNow,
}) async {
  final t = Translations.of(context);
  final periodLabel = effectivePeriod.localizedLabel(context);
  final startText = getMMMdDateFormatBasedOnYear(rangeStartDate).text;

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (ctx) {
      final TextStyle statValueStyle = Theme.of(
        ctx,
      ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600);

      return ModalContainer(
        title: t.assets.details.performance_sheet_title,
        subtitle: '$periodLabel · $startText',
        showTitleDivider: true,
        responseToKeyboard: false,
        bodyPadding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        body: SingleChildScrollView(
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetPerformanceStatTile(
                icon: Icons.trending_up_rounded,
                label: t.assets.details.performance_return,
                helpText: t.assets.details.performance_return_help,
                value: Row(
                  spacing: 6,
                  children: [
                    CurrencyDisplayer(
                      amountToConvert: performanceReturnMoney,
                      currency: asset.currency,
                      integerStyle: statValueStyle,
                    ),
                    Text('·', style: statValueStyle),
                    TrendingValue(
                      percentage: clampAssetPerformanceTrendFraction(
                        performanceReturnFraction,
                      ),
                      fontWeight: statValueStyle.fontWeight ?? FontWeight.w600,
                      fontSize: statValueStyle.fontSize ?? 18,
                    ),
                  ],
                ),
              ),
              AssetPerformanceStatTile(
                icon: Icons.savings_outlined,
                label: t.assets.details.performance_invested_value,
                helpText: t.assets.details.performance_invested_value_caption,
                value: CurrencyDisplayer(
                  amountToConvert: netInvestedNow,
                  currency: asset.currency,
                  integerStyle: statValueStyle,
                ),
              ),
              AssetPerformanceStatTile(
                icon: Icons.history_rounded,
                label: t.assets.details.performance_value_diff,
                helpText: t.assets.details.performance_value_diff_caption,
                value: Row(
                  spacing: 6,
                  children: [
                    CurrencyDisplayer(
                      amountToConvert: valueDiffMoney,
                      currency: asset.currency,
                      integerStyle: statValueStyle,
                    ),
                    Text('·', style: statValueStyle),
                    TrendingValue(
                      percentage: clampAssetPerformanceTrendFraction(
                        valueDiffFraction,
                      ),
                      fontWeight: statValueStyle.fontWeight ?? FontWeight.w600,
                      fontSize: statValueStyle.fontSize ?? 18,
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
    this.helpText,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String? helpText;
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

    return ListTile(
      leading: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: colorScheme.onPrimaryContainer, size: 22),
        ),
      ),
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: value,
      shape: border,
      trailing: helpText.isNotNullNorEmpty
          ? Tooltip(
              constraints: BoxConstraints(
                maxWidth: min(MediaQuery.widthOf(context) * 0.95, 250),
              ),
              triggerMode: TooltipTriggerMode.tap,
              message: helpText,
              child: const Icon(Icons.info_outline_rounded, size: 18),
            )
          : null,
    );
  }
}
