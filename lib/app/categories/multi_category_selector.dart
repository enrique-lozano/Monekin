import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

class MultiCategorySelector extends StatefulWidget {
  const MultiCategorySelector({
    super.key,
    required this.selectedCategories,
    this.onChange,
    this.direction = Axis.horizontal,
    required this.availableCategories,
  });

  final List<Category>? selectedCategories;
  final void Function(List<Category>? selectedCategories)? onChange;
  final Axis direction;

  /// List of the available categories to choose. If null, the component will
  /// display an empty container
  final List<Category>? availableCategories;

  @override
  State<MultiCategorySelector> createState() => _MultiCategorySelectorState();
}

class _MultiCategorySelectorState extends State<MultiCategorySelector> {
  final double iconSize = 38;
  final double iconPadding = 8;

  buildCategoriesOptions({
    required List<Category>? selectedCategories,
  }) {
    return [
      for (final (index, categoryToDisplay)
          in widget.availableCategories!.indexed) ...[
        Builder(builder: (context) {
          final isCategorySelected = selectedCategories != null &&
              selectedCategories!.any((cat) => cat.id == categoryToDisplay.id);

          return Column(
            children: [
              IconDisplayer.fromCategory(
                context,
                category: categoryToDisplay,
                size: iconSize,
                padding: iconPadding,
                isOutline: isCategorySelected,
                onTap: () {
                  if (!isCategorySelected) {
                    if (selectedCategories == null) {
                      selectedCategories = [categoryToDisplay];
                    } else {
                      selectedCategories!.add(categoryToDisplay);
                    }
                  } else {
                    selectedCategories!.removeWhere(
                        (element) => element.id == categoryToDisplay.id);

                    if (selectedCategories != null &&
                        selectedCategories!.isEmpty) {
                      selectedCategories = null;
                    }
                  }

                  setState(() {});

                  if (widget.onChange != null) {
                    widget.onChange!(selectedCategories);
                  }
                },
              ),
              const SizedBox(height: 4),
              ButtonSelectorLabel(label: categoryToDisplay.name),
            ],
          );
        }),
        if (index < widget.availableCategories!.length - 1 &&
            widget.direction == Axis.horizontal)
          const SizedBox(width: 12)
      ]
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    List<Category>? selectedCategories = widget.selectedCategories;

    if (selectedCategories != null && selectedCategories.isEmpty) {
      selectedCategories = null;
    }

    return Builder(builder: (context) {
      if (widget.availableCategories == null) {
        return Container();
      }

      if (widget.direction == Axis.vertical) {
        return Align(
          alignment: Alignment.topCenter,
          child: Wrap(
            runSpacing: 12,
            spacing: 24,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: buildCategoriesOptions(
              selectedCategories: selectedCategories,
            ),
          ),
        );
      }

      return ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                IconDisplayer(
                  icon: Icons.select_all,
                  size: iconSize,
                  padding: iconPadding,
                  isOutline: selectedCategories == null,
                  secondaryColor: appColorScheme(context).background.darken(
                        Theme.of(context).brightness == Brightness.dark
                            ? 0.6
                            : 0.1,
                      ),
                  mainColor: appColorScheme(context).onBackground,
                  onTap: () {
                    setState(() {
                      selectedCategories = null;
                    });

                    if (widget.onChange != null) {
                      widget.onChange!(selectedCategories);
                    }
                  },
                ),
                const SizedBox(height: 4),
                ButtonSelectorLabel(label: t.categories.select.all_short)
              ],
            ),
            const SizedBox(width: 6),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(right: 16),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Row(
                    children: buildCategoriesOptions(
                        selectedCategories: selectedCategories),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ButtonSelectorLabel extends StatelessWidget {
  const ButtonSelectorLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: Text(
        label,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
