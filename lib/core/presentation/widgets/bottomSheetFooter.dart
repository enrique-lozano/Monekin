import 'package:flutter/material.dart';
import 'package:monekin/i18n/translations.g.dart';

class BottomSheetFooter extends StatelessWidget {
  const BottomSheetFooter(
      {super.key,
      this.onSaved,
      this.showCloseIcon = true,
      this.submitText,
      this.submitIcon = Icons.save});

  /// The text inside the submiit button. Defaults to "save" in the current language
  final String? submitText;

  final IconData submitIcon;

  final bool showCloseIcon;

  /// Function to trigger when the main button is pressed. The main button will be disabled if this function is null
  final void Function()? onSaved;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final t = Translations.of(context);

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
              if (showCloseIcon)
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: IconButton.styleFrom(
                          side: BorderSide(color: colors.outline),
                          backgroundColor: colors.background)
                      .copyWith(
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return colors.onSurface;
                      }
                      return null;
                    }),
                  ),
                ),
              FilledButton.icon(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor:
                        Colors.grey[200], // Background Color
                    disabledForegroundColor: Colors.grey, //Text Color
                  ),
                  icon: Icon(submitIcon),
                  label: Text(submitText ?? t.general.save),
                  onPressed: onSaved != null
                      ? () {
                          onSaved!();
                        }
                      : null),
            ],
          ),
        ),
      ],
    );
  }
}
