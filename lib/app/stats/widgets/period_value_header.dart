import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// The amount reached at the end of the selected range next to how it evolved
/// along it. Sits on top of the evolution charts of the stats page.
class PeriodValueHeader extends StatelessWidget {
  const PeriodValueHeader({
    super.key,
    required this.label,
    required this.value,
    required this.relativeChange,
  });

  final String label;

  /// Amount at the end of the range. Null while it loads.
  final double? value;

  /// Change of [value] along the range, as a fraction of its initial amount.
  /// Null while it loads.
  final double? relativeChange;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final headlineStyle = Theme.of(context).textTheme.headlineSmall!;

    return Skeletonizer(
      enabled: value == null || relativeChange == null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              if (value == null)
                const Bone(width: 70, height: 40)
              else
                CurrencyDisplayer(
                  amountToConvert: value!,
                  integerStyle: headlineStyle,
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                t.stats.compared_to_previous_period,
                style: const TextStyle(fontSize: 12),
              ),
              if (relativeChange == null)
                const Bone(width: 52, height: 22)
              else
                TrendingValue(
                  percentage: relativeChange!,
                  fontWeight: headlineStyle.fontWeight!,
                  fontSize: headlineStyle.fontSize!,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
