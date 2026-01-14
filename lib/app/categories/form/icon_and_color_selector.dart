import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker_modal.dart';
import 'package:monekin/core/presentation/widgets/icon_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class IconAndColorSelector extends StatelessWidget {
  const IconAndColorSelector({
    super.key,
    required this.iconSelectorModalSubtitle,
    required this.iconDisplayer,
    required this.onDataChange,
    required this.data,
  });

  final String iconSelectorModalSubtitle;

  final void Function(({SupportedIcon icon, Color color}) data) onDataChange;

  final ({SupportedIcon icon, Color color}) data;
  final IconDisplayer iconDisplayer;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final bgColor =
        Theme.of(context).inputDecorationTheme.fillColor ??
        Theme.of(context).colorScheme.surfaceContainerHighest;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(inputBorderRadius),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: iconDisplayer,
          ),
          Flexible(
            child: Column(
              children: [
                Tappable(
                  onTap: () {
                    showIconSelectorModal(
                      context,
                      IconSelectorModal(
                        preselectedIconID: data.icon.id,
                        subtitle: iconSelectorModalSubtitle,
                        onIconSelected: (selectedIcon) {
                          onDataChange((color: data.color, icon: selectedIcon));
                        },
                      ),
                    );
                  },
                  bgColor: bgColor,
                  child: ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    title: Text(t.icon_selector.icon),
                    contentPadding: const EdgeInsets.only(
                      left: 6,
                      top: 2,
                      bottom: 2,
                      right: 16,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                    ),
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor, height: 0),
                Tappable(
                  onTap: () => showColorPickerModal(
                    context,
                    ColorPickerModal(
                      colorOptions: defaultColorPickerOptions,
                      selectedColor: data.color.toHex(),
                      customColorPreviewBuilder: (color) =>
                          iconDisplayer.copyWith(
                            secondaryColor: isAppInDarkBrightness(context)
                                ? color
                                : iconDisplayer.secondaryColor,
                            mainColor: isAppInLightBrightness(context)
                                ? color
                                : iconDisplayer.mainColor,
                            size: 32,
                            outlineWidth: 2,
                          ),
                      onColorSelected: (selColor) {
                        RouteUtils.popRoute();
                        onDataChange((color: selColor, icon: data.icon));
                      },
                    ),
                  ),
                  bgColor: bgColor,
                  child: ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    contentPadding: const EdgeInsets.only(
                      left: 6,
                      top: 2,
                      bottom: 2,
                      right: 16,
                    ),
                    title: Text(t.icon_selector.color),
                    trailing: Icon(Icons.circle, color: data.color),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
