import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';

final colorOptions = [
  'B71C1C',
  'D50000',
  'E53935',
  'EF5350',
  '880E4F',
  'C51162',
  'D81B60',
  'EC407A',
  '4A148C',
  'AA00FF',
  '8E24AA',
  'AB47BC',
  '1A237E',
  '2962FF',
  '2979FF',
  '42A5F5',
  '006064',
  '00897B',
  '00BFA5',
  '4DB6AC',
  '1B5E20',
  '388E3C',
  '8BC34A',
  'D4E157',
  'BF360C',
  'F4511E',
  'FB8C00',
  'FFA726',
  'E65100',
  'FFA000',
  'FFAB00',
  'FFCA28',
  '546E7A',
  '90A4AE',
  '795548',
  '757575',
];

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.colorOptions,
    this.selectedColor,
    this.onColorSelected,
    this.padding = const EdgeInsets.only(top: 8, bottom: 16),
  });

  final List<String> colorOptions;

  final String? selectedColor;

  final EdgeInsets padding;

  final void Function(String selectedColor)? onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late String? _color;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _color = widget.selectedColor;
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46 + widget.padding.top + widget.padding.bottom,
      child: Scrollbar(
        controller: _scrollController,
        child: Padding(
          padding: widget.padding,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: widget.colorOptions.length,
            itemBuilder: (BuildContext context, int index) {
              final colorItem = widget.colorOptions[index];

              return Container(
                clipBehavior: Clip.hardEdge,
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                margin: EdgeInsets.only(
                    left: index == 0 ? 16 : 4,
                    right: index == widget.colorOptions.length - 1 ? 16 : 4),
                child: Stack(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorHex.get(colorItem),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: () {
                          setState(() {
                            _color = colorItem;
                          });

                          if (widget.onColorSelected != null) {
                            widget.onColorSelected!(colorItem);
                          }
                        }),
                      ),
                    ),
                    if (_color != null &&
                        ColorHex.get('#$colorItem') == ColorHex.get(_color!))
                      const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(47, 255, 255, 255),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.check,
                            color: Colors.white,
                          )))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
