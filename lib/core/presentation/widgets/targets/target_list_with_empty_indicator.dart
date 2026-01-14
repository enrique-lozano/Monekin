import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/mixins/financial_target_mixin.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/targets/financial_target_card.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TargetListWithEmptyIndicator extends StatelessWidget {
  const TargetListWithEmptyIndicator({
    super.key,
    required this.targets,
    this.emptyTitle,
    required this.emptyDescription,
  });

  final List<FinancialTarget> targets;

  final String? emptyTitle;
  final String emptyDescription;

  @override
  Widget build(BuildContext context) {
    if (targets.isEmpty) {
      return Column(
        children: [
          Expanded(
            child: NoResults(
              title: emptyTitle ?? t.general.empty_warn,
              description: emptyDescription,
            ),
          ),
        ],
      );
    }

    if (BreakPoint.of(context).isLargerThan(BreakpointID.md)) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 74,
          left: 16,
          right: 16,
        ).withSafeBottom(context),
        child: Wrap(
          spacing: 16,
          runSpacing: 0,
          children: targets
              .map(
                (target) => LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width:
                          BreakPoint.of(context).isLargerThan(BreakpointID.xxl)
                          ? constraints.maxWidth / 4 - 12
                          : BreakPoint.of(context).isLargerThan(BreakpointID.lg)
                          ? constraints.maxWidth / 3 - 12
                          : constraints.maxWidth / 2 - 12,
                      child: FinancialTargetCard(target: target),
                    );
                  },
                ),
              )
              .toList(),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 74,
        left: 16,
        right: 16,
      ).withSafeBottom(context),
      itemCount: targets.length,
      itemBuilder: (context, index) {
        final target = targets[index];

        return FinancialTargetCard(target: target);
      },
    );
  }
}
