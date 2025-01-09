import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/color_picker/custom_color_picker.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<void> showCustomColorPickerModal(
    BuildContext context, CustomColorPickerModal component) {
  return showModalBottomSheet<Color>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return component;
    },
  );
}

class CustomColorPickerModal extends StatefulWidget {
  const CustomColorPickerModal({
    super.key,
    required this.initialColor,
    this.previewBuilder,
    required this.onColorSelected,
  });

  final Color initialColor;
  final Widget Function(Color color)? previewBuilder;
  final void Function(Color) onColorSelected;

  @override
  State<CustomColorPickerModal> createState() => _CustomColorPickerModalState();
}

class _CustomColorPickerModalState extends State<CustomColorPickerModal> {
  late Color color;

  @override
  void initState() {
    super.initState();

    color = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.icon_selector.custom_color,
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      body: CustomColorPicker(
          pickerColor: color,
          onColorChanged: (newColor) {
            setState(() {
              color = newColor;
            });
          }),
      endWidget:
          widget.previewBuilder == null ? null : widget.previewBuilder!(color),
      footer: BottomSheetFooter(onSaved: () {
        widget.onColorSelected(color);
      }),
    );
  }
}
