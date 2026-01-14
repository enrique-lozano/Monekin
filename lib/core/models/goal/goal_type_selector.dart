import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/goal/goal_type.enum.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<ModalResult<GoalType>?> showGoalTypeModal(
  BuildContext context, {
  required GoalType? initialType,
}) {
  return showModalBottomSheet<ModalResult<GoalType>>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return GoalTypeSelector(initialType: initialType);
    },
  );
}

class GoalTypeSelector extends StatelessWidget {
  const GoalTypeSelector({super.key, required this.initialType});

  final GoalType? initialType;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.goals.type.display,
      responseToKeyboard: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 0,
        ).withSafeBottom(context),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...GoalType.values.map(
              (type) => OutlinedButtonStacked(
                text: type.title(context),
                alignLeft: true,
                alignBeside: true,
                filled: type == initialType,
                color: type.color(context),
                afterWidget: Text(type.description(context)),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                onTap: () {
                  RouteUtils.popRoute(ModalResult(type));
                },
                iconData: Icons.golf_course,
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
