import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
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
  });

  final List<Category>? selectedCategories;
  final void Function(List<Category>? selectedCategories)? onChange;

  @override
  State<MultiCategorySelector> createState() => _MultiCategorySelectorState();
}

class _MultiCategorySelectorState extends State<MultiCategorySelector> {
  final double iconSize = 32;
  final double iconPadding = 8;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    List<Category>? selectedCategories = widget.selectedCategories;

    if (selectedCategories != null && selectedCategories.isEmpty) {
      selectedCategories = null;
    }

    return StreamBuilder(
        stream: CategoryService.instance.getMainCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          final allMainCategoriesToShow = snapshot.data!;

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
                      mainColor: appColorScheme(context).background.darken(0.4),
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
                        children: [
                          for (final (index, categoryToDisplay)
                              in allMainCategoriesToShow.indexed) ...[
                            Builder(builder: (context) {
                              final isCategorySelected = selectedCategories !=
                                      null &&
                                  selectedCategories!.any(
                                      (cat) => cat.id == categoryToDisplay.id);

                              return Column(
                                children: [
                                  IconDisplayer(
                                    supportedIcon: categoryToDisplay.icon,
                                    size: iconSize,
                                    padding: iconPadding,
                                    isOutline: isCategorySelected,
                                    onTap: () {
                                      if (!isCategorySelected) {
                                        if (selectedCategories == null) {
                                          selectedCategories = [
                                            categoryToDisplay
                                          ];
                                        } else {
                                          selectedCategories!
                                              .add(categoryToDisplay);
                                        }
                                      } else {
                                        selectedCategories!.removeWhere(
                                            (element) =>
                                                element.id ==
                                                categoryToDisplay.id);

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
                                    mainColor:
                                        ColorHex.get(categoryToDisplay.color),
                                  ),
                                  const SizedBox(height: 4),
                                  ButtonSelectorLabel(
                                      label: categoryToDisplay.name),
                                ],
                              );
                            }),
                            if (index < allMainCategoriesToShow.length - 1)
                              const SizedBox(width: 12)
                          ]
                        ],
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
