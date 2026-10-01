import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Opens a bottom sheet for choosing an account tracking mode.
///
/// Returns the selected [AccountTrackingMode] immediately when the user taps an option,
/// or `null` if the sheet is dismissed without a selection.
Future<AccountTrackingMode?> showTrackingModeSelector(
  BuildContext context, {
  required AccountTrackingMode selectedMode,
}) {
  return RouteUtils.showResponsiveModal<AccountTrackingMode>(
    context,
    builder: (context) =>
        _TrackingModeSelectorSheet(selectedMode: selectedMode),
  );
}

class _TrackingModeSelectorSheet extends StatelessWidget {
  const _TrackingModeSelectorSheet({required this.selectedMode});

  final AccountTrackingMode selectedMode;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.account.tracking_modes.title,
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
            ...AccountTrackingMode.values.map(
              (mode) => OutlinedButtonStacked(
                text: mode.title(context),
                alignLeft: true,
                alignBeside: true,
                filled: mode == selectedMode,
                afterWidget: Text(mode.description(context)),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                onTap: () => RouteUtils.popRoute(mode),
                iconData: mode.icon,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
