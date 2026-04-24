import 'package:flutter/material.dart';
import 'package:monekin/app/stats/widgets/net_worth/net_worth_composition_card.dart';
import 'package:monekin/app/stats/widgets/net_worth/net_worth_evolution_card.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class NetWorthTab extends StatelessWidget {
  const NetWorthTab({
    super.key,
    required this.filters,
    required this.dateRangeService,
  });

  final TransactionFilterSet filters;
  final DatePeriodState dateRangeService;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardWithHeader(
          title: t.stats.net_worth,
          subtitle: t.stats.net_worth_subtitle,
          bodyPadding: const EdgeInsets.only(
            bottom: 12,
            top: 16,
            right: 16,
            left: 16,
          ),
          body: NetWorthEvolutionCard(
            dateRangeService: dateRangeService,
            filters: filters,
          ),
        ),
        const SizedBox(height: 16),
        CardWithHeader(
          title: t.stats.net_worth_composition,
          subtitle: t.stats.net_worth_composition_subtitle,
          bodyPadding: const EdgeInsets.only(
            bottom: 12,
            top: 16,
            right: 16,
            left: 16,
          ),
          body: NetWorthCompositionCard(
            dateRangeService: dateRangeService,
            filters: filters,
          ),
        ),
      ],
    );
  }
}
