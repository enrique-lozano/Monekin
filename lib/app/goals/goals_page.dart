import 'package:flutter/material.dart';
import 'package:monekin/app/goals/goal_form_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/goal/goal_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/targets/financial_target_card.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.goals.title,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_rounded),
        label: Text(t.goals.form.new_title),
        onPressed: () => RouteUtils.pushRoute(const GoalFormPage()),
      ),
      body: StreamBuilder(
        stream: GoalService.instance.getGoals(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final goals = snapshot.data!;

          if (goals.isEmpty) {
            return NoResults(
              title: t.goals.empty_title,
              description: t.goals.empty_description,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 24).withSafeBottom(context),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return FinancialTargetCard(target: goals[index]);
            },
          );
        },
      ),
    );
  }
}
