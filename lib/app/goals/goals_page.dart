import 'package:flutter/material.dart';
import 'package:monekin/app/goals/components/goal_card.dart';
import 'package:monekin/app/goals/goal_form_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/goal/goal_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: 'Goals',
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_rounded),
        label: Text(t.ui_actions.add),
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
            return const NoResults(
              title: 'No goals found',
              description: 'Create a new goal to start tracking your savings!',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 24).withSafeBottom(context),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return GoalCard(goal: goals[index]);
            },
          );
        },
      ),
    );
  }
}
