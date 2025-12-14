import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/presentation/widgets/color_picker/custom_color_picker_modal.dart';
import 'package:monekin/core/presentation/widgets/gradient-box.borders.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<void> showColorPickerModal(
  BuildContext context,
  ColorPickerModal component,
) {
  return showModalBottomSheet<Color>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return component;
    },
  );
}

class ColorPickerModal extends StatelessWidget {
  const ColorPickerModal({
    super.key,
    required this.colorOptions,
    this.selectedColor,
    this.showCustomColorCircleOption = true,
    required this.onColorSelected,
    this.customColorPreviewBuilder,
  });

  final List<String> colorOptions;

  final bool showCustomColorCircleOption;

  final String? selectedColor;

  final Widget Function(Color color)? customColorPreviewBuilder;

  final void Function(Color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    double circleSize = 54;

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.65,
      minChildSize: 0.45,
      initialChildSize: 0.65,
      builder: (context, scrollController) {
        return ModalContainer(
          title: t.icon_selector.select_color,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            controller: scrollController,
            child: Align(
              alignment: Alignment.center,
              heightFactor: 1,
              child: Wrap(
                runAlignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 12,
                children: [
                  if (showCustomColorCircleOption)
                    buildCustomColorCircleSelector(circleSize, context),
                  ...List.generate(colorOptions.length, (index) {
                    final colorItem = colorOptions[index];

                    return buildSelectableColorCircle(
                      colorItem,
                      context,
                      size: circleSize,
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Tooltip buildCustomColorCircleSelector(
    double circleSize,
    BuildContext context,
  ) {
    return Tooltip(
      message: t.icon_selector.custom_color,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.8),
                Colors.yellow.withOpacity(0.8),
                Colors.green.withOpacity(0.8),
                Colors.blue.withOpacity(0.8),
                Colors.purple.withOpacity(0.8),
              ],
            ),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Tappable(
          bgColor: Colors.transparent,
          onTap: () {
            RouteUtils.popRoute();

            showCustomColorPickerModal(
              context,
              CustomColorPickerModal(
                initialColor: selectedColor == null
                    ? ColorHex.get(colorOptions.randomItem())
                    : ColorHex.get(selectedColor!),
                onColorSelected: onColorSelected,
                previewBuilder: customColorPreviewBuilder,
              ),
            );
          },
          borderRadius: BorderRadius.circular(999),
          child: Icon(
            Icons.colorize_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Container buildSelectableColorCircle(
    String colorItem,
    BuildContext context, {
    required double size,
  }) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: size,
      height: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(999)),
      child: Stack(
        children: [
          Tappable(
            bgColor: ColorHex.get(colorItem),
            onTap: () => onColorSelected(ColorHex.get('#$colorItem')),
            child: SizedBox(height: size, width: size),
          ),
          if (selectedColor != null &&
              ColorHex.get('#$colorItem') == ColorHex.get(selectedColor!))
            const DecoratedBox(
              decoration: BoxDecoration(
                color: Color.fromARGB(47, 255, 255, 255),
              ),
              child: Center(child: Icon(Icons.check, color: Colors.white)),
            ),
        ],
      ),
    );
  }
}
