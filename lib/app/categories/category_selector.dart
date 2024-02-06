import 'dart:ui';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

part 'category_selector.g.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    super.key,
    required this.selectedCategories,
    this.onChange,
    this.direction = Axis.horizontal,
    required this.availableCategories,
    this.extraHeaderButtons,
    this.multiSelection = true,
    this.iconSize = 48,
    this.iconPadding = 8,
  });

  final List<Category>? selectedCategories;
  final void Function(List<Category>? selectedCategories)? onChange;
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
  final List<Category>? availableCategories;

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  buildCategoriesOptions({
    required List<Category>? selectedCategories,
  }) {
    return [
      for (final (index, categoryToDisplay)
          in widget.availableCategories!.indexed) ...[
        Builder(builder: (context) {
          final isCategorySelected = selectedCategories == null ||
              selectedCategories!.any((cat) => cat.id == categoryToDisplay.id);

          return CategoryButtonSelector(
              maxTextSize: widget.iconSize * 1.2,
              iconWidget: IconDisplayer.fromCategory(
                context,
                category: categoryToDisplay,
                size: widget.iconSize,
                padding: widget.iconPadding,
                isOutline: isCategorySelected,
                onTap: () {
                  HapticFeedback.lightImpact();

                  if (!widget.multiSelection) {
                    selectedCategories = [categoryToDisplay];

                    print(selectedCategories);

                    setState(() {});

                    if (widget.onChange != null) {
                      widget.onChange!(selectedCategories);
                    }
                    return;
                  }

                  if (!isCategorySelected) {
                    if (selectedCategories == null) {
                      selectedCategories = [categoryToDisplay];
                    } else {
                      selectedCategories!.add(categoryToDisplay);

                      if (selectedCategories!.length ==
                          widget.availableCategories!.length) {
                        selectedCategories = null;
                      }
                    }
                  } else {
                    selectedCategories ??= [...widget.availableCategories!];

                    selectedCategories!.removeWhere(
                        (element) => element.id == categoryToDisplay.id);
                  }

                  setState(() {});

                  if (widget.onChange != null) {
                    widget.onChange!(selectedCategories);
                  }
                },
              ),
              label: categoryToDisplay.name);
        }),
        if (index < widget.availableCategories!.length - 1 &&
            widget.direction == Axis.horizontal)
          const SizedBox(width: 12)
      ]
    ];
  }

  Widget buildSelectAllButton(
    BuildContext context, {
    required List<Category>? selectedCategories,
  }) {
    final t = Translations.of(context);

    return CategoryButtonSelector(
      maxTextSize: widget.iconSize * 1.2,
      iconWidget: IconDisplayer(
        icon: Icons.select_all,
        size: widget.iconSize,
        padding: widget.iconPadding,
        isOutline: selectedCategories == null,
        secondaryColor: AppColors.of(context).background.darken(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.1,
            ),
        mainColor: AppColors.of(context).onBackground,
        onTap: () {
          print(selectedCategories);

          if (selectedCategories == null) {
            selectedCategories = [];
          } else {
            selectedCategories = null;
          }

          setState(() {});

          HapticFeedback.lightImpact();

          if (widget.onChange != null) {
            widget.onChange!(selectedCategories);
          }
        },
      ),
      label: t.categories.select.all_short,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Category>? selectedCategories = widget.selectedCategories;

    final extraHeaderButtonsWithSameSize = widget.extraHeaderButtons
        ?.map(
          (e) => e.copyWith(
            iconWidget: e.iconWidget.copyWith(
              size: widget.iconSize,
              padding: widget.iconPadding,
            ),
          ),
        )
        .toList();

    return Builder(builder: (context) {
      if (widget.availableCategories == null) {
        return Container();
      }

      if (widget.direction == Axis.vertical) {
        return Align(
          alignment: Alignment.center,
          heightFactor: 1,
          child: Wrap(
            runAlignment: WrapAlignment.center,
            runSpacing: 12,
            spacing: 24,
            children: [
              if (extraHeaderButtonsWithSameSize != null)
                ...extraHeaderButtonsWithSameSize,
              ...buildCategoriesOptions(
                selectedCategories: selectedCategories,
              )
            ],
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
            buildSelectAllButton(context,
                selectedCategories: selectedCategories),
            const SizedBox(width: 6),
            if (extraHeaderButtonsWithSameSize != null)
              for (final button in extraHeaderButtonsWithSameSize) ...[
                const SizedBox(width: 6),
                button,
                const SizedBox(width: 6)
              ],
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
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
