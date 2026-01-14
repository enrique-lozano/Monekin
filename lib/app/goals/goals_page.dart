import 'package:flutter/material.dart';
import 'package:monekin/app/goals/goal_form_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/goal/goal_service.dart';
import 'package:monekin/core/presentation/widgets/targets/target_list_with_empty_indicator.dart';
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

          return TargetListWithEmptyIndicator(
            targets: goals,
            emptyDescription: t.goals.empty_description,
            emptyTitle: t.goals.empty_title,
          );
        },
      ),
    );
  }
}
