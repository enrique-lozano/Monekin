import 'package:flutter/material.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class BottomSheetFooter extends StatelessWidget {
  const BottomSheetFooter({
    super.key,
    this.onSaved,
    this.showCloseIcon = true,
    this.submitText,
    this.submitIcon = Icons.save,
    this.extraActions = const [],
  });

  /// The text inside the submiit button. Defaults to "save" in the current language
  final String? submitText;

  final IconData submitIcon;

  final bool showCloseIcon;

  /// Function to trigger when the main button is pressed. The main button will be disabled if this function is null
  final void Function()? onSaved;

  final List<ListTileActionItem> extraActions;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final t = Translations.of(context);

    final confirmButton = FilledButton.icon(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.grey[200], // Background Color
        disabledForegroundColor: Colors.grey, //Text Color
      ),
      icon: Icon(submitIcon),
      label: Text(submitText ?? t.ui_actions.save),
      onPressed: onSaved != null
          ? () {
              onSaved!();
            }
          : null,
    );

    final closeButtonStyle =
        IconButton.styleFrom(
          side: BorderSide(color: colors.outline),
          backgroundColor: colors.surface,
        ).copyWith(
          foregroundColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return colors.onSurface;
            }
            return null;
          }),
        );

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        const Divider(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: showCloseIcon
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8,
                children: [
                  if (showCloseIcon)
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        RouteUtils.popRoute();
                      },
                      style: closeButtonStyle,
                    ),

                  ...extraActions.map(
                    (action) => IconButton(
                      onPressed: action.onClick,
                      icon: Icon(action.icon),
                      tooltip: action.label,
                      style: closeButtonStyle,
                    ),
                  ),
                ],
              ),
              confirmButton,
            ],
          ),
        ),
      ],
    );
  }
}
