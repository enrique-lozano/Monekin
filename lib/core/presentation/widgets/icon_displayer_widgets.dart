import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';

part 'icon_displayer_widgets.g.dart';

class IconDisplayerSelectorData<T extends Object> {
  const IconDisplayerSelectorData({
    required this.selectedItems,
    this.onChange,
    this.direction = Axis.horizontal,
    required this.availableItems,
    this.extraHeaderButtons,
    this.multiSelection = true,
    this.iconSize = 48,
    this.iconPadding = 8,
  });

  final List<T>? selectedItems;
  final void Function(List<T>? selectedItems)? onChange;
  final Axis direction;

  /// Extra options to add before the categories options. The size and padding of
  /// the `IconDisplayer` attribute here will be ignored to match the rest of the
  /// options
  final List<CategoryButtonSelector>? extraHeaderButtons;

  /// Wheter the user can select multiple categories
  final bool multiSelection;

  /// Size of all the icon options of the Widget
  final double iconSize;

  /// Padding of all the icon options of the Widget
  final double iconPadding;

  /// List of the available categories to choose. If null, the component will
  /// display an empty container
  final List<T>? availableItems;
}

class IconDisplayerSelectorRow extends StatelessWidget {
  const IconDisplayerSelectorRow(
      {super.key,
      required this.direction,
      required this.scrollableOptions,
      this.extraHeaderButtons});

  final Axis direction;

  final List<CategoryButtonSelector> scrollableOptions;

  final List<CategoryButtonSelector>? extraHeaderButtons;

  @override
  Widget build(BuildContext context) {
    final double horizontalSpace = scrollableOptions.elementAtOrNull(0) != null
        ? scrollableOptions.elementAtOrNull(0)!.iconWidget.size / 4
        : 12;

    if (direction == Axis.vertical) {
      return Align(
        alignment: Alignment.center,
        heightFactor: 1,
        child: Wrap(
          runAlignment: WrapAlignment.center,
          runSpacing: horizontalSpace,
          spacing: horizontalSpace * 2,
          children: [
            if (extraHeaderButtons != null) ...extraHeaderButtons!,
            ...scrollableOptions
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (extraHeaderButtons != null)
          for (final (index, button) in extraHeaderButtons!.indexed) ...[
            button,
            SizedBox(
                width: index == extraHeaderButtons!.length - 1
                    ? horizontalSpace / 2
                    : horizontalSpace)
          ],
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: 16),
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                for (final (index, button) in scrollableOptions.indexed) ...[
                  button,
                  SizedBox(
                      width: index == scrollableOptions.length - 1
                          ? horizontalSpace / 2
                          : horizontalSpace)
                ],
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

@CopyWith()
class CategoryButtonSelector extends StatelessWidget {
  const CategoryButtonSelector(
      {super.key,
      required this.iconWidget,
      required this.label,
      required this.maxTextSize});

  final IconDisplayer iconWidget;
  final String label;

  final double maxTextSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        iconWidget,
        const SizedBox(height: 4),
        SizedBox(
          width: maxTextSize,
          child: Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
