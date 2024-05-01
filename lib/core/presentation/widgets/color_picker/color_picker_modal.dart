import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<Color?> showColorPickerModal(
    BuildContext context, ColorPickerModal component) {
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
  const ColorPickerModal(
      {super.key, required this.colorOptions, this.selectedColor});

  final List<String> colorOptions;

  final String? selectedColor;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

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
                  children: List.generate(colorOptions.length, (index) {
                    final colorItem = colorOptions[index];

                    return Container(
                      clipBehavior: Clip.hardEdge,
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999)),
                      child: Stack(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: ColorHex.get(colorItem),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.pop(
                                  context,
                                  ColorHex.get('#$colorItem'),
                                ),
                              ),
                            ),
                          ),
                          if (selectedColor != null &&
                              ColorHex.get('#$colorItem') ==
                                  ColorHex.get(selectedColor!))
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(47, 255, 255, 255),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        });
  }
}
