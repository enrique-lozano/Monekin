import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/responsive/responsive_row_column.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorPickerHeight = 250.0,
    this.pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final double colorPickerHeight;
  final BorderRadius pickerAreaBorderRadius;

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);
  Widget? previewWidget;

  Color get currentColor => currentHsvColor.toColor().withOpacity(1);

  final TextEditingController hexColorText = TextEditingController(text: '');

  @override
  void initState() {
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
    hexColorText.text = currentColor.toHex();

    super.initState();
  }

  @override
  void didUpdateWidget(CustomColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentHsvColor = color);
    widget.onColorChanged(currentColor);
    hexColorText.text = currentColor.toHex();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isComponenHorizontal = BreakPoint.of(
      context,
    ).isLargerThan(BreakpointID.sm);

    return SizedBox(
      height: widget.colorPickerHeight + 50,
      child: ResponsiveRowColumn(
        direction: isComponenHorizontal ? Axis.horizontal : Axis.vertical,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowSpacing: 10,
        columnSpacing: 0,
        children: [
          ResponsiveRowColumnItem(
            columnOrder: 1,
            child: ResponsiveRowColumn(
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              rowCrossAxisAlignment: CrossAxisAlignment.end,
              rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
              direction: isComponenHorizontal ? Axis.vertical : Axis.horizontal,
              columnSpacing: 16,
              rowSpacing: 12,
              children: [
                ResponsiveRowColumnItem(
                  rowFit: FlexFit.loose,
                  rowFlex: 1,
                  child: SizedBox(
                    width: 180,
                    child: TextFormField(
                      controller: hexColorText,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.numbers_rounded),
                        counterText: '',
                      ),
                      maxLength: 6,
                      onChanged: (newValue) {
                        try {
                          currentHsvColor = HSVColor.fromColor(
                            ColorHex.get(newValue),
                          );
                          widget.onColorChanged(currentColor);

                          setState(() {});
                        } catch (e) {
                          Logger.printDebug('Invalid color');
                        }
                      },
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFit: FlexFit.loose,
                  rowFlex: 1,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.icon_selector.current_color_selection,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 3),
                      Container(
                        width: 180,
                        height: 38,
                        decoration: BoxDecoration(
                          color: currentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            columnOrder: 0,
            child: Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          height: widget.colorPickerHeight,
                          width: constraints.maxWidth / 1.05,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: ColorPickerArea(
                              currentHsvColor,
                              onColorChanging,
                              PaletteType.hsv,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: 40,
                        width: constraints.maxWidth,
                        child: ColorPickerSlider(
                          TrackType.hue,
                          currentHsvColor,
                          onColorChanging,
                          displayThumbColor: true,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
