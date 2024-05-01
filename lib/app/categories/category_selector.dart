import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/widgets/icon_displayer_widgets.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector(
    this.params, {
    super.key,
  });

  final IconDisplayerSelectorData<Category> params;

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<CategoryButtonSelector> buildCategoriesOptions({
    required List<Category>? selectedCategories,
  }) {
    return widget.params.availableItems!.map((categoryToDisplay) {
      final isCategorySelected = selectedCategories == null ||
          selectedCategories!.any((cat) => cat.id == categoryToDisplay.id);

      return CategoryButtonSelector(
          maxTextSize: widget.params.iconSize + widget.params.iconPadding * 2,
          iconWidget: IconDisplayer.fromCategory(
            context,
            category: categoryToDisplay,
            size: widget.params.iconSize,
            padding: widget.params.iconPadding,
            isOutline: isCategorySelected,
            onTap: () {
              HapticFeedback.lightImpact();

              if (!widget.params.multiSelection) {
                selectedCategories = [categoryToDisplay];

                setState(() {});

                if (widget.params.onChange != null) {
                  widget.params.onChange!(selectedCategories);
                }
                return;
              }

              if (!isCategorySelected) {
                if (selectedCategories == null) {
                  selectedCategories = [categoryToDisplay];
                } else {
                  selectedCategories!.add(categoryToDisplay);

                  if (selectedCategories!.length ==
                      widget.params.availableItems!.length) {
                    selectedCategories = null;
                  }
                }
              } else {
                selectedCategories ??= [...widget.params.availableItems!];

                selectedCategories!.removeWhere(
                    (element) => element.id == categoryToDisplay.id);
              }

              setState(() {});

              if (widget.params.onChange != null) {
                widget.params.onChange!(selectedCategories);
              }
            },
          ),
          label: categoryToDisplay.name);
    }).toList();
  }

  CategoryButtonSelector buildSelectAllButton(
    BuildContext context, {
    required List<Category>? selectedCategories,
  }) {
    final t = Translations.of(context);

    return CategoryButtonSelector(
      maxTextSize: widget.params.iconSize + widget.params.iconPadding * 2,
      iconWidget: IconDisplayer(
        icon: Icons.select_all,
        size: widget.params.iconSize,
        padding: widget.params.iconPadding,
        borderRadius: 99999,
        isOutline: selectedCategories == null,
        secondaryColor: AppColors.of(context).background.darken(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.1,
            ),
        mainColor: AppColors.of(context).onBackground,
        onTap: () {
          if (selectedCategories == null) {
            selectedCategories = [];
          } else {
            selectedCategories = null;
          }

          setState(() {});

          HapticFeedback.lightImpact();

          if (widget.params.onChange != null) {
            widget.params.onChange!(selectedCategories);
          }
        },
      ),
      label: t.categories.select.all_short,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Category>? selectedCategories = widget.params.selectedItems;

    final extraHeaderButtonsWithSameSize = widget.params.extraHeaderButtons
        ?.map(
          (e) => e.copyWith(
            iconWidget: e.iconWidget.copyWith(
              size: widget.params.iconSize,
              padding: widget.params.iconPadding,
            ),
          ),
        )
        .toList();

    return Builder(builder: (context) {
      if (widget.params.availableItems == null) {
        return Container();
      }

      return IconDisplayerSelectorRow(
        direction: widget.params.direction,
        extraHeaderButtons: [
          if (widget.params.direction == Axis.horizontal)
            buildSelectAllButton(context,
                selectedCategories: selectedCategories),
          if (extraHeaderButtonsWithSameSize != null)
            ...extraHeaderButtonsWithSameSize
        ],
        scrollableOptions:
            buildCategoriesOptions(selectedCategories: selectedCategories),
      );
    });
  }
}
