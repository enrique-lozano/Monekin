import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Opens a bottom sheet for choosing an account type.
///
/// Returns the selected [AccountType] immediately when the user taps an option,
/// or `null` if the sheet is dismissed without a selection.
Future<AccountType?> showAccountTypeSelector(
  BuildContext context, {
  required AccountType selectedType,
}) {
  return showModalBottomSheet<AccountType>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _AccountTypeSelectorSheet(selectedType: selectedType),
  );
}

class _AccountTypeSelectorSheet extends StatelessWidget {
  const _AccountTypeSelectorSheet({required this.selectedType});

  final AccountType selectedType;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.account.types.title,
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
            ...AccountType.values.map(
              (type) => OutlinedButtonStacked(
                text: type.title(context),
                alignLeft: true,
                alignBeside: true,
                filled: type == selectedType,
                afterWidget: Text(type.description(context)),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                onTap: () => RouteUtils.popRoute(type),
                iconData: type.icon,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
