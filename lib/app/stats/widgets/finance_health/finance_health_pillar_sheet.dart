import 'package:flutter/material.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_pillar_meta.dart';
import 'package:monekin/app/stats/widgets/finance_health/finance_health_sheet_widgets.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/finance_health_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Opens a sheet (or a right-side drawer on wide layouts) with the details of
/// a single financial-health pillar.
void showFinanceHealthPillarSheet(
  BuildContext context, {
  required FinanceHealthPillarMeta pillar,
}) {
  RouteUtils.showResponsiveSheet(
    context: context,
    builder: (context) => FinanceHealthPillarSheet(pillar: pillar),
  );
}

class FinanceHealthPillarSheet extends StatelessWidget {
  const FinanceHealthPillarSheet({super.key, required this.pillar});

  final FinanceHealthPillarMeta pillar;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final attrScore = pillar.attrScore;
    final isPaused = pillar.isPaused;
    final color = isPaused
        ? AppColors.of(context).textHint
        : FinanceHealthData.getHealthyValueColor(attrScore.score);

    return ModalContainer(
      title: pillar.title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pillar.valueText,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            FinanceHealthPill(
              text: isPaused
                  ? t.financial_health.paused_points(
                      total: attrScore.weight.toString(),
                    )
                  : t.financial_health.points_contribution(
                      earned: attrScore.weightedValueString(),
                      total: attrScore.weight.toString(),
                    ),
              color: color,
            ),
            const SizedBox(height: 20),
            HTMLText(
              tags: const {'b': TextStyle(fontWeight: FontWeight.bold)},
              htmlString: pillar.descriptionHtml,
            ),
            const SizedBox(height: 20),
            FinanceHealthSectionLabel(t.financial_health.about_indicator),
            const SizedBox(height: 6),
            Text(
              pillar.aboutText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            FinanceHealthSectionLabel(
              isPaused
                  ? t.financial_health.how_to_unlock
                  : t.financial_health.formula_label,
            ),
            const SizedBox(height: 6),
            Text(
              isPaused ? pillar.unlockText : pillar.formulaText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (pillar.prevAttrScore != null) ...[
              const SizedBox(height: 20),
              const Divider(height: 1),
              const SizedBox(height: 16),
              FinanceHealthSectionLabel(t.financial_health.your_own_past),
              const SizedBox(height: 12),
              _PillarPeriodRow(
                label: t.financial_health.previous_period_label,
                attrScore: pillar.prevAttrScore,
              ),
              const SizedBox(height: 10),
              _PillarPeriodRow(
                label: t.financial_health.now_label,
                attrScore: attrScore,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// The score this pillar had in a given period, in points of the total score.
class _PillarPeriodRow extends StatelessWidget {
  const _PillarPeriodRow({required this.label, required this.attrScore});

  final String label;
  final FinanceHealthAttrScore? attrScore;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final attrScore = this.attrScore;
    final available = attrScore != null && !attrScore.canNotBeCalculated;

    return FinanceHealthPeriodScoreRow(
      label: label,
      score: available ? attrScore.score : null,
      pointsText: available
          ? t.financial_health.points_short(
              value: attrScore.weightedValueString(),
            )
          : null,
    );
  }
}
